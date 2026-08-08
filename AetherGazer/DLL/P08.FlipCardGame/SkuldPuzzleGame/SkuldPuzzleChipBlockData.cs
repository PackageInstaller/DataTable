using System;
using System.Collections.Generic;

namespace SkuldPuzzleGame;

[Serializable]
public class SkuldPuzzleChipBlockData
{
	public int chipID;

	public int shapeTemplateId;

	public string spritePath;

	public int pixelBeginX;

	public int pixelBeginY;

	public float pixelScale = 1f;

	public ColorType colorType;

	public DIR beginDir;

	public SkuldPuzzleChipBlockStoryData storyData;

	public List<SkuldPuzzleDecorateData> drcorateList;
}
