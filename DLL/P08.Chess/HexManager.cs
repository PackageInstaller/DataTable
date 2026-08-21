using System;
using System.Collections.Generic;
using Chess;
using Pathfinding;
using UnityEngine;

public class HexManager
{
	public HexEntity[] mEnities;

	public int mWidth;

	public ChessScene chessScene;

	public MapData mapData;

	public ChessMapData chessMapData;

	private AstarPath astarPath;

	private GridGraph gridGraph;

	private Transform mapTrs;

	private Dictionary<GameObject, Vector3Int> gameObjectToCoordinate;

	private static HexManager sInstance;

	private List<Int2> limitNodeS;

	public static HexManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new HexManager();
			}
			return sInstance;
		}
	}

	public void Init()
	{
		gameObjectToCoordinate = new Dictionary<GameObject, Vector3Int>();
		astarPath = HexGridCoord.astarPath;
		gridGraph = astarPath.data.graphs[0] as GridGraph;
		int num = gridGraph.CountNodes();
		mWidth = gridGraph.Width;
		chessScene = NScene.GetCurrentScene() as ChessScene;
		mapData = chessScene.mapData;
		chessMapData = mapData.chessMapData;
		GameObject gameObject = GameObject.Find("Map");
		if (gameObject == null)
		{
			gameObject = new GameObject("Map");
		}
		mapTrs = gameObject.transform;
		mEnities = new HexEntity[num];
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			GridNode gridNode = node as GridNode;
			int nodeInGridIndex = gridNode.NodeInGridIndex;
			mEnities[nodeInGridIndex] = new HexEntity();
			mEnities[nodeInGridIndex].mHexStatus = HexEntity.HexStatus.mRuning;
			mEnities[nodeInGridIndex].gridNode = gridNode;
			mEnities[nodeInGridIndex].gridData = mapData.GetGridData(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
			GenerateWithEntity(mEnities[nodeInGridIndex]);
		});
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			GridNode node2 = node as GridNode;
			gridGraph.CalculateConnections((GridNodeBase)node2);
		});
	}

	public void ChangeGrid(int x, int z, GridData gridData, bool isExtend = false, Action callBack = null)
	{
		HexEntity hexEntity = FindEntity(x, z);
		if (hexEntity == null)
		{
			return;
		}
		if (isExtend)
		{
			gridData.x = (short)x;
			gridData.z = (short)z;
		}
		if (hexEntity.go != null)
		{
			GridEventTrigger component = hexEntity.go.GetComponent<GridEventTrigger>();
			if (component != null)
			{
				component.onPointerClick = (Action<GameObject>)Delegate.Remove(component.onPointerClick, new Action<GameObject>(ClickNode));
			}
			ChessHelper.PlayDisappearEffect(hexEntity.go, delegate
			{
				UnityEngine.Object.Destroy(hexEntity.go);
				gameObjectToCoordinate.Remove(hexEntity.go);
				hexEntity.gridData = gridData;
				GenerateWithEntity(hexEntity, isNeedAni: true, callBack);
				gridGraph.GetNodes(delegate(GraphNode node)
				{
					gridGraph.CalculateConnections((GridNodeBase)node);
				});
			});
		}
		else
		{
			hexEntity.gridData = gridData;
			GenerateWithEntity(hexEntity, isNeedAni: true, callBack);
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
	}

	public float ChangeGridStatus(int x, int z, int newStatus, Action func = null)
	{
		HexEntity hexEntity = FindEntity(x, z);
		_ = hexEntity.gridData.status;
		if (hexEntity != null)
		{
			if (hexEntity.go != null)
			{
				Animator animator = ChessHelper.GetGridAnimator(hexEntity.go);
				if (animator != null)
				{
					animator.Play(newStatus.ToString());
					int timer = 0;
					timer = FuncTimerManager.inst.CreateFuncTimer(delegate
					{
						if (animator == null)
						{
							FuncTimerManager.inst.RemoveFuncTimer(timer);
						}
						else if (animator.GetCurrentAnimatorStateInfo(0).normalizedTime > 0.96f)
						{
							FuncTimerManager.inst.RemoveFuncTimer(timer);
							if (func != null)
							{
								func();
							}
						}
					}, 0.1f);
				}
				else if (func != null)
				{
					func();
				}
			}
			GridConfig gridConfig = ChessMapCfgManager.Instance.GetGridConfig(hexEntity.gridData.typeID, newStatus);
			hexEntity.gridData.status = newStatus;
			if (gridConfig != null)
			{
				bool isInLimit = GetIsInLimit(x, z);
				hexEntity.gridNode.Walkable = !isInLimit && gridConfig.walkable >= 1;
				hexEntity.gridNode.Penalty = gridConfig.walkable * 1000;
			}
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
		return 0f;
	}

	public void LimitMoveRange(int centerX, int centerZ, int range = 1)
	{
		if (limitNodeS == null)
		{
			limitNodeS = new List<Int2>();
		}
		limitNodeS.Clear();
		List<Int2> rangeNodeS = ChessHelper.GetRangeNodeS(centerX, centerZ, range + 1);
		List<Int2> rangeNodeS2 = ChessHelper.GetRangeNodeS(centerX, centerZ, range);
		for (int i = 0; i < rangeNodeS.Count; i++)
		{
			if (rangeNodeS[i].x == centerX && rangeNodeS[i].y == centerZ)
			{
				limitNodeS.Add(rangeNodeS[i]);
				continue;
			}
			bool flag = false;
			for (int j = 0; j < rangeNodeS2.Count; j++)
			{
				if (rangeNodeS[i].x == rangeNodeS2[j].x && rangeNodeS[i].y == rangeNodeS2[j].y)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				limitNodeS.Add(rangeNodeS[i]);
			}
		}
		RefreshLimitMap();
	}

	private void RefreshLimitMap()
	{
		if (limitNodeS == null || limitNodeS.Count == 0)
		{
			return;
		}
		for (int i = 0; i < limitNodeS.Count; i++)
		{
			HexEntity hexEntity = Instance.FindEntity(limitNodeS[i].x, limitNodeS[i].y);
			if (hexEntity != null)
			{
				hexEntity.gridNode.Walkable = false;
			}
		}
		GridGraph gridGraph = astarPath.data.graphs[0] as GridGraph;
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			gridGraph.CalculateConnections((GridNodeBase)node);
		});
	}

	public void ClearMoveLimit()
	{
		for (int i = 0; i < limitNodeS.Count; i++)
		{
			HexEntity hexEntity = Instance.FindEntity(limitNodeS[i].x, limitNodeS[i].y);
			if (hexEntity != null)
			{
				GridConfig gridConfig = ChessMapCfgManager.Instance.GetGridConfig(hexEntity.gridData.typeID, hexEntity.gridData.status);
				if (gridConfig != null)
				{
					hexEntity.gridNode.Walkable = gridConfig.walkable >= 1;
					hexEntity.gridNode.Penalty = gridConfig.walkable * 1000;
				}
			}
		}
		GridGraph gridGraph = astarPath.data.graphs[0] as GridGraph;
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			gridGraph.CalculateConnections((GridNodeBase)node);
		});
		limitNodeS.Clear();
	}

	public bool GetIsInLimit(int x, int z)
	{
		if (limitNodeS == null || limitNodeS.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < limitNodeS.Count; i++)
		{
			if (limitNodeS[i].x == x && limitNodeS[i].y == z)
			{
				return true;
			}
		}
		return false;
	}

	public void PlayGridAnimation(int x, int z, string ani, Action func = null)
	{
		HexEntity hexEntity = FindEntity(x, z);
		int fullPathHash = -1;
		if (hexEntity == null || !(hexEntity.go != null))
		{
			return;
		}
		Animator animator = ChessHelper.GetGridAnimator(hexEntity.go);
		if (animator != null)
		{
			animator.Play(ani);
			int timer = 0;
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
						if (func != null)
						{
							func();
						}
					}
				}
			}, 0.1f);
		}
		else if (func != null)
		{
			func();
		}
	}

	public int CoordToIndex(int x, int z)
	{
		return x + z * mWidth;
	}

	public HexEntity FindEntity(int index)
	{
		if (mEnities.Length > index && index >= 0)
		{
			return mEnities[index];
		}
		return null;
	}

	public HexEntity FindEntity(int x, int z)
	{
		int index = CoordToIndex(x, z);
		return FindEntity(index);
	}

	public void GenerateWithEntity(HexEntity hexEntity, bool isNeedAni = false, Action callBack = null)
	{
		GridNode gridNode = hexEntity.gridNode;
		short x = (short)gridNode.XCoordinateInGrid;
		short z = (short)gridNode.ZCoordinateInGrid;
		GridData gridData = hexEntity.gridData;
		GridConfig gridConfig = ChessMapCfgManager.Instance.GetGridConfig(gridData.typeID, gridData.status);
		if (gridData.typeID == 10100 || gridConfig == null)
		{
			gridNode.Walkable = false;
			return;
		}
		bool isInLimit = GetIsInLimit(x, z);
		gridNode.Walkable = !isInLimit && gridConfig.walkable >= 1;
		gridNode.Penalty = gridConfig.walkable * 1000;
		string path = ((gridData.typeID != 10101) ? gridData.prefab : "WarChess/General/10101_runtime");
		GameObject gameObject = Asset.InstantiateWithoutCache(path);
		gameObject.transform.parent = mapTrs;
		gameObject.transform.position = (Vector3)gridNode.position;
		gameObject.name = gridData.typeID + "_node(" + x + "," + z + ")";
		gameObject.transform.localEulerAngles = new Vector3(0f, gridData.rotationY, 0f);
		Transform transform = gameObject.transform.Find("collider");
		if (transform != null)
		{
			GridEventTrigger gridEventTrigger = transform.GetComponent<GridEventTrigger>();
			if (gridEventTrigger == null)
			{
				gridEventTrigger = transform.gameObject.AddComponent<GridEventTrigger>();
			}
			GridEventTrigger gridEventTrigger2 = gridEventTrigger;
			gridEventTrigger2.onPointerClick = (Action<GameObject>)Delegate.Combine(gridEventTrigger2.onPointerClick, new Action<GameObject>(ClickNode));
			gridEventTrigger.callBackGo = gameObject;
		}
		gameObjectToCoordinate.Add(gameObject, new Vector3Int(x, 0, z));
		hexEntity.go = gameObject;
		if (gridData.status != 0)
		{
			Animator gridAnimator = ChessHelper.GetGridAnimator(gameObject);
			if (gridAnimator != null)
			{
				gridAnimator.Play("status_" + gridData.status);
			}
		}
		if (isNeedAni)
		{
			ChessHelper.PlayAppearEffect(gameObject, callBack);
		}
		else
		{
			callBack?.Invoke();
		}
	}

	public void GetEntityStatus()
	{
	}

	public void SetEntityStatus()
	{
	}

	public void ClickNode(GameObject go)
	{
		Debug.Log(go.name);
		if (!gameObjectToCoordinate.TryGetValue(go, out var value))
		{
			return;
		}
		ChessScene chessScene = NScene.GetCurrentScene() as ChessScene;
		HexAnimator mRole = chessScene.hexGridCoord.mRole;
		if ((value.x == mRole.GridPosition.x && value.z == mRole.GridPosition.z) || !HexFogManager.Instance.GetIsOpenFog(value.x, value.z))
		{
			return;
		}
		GridData gridData = FindEntity(value.x, value.z).gridData;
		GridConfig gridConfig = ChessMapCfgManager.Instance.GetGridConfig(gridData.typeID, gridData.status);
		if (gridConfig.interact == 0)
		{
			_ = gridConfig.walkable;
		}
		FindABPathResult findABPathResult = chessScene.hexGridCoord.FindPath(value.x, value.z, isCache: true);
		if (findABPathResult == null)
		{
			return;
		}
		ABPath abPath = findABPathResult.abPath;
		GridData[] array = null;
		if (!abPath.error && findABPathResult.isInRange)
		{
			array = new GridData[abPath.path.Count];
			for (int i = 0; i < abPath.path.Count; i++)
			{
				GridNode gridNode = abPath.path[i] as GridNode;
				array[i] = FindEntity(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid).gridData;
			}
		}
		Debug.Log("aBPath.error : " + abPath.error + "   abPathResult : " + findABPathResult.isInRange);
		if (array != null)
		{
			Debug.Log("gridList.Length : " + array.Length);
		}
		if (findABPathResult.isInRange)
		{
			LuaHelper.CallFunction("GridClick", gridData, array, abPath.error);
		}
		else
		{
			LuaHelper.CallFunction("GridClick", gridData, array, true);
		}
	}

	internal bool BeforeClick(GridNode mSelectedGrid)
	{
		return true;
	}

	internal void AfterClick(ABPath ab)
	{
	}

	public void Shutdown()
	{
		gameObjectToCoordinate.Clear();
		astarPath.Shutdown();
		HexGridCoord.astarPath = null;
		if (limitNodeS != null)
		{
			limitNodeS.Clear();
		}
	}
}
