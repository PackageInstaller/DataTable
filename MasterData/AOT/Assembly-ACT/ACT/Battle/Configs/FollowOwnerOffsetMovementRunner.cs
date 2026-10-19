using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class FollowOwnerOffsetMovementRunner : TrajectoryMovementRunner
{
	private Entity owner;

	private Vector3 ownerOffset;

	private Quaternion rotationOffset = Quaternion.identity;

	private bool rotationOffsetInitialized;

	protected override void OnCreate()
	{
		FollowOwnerOffsetMovementPattern followOwnerOffsetMovementPattern = (FollowOwnerOffsetMovementPattern)config;
		CompProduct compProduct = bullet.GetCompProduct();
		CompTransform compTransform = bullet.GetCompTransform();
		owner = compProduct.productOwner;
		ownerOffset = Vector3.zero;
		rotationOffset = Quaternion.identity;
		if (!IsOwnerValid(owner))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"子弹{bullet} 无有效Owner，无法进行偏移跟随");
			}
			return;
		}
		ownerOffset = compTransform.physicsPosition - GetOwnerPosition(owner);
		if (followOwnerOffsetMovementPattern.syncOwnerRotation)
		{
			rotationOffset = Quaternion.Inverse(GetOwnerRotation(owner)) * compTransform.rotation;
		}
	}

	public override void FixedUpdate(float dt)
	{
		if (dt <= 0f || !bullet.IsActive())
		{
			return;
		}
		FollowOwnerOffsetMovementPattern followOwnerOffsetMovementPattern = (FollowOwnerOffsetMovementPattern)config;
		CompTransform compTransform = bullet.GetCompTransform();
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		if (!IsOwnerValid(owner))
		{
			if (!followOwnerOffsetMovementPattern.freezeWhenOwnerMissing)
			{
				(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.physicsPosition, compTransform.rotation);
				(Entity, Ability, float) message = (bullet, ability, dt);
				generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
				compTransform.UpdatePosition(nextState.Item2);
			}
			else
			{
				compVelocity.velocity = Vector3.zero;
			}
			return;
		}
		dt = owner.GetCompTime().fixedDeltaTime;
		Vector3 physicsPosition = compTransform.physicsPosition;
		Vector3 vector = (GetOwnerPosition(owner) + ownerOffset - physicsPosition) / dt;
		Vector3 item = vector;
		if (followOwnerOffsetMovementPattern.velocityModifiers != null)
		{
			Vector3 vector2 = vector;
			for (int i = 0; i < followOwnerOffsetMovementPattern.velocityModifiers.Length; i++)
			{
				vector2 = followOwnerOffsetMovementPattern.velocityModifiers[i].Modify(vector2, dt, compTrajectory.life);
			}
			item = vector2;
		}
		if (followOwnerOffsetMovementPattern.syncOwnerRotation)
		{
			if (!rotationOffsetInitialized)
			{
				rotationOffset = Quaternion.Inverse(GetOwnerRotation(owner)) * compTransform.rotation;
				rotationOffsetInitialized = true;
			}
			compTransform.rotation = GetOwnerRotation(owner) * rotationOffset;
		}
		(Vector3, Vector3, Quaternion) state2 = (item, physicsPosition, compTransform.rotation);
		(Entity, Ability, float) message2 = (bullet, ability, dt);
		generalTrajectory.Evaluate(in message2, in state2, out (Vector3, Vector3, Quaternion) nextState2);
		compTransform.UpdatePosition(nextState2.Item2);
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
		owner = default;
		ownerOffset = Vector3.zero;
		rotationOffset = Quaternion.identity;
	}

	private static bool IsOwnerValid(Entity ownerEntity)
	{
		if (ownerEntity.IsActive())
		{
			if (!ownerEntity.TryGetCompTransform(out CompTransform _))
			{
				return ownerEntity.GetRootTransform() != null;
			}
			return true;
		}
		return false;
	}

	private static Vector3 GetOwnerPosition(Entity ownerEntity)
	{
		if (ownerEntity.TryGetCompTransform(out CompTransform component))
		{
			return component.physicsPosition;
		}
		Transform rootTransform = ownerEntity.GetRootTransform();
		if (!(rootTransform != null))
		{
			return Vector3.zero;
		}
		return rootTransform.position;
	}

	private static Quaternion GetOwnerRotation(Entity ownerEntity)
	{
		if (ownerEntity.TryGetCompTransform(out CompTransform component))
		{
			return component.rotation;
		}
		Transform rootTransform = ownerEntity.GetRootTransform();
		if (!(rootTransform != null))
		{
			return Quaternion.identity;
		}
		return rootTransform.rotation;
	}
}
