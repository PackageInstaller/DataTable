namespace Ase;

[Trigger("Timeline2任务倒计时事件触发器")]
public class Timeline2TaskTimerEventTrigger : TimelineEventTrigger
{
	public int taskId;

	public bool openCouneDown = true;

	public int time = 30;

	public override string TriggerName => "Timeline-任务倒计时事件触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (openCouneDown)
		{
			if (time >= 0)
			{
				sceneSystem.GetSystem<TaskSystem>().StartTimeCountDown(taskId, time);
			}
		}
		else
		{
			sceneSystem.GetSystem<TaskSystem>().StopTimeCountDown(taskId);
		}
	}
}
