using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断目标中边界", "Predicate", new string[] { "check", "target", "in", "bound", "retarget", "aim", "predicate", "condition" })]
public class CheckTargetInBound : ConfigPredicate
{
	public TargetBounds targetBounds;

	public override bool Check(ActionMemory memory)
	{
		Vector3 physicsPosition = memory.target.entity.GetCompTransform().physicsPosition;
		Entity owner = memory.owner;
		CompTransform compTransform = owner.GetCompTransform();
		Quaternion quaternion = ((owner.GetMono() != null) ? BaseFindTargetsByArea.GetReferenceEntityFaceDirRot(owner) : compTransform.rotation);
		Vector3 boundsCenter = compTransform.physicsPosition + quaternion * targetBounds.center;
		Vector3 extents = targetBounds.bounds.extents;
		Quaternion boundRotation = quaternion * Quaternion.Euler(targetBounds.localEulerAngle);
		return PhysicsUtility.IsPositionInsideBounds(boundsCenter, extents, boundRotation, physicsPosition);
	}
}
