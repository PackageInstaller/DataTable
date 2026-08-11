namespace Ase;

[Trigger("Timeline2任务事件触发器")]
public class Timeline2TaskEventTrigger : TimelineEventTrigger
{
	public int taskId;

	public int deltaValue;

	public TaskSystem.TaskOptionType changeType;

	public override string TriggerName => "Timeline-任务事件触发器";

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
	}
}
