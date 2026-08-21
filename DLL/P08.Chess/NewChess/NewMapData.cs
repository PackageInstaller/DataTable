using UnityEngine;

namespace NewChess;

public class NewMapData
{
	public int mapID;

	public NewChessMapData chessMapData;

	public byte[] mBinMap;

	public bool[] fogInfo;

	private NewGridChangeData[] mapInfoS;

	public int GridCount => chessMapData.width * chessMapData.height;

	public void SetMapId(int mapId)
	{
		mapID = mapId;
	}

	public void SetMapData(NewGridChangeData[] serverMapInfoS, bool[] fog)
	{
		mapInfoS = serverMapInfoS;
		fogInfo = fog;
	}

	public void Generate()
	{
		chessMapData = Object.Instantiate(Asset.Load<NewChessMapData>("Map/NewChess/" + mapID));
		TextAsset textAsset = Asset.Load<TextAsset>("Map/NewChess/" + mapID + "_graph.bytes");
		mBinMap = textAsset.bytes;
		for (int i = 0; i < mapInfoS.Length; i++)
		{
			ModifyGridData(mapInfoS[i]);
		}
	}

	private void ModifyGridData(NewGridChangeData gridChangeData)
	{
		if (gridChangeData.tag != -1)
		{
			if (gridChangeData.tag == 0)
			{
				NewGridData obj = chessMapData.mapInfo[gridChangeData.x * chessMapData.height + gridChangeData.z];
				obj.status = gridChangeData.status;
				obj.rotationY = gridChangeData.rotationY;
			}
			else if (gridChangeData.tag > 0)
			{
				NewGridData newGridData = chessMapData.extendInfo[gridChangeData.tag - 1];
				NewGridData obj2 = chessMapData.mapInfo[gridChangeData.x * chessMapData.height + gridChangeData.z];
				obj2.prefab = newGridData.prefab;
				obj2.typeID = newGridData.typeID;
				obj2.status = gridChangeData.status;
				obj2.x = gridChangeData.x;
				obj2.z = gridChangeData.z;
				obj2.enterParamList = newGridData.enterParamList;
				obj2.clickParamList = newGridData.clickParamList;
				obj2.exitParamList = newGridData.exitParamList;
				obj2.rotationY = gridChangeData.rotationY;
			}
		}
		if (gridChangeData.objecttag == -1)
		{
			NewGridData obj3 = chessMapData.mapInfo[gridChangeData.x * chessMapData.height + gridChangeData.z];
			obj3.objectPrefab = "";
			obj3.objectRotationY = 0f;
			obj3.objectTypeID = 0;
			obj3.objectEnterParamList = new int[0];
			obj3.objectClickParamList = new int[0];
			obj3.objectExitParamList = new int[0];
			obj3.objectFarClickParamList = new int[0];
		}
		else if (gridChangeData.objecttag == 0)
		{
			chessMapData.mapInfo[gridChangeData.x * chessMapData.height + gridChangeData.z].objectRotationY = gridChangeData.objectRotationY;
		}
		else
		{
			NewGridData newGridData2 = chessMapData.thingExtendInfo[gridChangeData.objecttag - 1];
			NewGridData obj4 = chessMapData.mapInfo[gridChangeData.x * chessMapData.height + gridChangeData.z];
			obj4.objectPrefab = newGridData2.objectPrefab;
			obj4.objectRotationY = gridChangeData.objectRotationY;
			obj4.objectTypeID = newGridData2.objectTypeID;
			obj4.objectEnterParamList = newGridData2.objectEnterParamList;
			obj4.objectClickParamList = newGridData2.objectClickParamList;
			obj4.objectExitParamList = newGridData2.objectExitParamList;
			obj4.objectFarClickParamList = newGridData2.objectFarClickParamList;
		}
	}

	public NewGridData GetGridData(int x, int z)
	{
		return chessMapData.mapInfo[x * chessMapData.height + z];
	}

	public void Dispose()
	{
		Object.Destroy(chessMapData);
		mBinMap = null;
	}
}
