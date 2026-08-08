using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pinball.Runtime;

[Serializable]
public class BlockPathData
{
	public List<Vector2> pathPoints = new List<Vector2>();

	public float speed = 1.5f;

	public PathEndBehavior endBehavior;

	public BlockPathData Clone()
	{
		return new BlockPathData
		{
			pathPoints = new List<Vector2>(pathPoints),
			speed = speed,
			endBehavior = endBehavior
		};
	}
}
