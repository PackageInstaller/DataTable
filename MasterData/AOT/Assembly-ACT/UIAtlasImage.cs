using System;
using ACT;
using ACT.UI;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

[Serializable]
public class UIAtlasImage
{
	public Image icon;

	[NonSerialized]
	public bool isLoaded;

	[NonSerialized]
	public YooAssetReference atlasRefAssetID;

	[NonSerialized]
	public int RefCount;

	public void Load(YooAssetReference rAtlasRef, int itemId)
	{
	}

	public void UnLoad(bool releaseSprite = false, Sprite defaultSprite = null)
	{
		if (releaseSprite && (bool)icon)
		{
			icon.sprite = null;
		}
		if (defaultSprite != null && (bool)icon)
		{
			icon.sprite = defaultSprite;
		}
		if (atlasRefAssetID != null && isLoaded)
		{
			for (int i = 0; i < RefCount; i++)
			{
				Singleton<UIAtlasManager>.instance.UnloadSprite(atlasRefAssetID);
			}
		}
		RefCount = 0;
		isLoaded = false;
		atlasRefAssetID = null;
	}
}
