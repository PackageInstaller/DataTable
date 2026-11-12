using UnityEngine;

namespace AIScript;

public class TowerDefenseFogOfWar
{
	private const string FOG_PREFAB_PATH = "Assets/AssetBundles/Environment/TowerDefence/Perfab/TowerDefence_WarFog.prefab";

	private const string GRID_ROOT_NAME = "GridMapRoot";

	private const string FOG_GRID_NAME = "fogGrid";

	private const string MAT_ROOT = "Assets/AssetBundles/FX/TowerDefence/Materials/";

	private const string MAT_DARK_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_dark.mat";

	private const string MAT_C1_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c1.mat";

	private const string MAT_C2OPP_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c2opp.mat";

	private const string MAT_C2ADJ_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c2adj.mat";

	private const string MAT_C3_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c3.mat";

	private const string MAT_C4_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c4.mat";

	private const string MAT_E1_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e1.mat";

	private const string MAT_E2OPP_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e2opp.mat";

	private const string MAT_E2ADJ_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e2adj.mat";

	private const string MAT_E3_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e3.mat";

	private const string MAT_E1CR_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e1cr.mat";

	private const string MAT_E1CL_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e1cl.mat";

	private const string MAT_E1C2_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e1c2.mat";

	private const string MAT_E2ADJC1_NAME = "Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e2adjc1.mat";

	private Material matDark;

	private Material matC1;

	private Material matC2Opp;

	private Material matC2Adj;

	private Material matC3;

	private Material matC4;

	private Material matE1;

	private Material matE2Opp;

	private Material matE2Adj;

	private Material matE3;

	private Material matE1Cr;

	private Material matE1Cl;

	private Material matE1C2;

	private Material matE2AdjC1;

	private int sizeX;

	private int sizeY;

	private GameObject fogRoot;

	private GameObject[] gridObjects;

	private MeshRenderer[] renderers;

	private bool[] litFlags;

	public void Init(ITowerDefenseGameplayHost host)
	{
	}

	public void InitGrid(int cols, int rows, float gridScaleX, float gridScaleZ, float addedX = 0f, float addedZ = 0f)
	{
		LoadMaterials();
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/Environment/TowerDefence/Perfab/TowerDefence_WarFog.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("战争迷雾 Prefab 为空:Assets/AssetBundles/Environment/TowerDefence/Perfab/TowerDefence_WarFog.prefab");
			return;
		}
		fogRoot = Object.Instantiate(gameObject);
		fogRoot.name = "TowerDefense_WarFog";
		Transform transform = fogRoot.transform.Find("GridMapRoot");
		if (null == transform)
		{
			Debug.LogError("战争迷雾 Prefab 缺少子节点:GridMapRoot");
			return;
		}
		Transform transform2 = fogRoot.transform.Find("fogGrid");
		if (null == transform2)
		{
			Debug.LogError("战争迷雾 Prefab 缺少子节点:fogGrid");
			return;
		}
		GameObject gameObject2 = transform2.gameObject;
		gameObject2.SetActive(value: false);
		sizeX = cols;
		sizeY = rows;
		int num = sizeX * sizeY;
		gridObjects = new GameObject[num];
		renderers = new MeshRenderer[num];
		litFlags = new bool[num];
		for (int i = 0; i < sizeY; i++)
		{
			for (int j = 0; j < sizeX; j++)
			{
				int num2 = Index(j, i);
				GameObject gameObject3 = Object.Instantiate(gameObject2, transform);
				gameObject3.name = $"FogGrid_{j}_{i}";
				gameObject3.SetActive(value: true);
				gameObject3.transform.localScale = new Vector3(gridScaleX + addedX, 10f, gridScaleZ + addedZ);
				gameObject3.transform.localPosition = new Vector3((float)j * gridScaleX, 2f, (float)i * gridScaleZ);
				gridObjects[num2] = gameObject3;
				renderers[num2] = gameObject3.GetComponent<MeshRenderer>();
			}
		}
		transform.transform.position = new Vector3((float)(-cols) * gridScaleX / 2f + 1.5f, 0f, (float)(-rows) * gridScaleZ / 2f + 1.5f);
		RefreshAll();
	}

	public void Clear()
	{
		if (gridObjects == null)
		{
			return;
		}
		GameObject[] array = gridObjects;
		foreach (GameObject gameObject in array)
		{
			if (gameObject != null)
			{
				Object.Destroy(gameObject);
			}
		}
		gridObjects = null;
		renderers = null;
		litFlags = null;
	}

	public void SetGridLit(int x, int y, bool lit)
	{
		if (InBounds(x, y))
		{
			int num = Index(x, y);
			if (litFlags[num] != lit)
			{
				litFlags[num] = lit;
				RefreshAffected(x, y);
			}
		}
	}

	public void SetAllLit(bool lit)
	{
		for (int i = 0; i < litFlags.Length; i++)
		{
			litFlags[i] = lit;
		}
		RefreshAll();
	}

	private void RefreshAffected(int cx, int cy)
	{
		for (int i = -1; i <= 1; i++)
		{
			for (int j = -1; j <= 1; j++)
			{
				RefreshCell(cx + j, cy + i);
			}
		}
	}

	private void RefreshAll()
	{
		for (int i = 0; i < sizeY; i++)
		{
			for (int j = 0; j < sizeX; j++)
			{
				RefreshCell(j, i);
			}
		}
	}

	private void RefreshCell(int x, int y)
	{
		if (InBounds(x, y))
		{
			bool isLit = ResolveState(x, y, out var mat, out var rotY);
			ApplyVisual(x, y, isLit, mat, rotY);
		}
	}

	private bool ResolveState(int x, int y, out Material mat, out float rotY)
	{
		bool flag = IsLit(x, y + 1);
		bool flag2 = IsLit(x, y - 1);
		bool flag3 = IsLit(x - 1, y);
		bool flag4 = IsLit(x + 1, y);
		bool flag5 = IsLit(x + 1, y + 1);
		bool flag6 = IsLit(x + 1, y - 1);
		bool flag7 = IsLit(x - 1, y - 1);
		bool flag8 = IsLit(x - 1, y + 1);
		if (litFlags[Index(x, y)])
		{
			mat = null;
			rotY = 0f;
			return true;
		}
		bool flag9 = flag5 && !flag && !flag4;
		bool flag10 = flag6 && !flag2 && !flag4;
		bool flag11 = flag7 && !flag2 && !flag3;
		bool flag12 = flag8 && !flag && !flag3;
		if (flag & flag4 & flag2 & flag3)
		{
			mat = matE3;
			rotY = 0f;
			return false;
		}
		if ((flag & flag4 & flag2) && !flag3)
		{
			mat = matE3;
			rotY = 0f;
			return false;
		}
		if ((flag4 & flag2 & flag3) && !flag)
		{
			mat = matE3;
			rotY = 90f;
			return false;
		}
		if ((flag2 & flag3 & flag) && !flag4)
		{
			mat = matE3;
			rotY = 180f;
			return false;
		}
		if ((flag3 & flag & flag4) && !flag2)
		{
			mat = matE3;
			rotY = 270f;
			return false;
		}
		if (((flag & flag4) && !flag2 && !flag3) & flag11)
		{
			mat = matE2AdjC1;
			rotY = 0f;
			return false;
		}
		if (((flag4 & flag2) && !flag3 && !flag) & flag12)
		{
			mat = matE2AdjC1;
			rotY = 90f;
			return false;
		}
		if (((flag2 & flag3) && !flag && !flag4) & flag9)
		{
			mat = matE2AdjC1;
			rotY = 180f;
			return false;
		}
		if (((flag3 & flag) && !flag4 && !flag2) & flag10)
		{
			mat = matE2AdjC1;
			rotY = 270f;
			return false;
		}
		if ((flag & flag4) && !flag2 && !flag3)
		{
			mat = matE2Adj;
			rotY = 0f;
			return false;
		}
		if ((flag4 & flag2) && !flag3 && !flag)
		{
			mat = matE2Adj;
			rotY = 90f;
			return false;
		}
		if ((flag2 & flag3) && !flag && !flag4)
		{
			mat = matE2Adj;
			rotY = 180f;
			return false;
		}
		if ((flag3 & flag) && !flag4 && !flag2)
		{
			mat = matE2Adj;
			rotY = 270f;
			return false;
		}
		if ((flag & flag2) && !flag3 && !flag4)
		{
			mat = matE2Opp;
			rotY = 0f;
			return false;
		}
		if ((flag3 & flag4) && !flag && !flag2)
		{
			mat = matE2Opp;
			rotY = 90f;
			return false;
		}
		if ((flag && !flag2 && !flag3 && !flag4) & flag10 & flag11)
		{
			mat = matE1C2;
			rotY = 0f;
			return false;
		}
		if ((flag4 && !flag3 && !flag && !flag2) & flag11 & flag12)
		{
			mat = matE1C2;
			rotY = 90f;
			return false;
		}
		if ((flag2 && !flag && !flag4 && !flag3) & flag12 & flag9)
		{
			mat = matE1C2;
			rotY = 180f;
			return false;
		}
		if ((flag3 && !flag4 && !flag2 && !flag) & flag9 & flag10)
		{
			mat = matE1C2;
			rotY = 270f;
			return false;
		}
		if (((flag && !flag2 && !flag3 && !flag4) & flag10) && !flag11)
		{
			mat = matE1Cr;
			rotY = 0f;
			return false;
		}
		if (((flag4 && !flag3 && !flag && !flag2) & flag11) && !flag12)
		{
			mat = matE1Cr;
			rotY = 90f;
			return false;
		}
		if (((flag2 && !flag && !flag4 && !flag3) & flag12) && !flag9)
		{
			mat = matE1Cr;
			rotY = 180f;
			return false;
		}
		if (((flag3 && !flag4 && !flag2 && !flag) & flag9) && !flag10)
		{
			mat = matE1Cr;
			rotY = 270f;
			return false;
		}
		if (((flag && !flag2 && !flag3 && !flag4) & flag11) && !flag10)
		{
			mat = matE1Cl;
			rotY = 0f;
			return false;
		}
		if (((flag4 && !flag3 && !flag && !flag2) & flag12) && !flag11)
		{
			mat = matE1Cl;
			rotY = 90f;
			return false;
		}
		if (((flag2 && !flag && !flag4 && !flag3) & flag9) && !flag12)
		{
			mat = matE1Cl;
			rotY = 180f;
			return false;
		}
		if (((flag3 && !flag4 && !flag2 && !flag) & flag10) && !flag9)
		{
			mat = matE1Cl;
			rotY = 270f;
			return false;
		}
		if (flag && !flag2 && !flag3 && !flag4)
		{
			mat = matE1;
			rotY = 0f;
			return false;
		}
		if (flag4 && !flag3 && !flag && !flag2)
		{
			mat = matE1;
			rotY = 90f;
			return false;
		}
		if (flag2 && !flag && !flag4 && !flag3)
		{
			mat = matE1;
			rotY = 180f;
			return false;
		}
		if (flag3 && !flag4 && !flag2 && !flag)
		{
			mat = matE1;
			rotY = 270f;
			return false;
		}
		if (flag9 & flag10 & flag11 & flag12)
		{
			mat = matC4;
			rotY = 0f;
			return false;
		}
		if ((flag9 & flag10 & flag11) && !flag12)
		{
			mat = matC3;
			rotY = 0f;
			return false;
		}
		if ((flag10 & flag11 & flag12) && !flag9)
		{
			mat = matC3;
			rotY = 90f;
			return false;
		}
		if ((flag11 & flag12 & flag9) && !flag10)
		{
			mat = matC3;
			rotY = 180f;
			return false;
		}
		if ((flag12 & flag9 & flag10) && !flag11)
		{
			mat = matC3;
			rotY = 270f;
			return false;
		}
		if ((flag9 & flag11) && !flag10 && !flag12)
		{
			mat = matC2Opp;
			rotY = 0f;
			return false;
		}
		if ((flag12 & flag10) && !flag9 && !flag11)
		{
			mat = matC2Opp;
			rotY = 90f;
			return false;
		}
		if ((flag9 & flag10) && !flag11 && !flag12)
		{
			mat = matC2Adj;
			rotY = 0f;
			return false;
		}
		if ((flag10 & flag11) && !flag12 && !flag9)
		{
			mat = matC2Adj;
			rotY = 90f;
			return false;
		}
		if ((flag11 & flag12) && !flag9 && !flag10)
		{
			mat = matC2Adj;
			rotY = 180f;
			return false;
		}
		if ((flag12 & flag9) && !flag10 && !flag11)
		{
			mat = matC2Adj;
			rotY = 270f;
			return false;
		}
		if (flag9 && !flag10 && !flag11 && !flag12)
		{
			mat = matC1;
			rotY = 0f;
			return false;
		}
		if (flag10 && !flag11 && !flag12 && !flag9)
		{
			mat = matC1;
			rotY = 90f;
			return false;
		}
		if (flag11 && !flag12 && !flag9 && !flag10)
		{
			mat = matC1;
			rotY = 180f;
			return false;
		}
		if (flag12 && !flag9 && !flag10 && !flag11)
		{
			mat = matC1;
			rotY = 270f;
			return false;
		}
		mat = matDark;
		rotY = 0f;
		return false;
	}

	private void LoadMaterials()
	{
		matDark = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_dark.mat");
		matC1 = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c1.mat");
		matC2Opp = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c2opp.mat");
		matC2Adj = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c2adj.mat");
		matC3 = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c3.mat");
		matC4 = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_c4.mat");
		matE1 = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e1.mat");
		matE2Opp = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e2opp.mat");
		matE2Adj = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e2adj.mat");
		matE3 = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e3.mat");
		matE1Cr = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e1cr.mat");
		matE1Cl = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e1cl.mat");
		matE1C2 = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e1c2.mat");
		matE2AdjC1 = LoadMat("Assets/AssetBundles/FX/TowerDefence/Materials/fx_td_light_mat_e2adjc1.mat");
	}

	private static Material LoadMat(string path)
	{
		Material material = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, path, typeof(Material)) as Material;
		if (null == material)
		{
			Debug.LogError("战争迷雾材质为空:" + path);
		}
		return material;
	}

	private void ApplyVisual(int x, int y, bool isLit, Material mat, float rotY)
	{
		int num = Index(x, y);
		GameObject gameObject = gridObjects[num];
		if (gameObject == null)
		{
			return;
		}
		gameObject.SetActive(!isLit);
		if (!isLit)
		{
			if (renderers[num] != null && mat != null)
			{
				renderers[num].material = mat;
			}
			Vector3 localEulerAngles = gameObject.transform.localEulerAngles;
			localEulerAngles.y = rotY;
			gameObject.transform.localEulerAngles = localEulerAngles;
		}
	}

	private int Index(int x, int y)
	{
		return y * sizeX + x;
	}

	private bool InBounds(int x, int y)
	{
		if (x >= 0 && x < sizeX && y >= 0)
		{
			return y < sizeY;
		}
		return false;
	}

	private bool IsLit(int x, int y)
	{
		if (!InBounds(x, y))
		{
			return false;
		}
		return litFlags[Index(x, y)];
	}
}
