local GuideNotePermTrainingRankUi = {}
local SeasonGameplayType = CommonDefine.SeasonGameplayType

function GuideNotePermTrainingRankUi.BuildRankInfoBatchParams()
  local params = {}
  
  local function tryAdd(rankType, extraId)
    if not extraId or extraId <= 0 then
      return
    end
    table.insert(params, {type = rankType, extraId = extraId})
  end
  
  if SeasonRotationModel and SeasonRotationModel.Instance then
    tryAdd(RankDefine.RankType.SeasonRoPvpPrebuilt, SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpPreBuilt))
    tryAdd(RankDefine.RankType.SeasonRoPvpDraft, SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpDraft))
    tryAdd(RankDefine.RankType.SeasonRoRailWay, SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway))
  end
  local seasonIdDiving = 0
  if DailyChallengeModel and DailyChallengeModel.Instance and DailyChallengeModel.Instance.GetSeasonId then
    seasonIdDiving = DailyChallengeModel.Instance:GetSeasonId() or 0
  end
  if 0 == seasonIdDiving and SeasonRotationModel and SeasonRotationModel.Instance then
    seasonIdDiving = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessDiving) or 0
  end
  tryAdd(RankDefine.RankType.SeasonRoDailyChallenge, seasonIdDiving)
  local abyssActivityTid = 0
  if AbyssExtModel and AbyssExtModel.Instance and AbyssExtModel.Instance.GetCurrActivityTid then
    abyssActivityTid = AbyssExtModel.Instance:GetCurrActivityTid() or 0
  end
  tryAdd(RankDefine.RankType.AbyssChallenge, abyssActivityTid)
  return params
end

function GuideNotePermTrainingRankUi.RequestRankInfoBatch(callback)
  local params = GuideNotePermTrainingRankUi.BuildRankInfoBatchParams()
  if 0 == #params then
    if callback then
      callback()
    end
    return
  end
  RankController.Instance:QueryRankInfoBatch(params, callback)
end

function GuideNotePermTrainingRankUi.GetRewardRankDisplayParams(rankType, rankSubTid)
  local selfRank = RankDataUtils.GetSelfRank(rankType, rankSubTid)
  local rewardRankIndex = selfRank and selfRank.rewardRankIndex or 0
  if rewardRankIndex <= 0 then
    rewardRankIndex = selfRank and (selfRank.rank or selfRank.rankIndex) or 0
  end
  local playersNum = RankDataUtils.GetRankLength(rankType, rankSubTid) or 0
  if playersNum <= 0 and RankModel and RankModel.Instance and RankModel.Instance.GetRankLength then
    playersNum = RankModel.Instance:GetRankLength(rankType, rankSubTid) or 0
  end
  playersNum = math.max(playersNum, 100)
  return rewardRankIndex, playersNum
end

function GuideNotePermTrainingRankUi.HideRankTitleSlots(view, divingTitleNode, scrollView, textRankNode)
  if divingTitleNode then
    view:SetActive(divingTitleNode, false)
  end
  if scrollView then
    view:SetActive(scrollView, false)
  end
  if textRankNode then
    textRankNode:SetActive(false)
  end
end

function GuideNotePermTrainingRankUi.GetRankTierDisplayData(args)
  local rewardRankIndex = args.rewardRankIndex
  local seasonId = args.seasonId
  local gameplayType = args.gameplayType
  local playersNum = args.playersNum
  local rankType = args.rankType
  local rankSubTid = args.rankSubTid
  if not rewardRankIndex or rewardRankIndex <= 0 then
    return nil
  end
  if seasonId and seasonId > 0 and SeasonRotationModel and SeasonRotationModel.Instance then
    local row = SeasonRotationModel.Instance:GetSeasonRankRewardRowByRewardIndex(seasonId, gameplayType, rewardRankIndex, playersNum)
    if row and row.Name then
      return {
        hasData = true,
        rankName = LT.Text(row.Name),
        rankIcon = row.RankIcon
      }
    end
  end
  if rankType and RankModel and RankModel.Instance then
    local rankCfg = RankModel.Instance:GetRankCfgByRewardIndex(rankType, rankSubTid, rewardRankIndex)
    if rankCfg and rankCfg.Name then
      return {
        hasData = true,
        rankName = LT.Text(rankCfg.Name),
        rankIcon = rankCfg.RankIcon
      }
    end
  end
  return nil
end

function GuideNotePermTrainingRankUi.ApplyRankRewardVisibility(view, scrollView, groupRankReward, hasData)
  if scrollView then
    view:SetActive(scrollView, hasData)
  end
  if groupRankReward then
    view:SetActive(groupRankReward, hasData)
  end
end

function GuideNotePermTrainingRankUi.ApplyRankTitle(view, divingTitleNode, rankData)
  if not divingTitleNode then
    return
  end
  if not rankData or rankData.hasData ~= true then
    view:SetActive(divingTitleNode, false)
    return
  end
  view:SetActive(divingTitleNode, true)
  UIComDungeonsDivingTitle.BindByTitleData(view.binder, divingTitleNode, {
    titleText = rankData.rankName,
    titleIcon = rankData.rankIcon,
    width = 325
  })
end

function GuideNotePermTrainingRankUi.ApplyRankTextFallback(view, scrollView, textRankNode, rankData)
  if rankData and rankData.hasData then
    local rankName = rankData.rankName
    local isSet = false
    if scrollView then
      local textComp = view:FindChildTextComponent(scrollView, "Text_Rank")
      if textComp then
        view:SetText(textComp.gameObject, rankName)
        textComp.gameObject:SetActive(true)
        isSet = true
      end
    end
    if true ~= isSet and textRankNode then
      view:SetText(textRankNode, rankName)
      textRankNode:SetActive(true)
    end
    return
  end
  if scrollView then
    local textComp = view:FindChildTextComponent(scrollView, "Text_Rank")
    if textComp then
      textComp.gameObject:SetActive(false)
      return
    end
  end
  if textRankNode then
    textRankNode:SetActive(false)
  end
end

function GuideNotePermTrainingRankUi.GetCurrentRankPrizeRewards(seasonId, gameplayType, rankType, rewardRankIndex, playersNum)
  if not (rewardRankIndex and not (rewardRankIndex <= 0) and seasonId) or seasonId <= 0 then
    return {}
  end
  local raw = {}
  if SeasonRotationModel and SeasonRotationModel.Instance then
    local row = SeasonRotationModel.Instance:GetSeasonRankRewardRowByRewardIndex(seasonId, gameplayType, rewardRankIndex, playersNum)
    if row and row.Name then
      raw = RankingBoardDataUtils.GetSeasonRankRowRewards(row)
    end
  end
  if (not raw or 0 == #raw) and rankType then
    local rankCfg = RankModel and RankModel.Instance and RankModel.Instance:GetRankCfgByRewardIndex(rankType, seasonId, rewardRankIndex)
    if rankCfg and rankCfg.Name then
      local fakeRow = {
        NewRankReward = {}
      }
      for tid, count in pairs(rankCfg.CoinReward or {}) do
        fakeRow.NewRankReward[tid] = count
      end
      for tid, count in pairs(rankCfg.GoldReward or {}) do
        fakeRow.NewRankReward[tid] = count
      end
      raw = RankingBoardDataUtils.GetSeasonRankRowRewards(fakeRow)
    end
  end
  do return GuideNotePermTrainingRewardMerge.MergeRewardsByTid end
  return GuideNotePermTrainingRewardMerge.MergeRewardsByTid, raw or {}, RankingBoardDataUtils.GetSeasonRankRowRewards(fakeRow), fakeRow, pairs(rankCfg.GoldReward or {})
end

return GuideNotePermTrainingRankUi
