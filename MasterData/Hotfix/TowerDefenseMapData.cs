using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Tower Defense Map Data", menuName = "游戏/关卡/塔防地图数据")]
public class TowerDefenseMapData : ScriptableObject
{
	[Serializable]
	public struct RouteGridInfo
	{
		public int gridID;

		public RouteAction action;

		[ReadOnly]
		public List<int> path2Grid;

		public static RouteGridInfo Null => new RouteGridInfo
		{
			gridID = -1
		};

		public bool IsNull => gridID == -1;

		public int GetNextGridIndex(int curGridID)
		{
			if (path2Grid == null || path2Grid.Count == 0)
			{
				return -1;
			}
			for (int i = 0; i < path2Grid.Count - 1; i++)
			{
				if (path2Grid.get_Item(i) == curGridID)
				{
					return path2Grid.get_Item(i + 1);
				}
			}
			return -1;
		}

		public bool ContainsGrid(int gridIndex)
		{
			if (path2Grid == null || path2Grid.Count == 0)
			{
				return false;
			}
			for (int i = 0; i < path2Grid.Count - 1; i++)
			{
				if (path2Grid.get_Item(i) == gridIndex)
				{
					return true;
				}
			}
			return false;
		}

		public bool Reachable()
		{
			if (path2Grid != null)
			{
				return path2Grid.Count > 0;
			}
			return false;
		}
	}

	[Serializable]
	public struct TowerDefenseRoute
	{
		public int id;

		[SerializeField]
		public List<RouteGridInfo> routePoints;

		public static TowerDefenseRoute Null => new TowerDefenseRoute
		{
			id = -1
		};

		public bool IsNUll => id == -1;

		public int GetNextGridIndex(int curGridID, int reachedPointIndex, out int curReachedPointIndex)
		{
			curReachedPointIndex = reachedPointIndex;
			if (routePoints == null)
			{
				return -1;
			}
			for (int i = reachedPointIndex; i < routePoints.Count; i++)
			{
				int nextGridIndex = routePoints.get_Item(i).GetNextGridIndex(curGridID);
				if (nextGridIndex != -1)
				{
					curReachedPointIndex = i;
					return nextGridIndex;
				}
			}
			return -1;
		}

		public int GetReachedPointIndex(int gridID, int reachedPointIndex)
		{
			if (routePoints == null)
			{
				return -1;
			}
			for (int i = reachedPointIndex; i < routePoints.Count; i++)
			{
				if (routePoints.get_Item(i).ContainsGrid(gridID))
				{
					return i;
				}
			}
			return -1;
		}

		public bool Reachable2End()
		{
			if (routePoints == null)
			{
				return false;
			}
			for (int i = 1; i < routePoints.Count; i++)
			{
				if (!routePoints.get_Item(i).Reachable())
				{
					return false;
				}
			}
			return true;
		}
	}

	[Serializable]
	public struct RouteAction
	{
		public int action;

		public string param;

		public static RouteAction Null => new RouteAction
		{
			action = -1
		};

		public bool IsNull => action == -1;
	}

	[Serializable]
	public struct TowerGrid
	{
		public int gridWalkableType;

		public int gridDeployType;

		public int gridAttribute;

		public int x;

		public int y;

		public int index;

		[HideInInspector]
		public Vector2 position;

		[HideInInspector]
		public float left;

		[HideInInspector]
		public float right;

		[HideInInspector]
		public float up;

		[HideInInspector]
		public float down;

		public static TowerGrid Null => new TowerGrid
		{
			index = -1
		};

		public bool IsNull => index == -1;

		public void SetPosition(int sizeX, int sizeY, Vector2 scale, Vector2 center)
		{
			float num = (float)sizeX * 0.5f;
			float num2 = (float)sizeY * 0.5f;
			Vector2 vector = scale * 0.5f;
			float num3 = ((float)x - num) * scale.x + center.x + vector.x;
			float num4 = ((float)y - num2) * scale.y + center.y + vector.y;
			position = new Vector2(num3, num4);
			left = num3 - vector.x;
			right = num3 + vector.x;
			up = num4 + vector.y;
			down = num4 - vector.y;
		}

		public bool IsPointInGrid(Vector2 p)
		{
			if (p.x >= left && p.x <= right && p.y <= up)
			{
				return p.y >= down;
			}
			return false;
		}
	}

	public Vector2 gridScale = new Vector2(3f, 3f);

	public Vector3 center = Vector3.zero;

	public int sizeX;

	public int sizeY;

	[ReadOnly]
	[SerializeField]
	public List<TowerGrid> towerGrids = new List<TowerGrid>();

	[ReadOnly]
	public List<TowerDefenseRoute> routes = new List<TowerDefenseRoute>();

	private TowerDefensePathFinding pathFinder;

	public TowerGrid GetGrid(int id)
	{
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerGrid result = towerGrids.get_Item(i);
			if (result.index == id)
			{
				return result;
			}
		}
		return TowerGrid.Null;
	}

	public TowerGrid GetGrid(int x, int y)
	{
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerGrid result = towerGrids.get_Item(i);
			if (result.x == x && result.y == y)
			{
				return result;
			}
		}
		return TowerGrid.Null;
	}

	public TowerGrid GetGrid(Vector3 worldPosition)
	{
		Vector2 p = new Vector2(worldPosition.x, worldPosition.z);
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerGrid result = towerGrids.get_Item(i);
			if (result.IsPointInGrid(p))
			{
				return result;
			}
		}
		return TowerGrid.Null;
	}

	public TowerDefenseRoute GetRoute(int routeID)
	{
		if (routes == null)
		{
			return TowerDefenseRoute.Null;
		}
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseRoute result = routes.get_Item(i);
			if (result.id == routeID)
			{
				return result;
			}
		}
		return TowerDefenseRoute.Null;
	}

	public RouteAction GetRouteAction(int routeID, int gridID)
	{
		if (routes == null)
		{
			return RouteAction.Null;
		}
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			if (towerDefenseRoute.id != routeID)
			{
				continue;
			}
			List<RouteGridInfo> routePoints = towerDefenseRoute.routePoints;
			if (routePoints == null || routePoints.Count == 0)
			{
				return RouteAction.Null;
			}
			for (int j = 0; j < routePoints.Count; j++)
			{
				RouteGridInfo routeGridInfo = routePoints.get_Item(j);
				if (routeGridInfo.gridID == gridID)
				{
					return routeGridInfo.action;
				}
			}
		}
		return RouteAction.Null;
	}

	public RouteAction GetRouteAction(int routeID, int gridID, int reachedPointIndex)
	{
		if (routes == null)
		{
			return RouteAction.Null;
		}
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			if (towerDefenseRoute.id != routeID)
			{
				continue;
			}
			List<RouteGridInfo> routePoints = towerDefenseRoute.routePoints;
			if (routePoints == null || routePoints.Count == 0)
			{
				return RouteAction.Null;
			}
			for (int j = reachedPointIndex; j < routePoints.Count; j++)
			{
				RouteGridInfo routeGridInfo = routePoints.get_Item(j);
				if (routeGridInfo.gridID == gridID)
				{
					return routeGridInfo.action;
				}
			}
		}
		return RouteAction.Null;
	}

	public void InitPathFinding()
	{
		pathFinder = new TowerDefensePathFinding(sizeX, sizeY);
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerGrid towerGrid = towerGrids.get_Item(i);
			if (towerGrid.gridWalkableType == 0)
			{
				SetObstacle(towerGrid.x, towerGrid.y);
				continue;
			}
			SetObstacle(towerGrid.x, towerGrid.y, isObstacle: false);
			SetWeight(towerGrid.x, towerGrid.y, 0);
		}
		CalculateRoutesPaths();
	}

	public void CalculateRoutesPaths()
	{
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseRoute value = routes.get_Item(i);
			List<RouteGridInfo> routePoints = value.routePoints;
			if (routePoints == null || routePoints.Count == 0)
			{
				break;
			}
			for (int j = 0; j < routePoints.Count; j++)
			{
				RouteGridInfo value2 = routePoints.get_Item(j);
				value2.path2Grid = null;
				routePoints.set_Item(j, value2);
			}
			for (int k = 0; k < routePoints.Count - 1; k++)
			{
				RouteGridInfo routeGridInfo = routePoints.get_Item(k);
				RouteGridInfo value3 = routePoints.get_Item(k + 1);
				List<int> path2Grid = FindPath(routeGridInfo.gridID, value3.gridID);
				value3.path2Grid = path2Grid;
				routePoints.set_Item(k + 1, value3);
			}
			value.routePoints = routePoints;
			routes.set_Item(i, value);
		}
	}

	public bool SetObstacle(int index, bool isObstacle = true)
	{
		TowerGrid grid = GetGrid(index);
		if (grid.IsNull)
		{
			return false;
		}
		if (isObstacle)
		{
			if (grid.gridWalkableType == 0)
			{
				return false;
			}
		}
		else if (grid.gridWalkableType == 1)
		{
			return false;
		}
		SetObstacle(grid.x, grid.y, isObstacle);
		CalculateRoutesPaths();
		return true;
	}

	private void SetObstacle(int x, int y, bool isObstacle = true)
	{
		pathFinder.SetObstacle(x, y, isObstacle);
	}

	public void SetWeight(int index, int weight = 0)
	{
		TowerGrid grid = GetGrid(index);
		SetWeight(grid.x, grid.y, weight);
	}

	public void SetWeight(int x, int y, int weight)
	{
		pathFinder.SetWeight(x, y, weight);
	}

	private List<int> FindPath(int startIndex, int endIndex)
	{
		TowerGrid grid = GetGrid(startIndex);
		TowerGrid grid2 = GetGrid(endIndex);
		List<TowerDefensePathFinding.Point> list = pathFinder.FindPath(grid.x, grid.y, grid2.x, grid2.y);
		if (list == null)
		{
			return null;
		}
		if (list.Count > 0)
		{
			List<int> list2 = new List<int>();
			for (int i = 0; i < list.Count; i++)
			{
				TowerDefensePathFinding.Point point = list.get_Item(i);
				list2.Add(GetGrid(point.x, point.y).index);
			}
			return list2;
		}
		return null;
	}

	public TowerGrid GetNextGrid(int rID, int curIndex, int reachedPointIndex, out int curReachedPointIndex)
	{
		curReachedPointIndex = reachedPointIndex;
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			if (towerDefenseRoute.id == rID)
			{
				int nextGridIndex = towerDefenseRoute.GetNextGridIndex(curIndex, reachedPointIndex, out curReachedPointIndex);
				return GetGrid(nextGridIndex);
			}
		}
		return TowerGrid.Null;
	}

	public int GetReachedPointIndex(int routeID, int gridID, int reachedPointIndex)
	{
		if (routes == null)
		{
			return -1;
		}
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			if (towerDefenseRoute.id == routeID)
			{
				return towerDefenseRoute.GetReachedPointIndex(gridID, reachedPointIndex);
			}
		}
		return -1;
	}

	public int Length2End(int routeID, int gridIndex, int reachedPointIndex)
	{
		if (routes == null)
		{
			return 0;
		}
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			if (towerDefenseRoute.id != routeID)
			{
				continue;
			}
			List<RouteGridInfo> routePoints = towerDefenseRoute.routePoints;
			if (routePoints == null)
			{
				return 0;
			}
			int num = -1;
			int num2 = 0;
			for (num2 = reachedPointIndex; num2 < routePoints.Count; num2++)
			{
				List<int> path2Grid = routePoints.get_Item(num2).path2Grid;
				if (path2Grid == null)
				{
					continue;
				}
				for (int j = 0; j < path2Grid.Count; j++)
				{
					if (path2Grid.get_Item(j) == gridIndex)
					{
						num = path2Grid.Count - j - 1;
						break;
					}
				}
				if (num >= 0)
				{
					break;
				}
			}
			if (num == -1)
			{
				return 0;
			}
			for (num2++; num2 < routePoints.Count; num2++)
			{
				List<int> path2Grid2 = routePoints.get_Item(num2).path2Grid;
				if (path2Grid2 != null && path2Grid2.Count != 0)
				{
					num += path2Grid2.Count - 1;
				}
			}
			return num;
		}
		return 0;
	}

	public bool GridIsMustArrive(int routeID, int gridIndex)
	{
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			if (towerDefenseRoute.id != routeID)
			{
				continue;
			}
			List<RouteGridInfo> routePoints = towerDefenseRoute.routePoints;
			if (routePoints != null)
			{
				for (int j = 0; j < routePoints.Count; j++)
				{
					if (gridIndex == routePoints.get_Item(j).gridID)
					{
						return true;
					}
				}
			}
			return false;
		}
		return false;
	}
}
