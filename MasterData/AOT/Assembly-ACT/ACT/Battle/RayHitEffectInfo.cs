using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public struct RayHitEffectInfo
{
	public Vector3 startPos;

	public Vector3 endPos;

	public List<Vector3> reflectPathPoints;

	public override string ToString()
	{
		return $"{startPos}->{endPos}";
	}
}
