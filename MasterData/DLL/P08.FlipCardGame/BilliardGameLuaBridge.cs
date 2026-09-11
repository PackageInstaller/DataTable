using BilliardGame;
using BilliardGame.Runtime;
using UnityEngine;

public static class BilliardGameLuaBridge
{
	public static void EntraceLauncher(int stageId, int hero1, int hero2, int hero3)
	{
		BilliardGameScene.Context.StageId = stageId;
		BilliardGameScene.Context.HeroId1 = hero1;
		BilliardGameScene.Context.HeroId2 = hero2;
		BilliardGameScene.Context.HeroId3 = hero3;
		BilliardGameDataManager.SetGameType(BilliardGameDataManager.GameType.BALL);
		NScene.Load<BilliardGameScene>();
	}

	public static void EntraceLauncher(int stageId, int heroId)
	{
		BilliardGameScene.Context.StageId = stageId;
		BilliardGameScene.Context.HeroId1 = heroId;
		BilliardGameDataManager.SetGameType(BilliardGameDataManager.GameType.Vehicle);
		NScene.Load<BilliardGameScene>();
	}

	public static void BindBilliardGameUI(GameObject go)
	{
		if (BilliardGameLogicManager.Instance != null)
		{
			BilliardGameLogicManager.Instance.InitTurnBasedGame(go);
		}
		else
		{
			Debug.LogError("弹球场景未加载完成");
		}
	}

	public static StageData GetStageData()
	{
		return BilliardGameManager.Instance.stageData;
	}

	public static int GetRoundNum()
	{
		if (BilliardGameLogicManager.Instance != null)
		{
			return BilliardGameLogicManager.Instance.CurRound;
		}
		return -1;
	}

	public static bool CheckDrag(float x, float y)
	{
		return BilliardGameLogicManager.Instance.CheckGuideInfo(x, y);
	}

	public static void SetGuideInfo(float x, float y)
	{
		BilliardGameLogicManager.Instance.SetGuideInfo(x, y);
	}

	public static BilliardGameEventTrigger GetTrigger()
	{
		return BilliardGameLogicManager.Instance.GetGuideTrigger();
	}

	public static BilliardGameExchangeData GetExchangeData()
	{
		return BilliardGameLogicManager.Instance.FinishGame();
	}

	public static void SaveMergeGroup(int[] buffIdList, int playerId)
	{
		BilliardGameLogicManager.Instance.AddMergeBuffGroup(buffIdList, playerId);
	}

	public static void RemoveBuff(int buffId, int playerId)
	{
		BilliardGameLogicManager.Instance.ForceRemoveBuff(buffId, playerId);
	}

	public static void AddBuff(int buffId, int playerId)
	{
		BilliardGameLogicManager.Instance.AddBuff(buffId, playerId);
	}

	public static void SetSelectBuffOver(bool flag)
	{
		BilliardGameLogicManager.Instance.SetSelectBuffOver(flag);
	}
}
