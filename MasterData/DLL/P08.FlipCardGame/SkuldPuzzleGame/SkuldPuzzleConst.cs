using System.Collections.Generic;
using UnityEngine;

namespace SkuldPuzzleGame;

public class SkuldPuzzleConst
{
	public const string stageNormalPath = "Assets/ComBattle/ABResources/Map/SkuldPuzzle/{0}.json";

	public const string stageAbPath = "Map/SkuldPuzzle/{0}.json";

	public const string puzzleImgPath = "TextureConfig/Activity_Skuld_Puzzle/{0}";

	public const string abHead = "Assets/ABResources/";

	public const string atlasHead = "Assets/UIResources/UI_AB/";

	public static int cubeSize = 148;

	public static int cubeSpace = 10;

	public static int chipSize = 153;

	public static int chipCubeSize = 150;

	public static int chipEdge = 9;

	public static Dictionary<ColorType, Color> ChipColorDic = new Dictionary<ColorType, Color>
	{
		{
			ColorType.None,
			Color.white
		},
		{
			ColorType.Red,
			new Color(1f, 0.6627451f, 0.7607843f, 1f)
		},
		{
			ColorType.Blue,
			new Color(0.52156866f, 0.654902f, 0.9490196f, 1f)
		}
	};

	public static Dictionary<ColorType, Color> ChipOutLineColorDic = new Dictionary<ColorType, Color>
	{
		{
			ColorType.None,
			Color.white
		},
		{
			ColorType.Red,
			new Color(79f / 85f, 52f / 85f, 0.70980394f, 1f)
		},
		{
			ColorType.Blue,
			new Color(0.61960787f, 62f / 85f, 0.95686275f, 1f)
		}
	};

	public static Dictionary<ColorType, string> TileColorController = new Dictionary<ColorType, string>
	{
		{
			ColorType.None,
			"normal"
		},
		{
			ColorType.Red,
			"pink"
		},
		{
			ColorType.Blue,
			"blue"
		}
	};

	public static List<Vector2Int> RoundNextList = new List<Vector2Int>
	{
		new Vector2Int(0, 1),
		new Vector2Int(1, 0),
		new Vector2Int(0, -1),
		new Vector2Int(-1, 0)
	};
}
