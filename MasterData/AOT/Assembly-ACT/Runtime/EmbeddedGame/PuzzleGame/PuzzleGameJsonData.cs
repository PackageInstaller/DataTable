using System;
using System.Collections.Generic;

namespace Runtime.EmbeddedGame.PuzzleGame;

[Serializable]
public class PuzzleGameJsonData
{
	public int boardWidth;

	public int boardHeight;

	public List<PuzzleCellData> cells;

	public List<PuzzleEdgeData> horizontalEdges;

	public List<PuzzleEdgeData> verticalEdges;

	public List<PuzzleShapeData> shapes;
}
