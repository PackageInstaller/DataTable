using UnityEngine;

namespace DG.Tweening.Plugins.Core.PathCore;

internal class LinearDecoder : ABSPathDecoder
{
	internal override int minInputWaypoints => 1;

	internal override void FinalizePath(Path p, Vector3[] wps, bool isClosedPath)
	{
		p.controlPoints = null;
		p.subdivisions = wps.Length * p.subdivisionsXSegment;
		SetTimeToLengthTables(p, p.subdivisions);
	}

	internal override Vector3 GetPoint(float perc, Vector3[] wps, Path p, ControlPoint[] controlPoints)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		if (perc <= 0f)
		{
			p.linearWPIndex = 1;
			return wps[0];
		}
		int num = 0;
		int num2 = 0;
		int num3 = p.timesTable.Length;
		for (int i = 1; i < num3; i++)
		{
			if (p.timesTable[i] >= perc)
			{
				num = i - 1;
				num2 = i;
				break;
			}
		}
		float num4 = p.timesTable[num];
		float num5 = perc - num4;
		float num6 = p.length * num5;
		Vector3 val = wps[num];
		Vector3 val2 = wps[num2];
		p.linearWPIndex = num2;
		return val + Vector3.ClampMagnitude(val2 - val, num6);
	}

	internal void SetTimeToLengthTables(Path p, int subdivisions)
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		float num = 0f;
		int num2 = p.wps.Length;
		float[] array = new float[num2];
		Vector3 val = p.wps[0];
		for (int i = 0; i < num2; i++)
		{
			Vector3 val2 = p.wps[i];
			float num3 = Vector3.Distance(val2, val);
			num += num3;
			val = val2;
			array[i] = num3;
		}
		float[] array2 = new float[num2];
		float num4 = 0f;
		for (int j = 1; j < num2; j++)
		{
			num4 += array[j];
			array2[j] = num4 / num;
		}
		p.length = num;
		p.wpLengths = array;
		p.timesTable = array2;
	}

	internal void SetWaypointsLengths(Path p, int subdivisions)
	{
	}
}
