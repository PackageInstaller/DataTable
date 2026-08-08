using Pinball;
using UnityEngine;

public static class PinballLuaBridge
{
	public static void InitTurnBasedPinballGame(GameObject turnBasedGameGo, PinballDataForExchange data)
	{
		if (PinballGameManager.Instance != null)
		{
			PinballGameManager.Instance.InitTurnBasedPinballGame(turnBasedGameGo, data);
		}
		else
		{
			Debug.LogError("弹球场景未加载完成");
		}
	}

	public static void GameRestart()
	{
		if (PinballGameManager.Instance != null)
		{
			PinballGameManager.Instance.GameRestart();
		}
		else
		{
			Debug.LogError("弹球场景未加载完成");
		}
	}

	public static void InterruptExitGame()
	{
		if (PinballGameManager.Instance != null)
		{
			PinballGameManager.Instance.InterruptExitGame();
		}
		else
		{
			Debug.LogError("弹球场景未加载完成");
		}
	}
}
