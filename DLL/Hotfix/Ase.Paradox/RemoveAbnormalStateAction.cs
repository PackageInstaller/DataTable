#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("目标移除异常状态", 0)]
[Category("✫ DragonLost/State")]
[Description("移除目标实体的特定异常状态。")]
public class RemoveAbnormalStateAction : ActionTaskBase
{
	[Name("目标实体ID", 0)]
	[Description("要移除异常状态的目标实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("异常状态ID", 0)]
	[Description("要移除的异常状态的ID。")]
	public BBParameter<int> StateId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError($"目标附加异常状态错误:实体ID{EntityId.value}为空!");
			EndAction();
		}
		else
		{
			entity.GetComponent<AbnormalStateComponent>().RemoveAbnormalState(StateId.value);
			EndAction();
		}
	}
}
