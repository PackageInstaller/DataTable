using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle.PlayerAI.Task;

[TaskCategory("ACT/Player")]
[TaskDescription("玩家按键输入")]
public class BTButtonInput : Action
{
	public SharedFloat pressTime;

	private float m_Time;

	public override void OnStart()
	{
		m_Time = 0f;
		base.OnStart();
	}

	public override TaskStatus OnUpdate()
	{
		m_Time += MonoECS.instance.mainEntity.GetCompTime().fixedDeltaTime;
		if (!(m_Time >= pressTime.Value))
		{
			return TaskStatus.Running;
		}
		return TaskStatus.Success;
	}
}
