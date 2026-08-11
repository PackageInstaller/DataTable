using System;
using UnityEngine;

namespace Ase;

[Serializable]
public struct KinematicCharacterMotorState
{
	public Vector3 Position;

	public Quaternion Rotation;

	public Vector3 BaseVelocity;

	public bool MustUnground;

	public float MustUngroundTime;

	public bool LastMovementIterationFoundAnyGround;

	public CharacterTransientGroundingReport GroundingStatus;

	public Rigidbody AttachedRigidbody;

	public Vector3 AttachedRigidbodyVelocity;
}
