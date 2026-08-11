using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查实体免疫状态", 0)]
[Description("检查实体存在免疫状态")]
public class CheckEntityStateBuff : ConditionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> EntityId;

	[Name("免疫状态ID", 0)]
	public BBParameter<int> StateBuffId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: true);
		if (entity == null)
		{
			return false;
		}
		return entity?.GetComponent<StateComponent>()?.ContainsImmuneBuff(StateBuffId.value) == true;
	}
}
