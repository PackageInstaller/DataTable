using System;
using System.Collections.Generic;
using Pathfinding;
using UnityEngine;

namespace ChessBoard;

public class ChessBoardHexManager
{
	public ChessBoardHexEntity[] mEnities;

	public int mWidth;

	public ChessBoardScene chessScene;

	public ChessBoardMap chessMap;

	public ChessBoardMapData chessMapData;

	private AstarPath astarPath;

	private GridGraph gridGraph;

	private Transform mapTrs;

	private Transform objectMapTrs;

	private Transform banDirMarkTrs;

	private Dictionary<GameObject, Vector3Int> gameObjectToCoordinate;

	private static ChessBoardHexManager sInstance;

	public static ChessBoardHexManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new ChessBoardHexManager();
			}
			return sInstance;
		}
	}

	public void Init()
	{
		gameObjectToCoordinate = new Dictionary<GameObject, Vector3Int>();
		astarPath = ChessBoardHexGridCoord.astarPath;
		gridGraph = astarPath.data.graphs[0] as GridGraph;
		int num = gridGraph.CountNodes();
		mWidth = gridGraph.Width;
		chessScene = NScene.GetCurrentScene() as ChessBoardScene;
		chessMap = chessScene.mapData;
		chessMapData = chessMap.chessBoardMapData;
		GameObject gameObject = GameObject.Find("Map");
		if (gameObject == null)
		{
			gameObject = new GameObject("Map");
		}
		mapTrs = gameObject.transform;
		GameObject gameObject2 = GameObject.Find("ThingMap");
		if (gameObject2 == null)
		{
			gameObject2 = new GameObject("ThingMap");
		}
		objectMapTrs = gameObject2.transform;
		GameObject gameObject3 = GameObject.Find("BanDirMark");
		if (gameObject3 == null)
		{
			gameObject3 = new GameObject("BanDirMark");
		}
		banDirMarkTrs = gameObject3.transform;
		mEnities = new ChessBoardHexEntity[num];
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			GridNode gridNode = node as GridNode;
			int nodeInGridIndex = gridNode.NodeInGridIndex;
			mEnities[nodeInGridIndex] = new ChessBoardHexEntity();
			mEnities[nodeInGridIndex].mHexStatus = ChessBoardHexEntity.HexStatus.mRuning;
			mEnities[nodeInGridIndex].gridNode = gridNode;
			mEnities[nodeInGridIndex].gridData = chessMap.GetGridData(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
			GenerateWithEntity(mEnities[nodeInGridIndex]);
			GenerateObjectWithEntity(mEnities[nodeInGridIndex]);
		});
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			GridNode gridNode = node as GridNode;
			int nodeInGridIndex = gridNode.NodeInGridIndex;
			GenerateBanDirMark(mEnities[nodeInGridIndex]);
			gridGraph.CalculateConnections((GridNodeBase)gridNode);
		});
	}

	public void ChangeGrid(int x, int z, ChessBoardGridData gridData, bool isInheritDir, bool isExtend = false, Action callBack = null)
	{
		ChessBoardHexEntity hexEntity = FindEntity(x, z);
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
			ChessBoardGridEventTrigger component = hexEntity.go.GetComponent<ChessBoardGridEventTrigger>();
			if (component != null)
			{
				component.onPointerClick = (Action<GameObject>)Delegate.Remove(component.onPointerClick, new Action<GameObject>(ClickNode));
			}
			ChessBoardHelper.PlayDisappearEffect(hexEntity.go, delegate
			{
				UnityEngine.Object.Destroy(hexEntity.go);
				gameObjectToCoordinate.Remove(hexEntity.go);
				if (hexEntity.thingGo != null)
				{
					gridData.thingPrefab = hexEntity.gridData.thingPrefab;
					gridData.thingTypeID = hexEntity.gridData.thingTypeID;
					gridData.thingRotationY = hexEntity.gridData.thingRotationY;
					gridData.thingEnterParam = hexEntity.gridData.thingEnterParam;
					gridData.thingExitParam = hexEntity.gridData.thingExitParam;
					gridData.thingStartMoveParam = hexEntity.gridData.thingStartMoveParam;
					gridData.thingEndMoveParam = hexEntity.gridData.thingEndMoveParam;
				}
				if (isInheritDir)
				{
					gridData.rotationY = hexEntity.gridData.rotationY;
				}
				gridData.banDir = hexEntity.gridData.banDir;
				gridData.banDirIsHide = hexEntity.gridData.banDirIsHide;
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
			if (hexEntity.thingGo != null)
			{
				gridData.thingPrefab = hexEntity.gridData.thingPrefab;
				gridData.thingTypeID = hexEntity.gridData.thingTypeID;
				gridData.thingRotationY = hexEntity.gridData.thingRotationY;
				gridData.thingEnterParam = hexEntity.gridData.thingEnterParam;
				gridData.thingExitParam = hexEntity.gridData.thingExitParam;
				gridData.thingStartMoveParam = hexEntity.gridData.thingStartMoveParam;
				gridData.thingEndMoveParam = hexEntity.gridData.thingEndMoveParam;
			}
			if (isInheritDir)
			{
				gridData.rotationY = hexEntity.gridData.rotationY;
			}
			gridData.banDir = hexEntity.gridData.banDir;
			gridData.banDirIsHide = hexEntity.gridData.banDirIsHide;
			hexEntity.gridData = gridData;
			GenerateWithEntity(hexEntity, isNeedAni: true, callBack);
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
	}

	public void ChangeThing(int x, int z, ChessBoardGridData gridData, bool isExtend = false, Action callBack = null)
	{
		ChessBoardHexEntity chessBoardHexEntity = FindEntity(x, z);
		if (chessBoardHexEntity == null)
		{
			return;
		}
		if (chessBoardHexEntity.thingGo != null)
		{
			UnityEngine.Object.DestroyImmediate(chessBoardHexEntity.thingGo);
			chessBoardHexEntity.gridData.thingTypeID = gridData.thingTypeID;
			chessBoardHexEntity.gridData.thingPrefab = gridData.thingPrefab;
			chessBoardHexEntity.gridData.thingRotationY = gridData.thingRotationY;
			chessBoardHexEntity.gridData.thingEnterParam = gridData.thingEnterParam;
			chessBoardHexEntity.gridData.thingExitParam = gridData.thingExitParam;
			chessBoardHexEntity.gridData.thingStartMoveParam = gridData.thingStartMoveParam;
			chessBoardHexEntity.gridData.thingEndMoveParam = gridData.thingEndMoveParam;
			GenerateObjectWithEntity(chessBoardHexEntity, isNeedAni: true, callBack);
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
		else
		{
			chessBoardHexEntity.gridData.thingTypeID = gridData.thingTypeID;
			chessBoardHexEntity.gridData.thingPrefab = gridData.thingPrefab;
			chessBoardHexEntity.gridData.thingRotationY = gridData.thingRotationY;
			chessBoardHexEntity.gridData.thingEnterParam = gridData.thingEnterParam;
			chessBoardHexEntity.gridData.thingExitParam = gridData.thingExitParam;
			chessBoardHexEntity.gridData.thingStartMoveParam = gridData.thingStartMoveParam;
			chessBoardHexEntity.gridData.thingEndMoveParam = gridData.thingEndMoveParam;
			GenerateObjectWithEntity(chessBoardHexEntity, isNeedAni: true, callBack);
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
	}

	public void DeleteThing(int x, int z, Action callBack = null)
	{
		ChessBoardHexEntity chessBoardHexEntity = FindEntity(x, z);
		if (chessBoardHexEntity != null && chessBoardHexEntity.thingGo != null)
		{
			UnityEngine.Object.DestroyImmediate(chessBoardHexEntity.thingGo);
			chessBoardHexEntity.gridData.thingTypeID = 0;
			chessBoardHexEntity.gridData.thingPrefab = "";
			chessBoardHexEntity.gridData.thingRotationY = 0f;
			chessBoardHexEntity.gridData.thingEnterParam = 0;
			chessBoardHexEntity.gridData.thingExitParam = 0;
			chessBoardHexEntity.gridData.thingStartMoveParam = 0;
			chessBoardHexEntity.gridData.thingEndMoveParam = 0;
			_ = chessBoardHexEntity.gridNode;
			ChessBoardMapCfgManager.Instance.GetGridConfig(chessBoardHexEntity.gridData.typeID, chessBoardHexEntity.gridData.status);
			FixHexEntityWalkable(chessBoardHexEntity);
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
		callBack?.Invoke();
	}

	public int CoordToIndex(int x, int z)
	{
		return x + z * mWidth;
	}

	public ChessBoardHexEntity FindEntity(int index)
	{
		if (mEnities.Length > index && index >= 0)
		{
			return mEnities[index];
		}
		return null;
	}

	public ChessBoardHexEntity FindEntity(int x, int z)
	{
		int index = CoordToIndex(x, z);
		return FindEntity(index);
	}

	public void GenerateWithEntity(ChessBoardHexEntity hexEntity, bool isNeedAni = false, Action callBack = null)
	{
		GridNode gridNode = hexEntity.gridNode;
		short x = (short)gridNode.XCoordinateInGrid;
		short z = (short)gridNode.ZCoordinateInGrid;
		ChessBoardGridData gridData = hexEntity.gridData;
		ChessBoardMapCfgManager.Instance.GetGridConfig(gridData.typeID, gridData.status);
		FixHexEntityWalkable(hexEntity);
		gridNode.Penalty = 1u;
		string path = ((gridData.typeID != ChessBoardConst.GROUND_GRID_ID) ? gridData.prefab : "ChessBoard/Ground/floor_runtime");
		GameObject gameObject = Asset.InstantiateWithoutCache(path);
		gameObject.transform.parent = mapTrs;
		gameObject.transform.position = (Vector3)gridNode.position;
		gameObject.transform.position = gameObject.transform.position.NewY(gridData.offsetY);
		gameObject.name = gridData.typeID + "_node(" + x + "," + z + ")";
		gameObject.transform.localEulerAngles = new Vector3(0f, gridData.rotationY, 0f);
		Transform transform = gameObject.transform.Find("collider");
		if (transform != null)
		{
			ChessBoardGridEventTrigger chessBoardGridEventTrigger = transform.GetComponent<ChessBoardGridEventTrigger>();
			if (chessBoardGridEventTrigger == null)
			{
				chessBoardGridEventTrigger = transform.gameObject.AddComponent<ChessBoardGridEventTrigger>();
			}
			ChessBoardGridEventTrigger chessBoardGridEventTrigger2 = chessBoardGridEventTrigger;
			chessBoardGridEventTrigger2.onPointerClick = (Action<GameObject>)Delegate.Combine(chessBoardGridEventTrigger2.onPointerClick, new Action<GameObject>(ClickNode));
			chessBoardGridEventTrigger.callBackGo = gameObject;
		}
		gameObjectToCoordinate.Add(gameObject, new Vector3Int(x, 0, z));
		hexEntity.go = gameObject;
		if (gridData.status != 0)
		{
			Animator gridAnimator = ChessBoardHelper.GetGridAnimator(gameObject);
			if (gridAnimator != null)
			{
				gridAnimator.Play("status_" + gridData.status);
			}
		}
		if (isNeedAni)
		{
			ChessBoardHelper.PlayAppearEffect(gameObject, callBack);
		}
		else
		{
			callBack?.Invoke();
		}
	}

	public void GenerateObjectWithEntity(ChessBoardHexEntity hexEntity, bool isNeedAni = false, Action callBack = null)
	{
		GridNode gridNode = hexEntity.gridNode;
		short num = (short)gridNode.XCoordinateInGrid;
		short num2 = (short)gridNode.ZCoordinateInGrid;
		ChessBoardGridData gridData = hexEntity.gridData;
		if (gridData.thingPrefab != "")
		{
			GameObject gameObject = Asset.InstantiateWithoutCache(gridData.thingPrefab);
			gameObject.transform.parent = objectMapTrs;
			gameObject.transform.position = (Vector3)gridNode.position;
			gameObject.name = gridData.thingTypeID + "_node(" + num + "," + num2 + ")";
			gameObject.transform.localEulerAngles = new Vector3(0f, gridData.thingRotationY, 0f);
			hexEntity.thingGo = gameObject;
			FixHexEntityWalkable(hexEntity);
			if (isNeedAni)
			{
				ChessBoardHelper.PlayAppearEffect(gameObject, callBack);
			}
			else
			{
				callBack?.Invoke();
			}
		}
	}

	public void GenerateBanDirMark(ChessBoardHexEntity hexEntity, Action callBack = null)
	{
		GridNode gridNode = hexEntity.gridNode;
		_ = gridNode.XCoordinateInGrid;
		_ = gridNode.ZCoordinateInGrid;
		ChessBoardGridData gridData = hexEntity.gridData;
		for (int i = 0; i < 6; i++)
		{
			if (gridData.banDir[i] && !gridData.banDirIsHide[i])
			{
				GameObject gameObject = Asset.InstantiateWithoutCache("ChessBoard/BanDirMark/Prefab/bandirmark_runtime");
				hexEntity.banDirMarkGoList[i] = gameObject;
				Vector3 vector = (Vector3)hexEntity.gridNode.position;
				Vector3 vector2 = (Vector3)FindEntity(hexEntity.gridData.x + ChessBoardHexGridCoord.mGridDirection[i].x, hexEntity.gridData.z + ChessBoardHexGridCoord.mGridDirection[i].y).gridNode.position;
				gameObject.transform.parent = GameObject.Find("BanDirMark").transform;
				Vector3 position = (vector + vector2) / 2f;
				gameObject.transform.position = position;
				gameObject.transform.LookAt(vector2);
			}
		}
		callBack?.Invoke();
	}

	public void FixHexEntityWalkable(ChessBoardHexEntity entity)
	{
		if (entity.thingGo != null)
		{
			if (ChessBoardMapCfgManager.Instance.GetThingConfig(entity.gridData.thingTypeID).fixWalkable >= 1)
			{
				entity.gridData.walkable = false;
				entity.gridNode.Walkable = false;
			}
			else if (ChessBoardMapCfgManager.Instance.GetGridConfig(entity.gridData.typeID, entity.gridData.status).walkable >= 1)
			{
				entity.gridData.walkable = true;
				entity.gridNode.Walkable = true;
			}
			else
			{
				entity.gridData.walkable = false;
				entity.gridNode.Walkable = false;
			}
		}
		else
		{
			bool walkable = ChessBoardMapCfgManager.Instance.GetGridConfig(entity.gridData.typeID, entity.gridData.status).walkable >= 1;
			entity.gridData.walkable = walkable;
			entity.gridNode.Walkable = walkable;
		}
	}

	public ChessBoardSmallMapData GetCurSmallMapData()
	{
		ChessBoardSmallMapData chessBoardSmallMapData = new ChessBoardSmallMapData();
		chessBoardSmallMapData.typeIDList = new int[mEnities.Length];
		chessBoardSmallMapData.thingTypeIDList = new int[mEnities.Length];
		for (int i = 0; i < mEnities.Length; i++)
		{
			chessBoardSmallMapData.typeIDList[i] = mEnities[i].gridData.typeID;
			chessBoardSmallMapData.thingTypeIDList[i] = mEnities[i].gridData.thingTypeID;
		}
		return chessBoardSmallMapData;
	}

	public void ClickNode(GameObject go)
	{
		Debug.Log(go.name);
		Camera.main.WorldToScreenPoint(go.transform.position);
		if (gameObjectToCoordinate.TryGetValue(go, out var value))
		{
			ChessBoardScene chessBoardScene = NScene.GetCurrentScene() as ChessBoardScene;
			if (chessBoardScene.hexGridCoord.heroEntity.isSelectingMovePos)
			{
				ChessBoardGridData gridData = FindEntity(value.x, value.z).gridData;
				LuaHelper.CallFunction("ChessBoardSelectMovePos", gridData.x, gridData.z);
			}
			else if (chessBoardScene.hexGridCoord.heroEntity.isSelectingNpc)
			{
				ChessBoardGridData gridData2 = FindEntity(value.x, value.z).gridData;
				LuaHelper.CallFunction("ChessBoardSelectNpcPos", gridData2.x, gridData2.z);
			}
			else if (chessBoardScene.hexGridCoord.heroEntity.isSelectingMapPos)
			{
				ChessBoardGridData gridData3 = FindEntity(value.x, value.z).gridData;
				LuaHelper.CallFunction("ChessBoardSelectMapPos", gridData3.x, gridData3.z);
			}
			else
			{
				ChessBoardGridData gridData4 = FindEntity(value.x, value.z).gridData;
				LuaHelper.CallFunction("ChessBoardCheckMapGrid", go.transform.position, gridData4.typeID);
			}
		}
	}

	public void PlayGridAnimation(int x, int z, string ani, int target, Action func = null)
	{
		ChessBoardHexEntity chessBoardHexEntity = FindEntity(x, z);
		int fullPathHash = -1;
		if (chessBoardHexEntity == null)
		{
			return;
		}
		switch (target)
		{
		case 1:
		{
			if (!(chessBoardHexEntity.go != null))
			{
				break;
			}
			Animator animator2 = ChessBoardHelper.GetGridAnimator(chessBoardHexEntity.go);
			if (animator2 != null)
			{
				animator2.Play(ani);
				int timer2 = 0;
				timer2 = FuncTimerManager.inst.CreateFuncTimer(delegate
				{
					if (animator2 == null)
					{
						FuncTimerManager.inst.RemoveFuncTimer(timer2);
					}
					else
					{
						AnimatorStateInfo currentAnimatorStateInfo = animator2.GetCurrentAnimatorStateInfo(0);
						if (fullPathHash == -1)
						{
							fullPathHash = currentAnimatorStateInfo.fullPathHash;
						}
						if (currentAnimatorStateInfo.normalizedTime > 0.96f || fullPathHash != currentAnimatorStateInfo.fullPathHash)
						{
							FuncTimerManager.inst.RemoveFuncTimer(timer2);
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
			break;
		}
		case 2:
		{
			if (!(chessBoardHexEntity.thingGo != null))
			{
				break;
			}
			Animator animator = ChessBoardHelper.GetGridAnimator(chessBoardHexEntity.thingGo);
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
			break;
		}
		}
	}

	public bool CheckHaveThingCanDestory()
	{
		bool ret = false;
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			int nodeInGridIndex = (node as GridNode).NodeInGridIndex;
			ChessBoardGridData gridData = mEnities[nodeInGridIndex].gridData;
			if (gridData.thingTypeID > 0)
			{
				ChessBoardThingConfig thingConfig = ChessBoardMapCfgManager.Instance.GetThingConfig(gridData.thingTypeID);
				if (gridData.thingTypeID > 0 && thingConfig.destoryable > 0)
				{
					ret = true;
				}
			}
		});
		return ret;
	}

	public void ShowAllThingChoiceEffect()
	{
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			int nodeInGridIndex = (node as GridNode).NodeInGridIndex;
			ChessBoardGridData gridData = mEnities[nodeInGridIndex].gridData;
			if (gridData.thingTypeID > 0)
			{
				ChessBoardThingConfig thingConfig = ChessBoardMapCfgManager.Instance.GetThingConfig(gridData.thingTypeID);
				if (gridData.thingTypeID > 0 && thingConfig.destoryable > 0)
				{
					ChessBoardEffectManager.Instance.ShowChoiceEffect(gridData.x, gridData.z);
				}
			}
		});
	}

	public void ShowAllNoThingGridChoiceEffect(int curX, int curZ)
	{
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			int nodeInGridIndex = (node as GridNode).NodeInGridIndex;
			ChessBoardGridData gridData = mEnities[nodeInGridIndex].gridData;
			if (curX != gridData.x || curZ != gridData.z)
			{
				ChessBoardGridConfig gridConfig = ChessBoardMapCfgManager.Instance.GetGridConfig(gridData.typeID, gridData.status);
				if (gridData.thingTypeID == 0 && gridConfig.walkable >= 1 && gridConfig.updatable == 0 && ChessBoardNPCManager.Instance.GetNPCIDByPos(new Vector3(gridData.x, 0f, gridData.z)) == -1)
				{
					ChessBoardEffectManager.Instance.ShowChoiceEffect(gridData.x, gridData.z);
				}
			}
		});
	}

	public void Shutdown()
	{
		gameObjectToCoordinate.Clear();
		astarPath.Shutdown();
		ChessBoardHexGridCoord.astarPath = null;
	}
}
