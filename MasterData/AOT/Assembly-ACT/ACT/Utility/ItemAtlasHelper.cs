using System;
using ACT.UI;
using Bamboo.AssetField;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;

namespace ACT.Utility;

public static class ItemAtlasHelper
{
	public const int ImageIdCountPerFolder = 32;

	public static int GetItemIconFolderIndex(int itemIconId)
	{
		if (itemIconId < 0)
		{
			return (itemIconId + 1) / 32 - 1;
		}
		return itemIconId / 32;
	}

	private static int GetItemIconConfigId(int itemIconId)
	{
		return ItemIconAtlasNameMap.GetConfigId(itemIconId);
	}

	public static void LoadItemIcon(this ImageAssetStation station, int itemIconId, BImage image)
	{
		station.LoadImage(GetItemIconConfigId(itemIconId), itemIconId, image);
	}

	public static void LoadItemIcon(this ImageAssetStation station, int itemIconId, int defaultItemIconId, BImage image)
	{
		int itemIconConfigId = GetItemIconConfigId(itemIconId);
		int itemIconConfigId2 = GetItemIconConfigId(defaultItemIconId);
		string key;
		if (itemIconConfigId == itemIconConfigId2)
		{
			station.LoadImage(itemIconConfigId, itemIconId, defaultItemIconId, image);
		}
		else if (ImageManager.instance.TryGetKey(itemIconConfigId, itemIconId, out key))
		{
			station.LoadImage(itemIconConfigId, itemIconId, image);
		}
		else
		{
			station.LoadImage(itemIconConfigId2, defaultItemIconId, image);
		}
	}

	public static void LoadItemIconAsync(this ImageAssetStation station, int itemIconId, BImage image, Action action = null)
	{
		station.LoadImageAsync(GetItemIconConfigId(itemIconId), itemIconId, image, action);
	}

	public static UniTask LoadItemIconAsync(this ImageAssetStation station, int itemIconId, BImage image)
	{
		return station.LoadImageAsync(GetItemIconConfigId(itemIconId), itemIconId, image);
	}

	public static AssetLoadHandle LoadItemIconResource(this ImageAssetStation station, int itemIconId, bool isRawImage)
	{
		return station.LoadResource(GetItemIconConfigId(itemIconId), itemIconId, isRawImage);
	}
}
