using System;
using System.Collections.Generic;
using Bamboo.AssetField;
using Fundamental;
using UnityEngine;
using UnityEngine.U2D;

namespace ACT.UI;

public class SpriteAtlasLoader : Singleton<SpriteAtlasLoader>
{
	private Dictionary<string, AssetLoadHandle> _loadedAtlas = new Dictionary<string, AssetLoadHandle>(1000);

	public override ContextType ContextType => ContextType.GLOBAL;

	public override void Init()
	{
		SpriteAtlasManager.atlasRequested += RequestAtlas;
	}

	public override void UnInit()
	{
		SpriteAtlasManager.atlasRequested -= RequestAtlas;
	}

	public override void OnDestroy()
	{
		foreach (KeyValuePair<string, AssetLoadHandle> loadedAtla in _loadedAtlas)
		{
			AssetStationManager.Root.Release(loadedAtla.Value);
		}
	}

	private async void RequestAtlas(string atlasName, Action<SpriteAtlas> callback)
	{
		if (_loadedAtlas.TryGetValue(atlasName, out var value))
		{
			await value;
			SpriteAtlas obj = value.As<SpriteAtlas>();
			callback(obj);
			return;
		}
		AssetLoadHandle loadHandle = AssetStationManager.Root.Load<SpriteAtlas>(atlasName);
		_loadedAtlas.Add(atlasName, loadHandle);
		await loadHandle;
		if (loadHandle.State != LoadState.Success)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("Failed to load sprite atlas : " + atlasName + " !");
			}
		}
		else
		{
			SpriteAtlas obj2 = loadHandle.As<SpriteAtlas>();
			callback(obj2);
		}
	}
}
