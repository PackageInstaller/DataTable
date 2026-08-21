using System;
using UnityEngine;

public class FloGameLuaBridge
{
	[Serializable]
	private class FloGameLuaData
	{
		public static FloGameLuaData tmpData = new FloGameLuaData();

		public bool isWin;

		public float percent;

		public float value1;

		public float value2;

		public float xValue;

		public float yValue;

		public int gameType;

		public float winBlur;

		public float winDistance;
	}

	private static FloGameManager GetManager()
	{
		FloGameManager instance = FloGameManager.instance;
		if (instance == null)
		{
			Debug.LogError("no FloGameManager");
		}
		return instance;
	}

	public static string GetGameData()
	{
		FloGameLuaData tmpData = FloGameLuaData.tmpData;
		FloGameManager manager = GetManager();
		if (manager != null)
		{
			FloGameData gameData = manager.gameData;
			tmpData.gameType = (int)gameData.gameType;
			tmpData.isWin = gameData.isWin;
			tmpData.value1 = gameData.value1;
			tmpData.value2 = gameData.value2;
			tmpData.xValue = gameData.xValue;
			tmpData.yValue = gameData.yValue;
			tmpData.percent = gameData.percent;
			tmpData.winBlur = gameData.winBlur;
			tmpData.winDistance = gameData.winDistance;
		}
		return JsonUtility.ToJson(tmpData);
	}

	public static void SetGameData(string data)
	{
		FloGameLuaData tmpData = FloGameLuaData.tmpData;
		JsonUtility.FromJsonOverwrite(data, tmpData);
		FloGameManager manager = GetManager();
		if (manager != null)
		{
			FloGameData gameData = manager.gameData;
			gameData.gameType = (FloGameType)tmpData.gameType;
			gameData.winBlur = tmpData.winBlur;
			gameData.winDistance = tmpData.winDistance;
			gameData.isWin = false;
			gameData.percent = 0f;
		}
	}

	public static void StartGame()
	{
		GetManager()?.StartGame();
	}

	public static void StopGame()
	{
		GetManager()?.StopGame();
	}
}
