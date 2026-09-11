using System;
using System.Collections.Generic;

namespace TetrisGame;

[Serializable]
public class TetrisGameStageSaveData
{
	public string stageID;

	public int width;

	public int height;

	public TetrisGameTileSaveData[] tileDataArray;

	public List<int> colorIndexArray;

	public List<TetrisGameChipCustomData> customArray;
}
