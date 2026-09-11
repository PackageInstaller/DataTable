using System;

namespace Chess;

[Serializable]
public class GridData
{
	public string prefab = "WarChess/General/10100";

	public float rotationY;

	public int typeID = 10100;

	public short x;

	public short z;

	public int[] paramList;

	public int status;

	public GridData()
	{
	}

	public GridData(GridData clone)
	{
		prefab = clone.prefab;
		typeID = clone.typeID;
		x = clone.x;
		z = clone.z;
		paramList = clone.paramList;
		status = clone.status;
	}
}
