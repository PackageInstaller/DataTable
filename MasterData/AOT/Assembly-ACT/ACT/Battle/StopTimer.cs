using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/废弃")]
[TaskDescription("结束计时")]
public class StopTimer : Conditional
{
	public SharedTimerList timers;

	public int timerIndex;

	public SharedUintList timerIndexList;

	public SharedFloatList timersMax;

	public SharedUintList timersCount;

	public SharedFloatList m_timerTime;

	public override void OnStart()
	{
		timerIndexList.Value.Remove((uint)timers.Value[timerIndex].index);
		timersMax.Value.Remove(timers.Value[timerIndex].maxTime);
		m_timerTime.Value.Remove(timers.Value[timerIndex].enterTime);
		timersCount.Value.Remove(timersCount.Value[timerIndex]);
		timers.Value[timerIndex].maxTime = 0f;
		timers.Value[timerIndex].time = 0f;
	}
}
