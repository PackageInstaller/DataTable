using System;
using UnityEngine;

public class DormStickController : IStickControllerGameLogic, IMoveController
{
	public Func<DormStickController, bool> StartMoving;

	public Action<DormStickController> StopMoving;

	private bool moving;

	public Vector3 InputVec { get; private set; }

	public Action<Vector2> OnMovingRawInputUpdate { get; internal set; }

	public Vector3 GetMovingVec()
	{
		return InputVec;
	}

	private void SendStopMove(bool force = false)
	{
		SetRoleInputVec(Vector3.zero);
		if (moving | force)
		{
			StopMoving?.Invoke(this);
		}
		moving = false;
	}

	private void SetRoleInputVec(Vector3 vec)
	{
		InputVec = vec;
	}

	private bool SendMoveDirection(Vector3 inputDirection)
	{
		SetRoleInputVec(inputDirection);
		if (!moving)
		{
			moving = StartMoving?.Invoke(this) ?? true;
			return true;
		}
		return false;
	}

	public void UpdateLogic(Vector2 joystickForwardVector)
	{
		Vector3 inputDirection = new Vector3(joystickForwardVector.x, 0f, joystickForwardVector.y);
		if (inputDirection.sqrMagnitude <= Mathf.Epsilon)
		{
			SendStopMove();
		}
		else if (!SendMoveDirection(inputDirection))
		{
			OnMovingRawInputUpdate?.Invoke(joystickForwardVector);
		}
	}

	internal void ResetIsMovingStarted()
	{
		moving = false;
	}
}
