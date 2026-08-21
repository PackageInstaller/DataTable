using NewChess;
using Pathfinding;
using UnityEngine;

public class NewHexEntity
{
	public enum HexStatus
	{
		mRuning,
		mDeath
	}

	public NewGridData gridData;

	public GridNode gridNode;

	public GameObject go;

	public float hight;

	public GameObject ObjectGo;

	public HexStatus mHexStatus;

	public Vector3 rendererPosition
	{
		get
		{
			Vector3 position = go.transform.position;
			position.y += hight;
			return position;
		}
	}
}
