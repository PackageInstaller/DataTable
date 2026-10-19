using System;
using System.Collections.Generic;
using UnityEngine;

namespace Runtime.EmbeddedGame.PuzzleGame;

[CreateAssetMenu(fileName = "NewPuzzleGameData", menuName = "ACT/EmbeddedGame/Puzzle Game Data")]
public class PuzzleGameData : ScriptableObject
{
	[Header("棋盘尺寸")]
	public int boardWidth = 8;

	public int boardHeight = 8;

	[Header("格子数据")]
	public List<PuzzleCellData> cells = new List<PuzzleCellData>();

	[Header("边数据")]
	public List<PuzzleEdgeData> horizontalEdges = new List<PuzzleEdgeData>();

	public List<PuzzleEdgeData> verticalEdges = new List<PuzzleEdgeData>();

	[Header("拼块定义数据")]
	public List<PuzzleShapeData> shapes = new List<PuzzleShapeData>();

	[NonSerialized]
	private Dictionary<Vector2Int, PuzzleCellData> _cellLookup;

	[NonSerialized]
	private Dictionary<Vector2Int, PuzzleEdgeData> _hEdgeLookup;

	[NonSerialized]
	private Dictionary<Vector2Int, PuzzleEdgeData> _vEdgeLookup;

	public void InitializeBoard()
	{
		cells = new List<PuzzleCellData>(boardWidth * boardHeight);
		for (int i = 0; i < boardHeight; i++)
		{
			for (int j = 0; j < boardWidth; j++)
			{
				cells.Add(new PuzzleCellData(j, i));
			}
		}
		InitializeEdges();
		RebuildLookups();
	}

	private void InitializeEdges()
	{
		horizontalEdges = new List<PuzzleEdgeData>();
		for (int i = 0; i <= boardHeight; i++)
		{
			for (int j = 0; j < boardWidth; j++)
			{
				horizontalEdges.Add(new PuzzleEdgeData(EdgeOrientation.Horizontal, j, i));
			}
		}
		verticalEdges = new List<PuzzleEdgeData>();
		for (int k = 0; k < boardHeight; k++)
		{
			for (int l = 0; l <= boardWidth; l++)
			{
				verticalEdges.Add(new PuzzleEdgeData(EdgeOrientation.Vertical, l, k));
			}
		}
	}

	public void ResizeBoard(int newWidth, int newHeight)
	{
		newWidth = Mathf.Max(1, newWidth);
		newHeight = Mathf.Max(1, newHeight);
		Dictionary<Vector2Int, PuzzleCellData> dictionary = new Dictionary<Vector2Int, PuzzleCellData>();
		foreach (PuzzleCellData cell in cells)
		{
			dictionary[cell.position] = cell;
		}
		Dictionary<Vector2Int, PuzzleEdgeData> dictionary2 = new Dictionary<Vector2Int, PuzzleEdgeData>();
		foreach (PuzzleEdgeData horizontalEdge in horizontalEdges)
		{
			dictionary2[horizontalEdge.position] = horizontalEdge;
		}
		Dictionary<Vector2Int, PuzzleEdgeData> dictionary3 = new Dictionary<Vector2Int, PuzzleEdgeData>();
		foreach (PuzzleEdgeData verticalEdge in verticalEdges)
		{
			dictionary3[verticalEdge.position] = verticalEdge;
		}
		List<PuzzleCellData> list = new List<PuzzleCellData>(newWidth * newHeight);
		for (int i = 0; i < newHeight; i++)
		{
			for (int j = 0; j < newWidth; j++)
			{
				Vector2Int key = new Vector2Int(j, i);
				list.Add(dictionary.TryGetValue(key, out var value) ? value : new PuzzleCellData(j, i));
			}
		}
		List<PuzzleEdgeData> list2 = new List<PuzzleEdgeData>();
		for (int k = 0; k <= newHeight; k++)
		{
			for (int l = 0; l < newWidth; l++)
			{
				Vector2Int key2 = new Vector2Int(l, k);
				list2.Add(dictionary2.TryGetValue(key2, out var value2) ? value2 : new PuzzleEdgeData(EdgeOrientation.Horizontal, l, k));
			}
		}
		List<PuzzleEdgeData> list3 = new List<PuzzleEdgeData>();
		for (int m = 0; m < newHeight; m++)
		{
			for (int n = 0; n <= newWidth; n++)
			{
				Vector2Int key3 = new Vector2Int(n, m);
				list3.Add(dictionary3.TryGetValue(key3, out var value3) ? value3 : new PuzzleEdgeData(EdgeOrientation.Vertical, n, m));
			}
		}
		boardWidth = newWidth;
		boardHeight = newHeight;
		cells = list;
		horizontalEdges = list2;
		verticalEdges = list3;
		RebuildLookups();
	}

	public PuzzleCellData GetCell(int x, int y)
	{
		if (x < 0 || x >= boardWidth || y < 0 || y >= boardHeight)
		{
			return null;
		}
		EnsureLookups();
		_cellLookup.TryGetValue(new Vector2Int(x, y), out var value);
		return value;
	}

	public PuzzleCellData GetCell(Vector2Int pos)
	{
		return GetCell(pos.x, pos.y);
	}

	public PuzzleEdgeData GetEdge(int x, int y, EdgeDirection direction)
	{
		return direction switch
		{
			EdgeDirection.Top => GetHEdge(x, y), 
			EdgeDirection.Bottom => GetHEdge(x, y + 1), 
			EdgeDirection.Left => GetVEdge(x, y), 
			EdgeDirection.Right => GetVEdge(x + 1, y), 
			_ => null, 
		};
	}

	public bool GetEdgeMarked(int x, int y, EdgeDirection direction)
	{
		return GetEdge(x, y, direction)?.isEnabled ?? false;
	}

	public void SetEdgeMarked(int x, int y, EdgeDirection direction, bool value)
	{
		PuzzleEdgeData edge = GetEdge(x, y, direction);
		if (edge != null)
		{
			edge.isEnabled = value;
		}
	}

	private PuzzleEdgeData GetHEdge(int x, int row)
	{
		if (x < 0 || x >= boardWidth || row < 0 || row > boardHeight)
		{
			return null;
		}
		EnsureLookups();
		_hEdgeLookup.TryGetValue(new Vector2Int(x, row), out var value);
		return value;
	}

	private PuzzleEdgeData GetVEdge(int col, int y)
	{
		if (col < 0 || col > boardWidth || y < 0 || y >= boardHeight)
		{
			return null;
		}
		EnsureLookups();
		_vEdgeLookup.TryGetValue(new Vector2Int(col, y), out var value);
		return value;
	}

	private void EnsureLookups()
	{
		if (_cellLookup == null || _hEdgeLookup == null || _vEdgeLookup == null)
		{
			RebuildLookups();
		}
	}

	public void RebuildLookups()
	{
		_cellLookup = new Dictionary<Vector2Int, PuzzleCellData>(cells.Count);
		foreach (PuzzleCellData cell in cells)
		{
			_cellLookup[cell.position] = cell;
		}
		_hEdgeLookup = new Dictionary<Vector2Int, PuzzleEdgeData>(horizontalEdges.Count);
		foreach (PuzzleEdgeData horizontalEdge in horizontalEdges)
		{
			_hEdgeLookup[horizontalEdge.position] = horizontalEdge;
		}
		_vEdgeLookup = new Dictionary<Vector2Int, PuzzleEdgeData>(verticalEdges.Count);
		foreach (PuzzleEdgeData verticalEdge in verticalEdges)
		{
			_vEdgeLookup[verticalEdge.position] = verticalEdge;
		}
	}

	public EdgeDirection GetCellEdgeFlags(int x, int y)
	{
		EdgeDirection edgeDirection = EdgeDirection.None;
		if (GetEdgeMarked(x, y, EdgeDirection.Top))
		{
			edgeDirection |= EdgeDirection.Top;
		}
		if (GetEdgeMarked(x, y, EdgeDirection.Right))
		{
			edgeDirection |= EdgeDirection.Right;
		}
		if (GetEdgeMarked(x, y, EdgeDirection.Bottom))
		{
			edgeDirection |= EdgeDirection.Bottom;
		}
		if (GetEdgeMarked(x, y, EdgeDirection.Left))
		{
			edgeDirection |= EdgeDirection.Left;
		}
		return edgeDirection;
	}

	public List<(Vector2Int cellPos, EdgeDirection direction)> GetEdgeAdjacentCells(PuzzleEdgeData edge)
	{
		List<(Vector2Int, EdgeDirection)> list = new List<(Vector2Int, EdgeDirection)>();
		if (edge == null)
		{
			return list;
		}
		Vector2Int position = edge.position;
		if (edge.orientation == EdgeOrientation.Horizontal)
		{
			Vector2Int item = new Vector2Int(position.x, position.y - 1);
			if (item.y >= 0 && item.y < boardHeight)
			{
				list.Add((item, EdgeDirection.Bottom));
			}
			Vector2Int item2 = new Vector2Int(position.x, position.y);
			if (item2.y >= 0 && item2.y < boardHeight)
			{
				list.Add((item2, EdgeDirection.Top));
			}
		}
		else
		{
			Vector2Int item3 = new Vector2Int(position.x - 1, position.y);
			if (item3.x >= 0 && item3.x < boardWidth)
			{
				list.Add((item3, EdgeDirection.Right));
			}
			Vector2Int item4 = new Vector2Int(position.x, position.y);
			if (item4.x >= 0 && item4.x < boardWidth)
			{
				list.Add((item4, EdgeDirection.Left));
			}
		}
		return list;
	}

	public string ExportToJson()
	{
		return JsonUtility.ToJson(new PuzzleGameJsonData
		{
			boardWidth = boardWidth,
			boardHeight = boardHeight,
			cells = cells,
			horizontalEdges = horizontalEdges,
			verticalEdges = verticalEdges,
			shapes = shapes
		}, prettyPrint: true);
	}

	public void ImportFromJson(string json)
	{
		PuzzleGameJsonData puzzleGameJsonData = JsonUtility.FromJson<PuzzleGameJsonData>(json);
		if (puzzleGameJsonData == null)
		{
			return;
		}
		boardWidth = Mathf.Max(1, puzzleGameJsonData.boardWidth);
		boardHeight = Mathf.Max(1, puzzleGameJsonData.boardHeight);
		InitializeBoard();
		if (puzzleGameJsonData.cells != null)
		{
			foreach (PuzzleCellData cell2 in puzzleGameJsonData.cells)
			{
				if (cell2 != null)
				{
					PuzzleCellData cell = GetCell(cell2.position);
					if (cell != null)
					{
						cell.isEnabled = cell2.isEnabled;
						cell.requiredFillCount = cell2.requiredFillCount;
						cell.ruleIds = cell2.ruleIds ?? new List<int>();
					}
				}
			}
		}
		ApplyImportedEdges(puzzleGameJsonData.horizontalEdges);
		ApplyImportedEdges(puzzleGameJsonData.verticalEdges);
		shapes = puzzleGameJsonData.shapes ?? new List<PuzzleShapeData>();
		RebuildLookups();
	}

	private void ApplyImportedEdges(List<PuzzleEdgeData> importedEdges)
	{
		if (importedEdges == null)
		{
			return;
		}
		foreach (PuzzleEdgeData importedEdge in importedEdges)
		{
			if (importedEdge != null)
			{
				Vector2Int position = importedEdge.position;
				PuzzleEdgeData puzzleEdgeData = ((importedEdge.orientation == EdgeOrientation.Horizontal) ? GetHEdge(position.x, position.y) : GetVEdge(position.x, position.y));
				if (puzzleEdgeData != null)
				{
					puzzleEdgeData.isEnabled = importedEdge.isEnabled;
					puzzleEdgeData.ruleIds = importedEdge.ruleIds ?? new List<int>();
				}
			}
		}
	}
}
