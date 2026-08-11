namespace Ase;

[Trigger("怪物组2修改任务存档事件触发器")]
public class MonsterGroup2ChangeTaskSaveStateEventTrigger : MonsterGroupEventTrigger
{
	public int taskId;

	public int taskSaveStateIndex;

	public string taskSaveStateValue;

	public override string TriggerName => "怪物组-修改任务存档事件触发器";

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
