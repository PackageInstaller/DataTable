using System;
using System.Collections.Generic;
using TangramGame;
using UnityEngine;

[Serializable]
public class TangramTileData
{
	public List<TangramChipTileData> dataList = new List<TangramChipTileData>();

	[HideInInspector]
	public int x;

	[HideInInspector]
	public int y;

	[HideInInspector]
	public TangramGameConst.TILE_DATA_TYPE tileType;
}
