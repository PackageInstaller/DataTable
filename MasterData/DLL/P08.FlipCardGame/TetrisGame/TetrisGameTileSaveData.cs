using System;

namespace TetrisGame;

[Serializable]
public class TetrisGameTileSaveData
{
	public int width;

	public int height;

	public TileType tileType;

	public int chipIndex;

	public int colorIndex;
}
