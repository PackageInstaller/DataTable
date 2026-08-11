using System;
using System.Collections.Generic;
using Cysharp.Text;
using UnityEngine;
using UnityEngine.U2D;

namespace Ase;

public class SpriteAtlasLoader : MonoBehaviour
{
	private List<string> _loadedPath;

	private static SpriteAtlasLoader _instance;

	private void Init()
	{
		_loadedPath = new List<string>();
		SpriteAtlasManager.atlasRequested += RequestAtlas;
	}

	public static void Initialize()
	{
		if (_instance == null)
		{
			_instance = new GameObject("SpriteAtlasLoader").AddComponent<SpriteAtlasLoader>();
			_instance.Init();
			UnityEngine.Object.DontDestroyOnLoad(_instance);
		}
	}

	public void OnDestroy()
	{
		for (int i = 0; i < _loadedPath.Count; i++)
		{
			GameEntry.Resource.UnloadAsset(_loadedPath[i]);
		}
		_loadedPath.Clear();
		SpriteAtlasManager.atlasRequested -= RequestAtlas;
	}

	private void RequestAtlas(string atlasName, Action<SpriteAtlas> callback)
	{
		string text = ZString.Concat("Assets/Art/UI/UIAtlas/", atlasName, ".spriteatlas");
		if (!_loadedPath.Contains(text))
		{
			_loadedPath.Add(text);
		}
		SpriteAtlas obj = GameEntry.Resource.LoadAsset<SpriteAtlas>(text, "DefaultPackage");
		callback(obj);
	}
}
