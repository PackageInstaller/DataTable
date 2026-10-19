using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/废弃")]
[TaskDescription("判断计时器是否计时结束，结束返回success，否则返回Failure")]
public class EstimateTimer : Conditional
{
	public SharedTimerList timers;

	public int timerIndex;

	public SharedUintList timerIndexList;

	public SharedFloatList timersMax;

	public SharedUintList timersCount;

	public SharedFloatList m_timerTime;

	private int m_timerIndex;

	public override void OnStart()
	{
		for (int i = 0; i < timers.Value.Count; i++)
		{
			if (timers.Value[i].index == timerIndex)
			{
				m_timerIndex = i;
			}
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (timers.Value[m_timerIndex].time != 0f)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
