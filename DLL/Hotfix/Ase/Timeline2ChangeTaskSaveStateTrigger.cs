namespace Ase;

[Trigger("Timeline2修改任务存档事件触发器")]
public class Timeline2ChangeTaskSaveStateTrigger : TimelineEventTrigger
{
	public int taskId;

	public int taskSaveStateIndex;

	public string taskSaveStateValue;

	public override string TriggerName => "Timeline-修改任务存档事件触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		sceneSystem.GetSystem<TaskSystem>().UpdateTaskState(taskId, taskSaveStateIndex, taskSaveStateValue);
	}

	private void CheckTaskStateValue()
	{
		taskSaveStateValue = taskSaveStateValue.PadLeft(2, '0');
	}
}
