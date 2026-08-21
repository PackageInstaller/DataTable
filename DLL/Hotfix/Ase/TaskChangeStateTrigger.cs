namespace Ase;

[Trigger("修改任务状态存档触发器")]
public class TaskChangeStateTrigger : BaseTrigger
{
	public int taskId;

	public int taskSaveStateIndex;

	public string taskSaveStateValue;

	public override string TriggerName => "修改任务状态存档触发器";

	private void CheckTaskStateValue()
	{
		taskSaveStateValue = taskSaveStateValue.PadLeft(2, '0');
	}

	protected override void DoExecute()
	{
		base.DoExecute();
		sceneSystem.GetSystem<TaskSystem>().UpdateTaskState(taskId, taskSaveStateIndex, taskSaveStateValue);
	}
}
