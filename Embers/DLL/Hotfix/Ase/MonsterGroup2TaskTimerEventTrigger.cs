namespace Ase;

[Trigger("怪物组2开始任务倒计时触发器")]
public class MonsterGroup2TaskTimerEventTrigger : MonsterGroupEventTrigger
{
	public int taskId;

	public bool openCouneDown = true;

	public int time = 30;

	public override string TriggerName => "怪物组-开始任务倒计时触发器";

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
