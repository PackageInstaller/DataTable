using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检测指定子弹是否命中", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于检测伤害流程中，子弹命中数据")]
public class CheckBulletDamage : ConditionTaskBase
{
	public enum CheckEnum
	{
		Any,
		BulletId,
		ConfigId
	}

	[Name("检测子弹类型", 0)]
	public CheckEnum checkEnum;

	[HideIf("checkEnum", 0)]
	[Name("子弹实体ID/子弹配置ID", 0)]
	public BBParameter<int> bulletId;

	[Space(10)]
	[Name("是否清理子弹命中数据", 0)]
	public BBParameter<bool> IsClearBulletDamageData;

	protected override bool OnCheck()
	{
		base.OnCheck();
		if (ownerEntity == null)
		{
			return false;
		}
		BattleDamageProgressSystem system = ownerEntity.GetSystem<BattleDamageProgressSystem>();
		if (system == null)
		{
			return false;
		}
		bool result = false;
		if (checkEnum == CheckEnum.Any)
		{
			result = system.CheckBulletDamageResultInfo();
		}
		else
		{
			BattleDamageProgressSystem.BulletDamageResultInfo bulletDamageResultInfo = null;
			if (checkEnum == CheckEnum.BulletId)
			{
				bulletDamageResultInfo = system.GetBulletDamageResultInfoByBulletId(bulletId.value);
			}
			else if (checkEnum == CheckEnum.ConfigId)
			{
				bulletDamageResultInfo = system.GetBulletDamageResultInfoByConfigId(bulletId.value);
			}
			if (bulletDamageResultInfo != null)
			{
				result = true;
			}
		}
		if (IsClearBulletDamageData.value)
		{
			system.ClearBulletDamageResultInfo();
		}
		return result;
	}
}
