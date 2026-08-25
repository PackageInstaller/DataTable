local TeamStageTipUtils = {}

function TeamStageTipUtils.GetTeamBuildContext(model, getBonusCardDes)
  return {
    stageCfg = model.stageCfg,
    isAbyssChallenge = function()
      do return model.IsAbyssChallenge end
      return model.IsAbyssChallenge, model
    end,
    specialTeamForbids = model.specialTeamForbids,
    getBonusCardDes = getBonusCardDes,
    getAssistAwaker = function()
      do return model.GetAssistAwaker end
      return model.GetAssistAwaker, model
    end,
    getStageLevelAjustType = function()
      do return model.GetStageLevelAjustType end
      return model.GetStageLevelAjustType, model
    end,
    isForceAssistStage = function()
      do return model.IsForceAssistStage end
      return model.IsForceAssistStage, model
    end
  }
end

function TeamStageTipUtils.GetSweepContext(stageCfg)
  local stageGroupTid = stageCfg and stageCfg.BelongGroup or 0
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  return {
    stageCfg = stageCfg,
    isAbyssChallenge = function()
      return stageGroupCfg and stageGroupCfg.Type == CommonDefine.StageGroupType.AbyssChallenge
    end,
    specialTeamForbids = TeamAssignDataUtils.GetSpecialTeamForbids(stageCfg and stageCfg.SpecialTeamIndex),
    getBonusCardDes = function()
      do return TeamStageTipUtils.GetSweepBonusCardDes end
      return TeamStageTipUtils.GetSweepBonusCardDes, stageCfg
    end,
    getAssistAwaker = function()
      return nil
    end,
    getStageLevelAjustType = function()
      return CommonDefine.StageAjustType.AdjustAwakerAndPlayer
    end,
    isForceAssistStage = function()
      do return CopyDataUtils.IsForceAssistStageGroup end
      return CopyDataUtils.IsForceAssistStageGroup, stageGroupTid
    end,
    getActivityBonusPercent = function()
      do return TeamStageTipUtils.GetSweepActivityBonusPercent end
      return TeamStageTipUtils.GetSweepActivityBonusPercent, stageCfg
    end,
    getActivityBonusSourceTitle = function()
      local tips = stageGroupCfg and stageGroupCfg.BonusTips
      local key = tips and tips[2]
      return key and LT.Text(key) or nil
    end,
    getActivityBonusTagText = function()
      do return BonusCardModel.Instance.GetBonusRewardTagText, BonusCardModel.Instance end
      return BonusCardModel.Instance.GetBonusRewardTagText, BonusCardModel.Instance, stageGroupTid
    end
  }
end

function TeamStageTipUtils.GetSweepActivityBonusPercent(stageCfg)
  if not stageCfg then
    return nil
  end
  local isCrazy = stageCfg.DailyChallengeMadnessDifficulty and 1 == stageCfg.DailyChallengeMadnessDifficulty or false
  if isCrazy then
    return nil
  end
  local stageGroupTid = stageCfg.BelongGroup or 0
  do return BonusCardModel.Instance.GetBonusRateByStageGroupTid, BonusCardModel.Instance, stageGroupTid, nil end
  return BonusCardModel.Instance.GetBonusRateByStageGroupTid, BonusCardModel.Instance, stageGroupTid, nil, nil
end

function TeamStageTipUtils.IsExpItemExcludedFromSweepActivityBonus(itemTid)
  if not itemTid then
    return true
  end
  if itemTid == CommonDefine.CurrencyType.PlayerExp then
    return true
  end
  if itemTid == CommonDefine.CurrencyType.AwakerUpgradeExp then
    return true
  end
  if itemTid == CommonDefine.CurrencyType.BpExp then
    return true
  end
  local accountExpTid = DT.GetConstant("AccountExpItemTid")
  if accountExpTid and itemTid == accountExpTid then
    return true
  end
  local itemCfg = ItemCfgUtils.GetCfg(itemTid)
  if itemCfg and itemCfg.SubType == CommonDefine.ItemSubType.ExpBonus then
    return true
  end
  return false
end

function TeamStageTipUtils.ApplySweepActivityBonusRewardSplit(rewardList, stageCfg)
  local expandedList = {}
  for _, reward in ipairs(rewardList or {}) do
    local itemCfg = ItemCfgUtils.GetCfg(reward.tid)
    local itemType = itemCfg and itemCfg.Type
    local dropItemType = CommonDefine.ItemType.DropItem
    local isDropItem = itemCfg and itemType == dropItemType
    if isDropItem then
      local dropItemInfoList = ItemCfgUtils.GetRandomAbsolutelyDropItemInfoList(reward.tid)
      if dropItemInfoList and #dropItemInfoList > 0 then
        for _, info in ipairs(dropItemInfoList) do
          local dropReward = table.clone(reward)
          dropReward.tid = info.tid
          dropReward.num = info.num
          table.insert(expandedList, dropReward)
        end
      else
        table.insert(expandedList, reward)
      end
    else
      table.insert(expandedList, reward)
    end
  end
  local rate = TeamStageTipUtils.GetSweepActivityBonusPercent(stageCfg)
  if not rate or rate <= 0 then
    return expandedList
  end
  local stageGroupTid = stageCfg and stageCfg.BelongGroup or 0
  local tagText = BonusCardModel.Instance:GetBonusRewardTagText(stageGroupTid)
  if not tagText or "" == tagText then
    return expandedList
  end
  local bonusItemSet = {}
  local stageGroupCfg = stageGroupTid and DT.StageGroup[stageGroupTid]
  if stageGroupCfg and stageGroupCfg.Bonus then
    for _, bonusTid in ipairs(stageGroupCfg.Bonus) do
      local bonusCfg = DT.Bonus[bonusTid]
      if bonusCfg and bonusCfg.BonusItem then
        bonusItemSet[bonusCfg.BonusItem] = true
      end
    end
  end
  local out = {}
  for _, reward in ipairs(expandedList) do
    table.insert(out, reward)
    local isNormal = reward.type == CommonDefine.ItemAwardType.Normal
    local isExpExcluded = TeamStageTipUtils.IsExpItemExcludedFromSweepActivityBonus(reward.tid)
    local inBonusSet = bonusItemSet[reward.tid]
    local hasNum = reward.num and reward.num > 0
    if isNormal and not isExpExcluded and inBonusSet and hasNum then
      local extraNum = math.floor(reward.num * rate / 100)
      if extraNum > 0 then
        local bonusReward = table.clone(reward)
        bonusReward.num = extraNum
        bonusReward.activityBonusTagText = tagText
        bonusReward.isGot = false
        table.insert(out, bonusReward)
      end
    end
  end
  return out
end

function TeamStageTipUtils.GetSweepBonusCardDes(stageCfg)
  local bonusRate = TeamStageTipUtils.GetSweepActivityBonusPercent(stageCfg)
  if not bonusRate then
    return nil
  end
  local stageGroupTid = stageCfg and stageCfg.BelongGroup or 0
  local rateText = bonusRate .. "%%"
  do return BonusCardModel.Instance.GetBonusShortTips, BonusCardModel.Instance, stageGroupTid end
  return BonusCardModel.Instance.GetBonusShortTips, BonusCardModel.Instance, stageGroupTid, rateText
end

function TeamStageTipUtils.GetIllustrateTipsAndTitle(ctx)
  if ctx.isAbyssChallenge and ctx.isAbyssChallenge() then
    return LT.Text("AbyssChallengeAwakerAssistRule"), LT.Text("AbyssChallengeAwakerAssistRuleTitle")
  end
  local stageCfg = ctx.stageCfg
  local stageGroupTid = stageCfg and stageCfg.BelongGroup or 0
  local title, content = BonusCardModel.Instance:GetBonusTipsViewContent(stageGroupTid)
  if title and content then
    return content, title
  end
  local ajustType = ctx.getStageLevelAjustType and ctx.getStageLevelAjustType()
  local assist = ctx.getAssistAwaker and ctx.getAssistAwaker()
  if ajustType and assist then
    do return LT.Text end
    return LT.Text, "DeepSeaInvasionDefensiveActiviityTips13"
  end
  return nil, nil
end

function TeamStageTipUtils.GetDisableTip(ctx)
  local disbleTip
  local forbids = ctx.specialTeamForbids or {}
  local dunhao = LT.GetComma()
  local needSpace = DataCenter.gameData.CurrTextLanguage == CommonDefine.Lang.EN
  if needSpace then
    dunhao = dunhao .. " "
  end
  if #forbids > 0 then
    local forbidNames = ""
    local total = #forbids
    for i, awakerTid in ipairs(forbids) do
      local awakerCfg = DT.AwakerConfig[awakerTid]
      if awakerCfg then
        if i ~= total then
          forbidNames = string.format("%s%s%s", forbidNames, LT.Text(awakerCfg.Name), dunhao)
        else
          forbidNames = string.format("%s%s", forbidNames, LT.Text(awakerCfg.Name))
        end
      end
    end
    disbleTip = LT.Textf("SpecialTeamBanTips", forbidNames)
  end
  local forceAssist = ctx.isForceAssistStage and ctx.isForceAssistStage()
  local assist = ctx.getAssistAwaker and ctx.getAssistAwaker()
  if forceAssist and not assist then
    disbleTip = LT.Text("ForceAssistTeam")
  end
  return disbleTip
end

function TeamStageTipUtils.GetNormalTip(ctx)
  local stageCfg = ctx.stageCfg
  local stageGroupTid = stageCfg and stageCfg.BelongGroup or 0
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  local bonusDes = ctx.getBonusCardDes and ctx.getBonusCardDes()
  if bonusDes then
    return bonusDes
  end
  if stageGroupCfg and stageGroupCfg.Type == CommonDefine.StageGroupType.RailWay then
    local title, _ = BonusCardModel.Instance:GetBonusTipsViewContent(stageGroupTid)
    return title
  end
  local getStageLevelAjustType = ctx.getStageLevelAjustType
  if getStageLevelAjustType and getStageLevelAjustType() then
    local normalTip
    local ajustType = getStageLevelAjustType()
    local forceAssist = ctx.isForceAssistStage and ctx.isForceAssistStage()
    local assist = ctx.getAssistAwaker and ctx.getAssistAwaker()
    if forceAssist and assist then
      if ajustType == CommonDefine.StageAjustType.AdjustAwaker then
        normalTip = LT.Text("DeepSeaInvasionDefensiveActiviityTips10")
      elseif ajustType == CommonDefine.StageAjustType.AdjustPlayer then
        normalTip = LT.Text("DeepSeaInvasionDefensiveActiviityTips11")
      elseif ajustType == CommonDefine.StageAjustType.AdjustAwakerAndPlayer then
        normalTip = LT.Text("DeepSeaInvasionDefensiveActiviityTips12")
      end
    end
    return normalTip
  end
  local needFightAwakerTid = TeamAssignDataUtils.GetIsOwnedAwakerTid(stageCfg and stageCfg.SpecialTeamIndex)
  if needFightAwakerTid then
    do return LT.Textf, "TeamNeedFightAwakerTips", LT.Text(AwakerDataUtils.GetAwakerName(needFightAwakerTid)) end
    return LT.Textf, "TeamNeedFightAwakerTips", LT.Text(AwakerDataUtils.GetAwakerName(needFightAwakerTid))
  end
end

function TeamStageTipUtils.GetTextTip(ctx)
  local disableTip = TeamStageTipUtils.GetDisableTip(ctx)
  if disableTip then
    return disableTip
  end
  do return TeamStageTipUtils.GetNormalTip end
  return TeamStageTipUtils.GetNormalTip, ctx
end

function TeamStageTipUtils.HasTextTip(ctx)
  local tip = TeamStageTipUtils.GetTextTip(ctx)
  return nil ~= tip and "" ~= tip
end

function TeamStageTipUtils.HasIllustrateTip(ctx)
  local content = TeamStageTipUtils.GetIllustrateTipsAndTitle(ctx)
  return nil ~= content
end

function TeamStageTipUtils.HasAnyTip(ctx)
  return TeamStageTipUtils.HasIllustrateTip(ctx) or TeamStageTipUtils.HasTextTip(ctx)
end

function TeamStageTipUtils.BindIllustrateButton(binder, button, getContext, useZ1Button)
  binder:BindToVisible(button, function()
    do return TeamStageTipUtils.HasIllustrateTip, getContext() end
    return TeamStageTipUtils.HasIllustrateTip, getContext()
  end)
  
  local function clickFunc()
    local content, title = TeamStageTipUtils.GetIllustrateTipsAndTitle(getContext())
    if content then
      UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
    end
  end
  
  if useZ1Button then
    binder:BindZ1Button(button, clickFunc)
  else
    binder:BindButtonClick(button, clickFunc)
  end
end

function TeamStageTipUtils.BindSingleTextTip(binder, text, getContext)
  binder:BindToVisible(text, function()
    do return TeamStageTipUtils.HasTextTip, getContext() end
    return TeamStageTipUtils.HasTextTip, getContext()
  end)
  binder:BindToText(text, function()
    return TeamStageTipUtils.GetTextTip(getContext()) or ""
  end)
end

function TeamStageTipUtils.BindDisableAndNormalTip(binder, disableText, normalText, getContext)
  binder:BindToVisible(disableText, function()
    return TeamStageTipUtils.GetDisableTip(getContext()) ~= nil
  end)
  binder:BindToText(disableText, function()
    do return TeamStageTipUtils.GetDisableTip, getContext() end
    return TeamStageTipUtils.GetDisableTip, getContext()
  end)
  binder:BindToVisible(normalText, function()
    local ctx = getContext()
    return not TeamStageTipUtils.GetDisableTip(ctx) and TeamStageTipUtils.GetNormalTip(ctx)
  end)
  binder:BindToText(normalText, function()
    do return TeamStageTipUtils.GetNormalTip, getContext() end
    return TeamStageTipUtils.GetNormalTip, getContext()
  end)
end

return TeamStageTipUtils
