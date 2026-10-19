using System.Collections.Generic;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class BaseFindTargetsByArea : BaseFindTargets
{
	public static void AddTarget(FindTargetResult result, BSet<FindTargetResult> results)
	{
		foreach (FindTargetResult result2 in results)
		{
			if (!result.Equals(result2))
			{
				continue;
			}
			FindTargetResult findTargetResult = default;
			findTargetResult = result;
			bool isParryOnlyBodyPart = result.IsParryOnlyBodyPart;
			bool isParryOnlyBodyPart2 = result2.IsParryOnlyBodyPart;
			if (isParryOnlyBodyPart != isParryOnlyBodyPart2)
			{
				if (isParryOnlyBodyPart2)
				{
					results.Remove(result2);
					results.Add(findTargetResult);
				}
			}
			else if (result.BodyPriority > result2.BodyPriority)
			{
				results.Remove(result2);
				results.Add(findTargetResult);
			}
			else if (result.BodyPriority == result2.BodyPriority && result.sqrDis < result2.sqrDis)
			{
				results.Remove(result2);
				results.Add(findTargetResult);
			}
			return;
		}
		results.Add(result);
	}

	public static (bool, FindTargetResult) GetResult(Vector3 anchor, Collider collider, Vector3 touchForward)
	{
		Damageable componentInParent = collider.GetComponentInParent<Damageable>();
		if ((bool)componentInParent)
		{
			Vector3 position = componentInParent.transform.position;
			FindTargetResult item = FindTargetResult.Damageable(componentInParent, (anchor - position).sqrMagnitude, position, collider);
			return (true, item);
		}
		return PhysicsUtility.GetEntityRef(collider)?.FindResult(anchor, touchForward) ?? (false, default);
	}

	public static void AddTargetByCollider(Vector3 anchor, Collider collider, BSet<FindTargetResult> results)
	{
		var (flag, result) = GetResult(anchor, collider, Vector3.zero);
		if (flag)
		{
			AddTarget(result, results);
		}
	}

	public static Quaternion GetReferenceEntityFaceDirRot(Entity referenceEntity)
	{
		if (!referenceEntity.TryGetCompPhysics(out CompPhysics component))
		{
			return referenceEntity.GetRootTransform()?.rotation ?? Quaternion.identity;
		}
		return component.faceDirRot;
	}

	public static void TargetBoundsLocalToWorld(Entity referenceEntity, TargetBounds targetBounds, out Bounds bounds, out Quaternion quaternion, out Vector3 anchor)
	{
		TargetBoundsLocalToWorld(referenceEntity, GetReferenceEntityFaceDirRot(referenceEntity), referenceEntity.GetCompTransform().physicsPosition, targetBounds, out bounds, out quaternion, out anchor);
	}

	public static void TargetBoundsLocalToWorld(Entity referenceEntity, TargetSectorBounds targetSectorBounds, out Bounds bounds, out Quaternion quaternion, out Vector3 anchor)
	{
		TargetBoundsLocalToWorld(referenceEntity, GetReferenceEntityFaceDirRot(referenceEntity), referenceEntity.GetCompTransform().physicsPosition, targetSectorBounds, out bounds, out quaternion, out anchor);
	}

	public static void TargetBoundsLocalToWorld(Entity referenceEntity, Quaternion faceDirRot, Vector3 physicsPosition, TargetSectorBounds targetSectorBounds, out Bounds bounds, out Quaternion quaternion, out Vector3 anchor)
	{
		Vector3 center = physicsPosition + faceDirRot * targetSectorBounds.bounds.center;
		bounds = new Bounds(center, targetSectorBounds.bounds.size);
		quaternion = faceDirRot * Quaternion.Euler(targetSectorBounds.localEulerAngle);
		MonoEntity mono = referenceEntity.GetMono();
		Transform transform = (mono ? mono.GetAttachPoint(targetSectorBounds.attachPoint) : null);
		if (transform != null)
		{
			anchor = transform.position;
		}
		else
		{
			anchor = physicsPosition + faceDirRot * targetSectorBounds.anchor;
		}
	}

	public static void TargetBoundsLocalToWorld(Entity referenceEntity, Quaternion faceDirRot, Vector3 physicsPosition, TargetBounds targetBounds, out Bounds bounds, out Quaternion quaternion, out Vector3 anchor)
	{
		Vector3 center = physicsPosition + faceDirRot * targetBounds.bounds.center;
		bounds = new Bounds(center, targetBounds.bounds.size);
		quaternion = faceDirRot * Quaternion.Euler(targetBounds.localEulerAngle);
		MonoEntity mono = referenceEntity.GetMono();
		Transform transform = (mono ? mono.GetAttachPoint(BattleConsts.AIM_ATTACH_POINT) : null);
		if (transform != null)
		{
			anchor = transform.position;
		}
		else
		{
			anchor = physicsPosition + faceDirRot * targetBounds.anchor;
		}
	}

	public static void FindSectorBoundsTargets(Entity referenceEntity, ref TargetSectorBounds targetSectorBounds, int mask, List<FindTargetResult> results, bool needDirRot = true, bool useRootPos = false)
	{
		Quaternion faceDirRot = (needDirRot ? GetReferenceEntityFaceDirRot(referenceEntity) : Quaternion.Euler(0f, 90f, 0f));
		Vector3 physicsPosition = referenceEntity.GetCompTransform().physicsPosition;
		if (targetSectorBounds.attachPoint != null && referenceEntity.GetEntityType() == EntityType.Character)
		{
			Transform attachPoint = referenceEntity.GetMono().GetAttachPoint(targetSectorBounds.attachPoint);
			if (attachPoint != null)
			{
				targetSectorBounds.UpdatePhysicCollideInfo(FindBoundsTargets(faceDirRot, physicsPosition, targetSectorBounds, mask, results, attachPoint.position));
			}
		}
		targetSectorBounds.UpdatePhysicCollideInfo(FindBoundsTargets(faceDirRot, useRootPos ? referenceEntity.GetRootTransform().position : physicsPosition, targetSectorBounds, mask, results));
	}

	public static void FindBoundsTargets(Entity referenceEntity, TargetBounds targetBounds, int mask, List<FindTargetResult> results, bool needDirRot = true, bool useRootPos = false)
	{
		MonoEntity mono = referenceEntity.GetMono();
		if ((object)mono != null && mono.TryGetAttachPoint(BattleConsts.AIM_ATTACH_POINT, out var attackPoint) && targetBounds.anchor == Vector3.zero)
		{
			FindBoundsTargets(needDirRot ? GetReferenceEntityFaceDirRot(referenceEntity) : Quaternion.Euler(0f, 90f, 0f), referenceEntity.GetCompTransform().physicsPosition, targetBounds, mask, results, attackPoint.position + new Vector3(0f, 0.25f, 0f));
		}
		else
		{
			FindBoundsTargets(needDirRot ? GetReferenceEntityFaceDirRot(referenceEntity) : Quaternion.Euler(0f, 90f, 0f), useRootPos ? referenceEntity.GetRootTransform().position : referenceEntity.GetCompTransform().physicsPosition, targetBounds, mask, results);
		}
	}

	private static void FindBoundsTargetsInternal(Vector3 boundsCenter, Vector3 boundsExtents, Quaternion boundRotation, int mask, Vector3 anchor, List<FindTargetResult> results)
	{
		BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get();
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		int num = Physics.OverlapBoxNonAlloc(boundsCenter, boundsExtents, cacheColliders, boundRotation, mask);
		for (int i = 0; i < num; i++)
		{
			AddTargetByCollider(anchor, cacheColliders[i], bSet);
		}
		PhysicsUtility.Release(cacheColliders);
		foreach (FindTargetResult item in bSet)
		{
			results.Add(item);
		}
		BSetPool<FindTargetResult>.Default.Recycle(bSet);
	}

	public static (Vector3, Vector3, Quaternion) FindBoundsTargets(Quaternion faceDirRot, Vector3 physicsPosition, TargetSectorBounds targetSectorBounds, int mask, List<FindTargetResult> results, Vector3 attachPoint = default(Vector3))
	{
		Quaternion quaternion = Quaternion.Euler(targetSectorBounds.localEulerAngle);
		Bounds sectorBounds = targetSectorBounds.GetSectorBounds();
		sectorBounds.extents = sectorBounds.extents;
		sectorBounds.center = quaternion * sectorBounds.center + targetSectorBounds.center;
		Vector3 anchor = physicsPosition + faceDirRot * targetSectorBounds.anchor;
		if (attachPoint != Vector3.zero)
		{
			anchor = attachPoint;
		}
		Vector3 vector = physicsPosition + faceDirRot * sectorBounds.center;
		Vector3 extents = sectorBounds.extents;
		Quaternion quaternion2 = faceDirRot * quaternion;
		FindBoundsTargetsInternal(vector, extents, quaternion2, mask, anchor, results);
		return (vector, extents * 2f, quaternion2);
	}

	public static void FindBoundsTargets(Quaternion faceDirRot, Vector3 physicsPosition, Bounds bounds, Vector3 localEulerAngle, Vector3 targetAnchor, int mask, List<FindTargetResult> results, Vector3 attachPoint = default(Vector3))
	{
		Vector3 boundsCenter = physicsPosition + faceDirRot * bounds.center;
		Vector3 extents = bounds.extents;
		Quaternion boundRotation = faceDirRot * Quaternion.Euler(localEulerAngle);
		Vector3 anchor = physicsPosition + faceDirRot * targetAnchor;
		if (attachPoint != Vector3.zero)
		{
			anchor = attachPoint;
		}
		FindBoundsTargetsInternal(boundsCenter, extents, boundRotation, mask, anchor, results);
	}

	public static void FindBoundsTargets(Quaternion faceDirRot, Vector3 physicsPosition, TargetBounds targetBounds, int mask, List<FindTargetResult> results, Vector3 attachPoint = default(Vector3))
	{
		FindBoundsTargets(faceDirRot, physicsPosition, targetBounds.bounds, targetBounds.localEulerAngle, targetBounds.anchor, mask, results, attachPoint);
	}
}
