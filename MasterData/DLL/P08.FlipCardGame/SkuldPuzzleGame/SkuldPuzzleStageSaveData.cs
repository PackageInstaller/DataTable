using System;
using System.Collections.Generic;

namespace SkuldPuzzleGame;

[Serializable]
public class SkuldPuzzleStageSaveData
{
	public string stageID;

	public int width;

	public int height;

	public SkuldPuzzleMapBlockData[] mapBlockData;

	public List<SkuldPuzzleChipBlockData> chipList;

	public List<SkuldPuzzleBanLineData> banList;
}
