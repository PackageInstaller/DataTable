using UnityEngine;

namespace Chess;

public class MapData
{
	public int mapID;

	public ChessMapData chessMapData;

	public byte[] mBinMap;

	public bool[] fogInfo;

	private GridChangeData[] mapInfoS;

	public int GridCount => chessMapData.width * chessMapData.height;

	public void SetMapId(int mapId)
	{
		mapID = mapId;
	}

	public void SetMapData(GridChangeData[] serverMapInfoS, bool[] fog)
	{
		mapInfoS = serverMapInfoS;
		fogInfo = fog;
	}

	public void Generate()
	{
		chessMapData = Object.Instantiate(Asset.Load<ChessMapData>("Map/Chess/" + mapID));
		TextAsset textAsset = Asset.Load<TextAsset>("Map/Chess/" + mapID + "_graph.bytes");
		mBinMap = textAsset.bytes;
		for (int i = 0; i < mapInfoS.Length; i++)
		{
			ModifyGridData(mapInfoS[i]);
		}
	}

	private void ModifyGridData(GridChangeData gridChangeData)
	{
		if (gridChangeData.tag == 0)
		{
			GridData obj = chessMapData.mapInfo[gridChangeData.x * chessMapData.height + gridChangeData.z];
			obj.status = gridChangeData.status;
			obj.rotationY = gridChangeData.rotationY;
			return;
		}
		GridData gridData = chessMapData.extendInfo[gridChangeData.tag - 1];
		GridData gridData2 = new GridData();
		gridData2.prefab = gridData.prefab;
		gridData2.typeID = gridData.typeID;
		gridData2.x = gridChangeData.x;
		gridData2.z = gridChangeData.z;
		gridData2.paramList = gridData.paramList;
		gridData2.status = gridChangeData.status;
		gridData2.rotationY = gridChangeData.rotationY;
		chessMapData.mapInfo[gridChangeData.x * chessMapData.height + gridChangeData.z] = gridData2;
	}

	public GridData GetGridData(int x, int z)
	{
		return chessMapData.mapInfo[x * chessMapData.height + z];
	}

	public void Dispose()
	{
		Object.Destroy(chessMapData);
		mBinMap = null;
	}
}
