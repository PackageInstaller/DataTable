using ACT.Battle;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Action;

[TaskCategory("NPC")]
[TaskDescription("射线检测确保NPC站在地面上，如果不在地面上则让NPC掉落到地面。")]
public class EnsureGround : NpcActionBase
{
	private RaycastHit _hitInfo;

	public override TaskStatus OnUpdate()
	{
		Transform modelTrans = OwnerEntity.GetModelTrans();
		if (!modelTrans)
		{
			return TaskStatus.Failure;
		}
		if (!Physics.SphereCast(modelTrans.position + 1.7f * Vector3.up, 0.1f, Vector3.down, out _hitInfo, 5f, BattleConsts.enviromentMask))
		{
			return TaskStatus.Failure;
		}
		_hitInfo.point += _hitInfo.normal * 0.001f;
		Vector3 position = modelTrans.position;
		position.y = _hitInfo.point.y;
		modelTrans.position = position;
		return TaskStatus.Success;
	}
}
