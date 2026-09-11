using System;
using System.Collections.Generic;
using UnityEngine;

namespace Chess;

public class ChessHelper
{
	public static GameObject fxGo;

	public static List<Vector3> forwardMap = new List<Vector3>
	{
		new Vector3(1f, 0f, 0f),
		new Vector3(0.5f, 0f, 0.9f),
		new Vector3(-0.5f, 0f, 0.9f),
		new Vector3(-1f, 0f, 0f),
		new Vector3(-0.5f, 0f, -0.9f),
		new Vector3(0.5f, 0f, -0.9f)
	};

	private const float DELTA = 0.2f;

	public static List<Vector3> firePointOffset = new List<Vector3>
	{
		new Vector3(0.5f, 0f, 0f),
		new Vector3(0.25f, 0f, 0.43f),
		new Vector3(-0.25f, 0f, 0.43f),
		new Vector3(-0.5f, 0f, 0f),
		new Vector3(-0.25f, 0f, -0.43f),
		new Vector3(0.25f, 0f, -0.43f)
	};

	public static List<Int2> directionMap = new List<Int2>
	{
		new Int2(1, 1),
		new Int2(0, 1),
		new Int2(-1, 0),
		new Int2(-1, -1),
		new Int2(0, -1),
		new Int2(1, 0)
	};

	private const float PERCISION = 0.01f;

	public static Animator GetGridAnimator(GameObject go)
	{
		Animator component = go.GetComponent<Animator>();
		if (component == null)
		{
			Transform transform = go.transform.Find("ani");
			if (transform != null)
			{
				component = transform.GetComponent<Animator>();
			}
		}
		return component;
	}

	public static GameObject GetGridFXGameObject(GameObject go)
	{
		Transform transform = go.transform.Find("fx");
		if (transform == null)
		{
			return null;
		}
		return transform.gameObject;
	}

	public static List<Int2> GetRangeNodeS(int centerX, int centerZ, int range)
	{
		List<Int2> list = new List<Int2>();
		Int3 @int = HexGridCoord.AxialToCubeCoord(centerX, centerZ);
		for (int i = -range; i <= range; i++)
		{
			for (int j = Mathf.Max(-range, -i - range); j <= Mathf.Min(range, -i + range); j++)
			{
				int z = -i - j;
				Int3 int2 = @int + new Int3(i, j, z);
				list.Add(HexGridCoord.CubeToAxialCoord(int2.x, int2.y, int2.z));
			}
		}
		return list;
	}

	public static int WaitForAnimationEnd(Animator animator, Action callback)
	{
		int timer = 0;
		int fullPathHash = -1;
		timer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			if (animator == null)
			{
				FuncTimerManager.inst.RemoveFuncTimer(timer);
			}
			else
			{
				AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
				if (fullPathHash == -1)
				{
					fullPathHash = currentAnimatorStateInfo.fullPathHash;
				}
				if (currentAnimatorStateInfo.normalizedTime > 0.96f || fullPathHash != currentAnimatorStateInfo.fullPathHash)
				{
					FuncTimerManager.inst.RemoveFuncTimer(timer);
					if (callback != null)
					{
						callback();
					}
				}
			}
		}, 0.1f);
		return timer;
	}

	public static void PlayDisappearEffect(GameObject go, Action callBack = null)
	{
		HexTransitionEffect transitionController = GetTransitionController(go);
		if (transitionController == null || !transitionController.enabled)
		{
			callBack?.Invoke();
		}
		else
		{
			transitionController.Disappear(go, callBack);
		}
	}

	public static void PlayAppearEffect(GameObject go, Action callBack = null)
	{
		HexTransitionEffect transitionController = GetTransitionController(go);
		if (transitionController == null || !transitionController.enabled)
		{
			callBack?.Invoke();
		}
		else
		{
			transitionController.Appear(go, callBack);
		}
	}

	public static HexTransitionEffect GetTransitionController(GameObject go)
	{
		Transform transform = go.transform.Find("Transition");
		if (transform == null)
		{
			return null;
		}
		return transform.gameObject.GetComponent<HexTransitionEffect>();
	}

	public static void SetGridSelectOutline(GameObject go, bool isSelect)
	{
		if (isSelect)
		{
			fxGo = Asset.Instantiate("WarChess/fx_pick_hexagon");
			fxGo.transform.position = go.transform.position;
		}
		else if (fxGo != null)
		{
			PooledAsset.DestroyOrReturn(fxGo);
		}
	}

	public static ChessEffect GetChessEffect(GameObject go)
	{
		Transform transform = go.transform.Find("Transition");
		if (transform == null)
		{
			return null;
		}
		return transform.gameObject.GetComponent<ChessEffect>();
	}

	public static int GetDirectionByForward(Vector3 forward)
	{
		for (int i = 0; i < forwardMap.Count; i++)
		{
			if (Math.Abs(forwardMap[i].x - (float)Math.Round(forward.x, 1)) < 0.2f && Math.Abs(forwardMap[i].y - (float)Math.Round(forward.y, 1)) < 0.2f && Math.Abs(forwardMap[i].z - (float)Math.Round(forward.z, 1)) < 0.2f)
			{
				return i;
			}
		}
		return 0;
	}

	public static Vector3 GetFirePointByDirection(Vector3 center, int direction)
	{
		return center + firePointOffset[direction];
	}

	public static Vector3 GetFireEndPoint(int x, int z, int direction, out Int2 coord)
	{
		Int2 @int = new Int2(x, z);
		bool flag = false;
		while (!flag)
		{
			Int2 int2 = @int + directionMap[direction];
			if (int2.x < 0 || int2.x > HexManager.Instance.mapData.chessMapData.width || int2.y < 0 || int2.y > HexManager.Instance.mapData.chessMapData.height)
			{
				flag = true;
				break;
			}
			HexEntity hexEntity = HexManager.Instance.FindEntity(int2.x, int2.y);
			if (ChessMapCfgManager.Instance.GetGridConfig(hexEntity.gridData.typeID, hexEntity.gridData.status).explode == 1)
			{
				coord = int2;
				return hexEntity.gridNode.position.vec3;
			}
			@int = int2;
		}
		HexEntity hexEntity2 = HexManager.Instance.FindEntity(@int.x, @int.y);
		coord = new Int2(-1, -1);
		return hexEntity2.gridNode.position.vec3 + forwardMap[direction];
	}

	public static Int2 GetSlideEndPoint(int x, int z, int direction, out Int2 crashPoint, out List<Int2> slidePath)
	{
		Int2 @int = new Int2(x, z);
		slidePath = new List<Int2>();
		bool flag = false;
		while (!flag)
		{
			Int2 int2 = @int + directionMap[direction];
			if (int2.x < 0 || int2.x > HexManager.Instance.mapData.chessMapData.width || int2.y < 0 || int2.y > HexManager.Instance.mapData.chessMapData.height)
			{
				flag = true;
				break;
			}
			HexEntity hexEntity = HexManager.Instance.FindEntity(int2.x, int2.y);
			GridConfig gridConfig = ChessMapCfgManager.Instance.GetGridConfig(hexEntity.gridData.typeID, hexEntity.gridData.status);
			slidePath.Add(@int);
			if (gridConfig.walkable == 0)
			{
				crashPoint = int2;
				return @int;
			}
			@int = int2;
		}
		crashPoint = new Int2(-1, -1);
		return @int;
	}

	public static bool isEqual(Vector3 a, Vector3 b)
	{
		bool num = Math.Abs(a.x - b.x) < 0.01f;
		bool flag = Math.Abs(a.y - b.y) < 0.01f;
		bool flag2 = Math.Abs(a.z - b.z) < 0.01f;
		if (num & flag & flag2)
		{
			return true;
		}
		return false;
	}

	public static Vector3 GetWorldPositionByHexCoord(int x, int z)
	{
		if (x < 0 || x > HexManager.Instance.mapData.chessMapData.width || z < 0 || z > HexManager.Instance.mapData.chessMapData.height)
		{
			return Vector3.zero;
		}
		return HexManager.Instance.FindEntity(x, z).gridNode.position.vec3;
	}

	public static List<Int2> GetStonePath(int x, int z, int direction)
	{
		List<Int2> list = new List<Int2>();
		HexEntity hexEntity = HexManager.Instance.FindEntity(x, z);
		switch (ChessMapCfgManager.Instance.GetRealTypeID(hexEntity.gridData.typeID, hexEntity.gridData.status))
		{
		case 206011:
			CommonStoneFindPath(x, z, direction, list);
			break;
		case 206012:
			WeightlossStoneFindPath(x, z, direction, list);
			break;
		default:
			Debug.LogError("移动石头typeID出错！！！");
			break;
		}
		return list;
	}

	protected static void CommonStoneFindPath(int x, int z, int direction, List<Int2> list)
	{
		Int2 @int = new Int2(x, z);
		Int2 int2 = @int + directionMap[direction];
		if (int2.x < 0 || int2.x > HexManager.Instance.mapData.chessMapData.width || int2.y < 0 || int2.y > HexManager.Instance.mapData.chessMapData.height)
		{
			return;
		}
		HexEntity hexEntity = HexManager.Instance.FindEntity(int2.x, int2.y);
		if (ChessMapCfgManager.Instance.GetGridConfig(hexEntity.gridData.typeID, hexEntity.gridData.status).stonecanmove != 0 && hexEntity.gridData.typeID != 20607)
		{
			list.Add(int2);
			@int = int2;
			if (hexEntity.gridData.typeID == 20602)
			{
				WeightlossStoneFindPath(@int.x, @int.y, direction, list);
			}
		}
	}

	protected static void WeightlossStoneFindPath(int x, int z, int direction, List<Int2> list)
	{
		Int2 @int = new Int2(x, z);
		HexEntity hexEntity;
		do
		{
			Int2 int2 = @int + directionMap[direction];
			if (int2.x < 0 || int2.x > HexManager.Instance.mapData.chessMapData.width || int2.y < 0 || int2.y > HexManager.Instance.mapData.chessMapData.height)
			{
				return;
			}
			hexEntity = HexManager.Instance.FindEntity(int2.x, int2.y);
			if (ChessMapCfgManager.Instance.GetGridConfig(hexEntity.gridData.typeID, hexEntity.gridData.status).stonecanmove == 0)
			{
				return;
			}
			list.Add(int2);
			@int = int2;
		}
		while (hexEntity.gridData.typeID != 20602);
		CommonStoneFindPath(@int.x, @int.y, direction, list);
	}

	public static Vector3 GetStoneNextEndPoint(int x, int z, int direction, out Int2 coord)
	{
		Int2 @int = new Int2(x, z);
		Int2 int2 = @int + directionMap[direction];
		if (int2.x < 0 || int2.x > HexManager.Instance.mapData.chessMapData.width || int2.y < 0 || int2.y > HexManager.Instance.mapData.chessMapData.height)
		{
			Debug.Log("到达边界！！");
			HexEntity hexEntity = HexManager.Instance.FindEntity(@int.x, @int.y);
			coord = new Int2(-1, -1);
			return hexEntity.gridNode.position.vec3 + forwardMap[direction];
		}
		HexEntity hexEntity2 = HexManager.Instance.FindEntity(int2.x, int2.y);
		coord = int2;
		return hexEntity2.gridNode.position.vec3;
	}

	public static HexStone GetGridStone(GameObject go)
	{
		HexStone component = go.GetComponent<HexStone>();
		if (component == null)
		{
			Transform transform = go.transform.Find("ani");
			if (transform != null)
			{
				component = transform.GetComponent<HexStone>();
			}
		}
		return component;
	}
}
