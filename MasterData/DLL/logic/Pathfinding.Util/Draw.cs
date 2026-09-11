using System;
using UnityEngine;

namespace Pathfinding.Util;

public class Draw
{
	public static readonly Draw Debug = new Draw
	{
		gizmos = false
	};

	public static readonly Draw Gizmos = new Draw
	{
		gizmos = true
	};

	private bool gizmos;

	private Matrix4x4 matrix;

	private void SetColor(Color color)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		if (gizmos && Gizmos.color != color)
		{
			Gizmos.color = color;
		}
	}

	public void Line(Vector3 a, Vector3 b, Color color)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		SetColor(color);
		if (gizmos)
		{
			Gizmos.DrawLine(((Matrix4x4)(ref matrix)).MultiplyPoint3x4(a), ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(b));
		}
		else
		{
			Debug.DrawLine(((Matrix4x4)(ref matrix)).MultiplyPoint3x4(a), ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(b), color);
		}
	}

	public void CircleXZ(Vector3 center, float radius, Color color, float startAngle = 0f, float endAngle = MathF.PI * 2f, int steps = 40)
	{
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		while (startAngle > endAngle)
		{
			startAngle -= MathF.PI * 2f;
		}
		Vector3 val = default(Vector3);
		((Vector3)(ref val))._002Ector(Mathf.Cos(startAngle) * radius, 0f, Mathf.Sin(startAngle) * radius);
		Vector3 val2 = default(Vector3);
		for (int i = 0; i <= steps; i++)
		{
			((Vector3)(ref val2))._002Ector(Mathf.Cos(Mathf.Lerp(startAngle, endAngle, (float)i / (float)steps)) * radius, 0f, Mathf.Sin(Mathf.Lerp(startAngle, endAngle, (float)i / (float)steps)) * radius);
			Line(center + val, center + val2, color);
			val = val2;
		}
	}

	public void Cylinder(Vector3 position, Vector3 up, float height, float radius, Color color)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		//IL_013e: Unknown result type (might be due to invalid IL or missing references)
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0118: Unknown result type (might be due to invalid IL or missing references)
		//IL_012c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0131: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = Vector3.Cross(up, Vector3.one);
		Vector3 normalized = ((Vector3)(ref val)).normalized;
		matrix = Matrix4x4.TRS(position, Quaternion.LookRotation(normalized, up), new Vector3(radius, height, radius));
		CircleXZ(Vector3.zero, 1f, color);
		if (height > 0f)
		{
			CircleXZ(Vector3.up, 1f, color);
			Line(new Vector3(1f, 0f, 0f), new Vector3(1f, 1f, 0f), color);
			Line(new Vector3(-1f, 0f, 0f), new Vector3(-1f, 1f, 0f), color);
			Line(new Vector3(0f, 0f, 1f), new Vector3(0f, 1f, 1f), color);
			Line(new Vector3(0f, 0f, -1f), new Vector3(0f, 1f, -1f), color);
		}
		matrix = Matrix4x4.identity;
	}

	public void CrossXZ(Vector3 position, Color color, float size = 1f)
	{
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		size *= 0.5f;
		Line(position - Vector3.right * size, position + Vector3.right * size, color);
		Line(position - Vector3.forward * size, position + Vector3.forward * size, color);
	}

	public void Bezier(Vector3 a, Vector3 b, Color color)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_0079: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = b - a;
		if (!(val == Vector3.zero))
		{
			Vector3 val2 = Vector3.Cross(Vector3.up, val);
			Vector3 val3 = Vector3.Cross(val, val2);
			val3 = ((Vector3)(ref val3)).normalized;
			val3 *= ((Vector3)(ref val)).magnitude * 0.1f;
			Vector3 p = a + val3;
			Vector3 p2 = b + val3;
			Vector3 a2 = a;
			for (int i = 1; i <= 20; i++)
			{
				float t = (float)i / 20f;
				Vector3 val4 = AstarSplines.CubicBezier(a, p, p2, b, t);
				Line(a2, val4, color);
				a2 = val4;
			}
		}
	}

	public Draw()
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		matrix = Matrix4x4.identity;
		base._002Ector();
	}
}
