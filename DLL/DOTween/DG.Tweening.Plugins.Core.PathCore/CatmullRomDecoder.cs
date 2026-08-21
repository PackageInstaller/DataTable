using System;
using UnityEngine;

namespace DG.Tweening.Plugins.Core.PathCore;

internal class CatmullRomDecoder : ABSPathDecoder
{
	private static readonly ControlPoint[] _PartialControlPs = new ControlPoint[2];

	private static readonly Vector3[] _PartialWps = (Vector3[])(object)new Vector3[2];

	internal override int minInputWaypoints => 1;

	internal override void FinalizePath(Path p, Vector3[] wps, bool isClosedPath)
	{
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0090: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		int num = wps.Length;
		if (p.controlPoints == null || p.controlPoints.Length != 2)
		{
			p.controlPoints = new ControlPoint[2];
		}
		if (isClosedPath)
		{
			p.controlPoints[0] = new ControlPoint(wps[num - 2], Vector3.zero);
			p.controlPoints[1] = new ControlPoint(wps[1], Vector3.zero);
		}
		else
		{
			p.controlPoints[0] = new ControlPoint(wps[1], Vector3.zero);
			Vector3 val = wps[num - 1];
			Vector3 val2 = val - wps[num - 2];
			p.controlPoints[1] = new ControlPoint(val + val2, Vector3.zero);
		}
		p.subdivisions = num * p.subdivisionsXSegment;
		SetTimeToLengthTables(p, p.subdivisions);
		SetWaypointsLengths(p, p.subdivisionsXSegment);
	}

	internal override Vector3 GetPoint(float perc, Vector3[] wps, Path p, ControlPoint[] controlPoints)
	{
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00da: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fa: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_0109: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0118: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		//IL_011f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0124: Unknown result type (might be due to invalid IL or missing references)
		int num = wps.Length - 1;
		int num2 = (int)Math.Floor(perc * (float)num);
		int num3 = num - 1;
		if (num3 > num2)
		{
			num3 = num2;
		}
		float num4 = perc * (float)num - (float)num3;
		Vector3 val = ((num3 == 0) ? controlPoints[0].a : wps[num3 - 1]);
		Vector3 val2 = wps[num3];
		Vector3 val3 = wps[num3 + 1];
		Vector3 val4 = ((num3 + 2 > wps.Length - 1) ? controlPoints[1].a : wps[num3 + 2]);
		return 0.5f * ((-val + 3f * val2 - 3f * val3 + val4) * (num4 * num4 * num4) + (2f * val - 5f * val2 + 4f * val3 - val4) * (num4 * num4) + (-val + val3) * num4 + 2f * val2);
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
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Unknown result type (might be due to invalid IL or missing references)
		//IL_0108: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		//IL_0113: Unknown result type (might be due to invalid IL or missing references)
		int num = p.wps.Length;
		float[] array = new float[num];
		array[0] = 0f;
		for (int i = 1; i < num; i++)
		{
			_PartialControlPs[0].a = ((i == 1) ? p.controlPoints[0].a : p.wps[i - 2]);
			_PartialWps[0] = p.wps[i - 1];
			_PartialWps[1] = p.wps[i];
			_PartialControlPs[1].a = ((i == num - 1) ? p.controlPoints[1].a : p.wps[i + 1]);
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
