using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断拥有者目标碰撞", "Predicate", new string[] { "check", "owner", "target", "collision", "retarget", "aim", "predicate", "condition" })]
public class CheckOwnerTargetCollisionPredicate : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		Vector3 physicsPosition = memory.owner.GetCompTransform().physicsPosition;
		Vector3 direction = ((memory.target.targetSourceType == FindTargetResult.TargetSourceType.Damageable) ? memory.target.damageable.transform.position : memory.target.entity.GetCompTransform().physicsPosition) - physicsPosition;
		RaycastHit hitInfo;
		return !Physics.Raycast(physicsPosition, direction, out hitInfo, direction.magnitude, BattleConsts.enviromentMask);
	}
}
