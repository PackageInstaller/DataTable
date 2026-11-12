using System;
using System.Collections.Generic;

public class TowerDefensePathFinding
{
	public struct Point(int x, int y)
	{
		public int x = x;

		public int y = y;
	}

	public class Node
	{
		private int gcost;

		public int weight;

		public Point Position { get; set; }

		public Node Parent { get; set; }

		public int GCost
		{
			get
			{
				return gcost + weight;
			}
			set
			{
				gcost = value;
			}
		}

		public int HCost { get; set; }

		public int FCost => GCost + HCost;

		public bool IsWalkable { get; set; } = true;

		public Node(int x, int y)
		{
			Position = new Point(x, y);
		}
	}

	private Node[,] grid;

	private int gridWidth;

	private int gridHeight;

	private static Point[] Directions = new Point[4]
	{
		new Point(1, 0),
		new Point(0, 1),
		new Point(-1, 0),
		new Point(0, -1)
	};

	public TowerDefensePathFinding(int width, int height)
	{
		gridWidth = width;
		gridHeight = height;
		InitializeGrid();
	}

	private void InitializeGrid()
	{
		grid = new Node[gridWidth, gridHeight];
		for (int i = 0; i < gridWidth; i++)
		{
			for (int j = 0; j < gridHeight; j++)
			{
				grid[i, j] = new Node(i, j);
			}
		}
	}

	public void SetWeight(int x, int y, int weight)
	{
		if (IsInGrid(x, y))
		{
			grid[x, y].weight = weight;
		}
	}

	public void SetObstacle(int x, int y, bool isObstacle)
	{
		if (IsInGrid(x, y))
		{
			grid[x, y].IsWalkable = !isObstacle;
		}
	}

	private bool IsInGrid(int x, int y)
	{
		if (x >= 0 && x < gridWidth && y >= 0)
		{
			return y < gridHeight;
		}
		return false;
	}

	public List<Point> FindPath(int sx, int sy, int ex, int ey)
	{
		return FindPath(new Point(sx, sy), new Point(ex, ey));
	}

	public List<Point> FindPath(Point start, Point end)
	{
		if (!IsInGrid(start.x, start.y) || !IsInGrid(end.x, end.y))
		{
			return new List<Point>();
		}
		Node node = grid[start.x, start.y];
		Node node2 = grid[end.x, end.y];
		if (!node.IsWalkable || !node2.IsWalkable)
		{
			return null;
		}
		List<Node> list = new List<Node>();
		HashSet<Node> hashSet = new HashSet<Node>();
		list.Add(node);
		for (int i = 0; i < gridWidth; i++)
		{
			for (int j = 0; j < gridHeight; j++)
			{
				Node node3 = grid[i, j];
				node3.GCost = int.MaxValue;
				node3.HCost = CalculateDistance(node3.Position, end);
				node3.Parent = null;
			}
		}
		node.GCost = 0;
		node.HCost = CalculateDistance(start, end);
		while (list.Count > 0)
		{
			Node node4 = list.get_Item(0);
			for (int k = 1; k < list.Count; k++)
			{
				if (list.get_Item(k).FCost < node4.FCost || (list.get_Item(k).FCost == node4.FCost && list.get_Item(k).HCost < node4.HCost))
				{
					node4 = list.get_Item(k);
				}
			}
			list.Remove(node4);
			hashSet.Add(node4);
			if (node4 == node2)
			{
				return ReconstructPath(node2);
			}
			foreach (Node neighbor in GetNeighbors(node4))
			{
				if (!neighbor.IsWalkable || hashSet.Contains(neighbor))
				{
					continue;
				}
				int num = node4.GCost + CalculateDistance(node4.Position, neighbor.Position);
				if (num < neighbor.GCost)
				{
					neighbor.Parent = node4;
					neighbor.GCost = num;
					if (!list.Contains(neighbor))
					{
						list.Add(neighbor);
					}
				}
			}
		}
		return null;
	}

	private List<Node> GetNeighbors(Node node)
	{
		List<Node> list = new List<Node>();
		Point[] directions = Directions;
		for (int i = 0; i < directions.Length; i++)
		{
			Point point = directions[i];
			int num = node.Position.x + point.x;
			int num2 = node.Position.y + point.y;
			if (IsInGrid(num, num2))
			{
				list.Add(grid[num, num2]);
			}
		}
		return list;
	}

	private int CalculateDistance(Point a, Point b)
	{
		return Math.Abs(a.x - b.x) + Math.Abs(a.y - b.y);
	}

	private List<Point> ReconstructPath(Node endNode)
	{
		List<Point> list = new List<Point>();
		for (Node node = endNode; node != null; node = node.Parent)
		{
			list.Add(node.Position);
		}
		list.Reverse();
		return list;
	}
}
