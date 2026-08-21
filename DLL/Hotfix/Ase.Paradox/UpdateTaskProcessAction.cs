using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("更新任务", 0)]
[Category("✫ DragonLost/Task")]
[Description("用于更新指定任务的进度数值。")]
public class UpdateTaskProcessAction : ActionTaskBase
{
	[RequiredField]
	[Name("任务Id", 0)]
	[Description("要更新进度的任务的唯一标识符。")]
	public BBParameter<int> taskId;

	[RequiredField]
	[Name("更新进度数值", 0)]
	[Description("要增加或减少的任务进度值。")]
	public BBParameter<int> deltaValue;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (taskId != null && taskId.value > 0)
		{
			GetOwnerEntity().GetSystem<TaskSystem>().UpdateTaskProcess(taskId.value, deltaValue.value);
		}
		OnActionFinish();
	}
}
