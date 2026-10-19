using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class MoveDirectly : Action
{
	public float time;

	public bool left;

	private Entity m_Entity;

	private float m_Timer;

	public override void OnStart()
	{
		m_Entity = Owner.ToEntity();
		m_Entity.GetCompNav().manual = true;
		m_Entity.GetCompInput().inputDir = (left ? EInputDir.Left : EInputDir.Right);
		m_Timer = time;
	}

	public override void OnEnd()
	{
		m_Entity.GetCompNav().manual = false;
		m_Entity.GetCompInput().inputDir = EInputDir.None;
	}

	public override TaskStatus OnUpdate()
	{
		m_Timer -= Time.deltaTime;
		if (!(m_Timer < 0f))
		{
			return TaskStatus.Running;
		}
		return TaskStatus.Success;
	}
}
