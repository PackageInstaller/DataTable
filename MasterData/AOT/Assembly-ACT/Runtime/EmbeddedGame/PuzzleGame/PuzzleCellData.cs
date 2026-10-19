using System;
using System.Collections.Generic;
using UnityEngine;

namespace Runtime.EmbeddedGame.PuzzleGame;

[Serializable]
public class PuzzleCellData
{
	public Vector2Int position;

	public bool isEnabled = true;

	public int requiredFillCount = 1;

	public List<int> ruleIds = new List<int>();

	public PuzzleCellData()
	{
	}

	public PuzzleCellData(int x, int y)
	{
		position = new Vector2Int(x, y);
	}
}
