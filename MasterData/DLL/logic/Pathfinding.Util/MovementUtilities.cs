using System;
using UnityEngine;

namespace Pathfinding.Util;

public static class MovementUtilities
{
	public static Vector2 ClampVelocity(Vector2 velocity, float maxSpeed, float slowdownFactor, bool slowWhenNotFacingTarget, Vector2 forward)
	{
		//IL_011c: Unknown result type (might be due to invalid IL or missing references)
		//IL_011e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0105: Unknown result type (might be due to invalid IL or missing references)
		//IL_0110: Unknown result type (might be due to invalid IL or missing references)
		//IL_0116: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		float num = maxSpeed * Mathf.Sqrt(Mathf.Min(1f, slowdownFactor));
		if (slowWhenNotFacingTarget && (forward.x != 0f || forward.y != 0f))
		{
			Vector2 val = VectorMath.Normalize(velocity, out var magnitude);
			float num2 = Vector2.Dot(val, forward);
			float num3 = Mathf.Clamp(num2 + 0.707f, 0.2f, 1f);
			num *= num3;
			magnitude = Mathf.Min(magnitude, num);
			float num4 = Mathf.Acos(Mathf.Clamp(num2, -1f, 1f));
			num4 = Mathf.Min(num4, (20f + 180f * Mathf.Clamp01(1f - slowdownFactor)) * (MathF.PI / 180f));
			float num5 = Mathf.Sin(num4);
			float num6 = Mathf.Cos(num4);
			num5 *= Mathf.Sign(val.x * forward.y - val.y * forward.x);
			return new Vector2(forward.x * num6 + forward.y * num5, forward.y * num6 - forward.x * num5) * magnitude;
		}
		return Vector2.ClampMagnitude(velocity, num);
	}

	public static Vector2 CalculateAccelerationToReachPoint(Vector2 deltaPosition, Vector2 targetVelocity, Vector2 currentVelocity, float acceleration, float maxSpeed)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0156: Unknown result type (might be due to invalid IL or missing references)
		//IL_015b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0166: Unknown result type (might be due to invalid IL or missing references)
		//IL_0167: Unknown result type (might be due to invalid IL or missing references)
		//IL_0187: Unknown result type (might be due to invalid IL or missing references)
		//IL_018c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0191: Unknown result type (might be due to invalid IL or missing references)
		//IL_0195: Unknown result type (might be due to invalid IL or missing references)
		//IL_019c: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00de: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_0100: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_012b: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		//IL_0137: Unknown result type (might be due to invalid IL or missing references)
		//IL_013d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_0147: Unknown result type (might be due to invalid IL or missing references)
		//IL_0148: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_0097: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		if (targetVelocity == Vector2.zero)
		{
			float num = 0.01f;
			float num2 = 10f;
			float num3 = acceleration * acceleration;
			while (num2 - num > 0.01f)
			{
				float num4 = (num2 + num) * 0.5f;
				Vector2 val = (6f * deltaPosition - 4f * num4 * currentVelocity) / (num4 * num4);
				Vector2 val2 = 6f * (num4 * currentVelocity - 2f * deltaPosition) / (num4 * num4 * num4);
				if (!(((Vector2)(ref val)).sqrMagnitude > num3))
				{
					Vector2 val3 = val + val2 * num4;
					if (!(((Vector2)(ref val3)).sqrMagnitude > num3))
					{
						num2 = num4;
						continue;
					}
				}
				num = num4;
			}
			Vector2 val4 = (6f * deltaPosition - 4f * num2 * currentVelocity) / (num2 * num2);
			Vector2 val5 = default(Vector2);
			((Vector2)(ref val5))._002Ector(currentVelocity.y, 0f - currentVelocity.x);
			return Vector2.op_Implicit(Vector3.ClampMagnitude(Vector2.op_Implicit(val4 + 1f * Vector3.Dot(Vector2.op_Implicit(val4), Vector2.op_Implicit(val5)) / Mathf.Max(0.0001f, ((Vector2)(ref val5)).sqrMagnitude) * val5), acceleration));
		}
		float magnitude = ((Vector2)(ref currentVelocity)).magnitude;
		Vector2 val6 = VectorMath.Normalize(targetVelocity, out var magnitude2);
		float magnitude3 = ((Vector2)(ref deltaPosition)).magnitude;
		Vector2 val7 = deltaPosition - val6 * Math.Min(0.5f * magnitude3 * magnitude2 / (magnitude + magnitude2), maxSpeed * 1.5f);
		return Vector2.ClampMagnitude((((Vector2)(ref val7)).normalized * maxSpeed - currentVelocity) * 10f, acceleration);
	}
}
