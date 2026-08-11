using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("触发任务", 0)]
[Category("✫ DragonLost/Task")]
[Description("用于触发指定的任务。")]
public class TriggerTaskAction : ActionTaskBase
{
	[RequiredField]
	[Name("任务Id", 0)]
	[Description("要触发的任务的唯一标识符。")]
	public BBParameter<int> taskId;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (taskId != null && taskId.value > 0)
		{
			GetOwnerEntity().GetSystem<TaskSystem>().ClientTriggerTask(taskId.value);
		}
		OnActionFinish();
	}
}
