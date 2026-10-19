using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public static class CameraOcclusionManager
{
	private static List<Collider> colliders = new List<Collider>();

	private static List<Collider> lastColliders = new List<Collider>();

	public static List<Collider> StartCollectOcclusion()
	{
		lastColliders.Clear();
		List<Collider> list = colliders;
		colliders = lastColliders;
		lastColliders = list;
		return colliders;
	}

	public static void EndCollectOcclusion()
	{
		foreach (Collider collider in colliders)
		{
			if (!lastColliders.Contains(collider))
			{
				OnOcclusionEnter(collider);
			}
		}
		foreach (Collider lastCollider in lastColliders)
		{
			if (!colliders.Contains(lastCollider))
			{
				OnOcclusionExit(lastCollider);
			}
		}
	}

	private static void OnOcclusionEnter(Collider collider)
	{
		collider.GetComponentInChildren<IOcclusionCallback>()?.OnOcclusionEnter();
	}

	private static void OnOcclusionExit(Collider collider)
	{
		collider.GetComponentInChildren<IOcclusionCallback>()?.OnOcclusionExit();
	}
}
