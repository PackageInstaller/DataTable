using System;
using System.Collections;
using System.Collections.Generic;
using NewChess;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class NewHexFogManager
{
	private static NewHexFogManager sInstance;

	private static float GridSide = 0.5f / Mathf.Sin(MathF.PI / 3f);

	private static float offsetHight = GridSide * Mathf.Sin(MathF.PI / 6f);

	public Vector2[] gridOffset = new Vector2[6]
	{
		new Vector2(0f, GridSide),
		new Vector2(0f, 0f - GridSide),
		new Vector2(0.5f, offsetHight),
		new Vector2(0.5f, 0f - offsetHight),
		new Vector2(-0.5f, offsetHight),
		new Vector2(-0.5f, 0f - offsetHight)
	};

	public ArrayList curFogInfo;

	private short mapWidth = 1;

	private short mapHeight = 1;

	public int visualField = 3;

	public HexaFogMesh fogMesh;

	private int curMapXOffset;

	private int curMapZOffset;

	private bool isInit;

	private float curMaxX;

	private float curMinX;

	private float curMaxZ;

	private float curMinZ;

	public static NewHexFogManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new NewHexFogManager();
			}
			return sInstance;
		}
	}

	public float CameraMaxX => curMaxX;

	public float CameraMinX => curMinX;

	public float CameraMaxZ => curMaxZ;

	public float CameraMinZ => curMinZ;

	public void Init(GameObject fogGo, bool[] fog, short width, short height)
	{
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(0, 0);
		if (newHexEntity != null)
		{
			fogGo.transform.position = (Vector3)newHexEntity.gridNode.position;
		}
		fogMesh = U3DUtil.Get<HexaFogMesh>(fogGo);
		mapWidth = width;
		mapHeight = height;
		if (curFogInfo != null)
		{
			foreach (int item in curFogInfo)
			{
				int num2 = item % mapWidth;
				int num3 = (item - num2) / mapWidth;
				fogMesh.SetCell(num2, num3, value: true);
				RefreshFogFx(num2, num3, isShow: true);
			}
		}
		else
		{
			curFogInfo = new ArrayList();
			for (int i = 0; i < fog.Length; i++)
			{
				if (fog[i])
				{
					int num4 = i % mapWidth;
					int num5 = (i - num4) / mapWidth;
					if (!isInit)
					{
						InitFogArea(num4, num5);
					}
					else
					{
						RefreshFogArea(num4, num5);
					}
					if (!curFogInfo.Contains(i))
					{
						curFogInfo.Add(i);
					}
					fogMesh.SetCell(num4, num5, value: true);
					RefreshFogFx(num4, num5, isShow: true);
				}
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
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(x, z);
		if (newHexEntity == null)
		{
			return;
		}
		GameObject go = newHexEntity.go;
		if (!(go == null))
		{
			GameObject gridFXGameObject = NewChessHelper.GetGridFXGameObject(go);
			if (gridFXGameObject != null)
			{
				gridFXGameObject.SetActive(isShow);
			}
		}
	}

	public void WalkOpenFog(int x, int z)
	{
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(x, z);
		Vector2 vector = new Vector2(newHexEntity.go.transform.position.x, newHexEntity.go.transform.position.z);
		NewGridConfig gridConfig = NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity.gridData.typeID, newHexEntity.gridData.status);
		object[] array = LuaHelper.CallFunction("GetPlayerOpenFogLength");
		int num = 0;
		if (array != null && array.Length != 0)
		{
			num = (int)(double)array[0];
		}
		visualField = num + gridConfig.fogAddRange;
		List<Int2> rangeNodeS = NewChessHelper.GetRangeNodeS(x, z, visualField);
		int num2 = 2 * visualField + 1;
		bool[,] array2 = new bool[num2, num2];
		curMapXOffset = rangeNodeS[0].x;
		curMapZOffset = rangeNodeS[0].y;
		List<Vector2> list = new List<Vector2>();
		for (int i = 0; i < rangeNodeS.Count; i++)
		{
			Int2 @int = rangeNodeS[i];
			if (CheckGridLegal(@int.x, @int.y))
			{
				RealXZToMapXZ(out var mapx, out var mapz, @int.x, @int.y);
				array2[mapx, mapz] = true;
				NewHexEntity newHexEntity2 = NewHexManager.Instance.FindEntity(@int.x, @int.y);
				if (NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity2.gridData.typeID, newHexEntity2.gridData.status).height > gridConfig.height)
				{
					list.Add(new Vector2(newHexEntity2.go.transform.position.x, newHexEntity2.go.transform.position.z));
				}
			}
		}
		while (list.Count > 0)
		{
			int index = 0;
			float num3 = 0f;
			for (int j = 0; j < list.Count; j++)
			{
				Vector2 b = list[j];
				float num4 = Vector2.Distance(vector, b);
				if (j == 0)
				{
					index = j;
					num3 = num4;
				}
				else if (num4 < num3)
				{
					index = j;
					num3 = num4;
				}
			}
			Vector2 vector2 = list[index];
			list.RemoveAt(index);
			GetArea(vector, vector2, out var FirstVector, out var SecendVector);
			float num5 = Vector2.Distance(vector, vector2);
			Vector3 rhs = new Vector3(FirstVector.x, 0f, FirstVector.y);
			Vector3 rhs2 = new Vector3(SecendVector.x, 0f, SecendVector.y);
			for (int k = 0; k < num2; k++)
			{
				for (int l = 0; l < num2; l++)
				{
					if (!array2[k, l])
					{
						continue;
					}
					MapXZToRealXZ(k, l, out var realx, out var realz);
					if (!CheckGridLegal(realx, realz))
					{
						continue;
					}
					NewHexEntity newHexEntity3 = NewHexManager.Instance.FindEntity(realx, realz);
					Vector2 vector3 = new Vector2(newHexEntity3.go.transform.position.x, newHexEntity3.go.transform.position.z);
					if (Vector2.Distance(vector, vector3) > num5)
					{
						Vector2 vector4 = vector3 - vector;
						Vector3 lhs = new Vector3(vector4.x, 0f, vector4.y);
						Vector3 vector5 = Vector3.Cross(lhs, rhs);
						Vector3 rhs3 = Vector3.Cross(lhs, rhs2);
						vector5.y = CheckFloatPrecision(vector5.y);
						rhs3.y = CheckFloatPrecision(rhs3.y);
						if (Vector3.Dot(lhs, rhs) >= 0f && Vector3.Dot(lhs, rhs3) >= 0f && ((vector5.y >= 0f && rhs3.y <= 0f) || (vector5.y <= 0f && rhs3.y >= 0f)))
						{
							array2[k, l] = false;
						}
					}
				}
			}
		}
		List<Int2> list2 = new List<Int2>();
		for (int m = 0; m < num2; m++)
		{
			for (int n = 0; n < num2; n++)
			{
				if (array2[m, n])
				{
					MapXZToRealXZ(m, n, out var realx2, out var realz2);
					int num6 = realz2 * mapWidth + realx2;
					if (!curFogInfo.Contains(num6))
					{
						list2.Add(new Int2(realx2, realz2));
						curFogInfo.Add(num6);
						RefreshFogArea(realx2, realz2);
					}
					fogMesh.SetCell(realx2, realz2, value: true);
					RefreshFogFx(realx2, realz2, isShow: true);
				}
			}
		}
		int[] array3 = new int[list2.Count];
		int[] array4 = new int[list2.Count];
		for (int num7 = 0; num7 < list2.Count; num7++)
		{
			array3[num7] = list2[num7].x;
			array4[num7] = list2[num7].y;
		}
		LuaHelper.CallFunction("NewChessFogOpen", x, z, array3, array4);
	}

	public bool GetIsOpenFog(int x, int z)
	{
		return curFogInfo.Contains(z * mapWidth + x);
	}

	public float CheckFloatPrecision(float f)
	{
		if (f >= -0.001f && f <= 0.001f)
		{
			return 0f;
		}
		return f;
	}

	public void ShutDown()
	{
		UnityEngine.Object.Destroy(fogMesh);
	}

	public void MapXZToRealXZ(int mapx, int mapz, out int realx, out int realz)
	{
		realx = curMapXOffset - mapx;
		realz = curMapZOffset - mapz;
	}

	public void RealXZToMapXZ(out int mapx, out int mapz, int realx, int realz)
	{
		mapx = curMapXOffset - realx;
		mapz = curMapZOffset - realz;
	}

	public bool CheckGridLegal(int x, int z)
	{
		if (x >= 0 && x < mapWidth && z >= 0 && z < mapHeight)
		{
			return true;
		}
		return false;
	}

	public void GetArea(Vector2 StartPos, Vector2 TargetPos, out Vector2 FirstVector, out Vector2 SecendVector)
	{
		FirstVector = Vector2.zero;
		SecendVector = Vector2.zero;
		float num = 1f;
		List<Vector2> list = new List<Vector2>();
		for (int i = 0; i < 6; i++)
		{
			Vector2 normalized = (TargetPos + gridOffset[i] - StartPos).normalized;
			list.Add(normalized);
		}
		for (int j = 0; j < 6; j++)
		{
			Vector2 vector = list[j];
			for (int k = j + 1; k < 6; k++)
			{
				Vector2 vector2 = list[k];
				float num2 = Vector2.Dot(vector, vector2);
				if (num > num2)
				{
					num = num2;
					FirstVector = vector;
					SecendVector = vector2;
				}
			}
		}
	}

	public void OpenAreaFog(int x, int z, int length, Action func = null)
	{
		foreach (Int2 rangeNode in NewChessHelper.GetRangeNodeS(x, z, length))
		{
			if (CheckGridLegal(rangeNode.x, rangeNode.y))
			{
				int num = rangeNode.y * mapWidth + rangeNode.x;
				if (!curFogInfo.Contains(num))
				{
					curFogInfo.Add(num);
					RefreshFogArea(rangeNode.x, rangeNode.y);
				}
				fogMesh.SetCell(rangeNode.x, rangeNode.y, value: true);
				RefreshFogFx(rangeNode.x, rangeNode.y, isShow: true);
			}
		}
		if (func != null)
		{
			func();
			func = null;
		}
	}

	public void OpenBarFog(List<Int2> openList)
	{
		foreach (Int2 open in openList)
		{
			if (CheckGridLegal(open.x, open.y))
			{
				int num = open.y * mapWidth + open.x;
				if (!curFogInfo.Contains(num))
				{
					curFogInfo.Add(num);
					RefreshFogArea(open.x, open.y);
				}
				fogMesh.SetCell(open.x, open.y, value: true);
				RefreshFogFx(open.x, open.y, isShow: true);
			}
		}
	}

	private void InitFogArea(int x, int z)
	{
		isInit = true;
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(x, z);
		curMaxX = newHexEntity.go.transform.position.x;
		curMinX = newHexEntity.go.transform.position.x;
		curMaxZ = newHexEntity.go.transform.position.z;
		curMinZ = newHexEntity.go.transform.position.z;
	}

	private void RefreshFogArea(int x, int z)
	{
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(x, z);
		if (newHexEntity.go.transform.position.x > curMaxX)
		{
			curMaxX = newHexEntity.go.transform.position.x;
		}
		else if (newHexEntity.go.transform.position.x < curMinX)
		{
			curMinX = newHexEntity.go.transform.position.x;
		}
		if (newHexEntity.go.transform.position.z > curMaxZ)
		{
			curMaxZ = newHexEntity.go.transform.position.z;
		}
		else if (newHexEntity.go.transform.position.z < curMinZ)
		{
			curMinZ = newHexEntity.go.transform.position.z;
		}
	}

	public void ClearCacheData()
	{
		curFogInfo = null;
		isInit = false;
		curMaxX = 0f;
		curMinX = 0f;
		curMaxZ = 0f;
		curMinZ = 0f;
	}
}
