using UnityEngine;

public struct QWCharacterMovement
{
	public Vector3 Direction;

	public float Magnitude;

	public bool UseGamePad;

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

	public QWCharacterMovement(Vector3 direction, float magnitude, bool useGamePad = false)
	{
		Direction = direction;
		Magnitude = magnitude;
		UseGamePad = useGamePad;
	}
}
