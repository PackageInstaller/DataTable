using System;
using System.Collections.Generic;
using UnityEngine;

namespace Runtime.EmbeddedGame.PuzzleGame;

[Serializable]
public class PuzzleEdgeData
{
	public EdgeOrientation orientation;

	public Vector2Int position;

	public bool isEnabled;

	public List<int> ruleIds = new List<int>();

	public PuzzleEdgeData()
	{
	}

	public PuzzleEdgeData(EdgeOrientation orientation, int x, int y)
	{
		this.orientation = orientation;
		position = new Vector2Int(x, y);
	}
}
