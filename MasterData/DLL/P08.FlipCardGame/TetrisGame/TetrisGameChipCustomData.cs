using System;

namespace TetrisGame;

[Serializable]
public class TetrisGameChipCustomData
{
	public int shapeIndex;

	public int colorIndex;

	public RotateDir dir;

	public int putInX = -1;

	public int putInY = -1;
}
