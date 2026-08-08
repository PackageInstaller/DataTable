using System;
using System.Collections.Generic;

namespace TangramGame;

[Serializable]
public class TangramGamePrefabData
{
	public TangramGameConst.TangramGameBaseInfo baseInfo;

	public List<TangramTileData> tileData;

	public List<TangramChipData> chipData;

	public TangramGamePrefabData(TangramGameConst.TangramGameBaseInfo baseInfo, List<TangramTileData> tileData, List<TangramChipData> chipData)
	{
		this.baseInfo = baseInfo;
		this.tileData = tileData;
		this.chipData = chipData;
	}
}
