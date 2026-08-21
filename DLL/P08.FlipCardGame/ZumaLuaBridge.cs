using UnityEngine;
using UnityEngine.UI;
using ZumaGame;

public class ZumaLuaBridge
{
	public static void Launcher(ZumaDataForExchange zumaData)
	{
		NScene.Load<ZumaSceneLoader>().SetGameConfig(zumaData);
	}

	public static void StartZumaGame()
	{
		(NScene.GetCurrentScene() as ZumaSceneLoader)?.StartZumaGame();
	}

	public static float GetCurTime()
	{
		ZumaSceneLoader zumaSceneLoader = NScene.GetCurrentScene() as ZumaSceneLoader;
		if (!(zumaSceneLoader != null))
		{
			return 0f;
		}
		return zumaSceneLoader.GetCurTime();
	}

	public static void PauseZumaGame()
	{
		(NScene.GetCurrentScene() as ZumaSceneLoader)?.PauseZumaGame();
	}

	public static void ReStartZumaGame()
	{
		(NScene.GetCurrentScene() as ZumaSceneLoader)?.ReStartZumaGame();
	}

	public static void UseZumaSkill()
	{
		(NScene.GetCurrentScene() as ZumaSceneLoader)?.UseZumaSkill();
	}

	public static void SetZumaGameCountdownUI(Animator timeAni, Text timeCountdownUI, Text skillCountdownUI, Image skillProgressImg)
	{
		(NScene.GetCurrentScene() as ZumaSceneLoader)?.SetZumaGameCountdownUI(timeAni, timeCountdownUI, skillCountdownUI, skillProgressImg);
	}

	public static void ReChallengeZumaGame(ZumaDataForExchange zumaData)
	{
		(NScene.GetCurrentScene() as ZumaSceneLoader)?.ReChallengeZumaGame(zumaData);
	}
}
