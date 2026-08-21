using UnityEngine;

namespace ChessBoard;

public class ChessBoardMap
{
	public int mapID;

	public ChessBoardMapData chessBoardMapData;

	public byte[] mBinMap;

	public ChessBoardGirdChangeData[] mapChangeInfoS;

	public ChessBoardThingChangeData[] thingChangeInfoS;

	public ChessBoardBanDirChangeData[] banDirChangeInfoS;

	public int GridCount => chessBoardMapData.width * chessBoardMapData.height;

	public void SetMapId(int mapId)
	{
		mapID = mapId;
	}

	public void SetMapChangeData(ChessBoardGirdChangeData[] serverMapInfoS, ChessBoardThingChangeData[] serverThingInfoS, ChessBoardBanDirChangeData[] serverBanDirInfoS)
	{
		mapChangeInfoS = serverMapInfoS;
		thingChangeInfoS = serverThingInfoS;
		banDirChangeInfoS = serverBanDirInfoS;
	}

	public void Generate()
	{
		chessBoardMapData = Object.Instantiate(Asset.Load<ChessBoardMapData>("Map/ChessBoard/" + mapID));
		TextAsset textAsset = Asset.Load<TextAsset>("Map/ChessBoard/" + mapID + "_graph.bytes");
		mBinMap = textAsset.bytes;
		for (int i = 0; i < mapChangeInfoS.Length; i++)
		{
			ModifyMapGridData(mapChangeInfoS[i]);
		}
		for (int j = 0; j < thingChangeInfoS.Length; j++)
		{
			ModifyThingGridData(thingChangeInfoS[j]);
		}
		for (int k = 0; k < banDirChangeInfoS.Length; k++)
		{
			ModifyBanDirGridData(banDirChangeInfoS[k]);
		}
	}

	private void ModifyMapGridData(ChessBoardGirdChangeData mapGridChangeData)
	{
		if (mapGridChangeData.tag == 0)
		{
			ChessBoardGridData obj = chessBoardMapData.mapInfo[mapGridChangeData.x * chessBoardMapData.height + mapGridChangeData.z];
			obj.status = mapGridChangeData.status;
			obj.rotationY = mapGridChangeData.rotationY;
			return;
		}
		ChessBoardGridData chessBoardGridData = chessBoardMapData.extendInfo[mapGridChangeData.tag - 1];
		ChessBoardGridData obj2 = chessBoardMapData.mapInfo[mapGridChangeData.x * chessBoardMapData.height + mapGridChangeData.z];
		obj2.prefab = chessBoardGridData.prefab;
		obj2.typeID = chessBoardGridData.typeID;
		obj2.status = mapGridChangeData.status;
		obj2.offsetY = chessBoardGridData.offsetY;
		obj2.x = mapGridChangeData.x;
		obj2.z = mapGridChangeData.z;
		obj2.enterParam = chessBoardGridData.enterParam;
		obj2.exitParam = chessBoardGridData.exitParam;
		obj2.startMoveParam = chessBoardGridData.startMoveParam;
		obj2.endMoveParam = chessBoardGridData.endMoveParam;
		obj2.rotationY = mapGridChangeData.rotationY;
	}

	private void ModifyThingGridData(ChessBoardThingChangeData gridChangeData)
	{
		if (gridChangeData.thingtag == -1)
		{
			ChessBoardGridData obj = chessBoardMapData.mapInfo[gridChangeData.x * chessBoardMapData.height + gridChangeData.z];
			obj.thingPrefab = "";
			obj.thingRotationY = 0f;
			obj.thingTypeID = 0;
			obj.thingEnterParam = 0;
			obj.thingExitParam = 0;
			obj.thingStartMoveParam = 0;
			obj.thingEndMoveParam = 0;
		}
		else if (gridChangeData.thingtag == 0)
		{
			chessBoardMapData.mapInfo[gridChangeData.x * chessBoardMapData.height + gridChangeData.z].thingRotationY = gridChangeData.thingRotationY;
		}
		else
		{
			ChessBoardGridData chessBoardGridData = chessBoardMapData.thingExtendInfo[gridChangeData.thingtag - 1];
			ChessBoardGridData obj2 = chessBoardMapData.mapInfo[gridChangeData.x * chessBoardMapData.height + gridChangeData.z];
			obj2.thingPrefab = chessBoardGridData.thingPrefab;
			obj2.thingRotationY = gridChangeData.thingRotationY;
			obj2.thingTypeID = chessBoardGridData.thingTypeID;
			obj2.thingEnterParam = chessBoardGridData.thingEnterParam;
			obj2.thingExitParam = chessBoardGridData.thingExitParam;
			obj2.thingStartMoveParam = chessBoardGridData.thingStartMoveParam;
			obj2.thingEndMoveParam = chessBoardGridData.thingEndMoveParam;
		}
	}

	private void ModifyBanDirGridData(ChessBoardBanDirChangeData gridChangeData)
	{
		ChessBoardGridData obj = chessBoardMapData.mapInfo[gridChangeData.x * chessBoardMapData.height + gridChangeData.z];
		obj.banDir = gridChangeData.banDir;
		obj.banDirIsHide = gridChangeData.banDirIsHide;
	}

	public ChessBoardGridData GetGridData(int x, int z)
	{
		return chessBoardMapData.mapInfo[x * chessBoardMapData.height + z];
	}

	public void Dispose()
	{
		Object.Destroy(chessBoardMapData);
		mBinMap = null;
	}
}
