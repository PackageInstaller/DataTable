namespace Ase;

[Trigger("交互物2开始任务倒计时触发器")]
public class MapItem2TaskTimerEventTrigger : MapItemEventTrigger
{
	public int taskId;

	public bool openCouneDown = true;

	public int time = 30;

	public override string TriggerName => "交互物-开始任务倒计时触发器";

	protected override void DoExecute()
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

	public override void OnDisposed()
	{
	}
}
