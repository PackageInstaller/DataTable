using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class GameResourceSystem : BaseSystem
{
	private List<string> materialPathList = new List<string>();

	protected override bool IsLogicSystem => true;

	public void AddMaterialResPath(string path)
	{
		if (!materialPathList.Contains(path))
		{
			materialPathList.Add(path);
		}
	}

	public bool CheckLocationValid(string location, string customPackageName = "")
	{
		return GameEntry.Resource.CheckLocationValid(location, customPackageName);
	}

	public async UniTask<GameObject> InstantiateAsync(string location, Transform parent, string packageName = "")
	{
		GameObject gameObject = await GameEntry.Resource.InstantiateAsync(location, parent, packageName);
		if (gameObject != null)
		{
			return gameObject;
		}
		return null;
	}

	public UniTask<T> LoadAssetAsync<T>(string location) where T : Object
	{
		return GameEntry.Resource.LoadAssetAsync<T>(location);
	}

	public T LoadAsset<T>(string location, string packageName = "") where T : Object
	{
		return GameEntry.Resource.LoadAsset<T>(location, packageName);
	}

	public UniTask<T> LoadAssetAsync<T>(string location, string packageName) where T : Object
	{
		return GameEntry.Resource.LoadAssetAsync<T>(location, packageName);
	}

	public void UnloadAsset(string location)
	{
		GameEntry.Resource.UnloadAsset(location);
	}

	public void UnloadUnusedAssets(bool performGCCollect = true, bool unloadResourceUnusedAssets = false)
	{
		GameEntry.Resource.UnloadUnusedAssets(performGCCollect, unloadResourceUnusedAssets);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (!materialPathList.IsNullOrEmpty())
		{
			foreach (string materialPath in materialPathList)
			{
				GameEntry.Resource.UnloadAsset(materialPath);
			}
			materialPathList.Clear();
		}
		GameEntry.Resource.UnLoadSpriteGroup("World");
	}
}
