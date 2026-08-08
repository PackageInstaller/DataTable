using System.IO;
using UnityEngine;

namespace TangramGame;

public static class TangramGameTools
{
	public static string headPath = "Assets/ABResources/TangramGame/{0}.json";

	public static string getHeadPath = "TangramGame/{0}.json";

	public static bool SavePrefabDataByJson(string stageID, TangramGamePrefabData data)
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

	public static TangramGamePrefabData LoadScriptableObject(string stageID)
	{
		string json = (Application.isPlaying ? AssetEx.LoadText(string.Format(getHeadPath, stageID)) : File.ReadAllText(string.Format(headPath, stageID)));
		return JsonUtility.FromJson<TangramGamePrefabData>(json);
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
}
