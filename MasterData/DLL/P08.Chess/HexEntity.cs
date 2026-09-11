using Chess;
using Pathfinding;
using UnityEngine;

public class HexEntity
{
	public enum HexStatus
	{
		mRuning,
		mDeath
	}

	public GridData gridData;

	public GridNode gridNode;

	public GameObject go;

	public HexStatus mHexStatus;
}
