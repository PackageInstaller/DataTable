using Cysharp.Threading.Tasks;

namespace Ase;

[Trigger("对话链2任务事件触发器")]
public class Dialogue2TaskEventTrigger : DialogueChainEventTrigger
{
	public int taskId;

	public int deltaValue;

	public TaskSystem.TaskOptionType changeType;

	public override string TriggerName => "NPC-任务事件触发器";

	protected override async UniTask DoExecuteAsync()
	{
		if (changeType == TaskSystem.TaskOptionType.Finished)
		{
			sceneSystem.GetSystem<TaskSystem>().FinishTask(taskId);
		}
		else if (changeType == TaskSystem.TaskOptionType.Updated)
		{
			sceneSystem.GetSystem<TaskSystem>().UpdateTaskProcess(taskId, deltaValue);
		}
		else if (changeType == TaskSystem.TaskOptionType.Updated)
		{
			sceneSystem.GetSystem<TaskSystem>().ClientTriggerTask(taskId);
		}
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
	}
}
