using System;
using System.Diagnostics;
using UnityEngine;

namespace T0World;

public abstract class MoveStateBase : PlayerState
{
	protected enum Turning
	{
		L,
		R
	}

	protected const Turning PREFERED_TURNING = Turning.R;

	protected Turning turning = Turning.R;

	public Transform PlayerTrs => moveBrain.player;

	public PlayerMoveAnimBrain.MoveState MoveState
	{
		get
		{
			return moveBrain.moveState;
		}
		set
		{
			moveBrain.moveState = value;
		}
	}

	public Vector3 MoveDir => moveBrain.MoveInput;

	[Conditional("UNITY_EDITOR")]
	protected void DebugDraw(Vector3 dir, Color color)
	{
	}

	public static Vector2 ToVec2XZ(Vector3 v)
	{
		return new Vector2(v.x, v.z);
	}

	public static Vector3 ToVec3(Vector2 v)
	{
		return new Vector3(v.x, 0f, v.y).normalized;
	}

	protected Quaternion CalcCompensation(Vector3 refVec, Vector3 movingV3, float maxTurning)
	{
		Quaternion result;
		if (Vector3.Dot(refVec, movingV3) <= MathF.PI * -113f / 355f)
		{
			result = Quaternion.Euler(0f, (turning == Turning.L) ? (0f - maxTurning) : maxTurning, 0f);
		}
		else if (Vector3.Dot(refVec, movingV3) >= MathF.PI * 113f / 355f)
		{
			result = Quaternion.identity;
		}
		else
		{
			Quaternion quaternion = Quaternion.LookRotation(refVec, Vector3.up);
			Quaternion quaternion2 = Quaternion.RotateTowards(quaternion, Quaternion.LookRotation(movingV3, Vector3.up), maxTurning);
			float y = (Quaternion.Inverse(quaternion) * quaternion2).eulerAngles.y;
			result = Quaternion.Euler(0f, y, 0f);
			turning = ((!(y < 0f)) ? Turning.R : Turning.L);
		}
		return result;
	}

	public MoveStateBase(PlayerMoveAnimBrain stateMachine)
		: base(stateMachine)
	{
	}

	public override (Quaternion, Vector3) UpdateMove(float dt)
	{
		return (base.Animancer.Animator.deltaRotation, base.Animancer.Animator.deltaPosition);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
	}
}
