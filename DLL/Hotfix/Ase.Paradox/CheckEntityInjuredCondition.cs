using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检测实体是否被击中", 0)]
[Category("✫ DragonLost/Entity")]
[Description("检测指定实体是否受到攻击，条件通过后返回攻击者ID和伤害值。")]
public class CheckEntityInjuredCondition : ConditionTaskBase
{
	[Name("返回的攻击者ID", 0)]
	[Description("受到攻击的实体的攻击者ID。")]
	public BBParameter<int> AttackId;

	[Name("是否清空数据", 0)]
	[Description("是否在检测后清空受击数据。")]
	public bool ClearData;

	[Name("返回的伤害值", 0)]
	[Description("受到攻击的实体受到的伤害值。")]
	public BBParameter<float> Damage;

	[RequiredField]
	[Name("实体ID", 0)]
	[Description("要检测的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("子弹标签筛选", 0)]
	public bool bulletLabelFilter;

	[Name("子弹标签", 0)]
	[ShowIf("bulletLabelFilter", true)]
	public string bulletLabel;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			return false;
		}
		HitComponent component = entity.GetComponent<HitComponent>();
		if (component == null)
		{
			return false;
		}
		bool isInjured = component.IsInjured;
		if (isInjured)
		{
			if (bulletLabelFilter && !CheckBulletLabel(component))
			{
				return false;
			}
			AttackId.value = component.AttackId;
			Damage.value = component.Damage;
		}
		if (ClearData)
		{
			component.ClearEntityInjuredData();
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"检测实体是否被击中 {isInjured}", entity);
		}
		return isInjured;
	}

	private bool CheckBulletLabel(HitComponent component)
	{
		if (string.IsNullOrEmpty(bulletLabel))
		{
			return false;
		}
		foreach (int hitEntityBulletId in component.GetHitEntityBulletIdList(EntityId.value))
		{
			DRBullet dataRow = GameEntry.DataTable.GetDataRow<DRBullet>(hitEntityBulletId);
			if (dataRow != null && dataRow.BulletLabel.Contains(bulletLabel))
			{
				return true;
			}
		}
		return false;
	}
}
