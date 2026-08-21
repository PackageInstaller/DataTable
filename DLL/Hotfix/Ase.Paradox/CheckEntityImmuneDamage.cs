using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查实体是否免疫伤害", 0)]
[Description("检查实体存在的所有免疫状态中是否免疫伤害")]
public class CheckEntityImmuneDamage : ConditionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> EntityId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: true);
		if (entity == null)
		{
			return false;
		}
		return entity?.GetComponent<StateComponent>()?.ImmuneDamage() == true;
	}
}
