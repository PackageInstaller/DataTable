using System;

namespace ChessBoard;

[Serializable]
public class ChessBoardGridData
{
	public string prefab = "ChessBoard/Ground/10100";

	public float rotationY;

	public int typeID = 10100;

	public short x;

	public short z;

	public bool[] banDir = new bool[6];

	public bool[] banDirIsHide = new bool[6];

	public int enterParam;

	public int exitParam;

	public int startMoveParam;

	public int endMoveParam;

	public int status;

	public string thingPrefab = "";

	public float thingRotationY;

	public int thingTypeID;

	public int thingEnterParam;

	public int thingExitParam;

	public int thingStartMoveParam;

	public int thingEndMoveParam;

	public float offsetY;

	public bool walkable;

	public ChessBoardGridData()
	{
	}

	public ChessBoardGridData(ChessBoardGridData clone)
	{
		prefab = clone.prefab;
		rotationY = clone.rotationY;
		typeID = clone.typeID;
		status = clone.status;
		x = clone.x;
		z = clone.z;
		enterParam = clone.enterParam;
		exitParam = clone.exitParam;
		startMoveParam = clone.startMoveParam;
		endMoveParam = clone.endMoveParam;
		status = clone.status;
		thingPrefab = clone.thingPrefab;
		thingRotationY = clone.thingRotationY;
		thingTypeID = clone.thingTypeID;
		thingEnterParam = clone.thingEnterParam;
		thingExitParam = clone.thingExitParam;
		thingStartMoveParam = clone.thingStartMoveParam;
		thingEndMoveParam = clone.thingEndMoveParam;
		offsetY = clone.offsetY;
		walkable = clone.walkable;
	}
}
