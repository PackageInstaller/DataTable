using System.Collections.Generic;
using UnityEngine;

namespace ACT.Utility;

public class RaycastHitComparer : IComparer<RaycastHit>
{
	public int Compare(RaycastHit x, RaycastHit y)
	{
		if (x.distance < y.distance)
		{
			return -1;
		}
		if (x.distance > y.distance)
		{
			return 1;
		}
		return 0;
	}
}
