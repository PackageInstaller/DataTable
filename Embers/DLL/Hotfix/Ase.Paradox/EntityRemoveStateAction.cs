using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("目标移除状态", 0)]
[Category("✫ DragonLost/State")]
[Description("从目标实体中移除指定的状态。")]
public class EntityRemoveStateAction : ActionTaskBase
{
	[Name("目标实体", 0)]
	[Description("要从其身上移除状态的实体的ID。")]
	public BBParameter<int> targetParam;

	[Name("状态Id", 0)]
	[Description("要移除的状态的ID。")]
	public BBParameter<int> stateId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetParam.value, isSyncEntity: false);
		if (entity == null)
		{
			OnActionFail();
			return;
		}
		entity.GetComponent<StateComponent>()?.RemoveState(stateId.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树目标移除状态 ： {stateId.value}", ownerEntity);
		}
		OnActionFinish();
	}
}
