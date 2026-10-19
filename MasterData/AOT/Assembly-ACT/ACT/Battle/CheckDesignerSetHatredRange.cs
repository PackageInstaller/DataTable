using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("判断关卡有没有配置仇恨范围，有配置就返回True，没有配置就返回False(节点废弃）")]
public class CheckDesignerSetHatredRange : Conditional
{
	protected Entity m_Entity;

	private Vector3 size;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		size = m_Entity.GetCompAI().hatredSize;
	}

	public override TaskStatus OnUpdate()
	{
		if (size != Vector3.zero)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
