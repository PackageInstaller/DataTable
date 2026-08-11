using UnityEngine;
using UnityEngine.SceneManagement;

namespace SceneStreamer;

public static class SceneUtils
{
	public static AABBData CalculateSceneBounds(Scene scene)
	{
		GameObject[] rootGameObjects = scene.GetRootGameObjects();
		AABBData result = AABBData.Reset();
		GameObject[] array = rootGameObjects;
		for (int i = 0; i < array.Length; i++)
		{
			Renderer[] componentsInChildren = array[i].GetComponentsInChildren<Renderer>();
			foreach (Renderer renderer in componentsInChildren)
			{
				if (!(renderer is ParticleSystemRenderer))
				{
					Bounds bounds = renderer.bounds;
					result.Union(new AABBData(bounds.min, bounds.max));
				}
			}
		}
		return result;
	}
}
