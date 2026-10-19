using System.Collections.Generic;
using ACT.Battle;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.ECS;
using Pb;

namespace ACT.EventTrack;

public static class TrackEvtServer
{
	private static void SetCharacters(StageSettleInfo info, out List<int> ids)
	{
		MonoECS.instance.chTimeStatisticsManager.Calculate();
		ids = new List<int>();
		for (int i = 0; i < BattleConsts.TEAMCAPITAL; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			int num = -1;
			int characterLv = -1;
			float hpPercent = -1f;
			if (teamCharacter.IsValid)
			{
				CompCharacter? compCharacter = teamCharacter.GetCompCharacter();
				num = compCharacter.characterSource.Id();
				characterLv = compCharacter.characterSource.Level();
				hpPercent = teamCharacter.GetCompAbility().HpPercent;
			}
			StageSettleCharacterInfo item = new StageSettleCharacterInfo
			{
				CharacterID = num,
				CharacterLv = characterLv,
				Damage = MonoECS.instance.damageStatisticsManager.GetDamageStatistics(num),
				Duration = MonoECS.instance.chTimeStatisticsManager.GetTimeStatistics(num),
				HpPercent = hpPercent
			};
			info.CharacterInfo.Add(item);
			ids.Add(num);
		}
	}

	public static void SetAbyssRechallengeReq(AbyssRechallengeReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.DieCount = TrackEvtUtils.CharacterDieCount();
		req.SettleInfo.Duration = Model<AbyssModel>.Interface.SubStageDuration;
		MonoECS.instance.chTimeStatisticsManager.ResetRecording();
		MonoECS.instance.damageStatisticsManager.ResetRecording();
		Model<AbyssModel>.Interface.ResetTimer();
	}

	public static void SetAbyssCompleteSubStageReq(AbyssCompleteSubStageReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.DieCount = TrackEvtUtils.CharacterDieCount();
		req.SettleInfo.Duration = Model<AbyssModel>.Interface.SubStageDuration;
	}

	public static void SetAbyssLeaveReq(AbyssLeaveReq req, bool tmp)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.Tmp = tmp;
		req.SettleInfo.Duration = Model<AbyssModel>.Interface.SubStageDuration;
		req.SettleInfo.DieCount = TrackEvtUtils.CharacterDieCount();
		MonoECS.instance.chTimeStatisticsManager.StopRecording();
	}

	public static void SetAbyssFailureReq(AbyssFailureReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<AbyssModel>.Interface.SubStageDuration;
		req.SettleInfo.DieCount = TrackEvtUtils.CharacterDieCount();
		MonoECS.instance.chTimeStatisticsManager.StopRecording();
	}

	public static void SetRaidRechallengeReq(RaidRechallengeReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<RaidModel>.Interface.Duration;
		req.SettleInfo.TrapCount = Model<RaidModel>.Interface.ParkourTrapTimes;
		req.SettleInfo.DieCount = TrackEvtUtils.CharacterDieCount();
		MonoECS.instance.chTimeStatisticsManager.ResetRecording();
		MonoECS.instance.damageStatisticsManager.ResetRecording();
		Model<RaidModel>.Interface.ResetTimer();
	}

	public static void SetRaidLeaveReq(RaidLeaveReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<RaidModel>.Interface.Duration;
		req.SettleInfo.TrapCount = Model<RaidModel>.Interface.ParkourTrapTimes;
		req.SettleInfo.DieCount = TrackEvtUtils.CharacterDieCount();
		MonoECS.instance.chTimeStatisticsManager.StopRecording();
	}

	public static void SetRaidTakeRewardsReq(RaidTakeRewardsReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<RaidModel>.Interface.Duration;
		req.SettleInfo.TrapCount = Model<RaidModel>.Interface.ParkourTrapTimes;
		req.SettleInfo.DieCount = TrackEvtUtils.CharacterDieCount();
	}

	public static void SetRaidFailureReq(RaidFailureReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<RaidModel>.Interface.Duration;
		req.SettleInfo.TrapCount = Model<RaidModel>.Interface.ParkourTrapTimes;
		req.SettleInfo.DieCount = TrackEvtUtils.CharacterDieCount();
		MonoECS.instance.chTimeStatisticsManager.StopRecording();
	}

	public static void SetTempleRechallengeReq(TempleRechallengeReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<TempleModel>.Interface.Duration;
		MonoECS.instance.chTimeStatisticsManager.ResetRecording();
		MonoECS.instance.damageStatisticsManager.ResetRecording();
		Model<TempleModel>.Interface.ResetTimer();
	}

	public static void SetTempleLeaveReq(TempleLeaveReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<TempleModel>.Interface.Duration;
		MonoECS.instance.chTimeStatisticsManager.StopRecording();
	}

	public static void SetTempleCompleteStageReq(TempleCompleteStageReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<TempleModel>.Interface.Duration;
	}

	public static void SetTempleFailureReq(TempleFailureReq req)
	{
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		SetCharacters(stageSettleInfo, out var _);
		req.SettleInfo = stageSettleInfo;
		req.SettleInfo.Duration = Model<TempleModel>.Interface.Duration;
		MonoECS.instance.chTimeStatisticsManager.StopRecording();
	}
}
