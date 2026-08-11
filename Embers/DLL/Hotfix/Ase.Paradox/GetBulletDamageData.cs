using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取子弹命中伤害流程数据", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于伤害流程中，子弹命中数据获取")]
public class GetBulletDamageData : ActionTaskBase
{
	public enum CheckEnum
	{
		Any,
		BulletId,
		ConfigId
	}

	[Name("检测子弹类型", 0)]
	public CheckEnum checkEnum;

	[Name("子弹实体ID/子弹配置ID", 0)]
	public BBParameter<int> bulletId;

	[Name("创建子弹的实体ID", 0)]
	public BBParameter<int> entityId;

	[Name("子弹标签列表", 0)]
	public BBParameter<List<string>> bulletLabelList = new BBParameter<List<string>>();

	[Space(10)]
	[Name("实际伤害", 0)]
	public BBParameter<int> Damage;

	[Name("实际削韧", 0)]
	public BBParameter<int> Tenacity;

	[Name("实际冲击力", 0)]
	public BBParameter<int> DefensePowerLevel;

	[Space(10)]
	[Name("子弹伤害系数", 0)]
	public BBParameter<List<float>> BulletDamageRatio = new BBParameter<List<float>>();

	[Name("子弹削韧系数", 0)]
	public BBParameter<float> BulletTenacityRatio;

	[Name("子弹固定削韧", 0)]
	public BBParameter<float> BulletFixedTenacity;

	[Name("子弹冲击力", 0)]
	public BBParameter<int> BulletPowerLevel;

	[Name("子弹所属技能ID", 0)]
	public BBParameter<int> BulletSkillID;

	[Space(10)]
	[Name("受击目标实体ID列表", 0)]
	public BBParameter<List<int>> DefenderIDList = new BBParameter<List<int>>();

	[Name("受击目标阵营列表", 0)]
	public BBParameter<List<EntityType>> DefenderEntityTypeList = new BBParameter<List<EntityType>>();

	[Name("命中部位等级列表", 0)]
	public BBParameter<List<int>> SiteLevelList = new BBParameter<List<int>>();

	[Name("命中破绽等级列表", 0)]
	public BBParameter<List<int>> WeaknessLevelList = new BBParameter<List<int>>();

	[Name("命中目标免疫状态列表", 0)]
	public BBParameter<List<int>> ImmnueStateList = new BBParameter<List<int>>();

	[Space(10)]
	[Name("是否清理子弹命中数据", 0)]
	public BBParameter<bool> IsClearBulletDamageData;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity == null)
		{
			EndAction();
			return;
		}
		BattleDamageProgressSystem system = ownerEntity.GetSystem<BattleDamageProgressSystem>();
		if (system == null)
		{
			EndAction();
			return;
		}
		List<BattleDamageProgressSystem.BulletDamageResultInfo> allBulletDamageResultInfo = system.GetAllBulletDamageResultInfo();
		List<BattleDamageProgressSystem.BulletDamageResultInfo> list = new List<BattleDamageProgressSystem.BulletDamageResultInfo>();
		for (int i = 0; i < allBulletDamageResultInfo.Count; i++)
		{
			BattleDamageProgressSystem.BulletDamageResultInfo bulletDamageResultInfo = allBulletDamageResultInfo[i];
			if (checkEnum != CheckEnum.Any)
			{
				if (checkEnum == CheckEnum.BulletId)
				{
					if (bulletDamageResultInfo.bulletId != bulletId.value)
					{
						continue;
					}
				}
				else if (checkEnum == CheckEnum.ConfigId && bulletDamageResultInfo.bulletConfigId != bulletId.value)
				{
					continue;
				}
			}
			if (bulletLabelList.value.IsNullOrEmpty() || (!bulletDamageResultInfo.bulletLabelList.IsNullOrEmpty() && bulletDamageResultInfo.bulletLabelList.HasCommonWith(bulletLabelList.value)))
			{
				list.Add(bulletDamageResultInfo);
			}
		}
		if (list.Count == 0)
		{
			EndAction();
			return;
		}
		Damage.value = 0;
		Tenacity.value = 0;
		DefenderIDList.value = new List<int>();
		DefenderEntityTypeList.value = new List<EntityType>();
		SiteLevelList.value = new List<int>();
		WeaknessLevelList.value = new List<int>();
		foreach (BattleDamageProgressSystem.BulletDamageResultInfo item in list)
		{
			Damage.value += item.damage;
			Tenacity.value += item.tenacity;
			DefenderIDList.value.Add(item.defenderId);
			DefenderEntityTypeList.value.Add(item.defenderEntityType);
			SiteLevelList.value.Add(item.siteLevel);
			WeaknessLevelList.value.Add(item.weaknessLevel);
		}
		int index = list.Count - 1;
		BattleDamageProgressSystem.BulletDamageResultInfo bulletDamageResultInfo2 = list[index];
		DefensePowerLevel.value = bulletDamageResultInfo2.defensePowerLevel;
		BulletDamageRatio.value = bulletDamageResultInfo2.bulletDamageRatio;
		BulletTenacityRatio.value = bulletDamageResultInfo2.bulletTenacityRatio;
		BulletFixedTenacity.value = bulletDamageResultInfo2.bulletFixedTenacity;
		BulletPowerLevel.value = bulletDamageResultInfo2.bulletPowerLevel;
		BulletSkillID.value = bulletDamageResultInfo2.skillId;
		ImmnueStateList.value = bulletDamageResultInfo2.immuneStateList;
		if (IsClearBulletDamageData.value)
		{
			system.ClearBulletDamageResultInfo();
		}
		EndAction();
	}
}
