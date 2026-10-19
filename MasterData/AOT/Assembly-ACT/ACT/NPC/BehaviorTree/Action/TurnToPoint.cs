using ACT.Battle;
using ACT.NPC.BehaviorTree.Variables;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Action;

[TaskCategory("NPC")]
[TaskDescription("转向目标点")]
public class TurnToPoint : NpcActionBase
{
	public SharedNpcPatrolParam patrolParam;

	public override TaskStatus OnUpdate()
	{
		base.OnFixedUpdate();
		NpcPatrolParam npcPatrolParam = patrolParam?.Value;
		Transform modelTrans = OwnerEntity.GetModelTrans();
		CompNpc compNpc = OwnerEntity.GetCompNpc();
		if (npcPatrolParam == null || modelTrans == null || compNpc == null)
		{
			return TaskStatus.Failure;
		}
		compNpc.BeginMove(modelTrans.position, npcPatrolParam.patrolPoint);
		Vector3 vector = npcPatrolParam.patrolPoint - modelTrans.position;
		vector.y = 0f;
		if (vector != Vector3.zero)
		{
			Quaternion quaternion = Quaternion.LookRotation(vector);
			modelTrans.rotation = ((Quaternion.Angle(quaternion, modelTrans.rotation) < 0.0001f) ? quaternion : Quaternion.Lerp(modelTrans.rotation, quaternion, 0.1f));
		}
		return TaskStatus.Success;
	}
}
