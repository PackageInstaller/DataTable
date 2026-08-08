using System;

namespace WaterPipeGame;

[Serializable]
public class WaterPipeStageSaveData
{
	public int stageID;

	public int width;

	public int height;

	public int cubeSize;

	public WaterPipeItemSaveData[] pipeItemDataArray;
}
