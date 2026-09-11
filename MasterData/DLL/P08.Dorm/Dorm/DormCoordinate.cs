using System;
using System.Collections.Generic;
using Dorm.Furniture;
using Pathfinding;
using UnityEngine;

namespace Dorm;

public class DormCoordinate
{
	private static DormCoordinate sInstance;

	private TileCoordinate<TileEntity> frontWallCoordinate;

	private TileCoordinate<TileEntity> behindWallCoordinate;

	private TileCoordinate<TileEntity> leftWallCoordinate;

	private TileCoordinate<TileEntity> rightWallCoordinate;

	private TileCoordinate<FloorEntity> floorCoordinate;

	public TileEntity[,,] enitieS;

	public Vector3 originalPoint;

	public Vector3Int totalSize;

	public List<RoomWallTag> roomWallTagS;

	public RoomWallTag floorRoomWallTag;

	[NonSerialized]
	private List<GameObject> obstacleWallS;

	public AstarPath astarPath;

	private GridGraph gridGraph;

	private byte[] mBinMap;

	private Dictionary<GridNode, List<Int2>> gridNodeToTileMap;

	public static DormCoordinate Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new DormCoordinate();
			}
			return sInstance;
		}
	}

	public static void Cleanup()
	{
		sInstance = null;
	}

	public void Init()
	{
		frontWallCoordinate = new TileCoordinate<TileEntity>(0.25f);
		behindWallCoordinate = new TileCoordinate<TileEntity>(0.25f);
		leftWallCoordinate = new TileCoordinate<TileEntity>(0.25f);
		rightWallCoordinate = new TileCoordinate<TileEntity>(0.25f);
		floorCoordinate = new TileCoordinate<FloorEntity>(0.25f);
		roomWallTagS = new List<RoomWallTag>();
		if (obstacleWallS == null)
		{
			obstacleWallS = new List<GameObject>();
		}
		else
		{
			foreach (GameObject obstacleWall in obstacleWallS)
			{
				if ((bool)obstacleWall)
				{
					UnityEngine.Object.Destroy(obstacleWall);
				}
			}
			obstacleWallS.Clear();
		}
		FurnitureManager.OnFillFurnitureOccupy = FillFurnitureOccupy;
		FurnitureManager.OnRemoveFurnitureOccupy = RemoveFurnitureOccupy;
	}

	private void FillFurnitureOccupy(FurnitureEntity furniture)
	{
		FillFurnitureOccupyWorldSpace(furniture.TileType, furniture.width, furniture.height, furniture.trs.position, furniture.trs.rotation, furniture.depth);
	}

	private void RemoveFurnitureOccupy(FurnitureEntity furniture)
	{
		RemoveFurnitureOccupyWorldSpace(furniture.TileType, furniture.width, furniture.height, furniture.trs.position, furniture.trs.rotation, furniture.depth);
	}

	internal IEnumerable<Collider> EnumerateObstacleColliders()
	{
		foreach (GameObject obstacleWall in obstacleWallS)
		{
			yield return obstacleWall.GetComponent<Collider>();
		}
	}

	public void RefreshCoordinate()
	{
		roomWallTagS.Clear();
		GameObject[] array = GameObject.FindGameObjectsWithTag("ground");
		for (int i = 0; i < array.Length; i++)
		{
			RoomWallTag component = array[i].GetComponent<RoomWallTag>();
			if (!(component != null) || component.width <= 0)
			{
				continue;
			}
			TileCoordinate<TileEntity> titleCoordinateWallWithType = GetTitleCoordinateWallWithType(component.tileType);
			if (titleCoordinateWallWithType != null)
			{
				titleCoordinateWallWithType.Init(component.originalPoint, component.width, component.height, component.tileType);
				roomWallTagS.Add(component);
				BoxCollider component2 = component.GetComponent<BoxCollider>();
				if ((bool)component2)
				{
					GameObject gameObject = new GameObject("obstacle wall");
					BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
					obstacleWallS.Add(gameObject);
					gameObject.layer = DormConst.OBSTACLE_LAYER_ID;
					gameObject.transform.position = component.transform.position;
					gameObject.transform.rotation = component.transform.rotation;
					boxCollider.center = component2.center + new Vector3(0f, 0f, -0.251f);
					boxCollider.size = component2.size + new Vector3(1f, 0f, 0.5f);
				}
			}
			else if (component.tileType == TileType.FLOOR)
			{
				floorRoomWallTag = component;
				floorCoordinate.Init(component.originalPoint, component.width, component.height, component.tileType);
				GenerateTotalCoordinate(component.width, component.height, component.depth, component.originalPoint);
			}
		}
	}

	private void GenerateTotalCoordinate(int width, int height, int depth, Vector3 originalPoint)
	{
		this.originalPoint = originalPoint;
		enitieS = new TileEntity[width, height, depth];
		totalSize = new Vector3Int(width, height, depth);
		for (short num = 0; num < depth; num++)
		{
			for (short num2 = 0; num2 < height; num2++)
			{
				for (short num3 = 0; num3 < width; num3++)
				{
					enitieS[num3, num2, num] = new TileEntity();
					enitieS[num3, num2, num].coordinateX = num3;
					enitieS[num3, num2, num].coordinateY = num2;
					enitieS[num3, num2, num].coordinateZ = num;
				}
			}
		}
	}

	public RoomWallTag GetAvailableWall()
	{
		RoomWallTag roomWallTag = null;
		for (int i = 0; i < roomWallTagS.Count; i++)
		{
			if (roomWallTagS[i].isShow && (roomWallTag == null || roomWallTagS[i].currentDot < roomWallTag.currentDot))
			{
				roomWallTag = roomWallTagS[i];
			}
		}
		return roomWallTag;
	}

	public RoomWallTag GetRoomWallTagByType(TileType tileType)
	{
		RoomWallTag result = null;
		for (int i = 0; i < roomWallTagS.Count; i++)
		{
			if (roomWallTagS[i].tileType == tileType)
			{
				result = roomWallTagS[i];
				break;
			}
		}
		return result;
	}

	public void ClearAllOccupy()
	{
		frontWallCoordinate.ClearCoordinateOccypy();
		behindWallCoordinate.ClearCoordinateOccypy();
		leftWallCoordinate.ClearCoordinateOccypy();
		rightWallCoordinate.ClearCoordinateOccypy();
		floorCoordinate.ClearCoordinateOccypy();
	}

	public TileCoordinate<TileEntity> GetTitleCoordinateWallWithType(TileType titleType)
	{
		return titleType switch
		{
			TileType.WALL_FRONT => frontWallCoordinate, 
			TileType.WALL_BEHIND => behindWallCoordinate, 
			TileType.WALL_LEFT => leftWallCoordinate, 
			TileType.WALL_RIGHT => rightWallCoordinate, 
			_ => null, 
		};
	}

	public TileCoordinate<FloorEntity> GetTitleCoordinateFloor()
	{
		return floorCoordinate;
	}

	public bool GetIsAvailable(TileType tileType, Vector3 position, int width, int height, float rotation, int depth = 0)
	{
		if (tileType == TileType.FLOOR)
		{
			if (depth == 0)
			{
				return floorCoordinate.GetIsAvailable(position, width, height, rotation);
			}
			return GetTotalCoordinateIsAvailable(tileType, position, width, height, rotation, depth);
		}
		if (GetTitleCoordinateWallWithType(tileType).GetIsAvailable(position, width, height, rotation))
		{
			return GetTotalCoordinateIsAvailable(tileType, position, width, height, rotation, depth);
		}
		return false;
	}

	public bool GetTotalCoordinateIsAvailable(TileType tileType, Vector3 position, int width, int height, float rotation, int depth = 0)
	{
		bool isHaveOutSide = false;
		if (tileType == TileType.FLOOR)
		{
			List<Vector2Int> hitEntityIndexS = floorCoordinate.GetHitEntityIndexS(position, width, height, rotation, out isHaveOutSide);
			for (int i = 0; i < hitEntityIndexS.Count; i++)
			{
				for (int j = GetStartDepthIndex(tileType, position); j < depth; j++)
				{
					TileEntity totalCoordinateTileEntityByType = GetTotalCoordinateTileEntityByType(tileType, hitEntityIndexS[i], j);
					if (totalCoordinateTileEntityByType != null && totalCoordinateTileEntityByType.isOccupy)
					{
						return false;
					}
				}
			}
		}
		else
		{
			List<Vector2Int> hitEntityIndexS2 = GetTitleCoordinateWallWithType(tileType).GetHitEntityIndexS(position, width, height, rotation, out isHaveOutSide);
			switch (tileType)
			{
			case TileType.WALL_BEHIND:
			case TileType.WALL_LEFT:
			{
				for (int l = 0; l < hitEntityIndexS2.Count; l++)
				{
					for (int m = GetStartDepthIndex(tileType, position); m < depth; m++)
					{
						TileEntity totalCoordinateTileEntityByType3 = GetTotalCoordinateTileEntityByType(tileType, hitEntityIndexS2[l], m);
						if (totalCoordinateTileEntityByType3 != null && totalCoordinateTileEntityByType3.isOccupy)
						{
							return false;
						}
					}
				}
				break;
			}
			case TileType.WALL_FRONT:
			case TileType.WALL_RIGHT:
			{
				for (int k = 0; k < hitEntityIndexS2.Count; k++)
				{
					int startDepthIndex = GetStartDepthIndex(tileType, position);
					int num = startDepthIndex - depth;
					for (int num2 = startDepthIndex; num2 > num; num2--)
					{
						TileEntity totalCoordinateTileEntityByType2 = GetTotalCoordinateTileEntityByType(tileType, hitEntityIndexS2[k], num2);
						if (totalCoordinateTileEntityByType2 != null && totalCoordinateTileEntityByType2.isOccupy)
						{
							return false;
						}
					}
				}
				break;
			}
			}
		}
		if (isHaveOutSide)
		{
			return false;
		}
		return true;
	}

	public void SetTotalCoordinateIsOccupy(TileType tileType, Vector3 position, List<Vector2Int> hitEntityS, int depth = 0, bool isOccupy = true)
	{
		switch (tileType)
		{
		case TileType.FLOOR:
		{
			for (int j = 0; j < hitEntityS.Count; j++)
			{
				for (int k = GetStartDepthIndex(tileType, position); k < depth; k++)
				{
					TileEntity tileEntity2 = enitieS[hitEntityS[j].x, hitEntityS[j].y, k];
					if (tileEntity2 != null)
					{
						tileEntity2.isOccupy = isOccupy;
					}
				}
			}
			break;
		}
		case TileType.WALL_LEFT:
		{
			for (int n = 0; n < hitEntityS.Count; n++)
			{
				for (int num3 = GetStartDepthIndex(tileType, position); num3 < depth; num3++)
				{
					TileEntity tileEntity4 = enitieS[num3, hitEntityS[n].x, hitEntityS[n].y];
					if (tileEntity4 != null)
					{
						tileEntity4.isOccupy = isOccupy;
					}
				}
			}
			break;
		}
		case TileType.WALL_RIGHT:
		{
			for (int num4 = 0; num4 < hitEntityS.Count; num4++)
			{
				int startDepthIndex2 = GetStartDepthIndex(tileType, position);
				int num5 = startDepthIndex2 - depth;
				for (int num6 = startDepthIndex2; num6 > num5; num6--)
				{
					TileEntity tileEntity5 = enitieS[num6, hitEntityS[num4].x, hitEntityS[num4].y];
					if (tileEntity5 != null)
					{
						tileEntity5.isOccupy = isOccupy;
					}
				}
			}
			break;
		}
		case TileType.WALL_BEHIND:
		{
			for (int l = 0; l < hitEntityS.Count; l++)
			{
				for (int m = GetStartDepthIndex(tileType, position); m < depth; m++)
				{
					TileEntity tileEntity3 = enitieS[hitEntityS[l].x, m, hitEntityS[l].y];
					if (tileEntity3 != null)
					{
						tileEntity3.isOccupy = isOccupy;
					}
				}
			}
			break;
		}
		case TileType.WALL_FRONT:
		{
			for (int i = 0; i < hitEntityS.Count; i++)
			{
				int startDepthIndex = GetStartDepthIndex(tileType, position);
				int num = startDepthIndex - depth;
				for (int num2 = startDepthIndex; num2 > num; num2--)
				{
					TileEntity tileEntity = enitieS[hitEntityS[i].x, num2, hitEntityS[i].y];
					if (tileEntity != null)
					{
						tileEntity.isOccupy = isOccupy;
					}
				}
			}
			break;
		}
		}
	}

	public TileEntity GetTotalCoordinateTileEntityByType(TileType tileType, Vector2Int hitIndex, int jIndex)
	{
		switch (tileType)
		{
		case TileType.FLOOR:
			return enitieS[hitIndex.x, hitIndex.y, jIndex];
		case TileType.WALL_FRONT:
		case TileType.WALL_BEHIND:
			return enitieS[hitIndex.x, jIndex, hitIndex.y];
		case TileType.WALL_LEFT:
		case TileType.WALL_RIGHT:
			return enitieS[jIndex, hitIndex.x, hitIndex.y];
		default:
			return null;
		}
	}

	public int GetStartDepthIndex(TileType tileType, Vector3 position)
	{
		Vector3 vector = position - originalPoint;
		switch (tileType)
		{
		case TileType.FLOOR:
		case TileType.CEIL:
			return Mathf.FloorToInt((vector.y + 0.01f) / 0.25f);
		case TileType.WALL_FRONT:
			return Mathf.FloorToInt((vector.z - 0.01f) / 0.25f);
		case TileType.WALL_BEHIND:
			return Mathf.FloorToInt((vector.z + 0.01f) / 0.25f);
		case TileType.WALL_LEFT:
			return Mathf.FloorToInt((vector.x + 0.01f) / 0.25f);
		case TileType.WALL_RIGHT:
			return Mathf.FloorToInt((vector.x - 0.01f) / 0.25f);
		default:
			return 0;
		}
	}

	public void RemoveFurnitureOccupyWorldSpace(TileType tileType, int w, int h, Vector3 worldPos, Quaternion worldRot, int depth = 0)
	{
		if (tileType == TileType.FLOOR)
		{
			List<Vector2Int> hitEntityS = floorCoordinate.RemoveRectOccupy(worldPos, w, h, worldRot.eulerAngles.y - floorRoomWallTag.transform.rotation.eulerAngles.y);
			SetTotalCoordinateIsOccupy(tileType, worldPos, hitEntityS, depth, isOccupy: false);
			if (gridGraph != null)
			{
				gridGraph.GetNodes(delegate(GraphNode node)
				{
					gridGraph.CalculateConnections((GridNodeBase)node);
				});
			}
		}
		else
		{
			TileCoordinate<TileEntity> titleCoordinateWallWithType = GetTitleCoordinateWallWithType(tileType);
			GetRoomWallTagByType(tileType);
			List<Vector2Int> hitEntityS2 = titleCoordinateWallWithType.RemoveRectOccupy(worldPos, w, h, titleCoordinateWallWithType.GetRotationAngle(worldRot.eulerAngles - floorRoomWallTag.transform.rotation.eulerAngles));
			SetTotalCoordinateIsOccupy(tileType, worldPos, hitEntityS2, depth, isOccupy: false);
		}
	}

	public void FillFurnitureOccupyWorldSpace(TileType tileType, int w, int h, Vector3 worldPos, Quaternion worldRot, int depth = 0)
	{
		if (tileType == TileType.FLOOR)
		{
			if (depth == 0)
			{
				floorCoordinate.FillRectOccupy(worldPos, w, h, worldRot.eulerAngles.y - floorRoomWallTag.transform.rotation.eulerAngles.y);
			}
			else
			{
				bool isHaveOutSide = false;
				List<Vector2Int> hitEntityIndexS = floorCoordinate.GetHitEntityIndexS(worldPos, w, h, worldRot.eulerAngles.y - floorRoomWallTag.transform.rotation.eulerAngles.y, out isHaveOutSide);
				SetTotalCoordinateIsOccupy(tileType, worldPos, hitEntityIndexS, depth);
			}
			if (gridGraph != null)
			{
				gridGraph.GetNodes(delegate(GraphNode node)
				{
					gridGraph.CalculateConnections((GridNodeBase)node);
				});
			}
		}
		else
		{
			TileCoordinate<TileEntity> titleCoordinateWallWithType = GetTitleCoordinateWallWithType(tileType);
			GetRoomWallTagByType(tileType);
			List<Vector2Int> hitEntityS = titleCoordinateWallWithType.FillRectOccupy(worldPos, w, h, titleCoordinateWallWithType.GetRotationAngle(worldRot.eulerAngles - floorRoomWallTag.transform.rotation.eulerAngles));
			SetTotalCoordinateIsOccupy(tileType, worldPos, hitEntityS, depth);
		}
	}

	public Vector3 FindNearestPosition(TileType titleType, Vector3 pos, bool isLimit = false, bool wallMountLayOnGround = false, int width = 0, int height = 0, bool snapByCeilToInt = false)
	{
		if (titleType == TileType.FLOOR)
		{
			return floorCoordinate.FindNearestPosition(pos, isLimit, wallMountLayOnGround: false, width, height, snapByCeilToInt);
		}
		return GetTitleCoordinateWallWithType(titleType).FindNearestPosition(pos, isLimit, wallMountLayOnGround, width, height, snapByCeilToInt);
	}

	public Vector2 GetPositionByType(TileType titleType, Vector3 pos)
	{
		if (titleType == TileType.FLOOR)
		{
			return floorCoordinate.Position2Coordinate(pos);
		}
		return GetTitleCoordinateWallWithType(titleType).Position2Coordinate(pos);
	}

	public float GetRotationByType(TileType titleType, Vector3 rotation)
	{
		if (titleType == TileType.FLOOR)
		{
			return floorCoordinate.GetRotationAngle(rotation);
		}
		return GetTitleCoordinateWallWithType(titleType).GetRotationAngle(rotation);
	}

	public Vector3 GetRotationAxisByType(TileType tileType)
	{
		if (tileType == TileType.FLOOR)
		{
			return floorCoordinate.GetRotationAxis();
		}
		return GetTitleCoordinateWallWithType(tileType).GetRotationAxis();
	}

	public Vector3 GetRealPositionByType(TileType titleType, Vector2 pos)
	{
		if (titleType == TileType.FLOOR)
		{
			return floorCoordinate.Coordinate2Position(pos);
		}
		return GetTitleCoordinateWallWithType(titleType).Coordinate2Position(pos);
	}

	public Vector2 GetRealRotationByType(TileType titleType, float rotation)
	{
		if (titleType == TileType.FLOOR)
		{
			return floorCoordinate.GetRealRotation(rotation);
		}
		return GetTitleCoordinateWallWithType(titleType).GetRealRotation(rotation);
	}

	public void BuildAStarPathCoordinate(int mapID)
	{
		TextAsset textAsset = Asset.Load<TextAsset>("Map/Dorm/" + mapID + "_graph.bytes");
		if (textAsset == null)
		{
			return;
		}
		if (astarPath == null)
		{
			astarPath = new AstarPath(null);
		}
		if (gridNodeToTileMap == null)
		{
			gridNodeToTileMap = new Dictionary<GridNode, List<Int2>>();
		}
		astarPath.scanOnStartup = true;
		mBinMap = textAsset.bytes;
		astarPath.LoadAstartData(ref mBinMap);
		gridGraph = astarPath.data.graphs[0] as GridGraph;
		gridGraph.UpdateTransform();
		gridNodeToTileMap.Clear();
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			GridNode gridNode = node as GridNode;
			List<Int2> groupS = floorCoordinate.GetGroupS(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid, 10);
			gridNodeToTileMap.Add(gridNode, groupS);
			for (int i = 0; i < groupS.Count; i++)
			{
				floorCoordinate.FindEntity(groupS[i].x, groupS[i].y).gridNode = gridNode;
			}
		});
	}

	public void RefreshAstarPathConnections()
	{
		if (gridGraph != null)
		{
			gridGraph.GetNodes(delegate(GraphNode node)
			{
				GridNode node2 = node as GridNode;
				gridGraph.CalculateConnections((GridNodeBase)node2);
			});
		}
	}

	public void RefreshAstarPathNodeWalkable(GridNode gridNode)
	{
		if (!gridNodeToTileMap.TryGetValue(gridNode, out var value))
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < value.Count; i++)
		{
			if (floorCoordinate.FindEntity(value[i].x, value[i].y).isOccupy)
			{
				num++;
			}
		}
		float num2 = (float)num / 100f;
		gridNode.Walkable = !(num2 > 0.25f);
	}

	public ABPath FindPath(Transform role, GraphNode node)
	{
		ABPath aBPath = ABPath.Construct(astarPath.GetNearest((Int3)role.transform.position).node.position, node.position);
		aBPath.Claim(this);
		AstarPath.StartPath(aBPath);
		AstarPath.BlockUntilCalculated(aBPath);
		return aBPath;
	}

	public ABPath FindPath(Transform role, int x, int z)
	{
		NNInfo nearest = astarPath.GetNearest((Int3)role.transform.position);
		ABPath obj = ABPath.Construct(end: (gridGraph.GetNode(x, z) as GridNode).position, start: nearest.node.position);
		obj.Claim(this);
		AstarPath.StartPath(obj);
		AstarPath.BlockUntilCalculated(obj);
		return obj;
	}

	public ABPath FindPath(Vector3 startPos, Vector3 endPos)
	{
		NNInfo nearest = astarPath.GetNearest((Int3)startPos);
		NNInfo nearest2 = astarPath.GetNearest((Int3)endPos);
		ABPath aBPath = ABPath.Construct(nearest.node.position, nearest2.position);
		aBPath.heuristic = Heuristic.Manhattan;
		aBPath.Claim(this);
		AstarPath.StartPath(aBPath, pushToFront: true);
		AstarPath.BlockUntilCalculated(aBPath);
		return aBPath;
	}

	public GraphNode GetRandomWalkEnableNode()
	{
		List<GraphNode> nodes = new List<GraphNode>();
		gridGraph.GetNodes(delegate(GraphNode node)
		{
			if (node.Walkable)
			{
				nodes.Add(node);
			}
		});
		int index = UnityEngine.Random.Range(0, nodes.Count - 1);
		return nodes[index];
	}
}
