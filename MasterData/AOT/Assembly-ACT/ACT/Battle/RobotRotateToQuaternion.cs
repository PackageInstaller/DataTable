using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class RobotRotateToQuaternion : Action
{
	public float ratDamping;

	public SharedQuaternion targetRotate;

	public bool useV3;

	public SharedVector3 targetVector3;

	public SharedBool stopRotate;

	public override TaskStatus OnUpdate()
	{
		if (stopRotate.Value)
		{
			return TaskStatus.Success;
		}
		Entity robotEntity = MonoECS.instance.localPlayer.robotEntity;
		if (!robotEntity.IsValid)
		{
			return TaskStatus.Failure;
		}
		Transform modelTrans = robotEntity.GetModelTrans();
		Quaternion localRotation = modelTrans.localRotation;
		if (useV3)
		{
			targetRotate.Value = Quaternion.Euler(targetVector3.Value);
		}
		modelTrans.localRotation = Quaternion.Lerp(localRotation, targetRotate.Value, ratDamping * Time.deltaTime);
		if (!(Quaternion.Angle(modelTrans.localRotation, targetRotate.Value) <= 0.1f))
		{
			return TaskStatus.Running;
		}
		return TaskStatus.Success;
	}
}
