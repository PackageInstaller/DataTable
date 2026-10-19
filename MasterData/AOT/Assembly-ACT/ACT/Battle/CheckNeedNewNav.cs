using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃")]
[TaskDescription("判断是否需要新的路径")]
public class CheckNeedNewNav : Conditional
{
	private Vector2 playPos;

	public override void OnStart()
	{
		playPos = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
	}

	public override TaskStatus OnUpdate()
	{
		if (MonoECS.instance.mainEntity.GetCompTransform().physicsPosition.Equals(playPos))
		{
			return TaskStatus.Running;
		}
		return TaskStatus.Success;
	}
}
