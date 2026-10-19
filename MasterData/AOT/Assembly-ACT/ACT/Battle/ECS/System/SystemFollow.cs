using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.ECS.System;

public class SystemFollow : EntitySystem
{
	private Filter _filter;

	private EntityAction<CompFollow> _fixedUpdateFollowerAction;

	private EntityAction<CompFollow> _updateFollowerAction;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompFollow>().Build();
		_fixedUpdateFollowerAction = FixedUpdateFollower;
		_updateFollowerAction = UpdateFollower;
	}

	public override void FixedUpdate()
	{
		_filter.ForEachStable(_fixedUpdateFollowerAction);
	}

	public override void Update()
	{
		_filter.ForEachStable(_updateFollowerAction);
	}

	private void FixedUpdateFollower(Entity entity, CompFollow compFollow)
	{
		Transform followTarget = compFollow.FollowTarget;
		if ((bool)followTarget)
		{
			CalculateFixedFollowPose(compFollow, followTarget, out var position, out var rotation);
			compFollow.PlatformMotionSource?.SyncPose(position, rotation);
			compFollow.UpdatePhysicsPose(position, rotation);
			CompTransform compTransform = entity.GetCompTransform();
			compTransform.UpdatePosition(position);
			compTransform.rotation = rotation;
			entity.GetRootTransform().SetPositionAndRotation(compTransform.physicsPosition, compTransform.rotation);
		}
	}

	private static void CalculateFixedFollowPose(CompFollow compFollow, Transform follow, out Vector3 position, out Quaternion rotation)
	{
		Rigidbody followRigidbody = compFollow.FollowRigidbody;
		if (followRigidbody == null || (follow != followRigidbody.transform && !follow.IsChildOf(followRigidbody.transform)))
		{
			position = follow.TransformPoint(compFollow.PositionOffset);
			rotation = follow.rotation * compFollow.RotationOffset;
			return;
		}
		Transform transform = followRigidbody.transform;
		Vector3 vector = transform.InverseTransformPoint(follow.position);
		Quaternion quaternion = Quaternion.Inverse(transform.rotation) * follow.rotation;
		Vector3 vector2 = followRigidbody.position + followRigidbody.rotation * vector;
		Quaternion quaternion2 = followRigidbody.rotation * quaternion;
		position = vector2 + quaternion2 * compFollow.PositionOffset;
		rotation = quaternion2 * compFollow.RotationOffset;
	}

	private void UpdateFollower(Entity entity, CompFollow compFollow)
	{
		if (!entity.IsTickAvailable() || entity.HasComponent<CompPhysics>())
		{
			return;
		}
		Transform rootTransform = entity.GetRootTransform();
		if ((bool)rootTransform)
		{
			float fixedDeltaTime = Time.fixedDeltaTime;
			float t = ((fixedDeltaTime > 0f) ? Mathf.Clamp01((Time.time - Time.fixedTime) / fixedDeltaTime) : 1f);
			Vector3 a = compFollow.LastPhysicsPosition;
			Vector3 position = compFollow.PhysicsPosition;
			Quaternion a2 = compFollow.LastPhysicsRotation;
			Quaternion rotation = compFollow.PhysicsRotation;
			Transform followTarget = compFollow.FollowTarget;
			Rigidbody followRigidbody = compFollow.FollowRigidbody;
			if ((bool)followTarget && (bool)followRigidbody && (followTarget == followRigidbody.transform || followTarget.IsChildOf(followRigidbody.transform)))
			{
				a = compFollow.PhysicsPosition;
				a2 = compFollow.PhysicsRotation;
				CalculateFixedFollowPose(compFollow, followTarget, out position, out rotation);
			}
			Vector3 position2 = Vector3.Lerp(a, position, t);
			Quaternion rotation2 = Quaternion.Slerp(a2, rotation, t);
			rootTransform.SetPositionAndRotation(position2, rotation2);
		}
	}
}
