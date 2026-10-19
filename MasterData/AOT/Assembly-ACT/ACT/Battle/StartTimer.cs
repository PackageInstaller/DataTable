using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("开始计时，一直在Running")]
public class StartTimer : Action
{
	public SharedTimerList timers;

	public SharedUintList timerIndexList;

	public SharedFloatList timersMax;

	public SharedUintList timersCount;

	public SharedFloatList m_timerTime;

	public override TaskStatus OnUpdate()
	{
		SystemTime timeSystem = GameManager.timeSystem;
		for (int i = 0; i < timerIndexList.Value.Count; i++)
		{
			if (timeSystem.time - m_timerTime.Value[i] > (float)timersCount.Value[i])
			{
				timersCount.Value[i]++;
				Timer timer = timers.Value[(int)timerIndexList.Value[i]];
				timer.count++;
				timer.time--;
				timer.time = Mathf.Clamp(timers.Value[(int)timerIndexList.Value[i]].time, 0f, timersMax.Value[i]);
				if (timer.time == 0f && timer.maxTime != 0f)
				{
					timerIndexList.Value.Remove((uint)timer.index);
					timersMax.Value.Remove(timer.maxTime);
					m_timerTime.Value.Remove(timer.enterTime);
					timersCount.Value.Remove((uint)timer.count);
					timer.maxTime = 0f;
				}
			}
		}
		return TaskStatus.Running;
	}
}
