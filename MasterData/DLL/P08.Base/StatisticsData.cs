using System.Collections.Generic;
using NetProcol;

public class StatisticsData
{
	public BattleResultForLua dataForLua = new BattleResultForLua();

	public uint currentFrameNumber;

	public List<DeadAgent> deathInfos = new List<DeadAgent>();

	public List<HurtInfo> hurtInfos = new List<HurtInfo>();

	public List<int> finishedAchievement = new List<int>();

	public List<int> currentAchievement = new List<int>();

	public List<int> choosedEffectID = new List<int>();

	public BattleResultInfo ToBattleResultInfo()
	{
		BattleResultInfo battleResultInfo = new BattleResultInfo
		{
			BattleTime = (int)(dataForLua.battleTime * 1000f),
			TotalDeadNum = dataForLua.totalDeadNum,
			TotalHittedNum = dataForLua.totalHittedNum,
			InjuredNum = dataForLua.injuredNum,
			FallDownNum = dataForLua.fallDownNum,
			KnockoutNum = dataForLua.knockoutNum,
			QteCount = dataForLua.qteExecuteCount,
			ResurrectTimes = dataForLua.resurrectTimes,
			FrameCount = currentFrameNumber
		};
		for (int i = 0; i < 3; i++)
		{
			battleResultInfo.CharsInfo.Add(new CharResultInfo
			{
				HeroID = ((dataForLua.currentHPHero.Count > i) ? dataForLua.currentHPHero[i] : 0),
				CurrentHP = ((dataForLua.currentHP.Count > i) ? dataForLua.currentHP[i] : 0),
				MaxHP = ((dataForLua.MaxHP.Count > i) ? dataForLua.MaxHP[i] : 0)
			});
		}
		for (int j = 0; j < hurtInfos.Count; j++)
		{
			HurtInfo hurtInfo = hurtInfos[j];
			if (hurtInfo.casterOrder >= 1 && hurtInfo.casterOrder <= 3)
			{
				if (hurtInfo.damageValue < 0)
				{
					battleResultInfo.CharsInfo.get_Item(hurtInfo.casterOrder - 1).Damage -= hurtInfo.damageValue;
				}
				else
				{
					battleResultInfo.CharsInfo.get_Item(hurtInfo.casterOrder - 1).Cure += hurtInfo.damageValue;
				}
			}
			if (hurtInfo.agentOrder >= 1 && hurtInfo.agentOrder <= 3 && hurtInfo.damageValue < 0)
			{
				battleResultInfo.CharsInfo.get_Item(hurtInfo.agentOrder - 1).Hurt -= hurtInfo.damageValue;
			}
		}
		battleResultInfo.EnemyDeadNum = deathInfos.Count;
		foreach (KeyValuePair<int, int> item in dataForLua.items)
		{
			battleResultInfo.ItemID.Add(item.Key);
			battleResultInfo.ItemNumber.Add(item.Value);
		}
		foreach (KeyValuePair<int, int> recordData in dataForLua.recordDatas)
		{
			battleResultInfo.RecordDataID.Add(recordData.Key);
			battleResultInfo.RecordDataNumber.Add(recordData.Value);
		}
		for (int k = 0; k < finishedAchievement.Count; k++)
		{
			battleResultInfo.Achievement.Add(finishedAchievement[k]);
		}
		for (int l = 0; l < choosedEffectID.Count; l++)
		{
			battleResultInfo.ChoosedEffectID.Add(choosedEffectID[l]);
		}
		return battleResultInfo;
	}
}
