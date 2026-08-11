namespace UnityEngine.Rendering;

public static class TileLayoutUtils
{
	public static bool TryLayoutByTiles(RectInt src, uint tileSize, out RectInt main, out RectInt topRow, out RectInt rightCol, out RectInt topRight)
	{
		if (src.width < tileSize || src.height < tileSize)
		{
			main = new RectInt(0, 0, 0, 0);
			topRow = new RectInt(0, 0, 0, 0);
			rightCol = new RectInt(0, 0, 0, 0);
			topRight = new RectInt(0, 0, 0, 0);
			return false;
		}
		int num = src.height / (int)tileSize;
		int num2 = src.width / (int)tileSize * (int)tileSize;
		int num3 = num * (int)tileSize;
		main = new RectInt
		{
			x = src.x,
			y = src.y,
			width = num2,
			height = num3
		};
		topRow = new RectInt
		{
			x = src.x,
			y = src.y + num3,
			width = num2,
			height = src.height - num3
		};
		rightCol = new RectInt
		{
			x = src.x + num2,
			y = src.y,
			width = src.width - num2,
			height = num3
		};
		topRight = new RectInt
		{
			x = src.x + num2,
			y = src.y + num3,
			width = src.width - num2,
			height = src.height - num3
		};
		return true;
	}

	public static bool TryLayoutByRow(RectInt src, uint tileSize, out RectInt main, out RectInt other)
	{
		if (src.height < tileSize)
		{
			main = new RectInt(0, 0, 0, 0);
			other = new RectInt(0, 0, 0, 0);
			return false;
		}
		int num = src.height / (int)tileSize * (int)tileSize;
		main = new RectInt
		{
			x = src.x,
			y = src.y,
			width = src.width,
			height = num
		};
		other = new RectInt
		{
			x = src.x,
			y = src.y + num,
			width = src.width,
			height = src.height - num
		};
		return true;
	}

	public static bool TryLayoutByCol(RectInt src, uint tileSize, out RectInt main, out RectInt other)
	{
		if (src.width < tileSize)
		{
			main = new RectInt(0, 0, 0, 0);
			other = new RectInt(0, 0, 0, 0);
			return false;
		}
		int num = src.width / (int)tileSize * (int)tileSize;
		main = new RectInt
		{
			x = src.x,
			y = src.y,
			width = num,
			height = src.height
		};
		other = new RectInt
		{
			x = src.x + num,
			y = src.y,
			width = src.width - num,
			height = src.height
		};
		return true;
	}
}
