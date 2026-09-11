using System;

namespace TetrisGame;

[Serializable]
public class TetrisGameChipSaveData
{
	public int chipIndex;

	public TetrisGameTileSaveData[] relevanceList;
}
