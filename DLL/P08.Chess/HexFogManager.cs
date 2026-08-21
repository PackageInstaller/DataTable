using System.Collections;
using System.Collections.Generic;
using Chess;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class HexFogManager
{
	private static HexFogManager sInstance;

	public bool[] fogInfo;

	public ArrayList curFogInfo;

	private short mapWidth = 1;

	private short mapHeight = 1;

	public int visualField = 3;

	public HexaFogMesh fogMesh;

	public static HexFogManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new HexFogManager();
			}
			return sInstance;
		}
	}

	public void Init(GameObject fogGo, bool[] fog, short width, short height)
	{
		HexEntity hexEntity = HexManager.Instance.FindEntity(0, 0);
		if (hexEntity != null)
		{
			fogGo.transform.position = (Vector3)hexEntity.gridNode.position;
		}
		fogMesh = U3DUtil.Get<HexaFogMesh>(fogGo);
		fogInfo = fog;
		mapWidth = width;
		mapHeight = height;
		curFogInfo = new ArrayList();
		for (int i = 0; i < fogInfo.Length; i++)
		{
			if (!fogInfo[i])
			{
				continue;
			}
			int num = i % mapWidth;
			int centerZ = (i - num) / mapWidth;
			List<Int2> rangeNodeS = ChessHelper.GetRangeNodeS(num, centerZ, visualField);
			for (int j = 0; j < rangeNodeS.Count; j++)
			{
				Int2 @int = rangeNodeS[j];
				int num2 = @int.y * mapWidth + @int.x;
				if (!curFogInfo.Contains(num2))
				{
					curFogInfo.Add(num2);
				}
				fogMesh.SetCell(@int.x, @int.y, value: true);
				RefreshFogFx(@int.x, @int.y, isShow: true);
			}
		}
		InitFogFX();
	}

	public void InitFogFX()
	{
		for (int i = 0; i < mapWidth; i++)
		{
			for (int j = 0; j < mapHeight; j++)
			{
				RefreshFogFx(i, j, GetIsOpenFog(i, j));
			}
		}
	}

	public void RefreshFogFx(int x, int z, bool isShow)
	{
		if (x < 0 || z < 0 || x >= mapWidth || z >= mapHeight)
		{
			return;
		}
		HexEntity hexEntity = HexManager.Instance.FindEntity(x, z);
		if (hexEntity == null)
		{
			return;
		}
		GameObject go = hexEntity.go;
		if (!(go == null))
		{
			GameObject gridFXGameObject = ChessHelper.GetGridFXGameObject(go);
			if (gridFXGameObject != null)
			{
				gridFXGameObject.SetActive(isShow);
			}
		}
	}

	public void WalkOpenFog(int x, int z)
	{
		int num = z * mapWidth + x;
		if (!fogInfo[num])
		{
			fogInfo[num] = true;
			List<int> list = new List<int> { num };
			LuaHelper.CallFunction("FogOpen", list);
		}
		List<Int2> rangeNodeS = ChessHelper.GetRangeNodeS(x, z, visualField);
		for (int i = 0; i < rangeNodeS.Count; i++)
		{
			Int2 @int = rangeNodeS[i];
			int num2 = @int.y * mapWidth + @int.x;
			if (!curFogInfo.Contains(num2))
			{
				curFogInfo.Add(num2);
			}
			fogMesh.SetCell(@int.x, @int.y, value: true);
			RefreshFogFx(@int.x, @int.y, isShow: true);
		}
	}

	public bool GetIsOpenFog(int x, int z)
	{
		return curFogInfo.Contains(z * mapWidth + x);
	}

	public void ShutDown()
	{
		curFogInfo.Clear();
		Object.Destroy(fogMesh);
	}
}
