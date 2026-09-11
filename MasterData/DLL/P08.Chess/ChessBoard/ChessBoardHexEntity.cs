using Pathfinding;
using UnityEngine;

namespace ChessBoard;

public class ChessBoardHexEntity
{
	public enum HexStatus
	{
		mRuning,
		mDeath
	}

	public ChessBoardGridData gridData;

	public GridNode gridNode;

	public GameObject go;

	public GameObject thingGo;

	public GameObject[] banDirMarkGoList = new GameObject[6];

	public HexStatus mHexStatus;
}
