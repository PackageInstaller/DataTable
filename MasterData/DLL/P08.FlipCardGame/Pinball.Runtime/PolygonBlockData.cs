using System;
using UnityEngine;

namespace Pinball.Runtime;

[Serializable]
public class PolygonBlockData
{
	public Vector2 localPos;

	public PolygonType type;

	public PolygonType convertType;

	public bool canRamdon;

	public BlockPathData pathData;
}
