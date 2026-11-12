#define LOG_WARNING
using UnityEngine;

namespace AIScript.Booter;

internal static class HotfixBootSceneManagers
{
	private const string MgrNodeName = "AdventureModuleLevelMgrNode";

	private const string PoolNodeName = "Pool";

	private const string PreloadNodeName = "PreloadNode";

	internal static void Setup()
	{
		GameObject orCreateMgrNode = GetOrCreateMgrNode();
		orCreateMgrNode.AddOrGetComponent<AdventureFXManager>();
		GetOrCreateChild(orCreateMgrNode, "Pool").AddOrGetComponent<AdventureLevelObjPoolMgr>();
		GetOrCreateChild(orCreateMgrNode, "PreloadNode").AddOrGetComponent<AdventureModulePreloadAssetsMrg>();
	}

	private static GameObject GetOrCreateMgrNode()
	{
		GameObject gameObject = GameObject.Find("AdventureModuleLevelMgrNode");
		if (gameObject != null)
		{
			return gameObject;
		}
		NovaLogger.Warning("<HotfixBootSceneManagers> 'AdventureModuleLevelMgrNode' not found in scene, create at runtime");
		gameObject = new GameObject("AdventureModuleLevelMgrNode");
		Object.DontDestroyOnLoad(gameObject);
		return gameObject;
	}

	private static GameObject GetOrCreateChild(GameObject parent, string childName)
	{
		Transform transform = parent.transform.Find(childName);
		if (transform != null)
		{
			return transform.gameObject;
		}
		GameObject gameObject = new GameObject(childName);
		gameObject.transform.SetParent(parent.transform, worldPositionStays: false);
		return gameObject;
	}
}
