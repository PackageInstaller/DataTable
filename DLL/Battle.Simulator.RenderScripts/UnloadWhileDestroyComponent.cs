using UnityEngine;

public class UnloadWhileDestroyComponent : MonoBehaviour
{
	public string path;

	private void OnDestroy()
	{
		if (!string.IsNullOrEmpty(path))
		{
			Asset.Unload(path);
		}
	}
}
