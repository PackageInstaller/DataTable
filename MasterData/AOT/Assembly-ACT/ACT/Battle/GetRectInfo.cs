using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("获得目标矩阵信息，一直返回running,没有找到对象的信息返回failure")]
public class GetRectInfo : Action
{
	public Vector3 size;

	public Vector3 onLadderSize;

	public Vector3 offest;

	public Vector3 onLadderOffest;

	public SharedVector3 targetPos;

	public SharedBool inRect;

	public SharedBool inLadder;

	public bool startRotateX;

	private Bounds bounds;

	private Entity flyEntity;

	private Entity target;

	public override void OnStart()
	{
		flyEntity = (Owner as ActBehaviorTree).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		if (MonoECS.instance.mainEntity != null)
		{
			target = MonoECS.instance.mainEntity;
			CompTransform compTransform = target.GetCompTransform();
			CompPhysics compPhysics = target.GetCompPhysics();
			CompTransform compTransform2 = flyEntity.GetCompTransform();
			bounds.center = compTransform.physicsPosition + ((compPhysics.state != ACTMovementMode.Climbing) ? offest : onLadderOffest);
			bounds.size = ((compPhysics.state != ACTMovementMode.Climbing) ? size : onLadderSize);
			targetPos.Value = bounds.ClosestPoint(compTransform2.physicsPosition);
			inRect.Value = bounds.Contains(compTransform2.physicsPosition);
			inLadder.Value = compPhysics.state == ACTMovementMode.Climbing;
			return TaskStatus.Running;
		}
		return TaskStatus.Failure;
	}
}
