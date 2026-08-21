-- chunkname: @IQIGame\\Module\\ChallengeWorldBoss\\ChallengeWorldBossModule.lua

ChallengeWorldBossModule = {}

function ChallengeWorldBossModule.Reload(podTable)
	ChallengeWorldBossModule.__worldBossPODTable = podTable

	ChallengeWorldBossModule:__InitStageCfgSortTable()
	ChallengeWorldBossModule:__InitRewardSortTable()

	if not EventUtil.HasEventListener(ChallengeWorldBossModule, EventID.OnBattleTotalDamageChange) then
		EventUtil.AddEventListener(ChallengeWorldBossModule, EventID.OnBattleTotalDamageChange, ChallengeWorldBossModule.__OnBattleTotalDamageChange)
	end
end

function ChallengeWorldBossModule.__OnBattleTotalDamageChange(_, totalDamage, actualDmg)
	if ChallengeWorldBossModule.CacheFightingData == nil then
		return
	end

	ChallengeWorldBossModule.CacheFightingData.totalDamage = totalDamage
end

function ChallengeWorldBossModule:__InitStageCfgSortTable()
	local cfgSortTable = {}

	ForPairs(CfgWorldBossStageTable, function(_, _cfg)
		if cfgSortTable[_cfg.ChapterId] == nil then
			cfgSortTable[_cfg.ChapterId] = {}
		end

		table.insert(cfgSortTable[_cfg.ChapterId], _cfg)
	end)

	local function sortFunc(a, b)
		return a.BossLevel < b.BossLevel
	end

	ForPairs(cfgSortTable, function(_chapterCid, _)
		table.sort(cfgSortTable[_chapterCid], sortFunc)
	end)

	ChallengeWorldBossModule.__worldBossStageSortTable = cfgSortTable
end

function ChallengeWorldBossModule:__InitRewardSortTable()
	local cfgSortTable = {}

	ForPairs(CfgWorldBossRewardTable, function(_, _cfgData)
		if cfgSortTable[_cfgData.RankType] == nil then
			cfgSortTable[_cfgData.RankType] = {}
		end

		table.insert(cfgSortTable[_cfgData.RankType], _cfgData)
	end)

	local function sortFunc(a, b)
		return a.RankLowerLimit < b.RankLowerLimit
	end

	ForPairs(cfgSortTable, function(_rankType, _)
		table.sort(cfgSortTable[_rankType], sortFunc)
	end)

	ChallengeWorldBossModule.__worldBossRewardSortTable = cfgSortTable
end

function ChallengeWorldBossModule.GetRankRewardCfgList()
	local cfg = ChallengeWorldBossModule.__worldBossRewardSortTable[Constant.CenterRankRankType.Specific]
	local cfg2 = ChallengeWorldBossModule.__worldBossRewardSortTable[Constant.CenterRankRankType.Percentage]

	return table.merge(cfg, cfg2)
end

function ChallengeWorldBossModule.GetCurWorldBossPOD()
	local activityPOD = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_ChallengeWorldBoss
	})
	local challengeWorldBossPOD = GetArrayValue(activityPOD, 1, nil)

	if challengeWorldBossPOD == nil then
		return nil
	end

	return challengeWorldBossPOD
end

function ChallengeWorldBossModule.GetCurWorldBossStageCfg(chapterCid)
	local stageCfg
	local stageCfgTable = ChallengeWorldBossModule.__worldBossStageSortTable[chapterCid]

	if stageCfgTable == nil then
		logError("世界Boss配置错误，找不到章节 {0} 对应的关卡配置数据", chapterCid)

		return stageCfg
	end

	local chapterDupPOD = ChallengeWorldBossModule.__worldBossPODTable[chapterCid]

	ForArray(stageCfgTable, function(_, _stageCfg)
		stageCfg = _stageCfg

		if chapterDupPOD == nil then
			return true
		end

		local success = TryToNumber(chapterDupPOD.passStatus[_stageCfg.Id], 0)

		if success == 0 then
			return true
		end
	end)

	return stageCfg
end

function ChallengeWorldBossModule.GetCurChapterCfg()
	local activityPOD = ChallengeWorldBossModule.GetCurWorldBossPOD()

	if activityPOD == nil then
		return nil
	end

	return ChallengeWorldBossModule.GetChapterCfgByActivityOpenCount(activityPOD.openCount)
end

function ChallengeWorldBossModule.GetChapterCfgByActivityOpenCount(openCount)
	log("当前世界Boss期数 --》 {0}", openCount)

	local seasonCfg = CfgWorldBossSeasonTable[openCount]

	if seasonCfg == nil then
		return nil
	end

	if seasonCfg.ChapterCid == 0 then
		return nil
	end

	return CfgWorldBossChapterTable[seasonCfg.ChapterCid]
end

function ChallengeWorldBossModule.IsFuncOpen()
	return UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_ChallengeWorldBoss)
end

function ChallengeWorldBossModule.IsActivityOpen()
	local chapterCfg = ChallengeWorldBossModule.GetCurChapterCfg()

	if chapterCfg == nil then
		return false
	end

	return true
end

function ChallengeWorldBossModule.SetCenterRankDataInvalidate()
	CenterRankModule.SetDataInvalidate(Constant.CenterRankID.ChallengeWorldBoss)
end

function ChallengeWorldBossModule.GetUpLevelGoalieCfgData(rankType, rank)
	local rankRangeIndex, _ = ChallengeWorldBossModule.__DoGetRankRangeByRank(rankType, rank)
	local upLevelRangeIndex = rankRangeIndex - 1

	if upLevelRangeIndex > 0 then
		return ChallengeWorldBossModule.GetRankRangeCfgWithIndex(rankType, upLevelRangeIndex)
	end

	if rankType == Constant.CenterRankRankType.Specific then
		return nil
	end

	return ChallengeWorldBossModule.GetLastLevelRankRangeCfg(Constant.CenterRankRankType.Specific)
end

function ChallengeWorldBossModule.GetRankRangeCfgData(rankType, rank)
	local _, cfgData = ChallengeWorldBossModule.__DoGetRankRangeByRank(rankType, rank)

	return cfgData
end

function ChallengeWorldBossModule.GetLastLevelRankRangeCfg(rankType)
	local sortTableList = ChallengeWorldBossModule.__worldBossRewardSortTable[rankType]

	return sortTableList[#sortTableList]
end

function ChallengeWorldBossModule.GetRankRangeCfgWithIndex(rankType, index)
	local sortTableList = ChallengeWorldBossModule.__worldBossRewardSortTable[rankType]

	return sortTableList[index]
end

function ChallengeWorldBossModule.__DoGetRankRangeByRank(rankType, rank)
	local rewardCfgList = ChallengeWorldBossModule.__worldBossRewardSortTable[rankType]
	local rangeIndex = 0
	local rangeCfg

	ForArrayTable(rewardCfgList, function(_index, _cfgData)
		if not NumberInRange(rank, _cfgData.RankLowerLimit, true, _cfgData.RankUpperLimit, true) then
			return
		end

		rangeIndex = _index
		rangeCfg = _cfgData

		return true
	end)

	return rangeIndex, rangeCfg
end

function ChallengeWorldBossModule.OnNotifyDup(dupPODList)
	if ChallengeWorldBossModule.__worldBossPODTable == nil then
		ChallengeWorldBossModule.__worldBossPODTable = {}
	end

	ForPairs(dupPODList, function(_, _dupPOD)
		ChallengeWorldBossModule.__worldBossPODTable[_dupPOD.cid] = _dupPOD
	end)
	EventDispatcher.Dispatch(EventID.OnWorldBossDupChange)
end

function ChallengeWorldBossModule.OnNotifyFinishDup(fightOverPOD)
	return
end

function ChallengeWorldBossModule.OnEnterStage(stageCid, units, agentSkill)
	ChallengeWorldBossModule.CacheFightingData = {}
	ChallengeWorldBossModule.CacheFightingData.stageCid = stageCid
	ChallengeWorldBossModule.CacheFightingData.totalDamage = 0

	net_worldBossDup.enterDup(stageCid, units, agentSkill)
end

function ChallengeWorldBossModule.OpenChallengeWorldBossUI()
	ChallengeWorldBossModule.SetCenterRankDataInvalidate()

	local getRankData = {}

	getRankData.count = 100
	getRankData.needUserData = true

	CenterRankModule.GetSelfRankGoalieData(Constant.CenterRankID.ChallengeWorldBoss, getRankData, ChallengeWorldBossModule.__DoOpenChallengeWorldBossUI, nil)
end

function ChallengeWorldBossModule.__DoOpenChallengeWorldBossUI(goalieData, args)
	local uiUserData = {}

	uiUserData.rankData = args.rankData
	uiUserData.goalieData = goalieData

	UIModule.Open(Constant.UIControllerName.ChallengeWorldBossUI, Constant.UILayer.UI, uiUserData)
end

function ChallengeWorldBossModule.OpenChallengeWorldBossRankUI()
	local getRankData = {}

	getRankData.count = 100
	getRankData.needUserData = true

	CenterRankModule.GetSelfRankGoalieData(Constant.CenterRankID.ChallengeWorldBoss, getRankData, ChallengeWorldBossModule.__DoOpenChallengeWorldBossRankUI, nil)
end

function ChallengeWorldBossModule.__DoOpenChallengeWorldBossRankUI(goalieData, args)
	local uiUserData = {}

	uiUserData.rankData = args.rankData
	uiUserData.goalieData = goalieData

	UIModule.Open(Constant.UIControllerName.ChallengeWorldBossRankUI, Constant.UILayer.UI, uiUserData)
end

function ChallengeWorldBossModule.OpenChallengeWorldBossRewardUI()
	local getRankData = {}

	getRankData.count = 100
	getRankData.needUserData = true

	CenterRankModule.GetRankData(Constant.CenterRankID.ChallengeWorldBoss, getRankData, ChallengeWorldBossModule.__DoOpenChallengeWorldBossRewardUI, nil)
end

function ChallengeWorldBossModule.__DoOpenChallengeWorldBossRewardUI(rankData, args)
	local uiUserData = {}

	uiUserData.rankData = rankData

	UIModule.Open(Constant.UIControllerName.ChallengeWorldBossRewardUI, Constant.UILayer.UI, uiUserData)
end
