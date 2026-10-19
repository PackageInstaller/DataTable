using System;
using System.Collections.Generic;
using ACT.Game.Data;
using Runtime.Model;

namespace ACT.UI;

public class RogueSettlementViewData : UIViewData
{
	public RogueFinishType FinishType;

	public int ModeId;

	public int ModeNameLocalizeId;

	public int CurrentProgress;

	public int TotalProgress;

	public float ElapsedSeconds;

	public int MaxDamage;

	public int GainCoin;

	public int NormalKillCount;

	public int EliteKillCount;

	public int TalentTreePoint;

	public readonly List<int> CharacterIds = new List<int>(3);

	public readonly List<RogueSettlementRewardData> Rewards = new List<RogueSettlementRewardData>();

	public readonly List<RogueBagItemData> BuildItems = new List<RogueBagItemData>();

	public Action OnLeave;

	public Action OnRetry;
}
