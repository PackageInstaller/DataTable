namespace Ase;

[Trigger("交互物2修改任务存档事件触发器")]
public class MapItem2ChangeTaskSaveStateEventTrigger : MapItemEventTrigger
{
	public int taskId;

	public int taskSaveStateIndex;

	public string taskSaveStateValue;

	public override string TriggerName => "交互物-修改任务存档事件触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (sceneSystem != null)
		{
			sceneSystem.GetSystem<TaskSystem>()?.UpdateTaskState(taskId, taskSaveStateIndex, taskSaveStateValue);
		}
	}

	private void CheckTaskStateValue()
	{
		taskSaveStateValue = taskSaveStateValue.PadLeft(2, '0');
	}
}
