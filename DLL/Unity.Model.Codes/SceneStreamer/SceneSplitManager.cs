using UnityEngine;

namespace SceneStreamer;

public class SceneSplitManager : MonoBehaviour
{
	public string sceneName;

	public Color color;

	public Vector3 position;

	[HideInInspector]
	public Vector3 size = new Vector3(10f, 10f, 10f);

	[HideInInspector]
	public Vector3Int wsPosition = new Vector3Int(10, 10, 10);

	private void OnDrawGizmosSelected()
	{
		Gizmos.color = color;
		Gizmos.DrawWireCube(position + size * 0.5f, size);
	}

	public AABBData GetAABB(bool ySplitIs)
	{
		AABBData result = AABBData.Reset();
		Renderer[] componentsInChildren = base.gameObject.GetComponentsInChildren<Renderer>();
		foreach (Renderer renderer in componentsInChildren)
		{
			if (!(renderer is ParticleSystemRenderer))
			{
				Bounds bounds = renderer.bounds;
				result.Union(new AABBData(bounds.min, bounds.max));
			}
		}
		if (!ySplitIs)
		{
			result.minCorner.y = 0f;
			result.maxCorner.y = 1f;
		}
		return result;
	}

	public void CalculateSize()
	{
		SceneSplitterSettings sceneSplitterSettings = Object.FindObjectOfType<SceneSplitterSettings>();
		AABBData aABB = GetAABB(sceneSplitterSettings.sceneCollectionManager.ySplitIs);
		position = aABB.minCorner;
		size = aABB.size;
		sceneName = base.gameObject.name;
	}

	public void AddToExtraSplit()
	{
		SceneSplitterSettings sceneSplitterSettings = Object.FindObjectOfType<SceneSplitterSettings>();
		if (!sceneSplitterSettings.extraSceneSplitManagers.Contains(this))
		{
			sceneSplitterSettings.extraSceneSplitManagers.Add(this);
		}
	}
}
