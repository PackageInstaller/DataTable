using System;

namespace NewChess;

[Serializable]
public class NewGridData
{
	public string prefab = "NewWarChess/General/10100";

	public float rotationY;

	public int typeID = 10100;

	public short x;

	public short z;

	public int[] enterParamList;

	public int[] clickParamList;

	public int[] exitParamList;

	public int status;

	public string objectPrefab = "";

	public float objectRotationY;

	public int objectTypeID;

	public int[] objectEnterParamList;

	public int[] objectClickParamList;

	public int[] objectExitParamList;

	public int[] objectFarClickParamList;

	public float offsetY;

	public NewGridData()
	{
	}

	public NewGridData(NewGridData clone)
	{
		prefab = clone.prefab;
		typeID = clone.typeID;
		status = clone.status;
		x = clone.x;
		z = clone.z;
		enterParamList = clone.enterParamList;
		clickParamList = clone.clickParamList;
		exitParamList = clone.exitParamList;
		objectPrefab = clone.objectPrefab;
		objectTypeID = clone.objectTypeID;
		objectEnterParamList = clone.objectEnterParamList;
		objectClickParamList = clone.objectClickParamList;
		objectExitParamList = clone.objectExitParamList;
		objectFarClickParamList = clone.objectFarClickParamList;
	}
}
