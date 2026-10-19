using System.Collections.Generic;
using ACT.World;
using UnityEngine;

namespace ACT.UI;

public class AreaGrid : LuminSerializedMonoBehaviour
{
	public MapArea area;

	public int rowNum;

	public int columnNum;

	public Vector2 benchmarkPos;

	public Vector2 mapUnderLeftOffset;

	[SerializeField]
	private Dictionary<MapLayer, GameObject> layerRoot;

	[SerializeField]
	public Dictionary<int, RectTransform> unlockFogRectTransform;

	[SerializeField]
	public Dictionary<int, RectTransform> unlockMaskRectTransform;

	public RectTransform GetUnlockFogRectTransform(int unlockFogId)
	{
		if (unlockFogRectTransform == null)
		{
			return null;
		}
		return unlockFogRectTransform.GetValueOrDefault(unlockFogId);
	}

	public RectTransform GetUnlockMaskRectTransform(int unlockMaskId)
	{
		if (unlockMaskRectTransform == null)
		{
			return null;
		}
		return unlockMaskRectTransform.GetValueOrDefault(unlockMaskId);
	}

	public Vector2 GetSize()
	{
		return new Vector2(columnNum, rowNum) * 512f;
	}

	public void ShowSingleLayer(MapLayer layer)
	{
		if (layerRoot == null)
		{
			return;
		}
		foreach (KeyValuePair<MapLayer, GameObject> item in layerRoot)
		{
			item.Value.SetActive(value: false);
		}
		if (layerRoot.TryGetValue(layer, out var value) && (bool)value)
		{
			value.SetActive(value: true);
		}
	}
}
