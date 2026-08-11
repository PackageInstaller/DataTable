namespace Ase;

[Trigger("怪物组2更新任务事件触发器")]
public class MonsterGroup2UpdateTaskEventTrigger : MonsterGroupEventTrigger
{
	public int taskId;

	public int deltaValue;

	public TaskSystem.TaskOptionType changeType;

	public override string TriggerName => "怪物组-更新任务事件触发器";

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
