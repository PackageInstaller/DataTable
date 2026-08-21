namespace Ase;

[Trigger("对话链2改变任务索引状态触发器")]
public class Dialogue2ChangeTaskIndexStateEventTrigger : DialogueChainEventTrigger
{
	public int taskId;

	public int taskSaveStateIndex;

	public string taskSaveStateValue;

	public override string TriggerName => "对话链-改变任务索引状态触发器";

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
