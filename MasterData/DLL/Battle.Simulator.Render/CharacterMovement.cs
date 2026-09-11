using UnityEngine;

public struct CharacterMovement
{
	public Vector3 Direction;

	public float Magnitude;

	public Vector3 Value => Direction * Magnitude;

	public bool IsMoving => Value.sqrMagnitude > 0.1f;

	public bool IsRunning
	{
		get
		{
			if ((Magnitude > 0.6f) & IsMoving)
			{
				return !IsSprinting;
			}
			return false;
		}
	}

	public bool IsSprinting
	{
		get
		{
			if (Magnitude > 1.1f)
			{
				return IsMoving;
			}
			return false;
		}
	}

	public CharacterMovement(Vector3 direction, float magnitude)
	{
		Direction = direction;
		Magnitude = magnitude;
	}
}
