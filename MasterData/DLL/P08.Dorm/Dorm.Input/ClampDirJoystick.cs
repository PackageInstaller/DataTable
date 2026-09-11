using System;
using System.Collections.Generic;
using UnityEngine;

namespace Dorm.Input;

public class ClampDirJoystick : P08JoystickController
{
	[Flags]
	public enum DirMask
	{
		None = 0,
		Left = 1,
		Right = 2,
		Up = 4,
		Down = 8,
		LeftUp = 0x10,
		RightUp = 0x20,
		LeftDown = 0x40,
		RightDown = 0x80
	}

	public DirMask dirMask;

	private static readonly Vector2 leftUpNormalized = new Vector2(-1f, 1f).normalized;

	private static readonly Vector2 leftDownNormalized = new Vector2(-1f, -1f).normalized;

	private static readonly Vector2 rightUpNormalized = new Vector2(1f, 1f).normalized;

	private static readonly Vector2 rightDownNormalized = new Vector2(1f, -1f).normalized;

	private static IEnumerable<Vector2> EnumerateInputDirByMask(DirMask mask)
	{
		if (mask.HasFlag(DirMask.Left))
		{
			yield return Vector2.left;
		}
		if (mask.HasFlag(DirMask.Right))
		{
			yield return Vector2.right;
		}
		if (mask.HasFlag(DirMask.Up))
		{
			yield return Vector2.up;
		}
		if (mask.HasFlag(DirMask.Down))
		{
			yield return Vector2.down;
		}
		if (mask.HasFlag(DirMask.LeftUp))
		{
			yield return leftUpNormalized;
		}
		if (mask.HasFlag(DirMask.RightUp))
		{
			yield return rightUpNormalized;
		}
		if (mask.HasFlag(DirMask.LeftDown))
		{
			yield return leftDownNormalized;
		}
		if (mask.HasFlag(DirMask.RightDown))
		{
			yield return rightDownNormalized;
		}
	}

	private Vector2 GetDirClamped(Vector2 input)
	{
		if (dirMask == DirMask.None)
		{
			return input;
		}
		float num = 0f;
		Vector2 vector = Vector2.zero;
		foreach (Vector2 item in EnumerateInputDirByMask(dirMask))
		{
			float num2 = Vector2.Dot(item, input);
			if (num2 > num)
			{
				num = num2;
				vector = item;
			}
		}
		return vector * input.magnitude;
	}

	protected override void UpdateOperationLogic()
	{
		if (!(moveAreaRect == null))
		{
			Vector3 vector = GetDirClamped(base.PointerPosition);
			vector.z = 0f;
			if (vector.magnitude >= moveAreaDeadRadius)
			{
				joystickForwardVector = vector.normalized;
			}
		}
	}

	private void UpdateJoystickCapDisplay(Vector2 dir)
	{
		joystickCap.localPosition = dir * moveAreaRadius;
	}

	private void Update()
	{
		if (inited)
		{
			if (base._block)
			{
				UpdateGamepad();
				UpdateOperationLogic();
			}
			joystickForwardVector = GetDirClamped(joystickForwardVector);
			UpdateJoystickCapDisplay(joystickForwardVector);
			if (base.updateGameLogic != null)
			{
				base.updateGameLogic.UpdateLogic(joystickForwardVector);
			}
			joystickForwardVector = Vector2.zero;
		}
	}
}
