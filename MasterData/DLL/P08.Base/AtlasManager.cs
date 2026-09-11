using System.Collections.Generic;
using UnityEngine;
using UnityEngine.U2D;
using UnityEngine.UI;

public static class AtlasManager
{
	private struct RefUnityObject
	{
		public Object refOwner;

		public string assetPath;

		public int reuseCount;
	}

	private static bool ready = false;

	private static Dictionary<string, Dictionary<string, Sprite>> atlasSpritePool;

	private static Dictionary<string, Sprite> spritePool;

	private static List<string> asyncLoadingDic;

	private static Dictionary<string, List<OnVoidHandler<Sprite>>> asyncLoadingCallBack;

	private static Dictionary<string, Dictionary<string, Sprite>> newAtlasSpritePool;

	private static Dictionary<int, RefUnityObject> refs = new Dictionary<int, RefUnityObject>(new IntComparer());

	private static List<string> uselessAssets = new List<string>();

	private static List<int> uselessIDs = new List<int>();

	public static bool GetReady()
	{
		return ready;
	}

	public static void Initialize()
	{
		if (!ready)
		{
			if (atlasSpritePool == null)
			{
				atlasSpritePool = new Dictionary<string, Dictionary<string, Sprite>>();
			}
			if (spritePool == null)
			{
				spritePool = new Dictionary<string, Sprite>();
			}
			if (asyncLoadingDic == null)
			{
				asyncLoadingDic = new List<string>();
			}
			if (asyncLoadingCallBack == null)
			{
				asyncLoadingCallBack = new Dictionary<string, List<OnVoidHandler<Sprite>>>();
			}
			if (newAtlasSpritePool == null)
			{
				newAtlasSpritePool = new Dictionary<string, Dictionary<string, Sprite>>();
			}
			if (refs == null)
			{
				refs = new Dictionary<int, RefUnityObject>();
			}
			else
			{
				refs.Clear();
			}
			ready = true;
		}
	}

	public static Sprite GetSpriteWithoutAtlas(string spritePath)
	{
		Initialize();
		spritePath = I18NConfigManager.GetI18NPathOrName(spritePath);
		if (!spritePool.ContainsKey(spritePath))
		{
			Sprite sprite = Asset.Load<Sprite>(spritePath);
			if (sprite == null)
			{
				return null;
			}
			spritePool.Add(spritePath, sprite);
		}
		return spritePool[spritePath];
	}

	public static void GetSpriteWithoutAtlasAsync(string spritePath, OnVoidHandler<Sprite> callback = null)
	{
		Initialize();
		spritePath = I18NConfigManager.GetI18NPathOrName(spritePath);
		if (spritePool.ContainsKey(spritePath))
		{
			callback(spritePool[spritePath]);
			return;
		}
		if (asyncLoadingDic.Contains(spritePath))
		{
			asyncLoadingCallBack[spritePath].Add(callback);
			return;
		}
		List<OnVoidHandler<Sprite>> list = new List<OnVoidHandler<Sprite>>();
		if (callback != null)
		{
			list.Add(callback);
		}
		asyncLoadingCallBack.Add(spritePath, list);
		asyncLoadingDic.Add(spritePath);
		if (Asset.LoadAssetAsync(spritePath, delegate(Sprite sprite)
		{
			if (asyncLoadingDic.Contains(spritePath))
			{
				asyncLoadingDic.Remove(spritePath);
			}
			if (sprite == null)
			{
				if (asyncLoadingCallBack.ContainsKey(spritePath))
				{
					asyncLoadingCallBack.Remove(spritePath);
				}
			}
			else
			{
				if (!spritePool.ContainsKey(spritePath))
				{
					spritePool.Add(spritePath, sprite);
				}
				foreach (OnVoidHandler<Sprite> item in asyncLoadingCallBack[spritePath])
				{
					item(sprite);
				}
				asyncLoadingCallBack.Remove(spritePath);
			}
		}) == null)
		{
			asyncLoadingDic.Remove(spritePath);
			asyncLoadingCallBack.Remove(spritePath);
			Debug.LogError("LoadAssetAsync return null! Sprite Not Found:" + spritePath);
		}
	}

	public static void UnloadSpriteWithoutAtlas(string spritePath)
	{
		Initialize();
		if (spritePool.ContainsKey(spritePath))
		{
			Asset.Unload(spritePath);
			spritePool.Remove(spritePath);
		}
	}

	public static Sprite GetSprite(string atlasName, string spriteName)
	{
		Initialize();
		if (!atlasSpritePool.ContainsKey(atlasName))
		{
			SpriteAtlas spriteAtlas = Asset.Load(atlasName) as SpriteAtlas;
			if (spriteAtlas != null)
			{
				Sprite[] array = new Sprite[spriteAtlas.spriteCount];
				spriteAtlas.GetSprites(array);
				int num = array.Length;
				if (num == 0)
				{
					Debug.LogError("GetSprite Atlas sprites Length 0 :" + atlasName);
					atlasSpritePool.Add(atlasName, new Dictionary<string, Sprite>());
				}
				else
				{
					Dictionary<string, Sprite> dictionary = new Dictionary<string, Sprite>();
					for (int i = 0; i < num; i++)
					{
						Sprite sprite = array[i];
						if ((bool)sprite)
						{
							string name = sprite.name;
							name = name.Replace("(Clone)", "");
							dictionary.TryAdd(name, sprite);
						}
					}
					atlasSpritePool.Add(atlasName, dictionary);
				}
			}
			else
			{
				Debug.LogError("GetSprite Atlas Not Found:" + atlasName);
				atlasSpritePool.Add(atlasName, new Dictionary<string, Sprite>());
			}
		}
		Dictionary<string, Sprite> dictionary2 = atlasSpritePool[atlasName];
		if (dictionary2.ContainsKey(spriteName))
		{
			return dictionary2[spriteName];
		}
		Debug.LogError("GetSprite Error:" + atlasName + "/" + spriteName);
		return null;
	}

	public static void UnloadSprite(string atlasName, string spriteName)
	{
		Initialize();
		if (atlasSpritePool.ContainsKey(atlasName) && atlasSpritePool[atlasName].ContainsKey(spriteName))
		{
			Asset.Unload(atlasName);
			atlasSpritePool[atlasName].Remove(spriteName);
			if (atlasSpritePool[atlasName].Count < 1)
			{
				atlasSpritePool[atlasName].Clear();
				atlasSpritePool.Remove(atlasName);
			}
		}
	}

	public static void UnloadAtlas(string atlasName)
	{
		Initialize();
		if (!atlasSpritePool.ContainsKey(atlasName))
		{
			return;
		}
		Dictionary<string, Sprite> dictionary = atlasSpritePool[atlasName];
		foreach (KeyValuePair<string, Sprite> item in dictionary)
		{
			_ = item;
			Asset.Unload(atlasName);
		}
		dictionary.Clear();
		atlasSpritePool.Remove(atlasName);
	}

	public static void UnloadAllSprite()
	{
		Initialize();
		List<string> list = new List<string>();
		foreach (string key in atlasSpritePool.Keys)
		{
			list.Add(key);
		}
		foreach (string item in list)
		{
			UnloadAtlas(item);
		}
		list.Clear();
		atlasSpritePool.Clear();
		spritePool.Clear();
		foreach (KeyValuePair<int, RefUnityObject> @ref in refs)
		{
			if (@ref.Value.refOwner == null && !string.IsNullOrEmpty(@ref.Value.assetPath))
			{
				for (int i = 0; i < @ref.Value.reuseCount; i++)
				{
					Asset.UnloadWithReturn(@ref.Value.assetPath);
				}
			}
		}
		refs.Clear();
		uselessAssets.Clear();
		uselessIDs.Clear();
	}

	public static void Destroy()
	{
		if (ready)
		{
			UnloadAllSprite();
		}
	}

	public static Sprite GetSpriteWithoutAtlas(SpriteRenderer image, string spritePath)
	{
		Initialize();
		spritePath = I18NConfigManager.GetI18NPathOrName(spritePath);
		Sprite sprite = null;
		if (image != null)
		{
			sprite = Asset.Load<Sprite>(spritePath);
			if (sprite != null)
			{
				image.sprite = sprite;
				RecordRef(image, spritePath);
			}
		}
		return sprite;
	}

	public static void GetSpriteWithoutAtlasAsyncNew(SpriteRenderer owner, string spritePath, OnVoidHandler<Sprite> callback = null)
	{
		Initialize();
		spritePath = I18NConfigManager.GetI18NPathOrName(spritePath);
		Asset.LoadAssetAsync(spritePath, delegate(Sprite sprite)
		{
			if (owner != null)
			{
				if (sprite != null)
				{
					owner.sprite = sprite;
					RecordRef(owner, spritePath);
				}
				if (callback != null)
				{
					callback(sprite);
				}
			}
		});
	}

	public static Sprite GetSpriteWithoutAtlas(Image image, string spritePath)
	{
		Initialize();
		spritePath = I18NConfigManager.GetI18NPathOrName(spritePath);
		Sprite sprite = null;
		if (image != null)
		{
			sprite = Asset.Load<Sprite>(spritePath);
			if (sprite != null)
			{
				image.sprite = sprite;
				RecordRef(image, spritePath);
			}
		}
		return sprite;
	}

	public static void GetSpriteWithoutAtlasAsyncNew(Image owner, string spritePath, OnVoidHandler<Sprite> callback = null)
	{
		Initialize();
		spritePath = I18NConfigManager.GetI18NPathOrName(spritePath);
		Asset.LoadAssetAsync(spritePath, delegate(Sprite sprite)
		{
			if (owner != null)
			{
				if (sprite != null)
				{
					owner.sprite = sprite;
					RecordRef(owner, spritePath);
				}
				if (callback != null)
				{
					callback(sprite);
				}
			}
		});
	}

	public static bool SetSprite(Image image, string atlasName, string spriteName)
	{
		Initialize();
		if (string.IsNullOrEmpty(spriteName) || string.IsNullOrEmpty(atlasName))
		{
			return false;
		}
		SpriteAtlas spriteAtlas = Asset.Load<SpriteAtlas>(atlasName);
		if (spriteAtlas == null)
		{
			Debug.LogWarning("Atlas Not Found:" + atlasName);
			return false;
		}
		if (!newAtlasSpritePool.ContainsKey(atlasName))
		{
			newAtlasSpritePool.Add(atlasName, new Dictionary<string, Sprite>());
		}
		Dictionary<string, Sprite> dictionary = newAtlasSpritePool[atlasName];
		if (!dictionary.ContainsKey(spriteName))
		{
			dictionary.Add(spriteName, spriteAtlas.GetSprite(spriteName));
		}
		if (image != null && dictionary[spriteName] != null)
		{
			image.sprite = dictionary[spriteName];
			RecordRef(image, atlasName);
			return true;
		}
		return false;
	}

	public static void RecordRef(Object owner, string spritePath)
	{
		if (!(owner != null))
		{
			return;
		}
		int instanceID = owner.GetInstanceID();
		if (refs.ContainsKey(instanceID))
		{
			if (refs[instanceID].assetPath != spritePath)
			{
				UnloadAssets(instanceID);
				refs[instanceID] = new RefUnityObject
				{
					refOwner = owner,
					assetPath = spritePath,
					reuseCount = 1
				};
			}
			else
			{
				int reuseCount = refs[instanceID].reuseCount + 1;
				refs[instanceID] = new RefUnityObject
				{
					refOwner = owner,
					assetPath = spritePath,
					reuseCount = reuseCount
				};
			}
		}
		else
		{
			refs[instanceID] = new RefUnityObject
			{
				refOwner = owner,
				assetPath = spritePath,
				reuseCount = 1
			};
		}
	}

	public static void UnloadAssets(int id)
	{
		if (refs.ContainsKey(id) && !string.IsNullOrEmpty(refs[id].assetPath))
		{
			bool flag = true;
			for (int i = 0; i < refs[id].reuseCount; i++)
			{
				flag = Asset.UnloadWithReturn(refs[id].assetPath);
			}
			if (flag && newAtlasSpritePool.ContainsKey(refs[id].assetPath))
			{
				UnloadAtlasWithoutUnloadAB(refs[id].assetPath);
			}
		}
	}

	public static void GCSprites()
	{
		foreach (KeyValuePair<int, RefUnityObject> @ref in refs)
		{
			bool flag = false;
			if (@ref.Value.refOwner == null)
			{
				if (!string.IsNullOrEmpty(@ref.Value.assetPath))
				{
					for (int i = 0; i < @ref.Value.reuseCount; i++)
					{
						flag = Asset.UnloadWithReturn(@ref.Value.assetPath);
					}
				}
				uselessIDs.Add(@ref.Key);
			}
			if (flag)
			{
				uselessAssets.Add(@ref.Value.assetPath);
			}
		}
		for (int j = 0; j < uselessAssets.Count; j++)
		{
			if (newAtlasSpritePool.ContainsKey(uselessAssets[j]))
			{
				UnloadAtlasWithoutUnloadAB(uselessAssets[j]);
			}
		}
		for (int k = 0; k < uselessIDs.Count; k++)
		{
			refs.Remove(uselessIDs[k]);
		}
		uselessIDs.Clear();
		uselessAssets.Clear();
	}

	public static void UnloadAtlasWithoutUnloadAB(string atlasName)
	{
		Initialize();
		if (!newAtlasSpritePool.ContainsKey(atlasName))
		{
			return;
		}
		Dictionary<string, Sprite> dictionary = newAtlasSpritePool[atlasName];
		foreach (KeyValuePair<string, Sprite> item in dictionary)
		{
			Object.Destroy(item.Value);
		}
		dictionary.Clear();
		newAtlasSpritePool.Remove(atlasName);
	}
}
