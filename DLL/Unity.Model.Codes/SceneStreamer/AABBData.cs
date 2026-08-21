using System;
using UnityEngine;

namespace SceneStreamer;

[Serializable]
public struct AABBData
{
	public Vector3 maxCorner;

	public Vector3 minCorner;

	public Vector3 size => maxCorner - minCorner;

	public Vector3 center => (maxCorner + minCorner) * 0.5f;

	public float surfaceArea => (size.x * size.y + size.x * size.z + size.y * size.z) * 2f;

	public AABBData(Vector3 min, Vector3 max)
	{
		minCorner = min;
		maxCorner = max;
	}

	public static AABBData Reset()
	{
		return new AABBData(Vector3.one * float.MaxValue, Vector3.one * float.MinValue);
	}

	public AABBData Union(AABBData aabbData)
	{
		minCorner.x = Mathf.Min(minCorner.x, aabbData.minCorner.x);
		minCorner.y = Mathf.Min(minCorner.y, aabbData.minCorner.y);
		minCorner.z = Mathf.Min(minCorner.z, aabbData.minCorner.z);
		maxCorner.x = Mathf.Max(maxCorner.x, aabbData.maxCorner.x);
		maxCorner.y = Mathf.Max(maxCorner.y, aabbData.maxCorner.y);
		maxCorner.z = Mathf.Max(maxCorner.z, aabbData.maxCorner.z);
		return new AABBData(minCorner, maxCorner);
	}

	public bool IsIntersect(AABBData other)
	{
		if (maxCorner.x < other.minCorner.x || minCorner.x > other.maxCorner.x)
		{
			return false;
		}
		if (maxCorner.y < other.minCorner.y || minCorner.y > other.maxCorner.y)
		{
			return false;
		}
		if (maxCorner.z < other.minCorner.z || minCorner.z > other.maxCorner.z)
		{
			return false;
		}
		return true;
	}
}
