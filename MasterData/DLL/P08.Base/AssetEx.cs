using System;
using UnityEngine;
using UnityEngine.UI;

public class AssetEx
{
	public static Sprite LoadSprite(string path, bool isdontdistroy = false)
	{
		return Asset.Load<Sprite>(path, isdontdistroy);
	}

	public static void LoadSpriteAsync(string path, OnVoidHandler<Sprite> callback = null)
	{
		Asset.LoadAssetAsync(path, callback);
	}

	public static void SetSpriteAsync(Image image, string path)
	{
		LoadSpriteAsync(path, delegate(Sprite sprite)
		{
			image.sprite = sprite;
		});
	}

	public static string LoadText(string path)
	{
		string empty = string.Empty;
		try
		{
			return Asset.Load<TextAsset>(path).text;
		}
		catch (Exception ex)
		{
			Debug.LogError(path + ex.ToString());
			throw ex;
		}
	}

	public static void UnloadSprite(string path, bool isdontdistroy = false)
	{
		Asset.Unload(path, isdontdistroy);
	}
}
