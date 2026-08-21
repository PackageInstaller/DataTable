using System;
using UnityEngine;

namespace DG.Tweening.Plugins.Core.PathCore;

internal class CubicBezierDecoder : ABSPathDecoder
{
	private static readonly ControlPoint[] _PartialControlPs = new ControlPoint[1];

	private static readonly Vector3[] _PartialWps = (Vector3[])(object)new Vector3[2];

	internal override int minInputWaypoints => 3;

	internal override void FinalizePath(Path p, Vector3[] wps, bool isClosedPath)
	{
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		//IL_011f: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		//IL_0134: Unknown result type (might be due to invalid IL or missing references)
		//IL_0136: Unknown result type (might be due to invalid IL or missing references)
		//IL_0138: Unknown result type (might be due to invalid IL or missing references)
		//IL_013d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_015a: Unknown result type (might be due to invalid IL or missing references)
		//IL_015c: Unknown result type (might be due to invalid IL or missing references)
		//IL_015e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0165: Unknown result type (might be due to invalid IL or missing references)
		//IL_016a: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0171: Unknown result type (might be due to invalid IL or missing references)
		//IL_0173: Unknown result type (might be due to invalid IL or missing references)
		//IL_0175: Unknown result type (might be due to invalid IL or missing references)
		//IL_017c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0181: Unknown result type (might be due to invalid IL or missing references)
		if (isClosedPath && !p.addedExtraEndWp)
		{
			isClosedPath = false;
		}
		int num = wps.Length;
		int num2 = (p.addedExtraStartWp ? 1 : 0);
		if (p.addedExtraEndWp)
		{
			num2++;
		}
		if (num < 3 + num2 || (num - num2) % 3 != 0)
		{
			Debug.LogError((object)"CubicBezier paths must contain waypoints in multiple of 3 excluding the starting point added automatically by DOTween (1: waypoint, 2: IN control point, 3: OUT control point — the minimum amount of waypoints for a single curve is 3)");
			return;
		}
		int num3 = num2 + (num - num2) / 3;
		Vector3[] array = (Vector3[])(object)new Vector3[num3];
		p.controlPoints = new ControlPoint[num3 - 1];
		array[0] = wps[0];
		int num4 = 1;
		int num5 = 0;
		for (int i = 3 + ((!p.addedExtraStartWp) ? 2 : 0); i < num; i += 3)
		{
			array[num4] = wps[i - 2];
			num4++;
			p.controlPoints[num5] = new ControlPoint(wps[i - 1], wps[i]);
			num5++;
		}
		p.wps = array;
		if (isClosedPath)
		{
			Vector3 val = p.wps[p.wps.Length - 2];
			Vector3 val2 = p.wps[0];
			Vector3 b = p.controlPoints[p.controlPoints.Length - 2].b;
			Vector3 a = p.controlPoints[0].a;
			Vector3 val3 = val2 - val;
			float magnitude = ((Vector3)(ref val3)).magnitude;
			p.controlPoints[p.controlPoints.Length - 1] = new ControlPoint(val + Vector3.ClampMagnitude(val - b, magnitude), val2 + Vector3.ClampMagnitude(val2 - a, magnitude));
		}
		p.subdivisions = num3 * p.subdivisionsXSegment;
		SetTimeToLengthTables(p, p.subdivisions);
		SetWaypointsLengths(p, p.subdivisionsXSegment);
	}

	internal override Vector3 GetPoint(float perc, Vector3[] wps, Path p, ControlPoint[] controlPoints)
	{
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		int num = wps.Length - 1;
		int num2 = (int)Math.Floor(perc * (float)num);
		int num3 = num - 1;
		if (num3 > num2)
		{
			num3 = num2;
		}
		float num4 = perc * (float)num - (float)num3;
		Vector3 val = wps[num3];
		Vector3 a = controlPoints[num3].a;
		Vector3 b = controlPoints[num3].b;
		Vector3 val2 = wps[num3 + 1];
		float num5 = 1f - num4;
		float num6 = num4 * num4;
		float num7 = num5 * num5;
		float num8 = num7 * num5;
		float num9 = num6 * num4;
		return num8 * val + 3f * num7 * num4 * a + 3f * num5 * num6 * b + num9 * val2;
	}

	internal void SetTimeToLengthTables(Path p, int subdivisions)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		float num = 0f;
		float num2 = 1f / (float)subdivisions;
		float[] array = new float[subdivisions];
		float[] array2 = new float[subdivisions];
		Vector3 val = GetPoint(0f, p.wps, p, p.controlPoints);
		for (int i = 1; i < subdivisions + 1; i++)
		{
			float num3 = num2 * (float)i;
			Vector3 point = GetPoint(num3, p.wps, p, p.controlPoints);
			num += Vector3.Distance(point, val);
			val = point;
			array[i - 1] = num3;
			array2[i - 1] = num;
		}
		p.length = num;
		p.timesTable = array;
		p.lengthsTable = array2;
	}

	internal void SetWaypointsLengths(Path p, int subdivisions)
	{
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00be: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		int num = p.wps.Length;
		float[] array = new float[num];
		array[0] = 0f;
		for (int i = 1; i < num; i++)
		{
			_PartialControlPs[0] = p.controlPoints[i - 1];
			_PartialWps[0] = p.wps[i - 1];
			_PartialWps[1] = p.wps[i];
			float num2 = 0f;
			float num3 = 1f / (float)subdivisions;
			Vector3 val = GetPoint(0f, _PartialWps, p, _PartialControlPs);
			for (int j = 1; j < subdivisions + 1; j++)
			{
				float perc = num3 * (float)j;
				Vector3 point = GetPoint(perc, _PartialWps, p, _PartialControlPs);
				num2 += Vector3.Distance(point, val);
				val = point;
			}
			array[i] = num2;
		}
		p.wpLengths = array;
	}
}
