using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查实体状态", 0)]
[Description("检查指定实体的当前状态是否与给定状态ID匹配。")]
public class CheckEntityState : ConditionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要检查状态的实体的唯一标识符。")]
	public BBParameter<int> EntityId;

	[Name("状态ID", 0)]
	[Description("要比较的状态的唯一标识符。")]
	public BBParameter<int> StateId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: true);
		if (entity == null)
		{
			return false;
		}
		StateData currentState = entity.GetComponent<StateComponent>().GetCurrentState();
		if (currentState == null)
		{
			return false;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"检查实体状态 ：实体ID : {EntityId.value}  状态ID : {StateId.value} 获取实体当前状态 : {currentState.Id} ", ownerEntity);
		}
		return StateId.value == currentState.Id;
	}
}
