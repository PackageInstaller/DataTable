using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class SeparateSegmentConfig : ScriptableObject
{
	public float duration = 0.5f;

	[Range(-0.01f, 0.01f)]
	public float precision = 0.0001f;

	public List<PointData> polygonGroup = new List<PointData>();
}
