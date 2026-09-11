using System.Collections.Generic;
using UnityEngine;

namespace Capture.Library;

public class Point2DCompare : IComparer<Vector2>
{
	public int Compare(Vector2 x, Vector2 y)
	{
		if (x.x != y.x)
		{
			return x.x.CompareTo(y.x);
		}
		return x.y.CompareTo(y.y);
	}
}
