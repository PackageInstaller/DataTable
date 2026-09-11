using System.IO;
using UnityEngine;

namespace SkuldPuzzleGame;

public class SkuldPuzzleTools
{
	public static void SaveStageData(string stageID, SkuldPuzzleStageSaveData stageData)
	{
		string path = $"Assets/ComBattle/ABResources/Map/SkuldPuzzle/{stageID}.json";
		string contents = JsonUtility.ToJson(stageData);
		File.WriteAllText(path, contents);
	}

	public static SkuldPuzzleStageSaveData LoadStageData(string stageID)
	{
		string json = (Application.isPlaying ? AssetEx.LoadText($"Map/SkuldPuzzle/{stageID}.json") : File.ReadAllText($"Assets/ComBattle/ABResources/Map/SkuldPuzzle/{stageID}.json"));
		return JsonUtility.FromJson<SkuldPuzzleStageSaveData>(json);
	}

	public static void SaveChipShapData(SkuldPuzzleShapeChipAllSaveData shapeData)
	{
		string path = string.Format("Assets/ComBattle/ABResources/Map/SkuldPuzzle/{0}.json", "chipShape");
		string contents = JsonUtility.ToJson(shapeData);
		File.WriteAllText(path, contents);
	}

	public static SkuldPuzzleShapeChipAllSaveData LoadShapeChipData()
	{
		string json = (Application.isPlaying ? AssetEx.LoadText(string.Format("Map/SkuldPuzzle/{0}.json", "chipShape")) : File.ReadAllText(string.Format("Assets/ComBattle/ABResources/Map/SkuldPuzzle/{0}.json", "chipShape")));
		return JsonUtility.FromJson<SkuldPuzzleShapeChipAllSaveData>(json);
	}

	public static void CalculateTrueTileIndex(int oriX, int oriY, int curX, int curY, float rotate, out int x, out int y)
	{
		int num = Mathf.RoundToInt(Mathf.Abs(rotate) / 90f) % 4;
		x = 0;
		y = 0;
		switch (num)
		{
		case 0:
			x = oriX + curX;
			y = oriY + curY;
			break;
		case 1:
			x = oriX - curY;
			y = oriY + curX;
			break;
		case 2:
			x = oriX - curX;
			y = oriY - curY;
			break;
		case 3:
			x = oriX + curY;
			y = oriY - curX;
			break;
		}
	}

	public static Sprite GetPuzzleBgSprte(int shapeID, ColorType colorType = ColorType.None)
	{
		string spritePath = string.Empty;
		switch (colorType)
		{
		case ColorType.None:
			spritePath = string.Format("TextureConfig/Activity_Skuld_Puzzle/{0}", "Maskbg_" + shapeID);
			break;
		case ColorType.Red:
			spritePath = string.Format("TextureConfig/Activity_Skuld_Puzzle/{0}", "Maskpink_" + shapeID);
			break;
		case ColorType.Blue:
			spritePath = string.Format("TextureConfig/Activity_Skuld_Puzzle/{0}", "Maskblue_" + shapeID);
			break;
		}
		return AtlasManager.GetSpriteWithoutAtlas(spritePath);
	}

	public static Sprite GetPuzzleSprite(string spritePath)
	{
		Sprite sprite = null;
		if (!string.IsNullOrEmpty(spritePath))
		{
			sprite = AssetEx.LoadSprite(spritePath.Substring("Assets/ABResources/".Length));
			if (sprite == null)
			{
				sprite = AtlasManager.GetSpriteWithoutAtlas(spritePath.Substring("Assets/UIResources/UI_AB/".Length));
			}
		}
		return sprite;
	}

	public static bool CheckIsHaveStoryMode(SkuldPuzzleStageSaveData stageData)
	{
		foreach (SkuldPuzzleChipBlockData chip in stageData.chipList)
		{
			if (chip.storyData != null && chip.storyData.storyFillX > -1 && chip.storyData.storyFillY > -1)
			{
				return true;
			}
		}
		return false;
	}
}
