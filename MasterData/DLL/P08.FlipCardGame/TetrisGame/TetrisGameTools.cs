using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace TetrisGame;

public class TetrisGameTools
{
	public static string headPath = "Assets/ABResources/TetrisGame/{0}.json";

	public static string chipPath = "Assets/ABResources/TetrisGame/chipStage.json";

	public static string getHeadPath = "TetrisGame/{0}.json";

	public static string getChipPath = "TetrisGame/chipStage.json";

	public static string specialChipPath = "Assets/ABResources/TetrisGame/specialChipStage.json";

	public static string specialGetChipPath = "TetrisGame/specialChipStage.json";

	public const string tetrisSheet = "minigame_activity_3_6";

	public const string tetrisUp = "minigame_activity_3_6_block_up";

	public const string tetrisDown = "minigame_activity_3_6_block_down";

	public const string tetrisRotate = "minigame_activity_3_6_block_rotate";

	public const string tetrisRefreshNormal = "minigame_activity_3_6_block_refresh01";

	public const string tetrisRefreshSpecial = "minigame_activity_3_6_block_refresh02";

	public const string tetrisFinish1 = "minigame_activity_3_6_block_finish01";

	public const string tetrisFinish2 = "minigame_activity_3_6_block_finish02";

	public const string tetrisFinish3 = "minigame_activity_3_6_block_finish03";

	public const string tetrisFinish4 = "minigame_activity_3_6_block_finish04";

	public const int maxColorIndex = 16;

	public static List<int> randomList = new List<int> { 0, 1, 2, 3, 4, 6, 7, 8, 9 };

	public static bool SavePrefabDataByJson(string stageID, TetrisGameStageSaveData data)
	{
		if (stageID != null)
		{
			string path = string.Format(headPath, stageID);
			string contents = JsonUtility.ToJson(data);
			File.WriteAllText(path, contents);
			return true;
		}
		return false;
	}

	public static bool SavePrefabDataByJson(TetrisGameChipAllSaveData data)
	{
		string contents = JsonUtility.ToJson(data);
		File.WriteAllText(chipPath, contents);
		return true;
	}

	public static TetrisGameStageSaveData LoadScriptableObject(string stageID)
	{
		string json = (Application.isPlaying ? AssetEx.LoadText(string.Format(getHeadPath, stageID)) : File.ReadAllText(string.Format(headPath, stageID)));
		return JsonUtility.FromJson<TetrisGameStageSaveData>(json);
	}

	public static TetrisGameChipAllSaveData LoadChipScriptableObject(bool isSpecial = false)
	{
		string json = ((!Application.isPlaying) ? ((!isSpecial) ? File.ReadAllText(chipPath) : File.ReadAllText(specialChipPath)) : ((!isSpecial) ? AssetEx.LoadText(getChipPath) : AssetEx.LoadText(specialGetChipPath)));
		return JsonUtility.FromJson<TetrisGameChipAllSaveData>(json);
	}

	public static Vector2 CalculateTrueTileIndex(int orix, int oriy, int curX, int curY, float rotate)
	{
		return (Mathf.RoundToInt(Mathf.Abs(rotate) / 90f) % 4) switch
		{
			0 => new Vector2(orix + curX, oriy + curY), 
			1 => new Vector2(orix - curY, oriy + curX), 
			2 => new Vector2(orix - curX, oriy - curY), 
			3 => new Vector2(orix + curY, oriy - curX), 
			_ => new Vector2(0f, 0f), 
		};
	}

	public static bool CalculateTrueTileIndex(int orix, int oriy, int curX, int curY, float rotate, int width, int height, int maxWid, int maxHeight)
	{
		int num = Mathf.RoundToInt(Mathf.Abs(rotate) / 90f) % 4;
		Vector2 vector = new Vector2(-1f, -1f);
		switch (num)
		{
		case 0:
			vector = new Vector2(orix + curX, oriy + curY);
			break;
		case 1:
			vector = new Vector2(orix - curY, oriy + curX);
			break;
		case 2:
			vector = new Vector2(orix - curX, oriy - curY);
			break;
		case 3:
			vector = new Vector2(orix + curY, oriy - curX);
			break;
		}
		if (vector.x < 0f || vector.x >= (float)maxWid)
		{
			return false;
		}
		if (vector.y < 0f || vector.y >= (float)maxHeight)
		{
			return false;
		}
		return true;
	}

	public static bool CheckIsDispose(TileType tileType)
	{
		return true;
	}

	public static int RandomChipIndex()
	{
		int index = Random.Range(0, randomList.Count);
		return randomList[index];
	}
}
