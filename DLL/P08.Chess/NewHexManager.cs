using System;
using System.Collections.Generic;
using NewChess;
using Pathfinding;
using UnityEngine;

public class NewHexManager
{
	public NewHexEntity[] mEnities;

	public int mWidth;

	public NewChessScene chessScene;

	public NewMapData mapData;

	public NewChessMapData chessMapData;

	private AstarPath astarPath;

	private GridGraph gridGraph;

	private Transform mapTrs;

	private Transform objectMapTrs;

	private Dictionary<GameObject, Vector3Int> gameObjectToCoordinate;

	private static NewHexManager sInstance;

	public static NewHexManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new NewHexManager();
			}
			return sInstance;
		}
	}

	public void Init()
	{
		gameObjectToCoordinate = new Dictionary<GameObject, Vector3Int>();
		astarPath = NewHexGridCoord.astarPath;
		gridGraph = astarPath.data.graphs[0] as GridGraph;
		int num = gridGraph.CountNodes();
		mWidth = gridGraph.Width;
		chessScene = NScene.GetCurrentScene() as NewChessScene;
		mapData = chessScene.mapData;
		chessMapData = mapData.chessMapData;
		GameObject gameObject = GameObject.Find("Map");
		if (gameObject == null)
		{
			gameObject = new GameObject("Map");
		}
		mapTrs = gameObject.transform;
		GameObject gameObject2 = GameObject.Find("ObjectMap");
		if (gameObject2 == null)
		{
			gameObject2 = new GameObject("ObjectMap");
		}
		objectMapTrs = gameObject2.transform;
		mEnities = new NewHexEntity[num];
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			GridNode gridNode = node as GridNode;
			int nodeInGridIndex = gridNode.NodeInGridIndex;
			mEnities[nodeInGridIndex] = new NewHexEntity();
			mEnities[nodeInGridIndex].mHexStatus = NewHexEntity.HexStatus.mRuning;
			mEnities[nodeInGridIndex].gridNode = gridNode;
			mEnities[nodeInGridIndex].gridData = mapData.GetGridData(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
			GenerateWithEntity(mEnities[nodeInGridIndex]);
			GenerateObjectWithEntity(mEnities[nodeInGridIndex]);
		});
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			GridNode node2 = node as GridNode;
			gridGraph.CalculateConnections((GridNodeBase)node2);
		});
	}

	public void ChangeGrid(int x, int z, NewGridData gridData, bool isInheritDir, bool isExtend = false, Action callBack = null)
	{
		NewHexEntity hexEntity = FindEntity(x, z);
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
			NewGridEventTrigger component = hexEntity.go.GetComponent<NewGridEventTrigger>();
			if (component != null)
			{
				component.onPointerClick = (Action<GameObject>)Delegate.Remove(component.onPointerClick, new Action<GameObject>(ClickNode));
			}
			NewChessHelper.PlayDisappearEffect(hexEntity.go, delegate
			{
				UnityEngine.Object.Destroy(hexEntity.go);
				gameObjectToCoordinate.Remove(hexEntity.go);
				if (hexEntity.ObjectGo != null)
				{
					gridData.objectPrefab = hexEntity.gridData.objectPrefab;
					gridData.objectTypeID = hexEntity.gridData.objectTypeID;
					gridData.objectRotationY = hexEntity.gridData.objectRotationY;
					gridData.objectEnterParamList = hexEntity.gridData.objectEnterParamList;
					gridData.objectClickParamList = hexEntity.gridData.objectClickParamList;
					gridData.objectExitParamList = hexEntity.gridData.objectExitParamList;
					gridData.objectFarClickParamList = hexEntity.gridData.objectFarClickParamList;
				}
				if (isInheritDir)
				{
					gridData.rotationY = hexEntity.gridData.rotationY;
				}
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
			if (hexEntity.ObjectGo != null)
			{
				gridData.objectPrefab = hexEntity.gridData.objectPrefab;
				gridData.objectTypeID = hexEntity.gridData.objectTypeID;
				gridData.objectRotationY = hexEntity.gridData.objectRotationY;
				gridData.objectEnterParamList = hexEntity.gridData.objectEnterParamList;
				gridData.objectClickParamList = hexEntity.gridData.objectClickParamList;
				gridData.objectExitParamList = hexEntity.gridData.objectExitParamList;
				gridData.objectFarClickParamList = hexEntity.gridData.objectFarClickParamList;
			}
			if (isInheritDir)
			{
				gridData.rotationY = hexEntity.gridData.rotationY;
			}
			hexEntity.gridData = gridData;
			GenerateWithEntity(hexEntity, isNeedAni: true, callBack);
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
	}

	public void ChangeObject(int x, int z, NewGridData gridData, bool isExtend = false, Action callBack = null)
	{
		NewHexEntity newHexEntity = FindEntity(x, z);
		if (newHexEntity == null)
		{
			return;
		}
		if (newHexEntity.ObjectGo != null)
		{
			UnityEngine.Object.DestroyImmediate(newHexEntity.ObjectGo);
			newHexEntity.gridData.objectTypeID = gridData.objectTypeID;
			newHexEntity.gridData.objectPrefab = gridData.objectPrefab;
			newHexEntity.gridData.objectRotationY = gridData.objectRotationY;
			newHexEntity.gridData.objectEnterParamList = gridData.objectEnterParamList;
			newHexEntity.gridData.objectClickParamList = gridData.objectClickParamList;
			newHexEntity.gridData.objectExitParamList = gridData.objectExitParamList;
			newHexEntity.gridData.objectFarClickParamList = gridData.objectFarClickParamList;
			GenerateObjectWithEntity(newHexEntity, isNeedAni: true, callBack);
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
		else
		{
			newHexEntity.gridData.objectTypeID = gridData.objectTypeID;
			newHexEntity.gridData.objectPrefab = gridData.objectPrefab;
			newHexEntity.gridData.objectRotationY = gridData.objectRotationY;
			newHexEntity.gridData.objectEnterParamList = gridData.objectEnterParamList;
			newHexEntity.gridData.objectClickParamList = gridData.objectClickParamList;
			newHexEntity.gridData.objectExitParamList = gridData.objectExitParamList;
			newHexEntity.gridData.objectFarClickParamList = gridData.objectFarClickParamList;
			GenerateObjectWithEntity(newHexEntity, isNeedAni: true, callBack);
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
	}

	public float ChangeGridStatus(int x, int z, int newStatus, Action func = null)
	{
		NewHexEntity newHexEntity = FindEntity(x, z);
		_ = newHexEntity.gridData.status;
		if (newHexEntity != null)
		{
			if (newHexEntity.go != null)
			{
				Animator animator = NewChessHelper.GetGridAnimator(newHexEntity.go);
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
			NewGridConfig gridConfig = NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity.gridData.typeID, newStatus);
			newHexEntity.gridData.status = newStatus;
			if (gridConfig != null)
			{
				FixHexEntityWalkable(newHexEntity);
				newHexEntity.gridNode.Penalty = gridConfig.penalty;
			}
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				gridGraph.CalculateConnections((GridNodeBase)node);
			});
		}
		return 0f;
	}

	public void PlayGridAnimation(int x, int z, string ani, int target, Action func = null)
	{
		NewHexEntity newHexEntity = FindEntity(x, z);
		int fullPathHash = -1;
		if (newHexEntity == null)
		{
			return;
		}
		switch (target)
		{
		case 1:
		{
			if (!(newHexEntity.go != null))
			{
				break;
			}
			Animator animator2 = NewChessHelper.GetGridAnimator(newHexEntity.go);
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
			if (!(newHexEntity.ObjectGo != null))
			{
				break;
			}
			Animator animator = NewChessHelper.GetGridAnimator(newHexEntity.ObjectGo);
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

	public void DeleteObject(int x, int z, Action callBack = null)
	{
		NewHexEntity newHexEntity = FindEntity(x, z);
		if (newHexEntity != null && newHexEntity.ObjectGo != null)
		{
			UnityEngine.Object.DestroyImmediate(newHexEntity.ObjectGo);
			newHexEntity.gridData.objectTypeID = 0;
			newHexEntity.gridData.objectPrefab = "";
			newHexEntity.gridData.objectRotationY = 0f;
			newHexEntity.gridData.objectEnterParamList = new int[0];
			newHexEntity.gridData.objectClickParamList = new int[0];
			newHexEntity.gridData.objectExitParamList = new int[0];
			newHexEntity.gridData.objectFarClickParamList = new int[0];
			_ = newHexEntity.gridNode;
			NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity.gridData.typeID, newHexEntity.gridData.status);
			FixHexEntityWalkable(newHexEntity);
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

	public NewHexEntity FindEntity(int index)
	{
		if (mEnities.Length > index && index >= 0)
		{
			return mEnities[index];
		}
		return null;
	}

	public NewHexEntity FindEntity(int x, int z)
	{
		int index = CoordToIndex(x, z);
		return FindEntity(index);
	}

	public void GenerateWithEntity(NewHexEntity hexEntity, bool isNeedAni = false, Action callBack = null)
	{
		GridNode gridNode = hexEntity.gridNode;
		short x = (short)gridNode.XCoordinateInGrid;
		short z = (short)gridNode.ZCoordinateInGrid;
		NewGridData gridData = hexEntity.gridData;
		NewGridConfig gridConfig = NewChessMapCfgManager.Instance.GetGridConfig(gridData.typeID, gridData.status);
		FixHexEntityWalkable(hexEntity);
		gridNode.Penalty = gridConfig.penalty;
		string path = ((gridConfig.isHide == 1) ? "NewWarChess/General/floor_runtime" : ((gridConfig.isHide != 2) ? gridData.prefab : "NewWarChess/General/empty_runtime"));
		GameObject gameObject = Asset.InstantiateWithoutCache(path);
		gameObject.transform.parent = mapTrs;
		gameObject.transform.position = (Vector3)gridNode.position;
		gameObject.transform.position = gameObject.transform.position.NewY(gridData.offsetY);
		gameObject.name = gridData.typeID + "_node(" + x + "," + z + ")";
		gameObject.transform.localEulerAngles = new Vector3(0f, gridData.rotationY, 0f);
		Transform transform = gameObject.transform.Find("collider");
		if (transform != null)
		{
			NewGridEventTrigger newGridEventTrigger = transform.GetComponent<NewGridEventTrigger>();
			if (newGridEventTrigger == null)
			{
				newGridEventTrigger = transform.gameObject.AddComponent<NewGridEventTrigger>();
			}
			NewGridEventTrigger newGridEventTrigger2 = newGridEventTrigger;
			newGridEventTrigger2.onPointerClick = (Action<GameObject>)Delegate.Combine(newGridEventTrigger2.onPointerClick, new Action<GameObject>(ClickNode));
			newGridEventTrigger.callBackGo = gameObject;
		}
		gameObjectToCoordinate.Add(gameObject, new Vector3Int(x, 0, z));
		hexEntity.go = gameObject;
		if (1 <= gridConfig.mapLayer && gridConfig.mapLayer <= 3)
		{
			hexEntity.hight = NewChessHelper.m_layHeight * (float)(gridConfig.mapLayer - 1);
		}
		if (gridData.status != 0)
		{
			Animator gridAnimator = NewChessHelper.GetGridAnimator(gameObject);
			if (gridAnimator != null)
			{
				gridAnimator.Play("status_" + gridData.status);
			}
		}
		NewChessScene newChessScene = NScene.GetCurrentScene() as NewChessScene;
		if ((bool)newChessScene.hexGridCoord.mRole)
		{
			NewHexAnimator mRole = newChessScene.hexGridCoord.mRole;
			if (gridData.x == mRole.GridPosition.x && gridData.z == mRole.GridPosition.z)
			{
				mRole.FixPosition(hexEntity.rendererPosition);
				NewHexFogManager.Instance.WalkOpenFog(gridData.x, gridData.z);
			}
		}
		if (isNeedAni)
		{
			NewChessHelper.PlayAppearEffect(gameObject, callBack);
		}
		else
		{
			callBack?.Invoke();
		}
	}

	public void GenerateObjectWithEntity(NewHexEntity hexEntity, bool isNeedAni = false, Action callBack = null)
	{
		GridNode gridNode = hexEntity.gridNode;
		short num = (short)gridNode.XCoordinateInGrid;
		short num2 = (short)gridNode.ZCoordinateInGrid;
		NewGridData gridData = hexEntity.gridData;
		if (gridData.objectPrefab != "")
		{
			GameObject gameObject = Asset.InstantiateWithoutCache(gridData.objectPrefab);
			gameObject.transform.parent = objectMapTrs;
			gameObject.transform.position = hexEntity.rendererPosition;
			gameObject.name = gridData.objectTypeID + "_node(" + num + "," + num2 + ")";
			gameObject.transform.localEulerAngles = new Vector3(0f, gridData.objectRotationY, 0f);
			hexEntity.ObjectGo = gameObject;
			FixHexEntityWalkable(hexEntity);
			if (isNeedAni)
			{
				NewChessHelper.PlayAppearEffect(gameObject, callBack);
			}
			else
			{
				callBack?.Invoke();
			}
		}
	}

	public void FixHexEntityWalkable(NewHexEntity entity)
	{
		if (entity.ObjectGo != null)
		{
			if (NewChessMapCfgManager.Instance.GetThingConfig(entity.gridData.objectTypeID).walkable >= 1 && NewChessMapCfgManager.Instance.GetGridConfig(entity.gridData.typeID, entity.gridData.status).walkable >= 1)
			{
				entity.gridNode.Walkable = true;
			}
			else
			{
				entity.gridNode.Walkable = false;
			}
		}
		else
		{
			entity.gridNode.Walkable = NewChessMapCfgManager.Instance.GetGridConfig(entity.gridData.typeID, entity.gridData.status).walkable >= 1;
		}
	}

	public void ClickNode(GameObject go)
	{
		Debug.Log(go.name);
		Vector3 vector = Camera.main.WorldToScreenPoint(go.transform.position);
		if (!gameObjectToCoordinate.TryGetValue(go, out var value) || !NewHexFogManager.Instance.GetIsOpenFog(value.x, value.z))
		{
			return;
		}
		NewChessScene newChessScene = NScene.GetCurrentScene() as NewChessScene;
		NewHexAnimator mRole = newChessScene.hexGridCoord.mRole;
		NewHexEntity newHexEntity = FindEntity(value.x, value.z);
		NewGridData gridData = newHexEntity.gridData;
		NewGridConfig gridConfig = NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity.gridData.typeID, newHexEntity.gridData.status);
		NewGridData[] array = null;
		if (value.x == mRole.GridPosition.x && value.z == mRole.GridPosition.z)
		{
			LuaHelper.CallFunction("NewChessGridClick", gridData, array, vector, false, true);
			return;
		}
		bool flag = false;
		if (!newHexEntity.gridNode.Walkable)
		{
			if (newHexEntity.ObjectGo != null)
			{
				newHexEntity.gridNode.Walkable = true;
				gridGraph.GetNodes(delegate(GraphNode node)
				{
					gridGraph.CalculateConnections((GridNodeBase)node);
				});
				flag = true;
			}
			else if (gridConfig.walkable <= 0 && gridConfig.mapLayer == 1)
			{
				newHexEntity.gridNode.Walkable = true;
				gridGraph.GetNodes(delegate(GraphNode node)
				{
					gridGraph.CalculateConnections((GridNodeBase)node);
				});
				flag = true;
			}
		}
		FindABPathResult findABPathResult = newChessScene.hexGridCoord.FindPath(value.x, value.z, flag, isCache: true);
		if (flag)
		{
			if (newHexEntity.ObjectGo != null)
			{
				newHexEntity.gridNode.Walkable = false;
				gridGraph.GetNodes(delegate(GraphNode node)
				{
					gridGraph.CalculateConnections((GridNodeBase)node);
				});
			}
			else
			{
				newHexEntity.gridNode.Walkable = gridConfig.walkable >= 1;
				gridGraph.GetNodes(delegate(GraphNode node)
				{
					gridGraph.CalculateConnections((GridNodeBase)node);
				});
			}
		}
		ABPath abPath = findABPathResult.abPath;
		if (gridData.objectPrefab != "" && gridData.objectFarClickParamList.Length != 0)
		{
			if (!newHexEntity.gridNode.Walkable && (abPath.error || abPath.path.Count > 1))
			{
				LuaHelper.CallFunction("NewChessGridFarClick", gridData, vector);
				return;
			}
			if (newHexEntity.gridNode.Walkable && (abPath.error || abPath.path.Count > 2))
			{
				LuaHelper.CallFunction("NewChessGridFarClick", gridData, vector);
				return;
			}
		}
		if (findABPathResult == null)
		{
			return;
		}
		if (!abPath.error && findABPathResult.isInRange)
		{
			array = new NewGridData[abPath.path.Count];
			for (int num = 0; num < abPath.path.Count; num++)
			{
				GridNode gridNode = abPath.path[num] as GridNode;
				array[num] = FindEntity(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid).gridData;
			}
		}
		Debug.Log("aBPath.error : " + abPath.error + "   abPathResult : " + findABPathResult.isInRange);
		if (array != null)
		{
			Debug.Log("gridList.Length : " + array.Length);
		}
		if (findABPathResult.isInRange)
		{
			LuaHelper.CallFunction("NewChessGridClick", gridData, array, vector, abPath.error, false);
		}
		else
		{
			LuaHelper.CallFunction("NewChessGridClick", gridData, array, vector, true, false);
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
		NewHexGridCoord.astarPath = null;
	}
}
