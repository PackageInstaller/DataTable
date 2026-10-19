using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using Unity.Mathematics;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class RobotFaceToPlayer : Action
{
	public float ratDamping = 5f;

	public override TaskStatus OnUpdate()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		Entity robotEntity = MonoECS.instance.localPlayer.robotEntity;
		quaternion quaternion2 = ((!(mainEntity.GetCompTransform().physicsPosition.x - robotEntity.GetCompTransform().physicsPosition.x < 0f)) ? ((quaternion)Quaternion.Euler(0f, 90f, 0f)) : ((quaternion)Quaternion.Euler(0f, -90f, 0f)));
		Quaternion localRotation = robotEntity.GetModelTrans().localRotation;
		robotEntity.GetModelTrans().localRotation = Quaternion.Lerp(localRotation, quaternion2, ratDamping * Time.deltaTime);
		return TaskStatus.Running;
	}
}
