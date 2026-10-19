using System;
using System.Collections.Generic;
using UnityEngine;

namespace Runtime.EmbeddedGame.PuzzleGame;

[Serializable]
public class PuzzleShapeData
{
	public List<Vector2Int> cells = new List<Vector2Int>();
}
