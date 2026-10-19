using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Utility;
using Bamboo.ECS;

namespace ACT.UI;

public class StageChallengeManager
{
	public static Action<ChallengeActOn> InitEntity;

	public static Action<ChallengeActOn> StartBattle;

	private static StageChallengeManager instance;

	public static List<string> localChallengeBuff = new List<string>();

	public List<StageChallengInfo> challengInfo;

	public int curBossID = 5;

	public static StageChallengeManager Instance
	{
		get
		{
			if (instance == null)
			{
				instance = new StageChallengeManager();
			}
			return instance;
		}
	}

	public StageChallengInfo GetChallgeInfo(int id)
	{
		if (challengInfo == null)
		{
			challengInfo = new List<StageChallengInfo>();
		}
		StageChallengInfo stageChallengInfo = challengInfo.Find((StageChallengInfo x) => x.bossID == id);
		if (stageChallengInfo != null)
		{
			return stageChallengInfo;
		}
		StageChallengInfo stageChallengInfo2 = new StageChallengInfo
		{
			bossID = id
		};
		challengInfo.Add(stageChallengInfo2);
		return stageChallengInfo2;
	}

	public void RestInitAndBattleAction()
	{
		InitEntity = null;
		StartBattle = null;
	}

	public void RemoveChallengeBuff()
	{
		if (localChallengeBuff == null)
		{
			return;
		}
		CompAbility compAbility = MonoECS.instance.mainEntity.GetCompAbility();
		foreach (string item in localChallengeBuff)
		{
			if (compAbility.HasAbility(item))
			{
				compAbility.RemoveAbility(item);
			}
		}
		localChallengeBuff.Clear();
	}
}
