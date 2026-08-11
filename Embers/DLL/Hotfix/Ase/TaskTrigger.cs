using UnityEngine;

namespace Ase;

[Trigger("任务触发器")]
public class TaskTrigger : BaseTrigger
{
	public int taskId;

	public int deltaValue;

	public TaskSystem.TaskOptionType changeType;

	public override string TriggerName => "任务触发器";

	protected virtual void UpdateEventTriggerName()
	{
		((Object)(object)this).name = (triggerInitSwitch ? "√" : "×") + $" {TriggerName} - 任务ID:{taskId}";
	}

	protected override void DoExecute()
	{
		base.DoExecute();
		if (changeType == TaskSystem.TaskOptionType.Finished)
		{
			sceneSystem.GetSystem<TaskSystem>().FinishTask(taskId);
		}
		else if (changeType == TaskSystem.TaskOptionType.Updated)
		{
			sceneSystem.GetSystem<TaskSystem>().UpdateTaskProcess(taskId, deltaValue);
		}
		else if (changeType == TaskSystem.TaskOptionType.Trigger)
		{
			sceneSystem.GetSystem<TaskSystem>().ClientTriggerTask(taskId);
		}
	}
}
