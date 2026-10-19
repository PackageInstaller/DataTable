using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("获得一个随机位置， 基于自身或者仇恨目标的位置")]
public class GetRandomPosition : Action
{
	public enum TargetType
	{
		self,
		hateTarget
	}

	public TargetType targetType;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("输出位置")]
	public SharedVector3 outputPosition;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("X轴范围")]
	public SharedVector2 rangeX;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("Y轴范围")]
	public SharedVector2 rangeY;

	private Entity m_Entity;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		switch (targetType)
		{
		case TargetType.self:
			outputPosition.Value = m_Entity.GetCompTransform().physicsPosition + new Vector3(Random.Range(rangeX.Value.x, rangeX.Value.y), Random.Range(rangeY.Value.x, rangeY.Value.y), 0f);
			break;
		case TargetType.hateTarget:
			outputPosition.Value = m_Entity.GetCompHatred().hatredTarget.GetCompTransform().physicsPosition + new Vector3(Random.Range(rangeX.Value.x, rangeX.Value.y), Random.Range(rangeY.Value.x, rangeY.Value.y), 0f);
			break;
		}
		return TaskStatus.Success;
	}
}
