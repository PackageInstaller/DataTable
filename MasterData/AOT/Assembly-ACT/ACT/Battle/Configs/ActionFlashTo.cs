using System;
using System.Threading;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行闪现到", "Action", new string[] { "flash", "to", "move", "movement", "position", "velocity" })]
public class ActionFlashTo : ConfigAction
{
	public enum GetFlashEndPointType
	{
		GetByV3,
		GetByEntity
	}

	public enum StartPointType
	{
		waist,
		phyPos
	}

	public ConfigFunction<EntityReference> flashTarget;

	public GetFlashEndPointType getFlashEndPointType;

	public ConfigFunction<Vector3> flashToPosition;

	public ConfigFunction<EntityReference> flashToTargetRefer;

	public Vector3 offset;

	public bool faceTo;

	public ConfigFunction<float> delay;

	private float realDelayTime;

	[Tooltip("默认为True即可")]
	public bool cancelAfterDie = true;

	public bool ignoreEntityCollision;

	public bool ignoreLockZ;

	public StartPointType startPointType;

	public override void Do(ActionMemory memory)
	{
		if (delay != null)
		{
			realDelayTime = delay.Return(memory);
		}
		else
		{
			realDelayTime = 0f;
		}
		DelayFlash(memory).Forget();
	}

	private async UniTaskVoid DelayFlash(ActionMemory memory)
	{
		Entity flashTargetValue = flashTarget?.Return(memory).entity ?? default(Entity);
		if (!flashTargetValue.IsValid)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		Vector3 flashStartPosition = Vector3.zero;
		switch (startPointType)
		{
		case StartPointType.waist:
		{
			if (memory.target.entity.GetMono().TryGetAttachPoint("waist", out var attackPoint))
			{
				flashStartPosition = attackPoint.position;
			}
			else
			{
				flashStartPosition = memory.target.entity.GetCompTransform().physicsPosition;
			}
			break;
		}
		case StartPointType.phyPos:
			flashStartPosition = memory.target.entity.GetCompTransform().physicsPosition;
			break;
		}
		Vector3 flashToPositionValue = Vector3.zero;
		float num = 0f;
		switch (getFlashEndPointType)
		{
		case GetFlashEndPointType.GetByV3:
			flashToPositionValue = flashToPosition?.Return(memory) ?? default(Vector3);
			break;
		case GetFlashEndPointType.GetByEntity:
		{
			Entity entity = flashToTargetRefer?.Return(memory).entity ?? default(Entity);
			if (entity.IsValid)
			{
				flashToPositionValue = entity.GetCompTransform().physicsPosition;
			}
			else if (flashToTargetRefer != null)
			{
				flashToPositionValue = memory.owner.GetCompTransform().physicsPosition;
				entity = memory.owner;
			}
			num = entity.GetCompTransform().size.x;
			break;
		}
		}
		if (!ignoreLockZ)
		{
			flashToPositionValue.z = flashStartPosition.z;
		}
		Vector3 world = flashToPositionValue - flashStartPosition;
		CompPhysics compPhysics = memory.caster.GetCompPhysics();
		Vector3 local = offset;
		if (compPhysics.WorldToPathLocal(world).z < 0f)
		{
			local.z *= -1f;
		}
		if (getFlashEndPointType == GetFlashEndPointType.GetByEntity)
		{
			Vector3 vector = new Vector3(0f, 0f, flashTargetValue.GetCompTransform().size.x + num);
			if (compPhysics.WorldToPathLocal(world).z < 0f)
			{
				vector.z *= -1f;
			}
			local += vector;
		}
		Vector3 targetPoint = flashToPositionValue + compPhysics.PathLocalToWorld(local);
		if (cancelAfterDie)
		{
			CancellationToken token = memory.owner.GetCompAbility().GetCancellationTokenOnDie();
			if (realDelayTime > 0f)
			{
				await UniTask.Delay(TimeSpan.FromSeconds(realDelayTime), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
		}
		else if (realDelayTime > 0f)
		{
			await UniTask.Delay(TimeSpan.FromSeconds(realDelayTime));
		}
		if (flashTargetValue.IsActive() && flashTargetValue.IsAlive())
		{
			if (!ignoreEntityCollision)
			{
				Resolve();
			}
			flashTargetValue.Teleport(targetPoint);
			if (faceTo)
			{
				flashTargetValue.SetFaceLeft((targetPoint - flashToPositionValue).x > 0f);
			}
		}
		void Resolve()
		{
			DebugUtility.DrawSphere(targetPoint, 0.2f, Color.red);
			CompTransform compTransform = flashTargetValue.GetCompTransform();
			targetPoint = ResolveOffset(flashStartPosition, targetPoint - flashStartPosition, compTransform.size, compTransform.physicsPosition);
			DebugUtility.DrawSphere(targetPoint, 0.2f, Color.green);
		}
	}

	private Vector3 ResolveOffset(Vector3 position, Vector3 resolveOffset, Vector2 size, Vector3 fallbackFoot)
	{
		float num = size.x - 0.1f;
		Vector3 characterPosition = position + new Vector3(0f, num, 0f);
		float height = Mathf.Max(0f, size.y - num * 2f);
		bool flag = PhysicsUtility.CapsuleCast(characterPosition, height, num, resolveOffset.normalized, resolveOffset.magnitude, ShouldFilter, BattleConsts.enviromentMask | BattleConsts.entityMask, out var hitResult, out var startPenetrating);
		Vector3 penetratingFix = new Vector3(0f, 0f, 0f);
		if (flag & startPenetrating)
		{
			PhysicsUtility.ComputeCapsulePenetrationFix(position + resolveOffset.normalized * hitResult.distance, size.y, num, BattleConsts.enviromentMask | BattleConsts.entityMask, ShouldFilter, out penetratingFix);
		}
		Vector3 vector = (flag ? (position + resolveOffset.normalized * hitResult.distance + (startPenetrating ? penetratingFix : Vector3.zero)) : (position + resolveOffset));
		Vector3 dir = ((resolveOffset.sqrMagnitude > 1E-08f) ? resolveOffset.normalized : Vector3.zero);
		int num2;
		if ((flag & startPenetrating) && hitResult.distance > 0f)
		{
			num2 = (HasIntoSurfaceStartPenetrating(position, size.y, num, dir, resolveOffset.magnitude) ? 1 : 0);
			if (num2 != 0)
			{
				goto IL_0165;
			}
		}
		else
		{
			num2 = 0;
		}
		if (!IsFlashPoseInsideEnvironment(vector, size, num))
		{
			goto IL_0165;
		}
		int num3 = ((!IsFlashPoseInsideEnvironment(fallbackFoot, size, num)) ? 1 : 0);
		goto IL_0166;
		IL_0165:
		num3 = 0;
		goto IL_0166;
		IL_0166:
		bool flag2 = (byte)num3 != 0;
		if (((uint)num2 | (flag2 ? 1u : 0u)) != 0)
		{
			vector = fallbackFoot;
		}
		return vector;
	}

	private bool ShouldFilter(Collider collider)
	{
		if (collider.gameObject.layer == 6)
		{
			IColliderEntityRef entityRef = PhysicsUtility.GetEntityRef(collider);
			if (entityRef != null)
			{
				MonoEntity monoEntity = entityRef?.GetMonoEntity();
				if (monoEntity != null && monoEntity.entity.IsBehaveEntity())
				{
					CompPhysics compPhysics = monoEntity.entity.GetCompPhysics();
					if (compPhysics != null && compPhysics.overlapEntityMode == OverlapEntityMode.Uncrossable)
					{
						return false;
					}
				}
				return true;
			}
		}
		return false;
	}

	private bool IsFlashPoseInsideEnvironment(Vector3 foot, Vector2 size, float radius)
	{
		float num = Mathf.Max(0f, radius);
		float num2 = Mathf.Max(size.y, num * 2f);
		Vector3 vector = foot + new Vector3(0f, num, 0f);
		Vector3 point = foot + new Vector3(0f, num2 - num, 0f);
		Vector3 point2 = foot + new Vector3(0f, num2 * 0.5f, 0f);
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		try
		{
			int layerMask = BattleConsts.enviromentMask | BattleConsts.entityMask;
			int num3 = Physics.OverlapCapsuleNonAlloc(vector, point, num, cacheColliders, layerMask);
			for (int i = 0; i < num3; i++)
			{
				Collider collider = cacheColliders[i];
				if (!(collider == null) && !ShouldFilter(collider) && !(collider is MeshCollider { convex: false }) && (IsPointInsideCollider(collider, point2) || IsPointInsideCollider(collider, vector)))
				{
					return true;
				}
			}
			return false;
		}
		finally
		{
			PhysicsUtility.Release(cacheColliders);
		}
	}

	private static bool IsPointInsideCollider(Collider col, Vector3 point)
	{
		return (col.ClosestPoint(point) - point).sqrMagnitude <= 1E-08f;
	}

	private bool HasIntoSurfaceStartPenetrating(Vector3 foot, float height, float radius, Vector3 dir, float dist)
	{
		if (dir.sqrMagnitude < 1E-08f || dist <= 0f)
		{
			return false;
		}
		Vector3 vector = foot + new Vector3(0f, radius, 0f);
		Vector3 point = vector + new Vector3(0f, Mathf.Max(0f, height - radius * 2f), 0f);
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		try
		{
			int num = Physics.CapsuleCastNonAlloc(vector, point, radius, dir, cacheHits, dist, BattleConsts.enviromentMask | BattleConsts.entityMask);
			for (int i = 0; i < num; i++)
			{
				RaycastHit raycastHit = cacheHits[i];
				if (!(raycastHit.collider == null) && !ShouldFilter(raycastHit.collider) && !(raycastHit.distance > 0f) && !(raycastHit.collider.transform.rotation != Quaternion.identity) && !(raycastHit.normal.sqrMagnitude < 1E-08f) && Vector3.Dot(raycastHit.normal.normalized, dir) < -0.1f)
				{
					return true;
				}
			}
			return false;
		}
		finally
		{
			PhysicsUtility.Release(cacheHits);
		}
	}
}
