#define ENABLE_ERROR_AND_ABOVE_LOG
using UnityEngine;

namespace GameFramework.Resource;

public sealed class ObjectContextLifecycle : MonoBehaviour
{
	private string assetPath;

	private string assetPackageName;

	private IResourceManager resourceManager;

	public void Initialize(IResourceManager manager, string location, string packageName)
	{
		resourceManager = manager;
		assetPath = location;
		assetPackageName = packageName;
	}

	private void OnDestroy()
	{
		if (resourceManager == null)
		{
			Log.Error("Object context manager is invalid.");
		}
		else
		{
			resourceManager.UnloadAsset(base.gameObject);
		}
	}
}
