using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("目标附加状态", 0)]
[Category("✫ DragonLost/State")]
[Description("向目标实体附加指定的状态。")]
public class AdditionalStateAction : ActionTaskBase
{
	[Name("状态Id", 0)]
	[Description("要附加的状态的ID。")]
	public BBParameter<int> stateId;

	[Name("目标实体", 0)]
	[Description("要附加状态的目标实体的ID。")]
	public BBParameter<int> targetParam;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetParam.value, isSyncEntity: false);
		if (entity == null)
		{
			OnActionFail();
			return;
		}
		entity.GetComponent<StateComponent>()?.AddState(stateId.value, ownerEntity.Id);
		OnActionFinish();
	}
}
