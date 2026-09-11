using System;
using TangramGame;
using UnityEngine;

[Serializable]
public class TangramChipTileData
{
	[HideInInspector]
	public int x;

	[HideInInspector]
	public int y;

	public int chipIndex;

	public TangramGameConst.TILE_TYPE tileType = TangramGameConst.TILE_TYPE.EMPTY;

	public TangramChipTileData(int x, int y)
	{
		this.x = x;
		this.y = y;
	}
}
