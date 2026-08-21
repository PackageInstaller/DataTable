using UnityEngine;

namespace Capture.Library;

public struct AABB
{
	public Bounds aabb;

	public Vector3 size
	{
		get
		{
			return aabb.size;
		}
		private set
		{
		}
	}

	public Vector3 center
	{
		get
		{
			return aabb.center;
		}
		private set
		{
		}
	}
}
