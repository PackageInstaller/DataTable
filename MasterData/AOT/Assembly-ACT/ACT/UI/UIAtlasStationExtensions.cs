using System;
using ACT.Core;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public static class UIAtlasStationExtensions
{
	public static ImageAssetStation GetImageStation(this Component component)
	{
		return component.GetComponentInParent<IBaseUIView>()?.Station;
	}

	[Obsolete("Deprecated atlas compatibility API. Prefer LoadItemIcon(itemIconId, image) with BImage.")]
	public static void LoadItemSprite(this ImageAssetStation station, AssetID atlasKey, int itemId, BImage image)
	{
		if (station != null && image != null)
		{
			int iconAddress = RuntimeConfigs.data.itemDatas[itemId].iconAddress;
			station.LoadItemIcon(iconAddress, image);
		}
	}
}
