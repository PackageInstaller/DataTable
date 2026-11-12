using System.Collections.Generic;
using UnityEngine;

internal class AdventureObjectOrderByLocationComparer : IComparer<LogicEntity>
{
	public int Compare(LogicEntity a, LogicEntity b)
	{
		Vector3 position = a.transform.position;
		Vector3 position2 = b.transform.position;
		if (position.z < position2.z)
		{
			return -1;
		}
		if (position.z > position2.z)
		{
			return 1;
		}
		if (position.x < position2.x)
		{
			return -1;
		}
		if (!(position.x > position2.x))
		{
			return 0;
		}
		return 1;
	}
}
