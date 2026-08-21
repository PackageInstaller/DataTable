using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查火种是否激活", 0)]
[Category("✫ DragonLost/Condition")]
[Description("检查火种是否激活。")]
public class CheckKindlingIsActive : ConditionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要检查状态的实体的唯一标识符。")]
	public BBParameter<int> EntityId;

	[Name("火种ID", 0)]
	[Description("火种ID。")]
	public BBParameter<int> KingLingId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(EntityId.value);
		if (entity == null)
		{
			return false;
		}
		if (!(entity is HeroEntity heroEntity))
		{
			return false;
		}
		bool flag = heroEntity.BattleHeroData.CheckKindlingIsActive(KingLingId.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"检查火种是否激活 实体ID : {EntityId.value}  火种id ：{KingLingId.value}  result : {flag}", ownerEntity);
		}
		return flag;
	}
}
