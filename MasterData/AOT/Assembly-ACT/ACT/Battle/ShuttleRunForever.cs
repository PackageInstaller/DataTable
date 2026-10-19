using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("从当前位置向逐个沿着路径点移动，抵达最后一个点后重复执行。行走过程中返回running，寻路失败返回failure")]
public class ShuttleRunForever : ShuttleRun
{
	public override bool EndShuttleRun()
	{
		m_CurrentIndex %= m_Entity.GetCompAI().patrolPoints.Count;
		return false;
	}
}
