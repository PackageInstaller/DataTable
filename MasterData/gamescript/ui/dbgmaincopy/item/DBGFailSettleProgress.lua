local DBGFailSettleProgress, Super = System.NewComponent("DBGFailSettleProgress")

function DBGFailSettleProgress:ctor(uiNode, isSucceess, isDailyChallenge)
  Super.ctor(self)
  self.ui = UI_Dungeons_Panel_OutResource(uiNode)
  self.isSucceess = isSucceess
  self.isDailyChallenge = isDailyChallenge
end

function DBGFailSettleProgress:OnBind(binder)
  self.binder = binder
  self:UpdateAwakerTrinkets()
  self:InitProgress()
  self:ResetMyAwakerList()
end

function DBGFailSettleProgress:InitProgress()
  if self.isSucceess then
    return
  end
  if not self.isDailyChallenge then
    self.ui.Group_Progress:SetActive(true)
  end
  local trainList = {
    "KeeperLevel",
    "Level",
    "SkillStandard",
    "WeaponStandard",
    "TrinketStandard"
  }
  local trainKeyList = {
    "keeperLevel",
    "level",
    "skillTrainValue",
    "weaponTrainValue",
    "trinketTainValue"
  }
  local trainTitleTextMap = {
    KeeperLevel = LT.Text("PlayerLv"),
    Level = LT.Text("TeamAverageLevel"),
    SkillStandard = LT.Text("TeamSkillStrength"),
    WeaponStandard = LT.Text("TeamWeaponStrength"),
    TrinketStandard = LT.Text("TeamTrinketStrength")
  }
  local uiNodeList = {
    self.isDailyChallenge and self.ui.Progress_Keeper_Lv_Daily or self.ui.Progress_Keeper_Lv,
    self.isDailyChallenge and self.ui.Progress_Lv_Daily or self.ui.Progress_Lv,
    self.isDailyChallenge and self.ui.Progress_Skill_Daily or self.ui.Progress_Skill,
    self.isDailyChallenge and self.ui.Progress_Weapons_Daily or self.ui.Progress_Weapons,
    self.isDailyChallenge and self.ui.Progress_Jewelry_Daily or self.ui.Progress_Jewelry
  }
  local standardValueList = self:GetStandardTrainValueData()
  local myAverageTrainList = self:GetMyAverageTrainList()
  for index, trainKey in ipairs(trainList) do
    local uiNode = uiNodeList[index]
    if 0 == standardValueList[trainKey] then
      uiNode:SetActive(false)
    else
      uiNode:SetActive(true)
      local progressValue = myAverageTrainList[trainKeyList[index]] / standardValueList[trainKey]
      local mainText = trainTitleTextMap[trainKey]
      local subText = ""
      if "Level" == trainKey then
        progressValue = self:GetAverageTeamLvProgress(myAverageTrainList[trainKeyList[index]], standardValueList[trainKey])
        local result = self:GetRecommendLv(myAverageTrainList[trainKeyList[index]], standardValueList[trainKey])
        subText = LT.Textf("TeamRecommendLevel", result)
      elseif "KeeperLevel" == trainKey then
        subText = LT.Textf("RecommendAccountLevel", standardValueList[trainKey])
      end
      self.binder:BindUIBehavior(uiNode, progressValue, mainText, subText)
    end
  end
  if not self:_CheckAwakerHaveTrinkets() then
    self.ui.Progress_Jewelry:SetActive(false)
    self.ui.Progress_Jewelry_Daily:SetActive(false)
  end
  self.ui.Progress_Weapons:SetActive(false)
  self.ui.Progress_Weapons_Daily:SetActive(false)
  self:ResetMyAwakerList()
end

function DBGFailSettleProgress:GetStandardTrainValueData()
  local settleData = DataCenter.copiesData.copiesSettleData or {}
  local stageId = settleData.stageId
  local stageLevel = MainCopyDataUtils.GetStageLevel(stageId)
  local cfg = DT.PracticeStandard[stageLevel]
  local cfgs = {
    KeeperLevel = stageLevel or 0,
    Level = cfg and cfg.Level or 0,
    SkillStandard = cfg and cfg.SkillStandard or 0,
    WeaponStandard = cfg and cfg.WeaponStandard or 0,
    TrinketStandard = cfg and cfg.TrinketStandard or 0
  }
  return cfgs
end

function DBGFailSettleProgress:_GetExtraLvUpperLimit()
  local myAwakerList = self:GetMyAwakerList()
  local extraLvUpperLimit = 0
  if myAwakerList and #myAwakerList > 0 then
    local awakerData = myAwakerList[1]
    if awakerData then
      local cfg = DT.LevelLimitIncrease[awakerData.tid]
      if cfg and cfg.data_list and cfg.data_list[#cfg.data_list] then
        extraLvUpperLimit = cfg.data_list[#cfg.data_list].LevelLimitIncreaseValue or 0
      end
    end
  end
  return extraLvUpperLimit
end

function DBGFailSettleProgress:GetAverageTeamLvProgress(teamAvergerLevel, recommandLevel)
  local extraLvUpperLimit = self:_GetExtraLvUpperLimit()
  local maxLv = DT.GetConstant("AwakerMaxLv") + extraLvUpperLimit
  if recommandLevel > maxLv then
    recommandLevel = maxLv
  end
  return teamAvergerLevel / recommandLevel
end

function DBGFailSettleProgress:GetRecommendLv(teamAvergerLevel, recommandLevel)
  local extraLvUpperLimit = self:_GetExtraLvUpperLimit()
  local maxLv = DT.GetConstant("AwakerMaxLv") + extraLvUpperLimit
  if recommandLevel > maxLv then
    return maxLv
  else
    return recommandLevel
  end
end

function DBGFailSettleProgress:GetMyAverageTrainList()
  local myAwakerList = self:GetMyAwakerList()
  local myTrainList = {
    keeperLevel = 0,
    level = 0,
    skillTrainValue = 0,
    weaponTrainValue = 0,
    trinketTainValue = 0
  }
  local assistItemDataMap = DataCenter.copiesData.ItemDataMap
  for _, awakerData in ipairs(myAwakerList) do
    if awakerData.tid == DataCenter.copiesData.AssistAwakerTid then
      awakerData.isAssist = true
    end
    local trainValue = AwakerDataUtils.GetAwakerTrainValue(awakerData.tid)
    local trinketTrainValue = AwakerDataUtils.GetAwakerTrinketTrainVallue(awakerData, assistItemDataMap)
    myTrainList.level = myTrainList.level + trainValue.level
    myTrainList.skillTrainValue = myTrainList.skillTrainValue + trainValue.skillTrainValue
    myTrainList.weaponTrainValue = myTrainList.weaponTrainValue + trainValue.weaponTrainValue
    myTrainList.trinketTainValue = myTrainList.trinketTainValue + trinketTrainValue
  end
  local myAwakerCount = #myAwakerList
  for k, v in pairs(myTrainList) do
    myTrainList[k] = v / myAwakerCount
  end
  myTrainList.keeperLevel = DataCenter.playerData.DRole.level
  return myTrainList
end

function DBGFailSettleProgress:UpdateAwakerTrinkets()
  local myAwakerList = self:GetMyAwakerList()
  local teamType = DataCenter.copiesData.copiesSettleData.teamType
  local teamIdx = DataCenter.copiesData.copiesSettleData.teamIdx
  local awaker2Trinkets = DBGTeamDataUtils.GetAwaker2TrinketsByTeamIdx(teamType, teamIdx)
  if not awaker2Trinkets then
    return
  end
  local assistAwakerItems = DataCenter.copiesData.ItemDataMap
  local assistAwakerTid = DataCenter.copiesData.AssistAwakerTid
  if assistAwakerItems and assistAwakerTid and 0 ~= assistAwakerTid then
    for uid, itemData in pairs(assistAwakerItems) do
      if not itemData then
      else
        local itemType = ItemDataUtils.GetItemType(itemData.tid)
        if itemType ~= CommonDefine.ItemType.Trinket then
        else
          if not awaker2Trinkets[assistAwakerTid] then
            awaker2Trinkets[assistAwakerTid] = {}
          end
          table.insert(awaker2Trinkets[assistAwakerTid], uid)
        end
      end
    end
  end
  for _, awakerData in ipairs(myAwakerList) do
    local awakerTid = awakerData.tid
    if not awakerTid then
    else
      local trinkets = awaker2Trinkets[awakerTid]
      if not trinkets then
      else
        awakerData.trinkets = trinkets
      end
    end
  end
end

function DBGFailSettleProgress:GetMyAwakerList()
  local awakerDataMap = DataCenter.copiesData.battleAwakerMap
  local myList = {}
  for _, awakerData in pairs(awakerDataMap) do
    local myAwakerData = AwakerDataUtils.GetAwakerData(awakerData.tid)
    if myAwakerData then
      table.insert(myList, myAwakerData)
    end
  end
  return myList
end

function DBGFailSettleProgress:_CheckAwakerHaveTrinkets()
  local awakerDataList = self:GetMyAwakerList()
  for _, awakerData in pairs(awakerDataList) do
    if not awakerData.trinkets or not table.next(awakerData.trinkets) then
      return false
    end
    for _, trinketUid in pairs(awakerData.trinkets) do
      if 0 ~= trinketUid then
        return true
      end
    end
  end
  return false
end

function DBGFailSettleProgress:ResetMyAwakerList()
  local myAwakerList = self:GetMyAwakerList()
  for _, awakerData in ipairs(myAwakerList) do
    if not awakerData then
    else
      awakerData.trinkets = {}
      awakerData.isAssist = nil
    end
  end
end

return DBGFailSettleProgress
