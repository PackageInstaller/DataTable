using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("设置计时器，并返回success")]
public class SetTimer : Action
{
	public SharedTimerList timers;

	public int timerIndex;

	public float timerTime;

	public SharedUintList timerIndexList;

	public SharedFloatList timersMax;

	public SharedUintList timersCount;

	public SharedFloatList m_timerTime;

	public override void OnStart()
	{
		for (int num = timerIndexList.Value.Count - 1; num >= 0; num--)
		{
			uint num2 = timerIndexList.Value[num];
			Timer timer = timers.Value[(int)num2];
			if (num2 == timerIndex)
			{
				timerIndexList.Value.Remove((uint)timerIndex);
				timersMax.Value.Remove(timer.maxTime);
				m_timerTime.Value.Remove(timer.enterTime);
				timersCount.Value.Remove((uint)timer.count);
			}
		}
		SystemTime timeSystem = GameManager.timeSystem;
		timerIndexList.Value.Add((uint)timerIndex);
		timersMax.Value.Add(timerTime);
		m_timerTime.Value.Add(timeSystem.time);
		timers.Value[timerIndex].count = 1f;
		timers.Value[timerIndex].time = timerTime;
		timers.Value[timerIndex].maxTime = timerTime;
		timers.Value[timerIndex].enterTime = timeSystem.time;
		timersCount.Value.Add((uint)timers.Value[timerIndex].count);
	}

	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}
}
