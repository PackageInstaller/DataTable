using UnityEngine;

namespace ACT.Battle;

public class CompFollow : EcsComponent
{
	public Transform FollowTarget { get; set; }

	public Vector3 PositionOffset { get; set; }

	public Quaternion RotationOffset { get; set; }

	public FollowPlatformMotionSource PlatformMotionSource { get; set; }

	public Rigidbody FollowRigidbody { get; set; }

	public Vector3 LastPhysicsPosition { get; private set; }

	public Vector3 PhysicsPosition { get; private set; }

	public Quaternion LastPhysicsRotation { get; private set; }

	public Quaternion PhysicsRotation { get; private set; }

	protected override void OnGet()
	{
		FollowTarget = null;
		PositionOffset = Vector3.zero;
		RotationOffset = Quaternion.identity;
		PlatformMotionSource = null;
		FollowRigidbody = null;
		ResetPhysicsPose(Vector3.zero, Quaternion.identity);
	}

	protected override void OnRelease()
	{
		FollowTarget = null;
		PositionOffset = Vector3.zero;
		RotationOffset = Quaternion.identity;
		PlatformMotionSource = null;
		FollowRigidbody = null;
		ResetPhysicsPose(Vector3.zero, Quaternion.identity);
	}

	public void ResetPhysicsPose(Vector3 position, Quaternion rotation)
	{
		LastPhysicsPosition = position;
		PhysicsPosition = position;
		LastPhysicsRotation = rotation;
		PhysicsRotation = rotation;
	}

	public void UpdatePhysicsPose(Vector3 position, Quaternion rotation)
	{
		LastPhysicsPosition = PhysicsPosition;
		LastPhysicsRotation = PhysicsRotation;
		PhysicsPosition = position;
		PhysicsRotation = rotation;
	}
}
