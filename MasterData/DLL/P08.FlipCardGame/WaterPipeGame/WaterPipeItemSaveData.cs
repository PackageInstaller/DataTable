using System;

namespace WaterPipeGame;

[Serializable]
public class WaterPipeItemSaveData
{
	public PipeType pipeType;

	public DIR dir;

	public int eventID;

	public string spriteName = "";
}
