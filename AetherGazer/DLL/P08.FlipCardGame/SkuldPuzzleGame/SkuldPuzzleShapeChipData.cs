using System;
using System.Collections.Generic;

namespace SkuldPuzzleGame;

[Serializable]
public class SkuldPuzzleShapeChipData
{
	public int width;

	public int height;

	public int shapeTemplateId;

	public List<SkuldPuzzleTileData> tileList;
}
