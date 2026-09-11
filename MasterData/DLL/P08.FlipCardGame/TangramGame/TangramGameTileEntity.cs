using UnityEngine;

namespace TangramGame;

public class TangramGameTileEntity
{
	public short coordinateX;

	public short coordinateY;

	public Vector2 pos;

	public GameObject go;

	public TangramGameConst.TILE_TYPE curTileType = TangramGameConst.TILE_TYPE.EMPTY;

	public TangramGameConst.TILE_TYPE shadowType = TangramGameConst.TILE_TYPE.EMPTY;

	public void Dispose()
	{
		Object.DestroyImmediate(go);
	}

	public bool CheckTileCanPlace(TangramGameConst.TILE_TYPE type)
	{
		switch (curTileType)
		{
		case TangramGameConst.TILE_TYPE.EMPTY:
			return true;
		case TangramGameConst.TILE_TYPE.FULL:
			return false;
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_LOW)
			{
				return true;
			}
			return false;
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_HIGH)
			{
				return true;
			}
			return false;
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.LEFT_LOW)
			{
				return true;
			}
			return false;
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			if (type == TangramGameConst.TILE_TYPE.LEFT_HIGH)
			{
				return true;
			}
			return false;
		default:
			return false;
		}
	}

	public void FillOccupy(TangramGameConst.TILE_TYPE type)
	{
		if (type == TangramGameConst.TILE_TYPE.EMPTY)
		{
			return;
		}
		switch (curTileType)
		{
		case TangramGameConst.TILE_TYPE.EMPTY:
			curTileType = type;
			break;
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_LOW)
			{
				curTileType = TangramGameConst.TILE_TYPE.FULL;
			}
			break;
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_HIGH)
			{
				curTileType = TangramGameConst.TILE_TYPE.FULL;
			}
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.LEFT_LOW)
			{
				curTileType = TangramGameConst.TILE_TYPE.FULL;
			}
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			if (type == TangramGameConst.TILE_TYPE.LEFT_HIGH)
			{
				curTileType = TangramGameConst.TILE_TYPE.FULL;
			}
			break;
		case TangramGameConst.TILE_TYPE.FULL:
			break;
		}
	}

	public void RemoveOccupy(TangramGameConst.TILE_TYPE type)
	{
		if (type == TangramGameConst.TILE_TYPE.EMPTY)
		{
			return;
		}
		switch (curTileType)
		{
		case TangramGameConst.TILE_TYPE.FULL:
			switch (type)
			{
			case TangramGameConst.TILE_TYPE.LEFT_HIGH:
				curTileType = TangramGameConst.TILE_TYPE.RIGHT_LOW;
				break;
			case TangramGameConst.TILE_TYPE.LEFT_LOW:
				curTileType = TangramGameConst.TILE_TYPE.RIGHT_HIGH;
				break;
			case TangramGameConst.TILE_TYPE.RIGHT_LOW:
				curTileType = TangramGameConst.TILE_TYPE.LEFT_HIGH;
				break;
			case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
				curTileType = TangramGameConst.TILE_TYPE.LEFT_LOW;
				break;
			case TangramGameConst.TILE_TYPE.FULL:
				curTileType = TangramGameConst.TILE_TYPE.EMPTY;
				break;
			}
			break;
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			if (type == TangramGameConst.TILE_TYPE.LEFT_HIGH)
			{
				curTileType = TangramGameConst.TILE_TYPE.EMPTY;
			}
			break;
		case TangramGameConst.TILE_TYPE.EMPTY:
			break;
		}
	}
}
