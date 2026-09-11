using System;
using System.Runtime.CompilerServices;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public struct IntRect(int xmin, int ymin, int xmax, int ymax)
{
	public int xmin = xmin;

	public int ymin = ymin;

	public int xmax = xmax;

	public int ymax = ymax;

	private static readonly int[] Rotations;

	public int Width => xmax - xmin + 1;

	public int Height => ymax - ymin + 1;

	public bool Contains(int x, int y)
	{
		if (x >= xmin && y >= ymin && x <= xmax)
		{
			return y <= ymax;
		}
		return false;
	}

	public bool IsValid()
	{
		if (xmin <= xmax)
		{
			return ymin <= ymax;
		}
		return false;
	}

	public static bool operator ==(IntRect a, IntRect b)
	{
		if (a.xmin == b.xmin && a.xmax == b.xmax && a.ymin == b.ymin)
		{
			return a.ymax == b.ymax;
		}
		return false;
	}

	public static bool operator !=(IntRect a, IntRect b)
	{
		if (a.xmin == b.xmin && a.xmax == b.xmax && a.ymin == b.ymin)
		{
			return a.ymax != b.ymax;
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		IntRect intRect = (IntRect)obj;
		if (xmin == intRect.xmin && xmax == intRect.xmax && ymin == intRect.ymin)
		{
			return ymax == intRect.ymax;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (xmin * 131071) ^ (xmax * 3571) ^ (ymin * 3109) ^ (ymax * 7);
	}

	public static IntRect Intersection(IntRect a, IntRect b)
	{
		return new IntRect(Math.Max(a.xmin, b.xmin), Math.Max(a.ymin, b.ymin), Math.Min(a.xmax, b.xmax), Math.Min(a.ymax, b.ymax));
	}

	public static bool Intersects(IntRect a, IntRect b)
	{
		if (a.xmin <= b.xmax && a.ymin <= b.ymax && a.xmax >= b.xmin)
		{
			return a.ymax >= b.ymin;
		}
		return false;
	}

	public static IntRect Union(IntRect a, IntRect b)
	{
		return new IntRect(Math.Min(a.xmin, b.xmin), Math.Min(a.ymin, b.ymin), Math.Max(a.xmax, b.xmax), Math.Max(a.ymax, b.ymax));
	}

	public IntRect ExpandToContain(int x, int y)
	{
		return new IntRect(Math.Min(xmin, x), Math.Min(ymin, y), Math.Max(xmax, x), Math.Max(ymax, y));
	}

	public IntRect Expand(int range)
	{
		return new IntRect(xmin - range, ymin - range, xmax + range, ymax + range);
	}

	public IntRect Rotate(int r)
	{
		int num = Rotations[r * 4];
		int num2 = Rotations[r * 4 + 1];
		int num3 = Rotations[r * 4 + 2];
		int num4 = Rotations[r * 4 + 3];
		int val = num * xmin + num2 * ymin;
		int val2 = num3 * xmin + num4 * ymin;
		int val3 = num * xmax + num2 * ymax;
		int val4 = num3 * xmax + num4 * ymax;
		return new IntRect(Math.Min(val, val3), Math.Min(val2, val4), Math.Max(val, val3), Math.Max(val2, val4));
	}

	public IntRect Offset(Int2 offset)
	{
		return new IntRect(xmin + offset.x, ymin + offset.y, xmax + offset.x, ymax + offset.y);
	}

	public IntRect Offset(int x, int y)
	{
		return new IntRect(xmin + x, ymin + y, xmax + x, ymax + y);
	}

	public override string ToString()
	{
		return "[x: " + xmin + "..." + xmax + ", y: " + ymin + "..." + ymax + "]";
	}

	public void DebugDraw(GraphTransform transform, Color color)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_008d: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0094: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_0096: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = transform.Transform(new Vector3((float)xmin, 0f, (float)ymin));
		Vector3 val2 = transform.Transform(new Vector3((float)xmin, 0f, (float)ymax));
		Vector3 val3 = transform.Transform(new Vector3((float)xmax, 0f, (float)ymax));
		Vector3 val4 = transform.Transform(new Vector3((float)xmax, 0f, (float)ymin));
		Debug.DrawLine(val, val2, color);
		Debug.DrawLine(val2, val3, color);
		Debug.DrawLine(val3, val4, color);
		Debug.DrawLine(val4, val, color);
	}

	static IntRect()
	{
		//IL_000d: Field data (rva=0xe38) could not be found in any section!
		//IL_000d: Field data (rva=0xe38) could not be found in any section!
		int[] array = new int[16];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		Rotations = array;
	}
}
