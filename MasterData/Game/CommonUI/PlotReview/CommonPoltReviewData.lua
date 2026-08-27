local CommonPoltReviewData = class("CommonPoltReviewData")
local SectorEnum = require("Game.Sector.SectorEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local CommonPoltReviewGroupData = require("Game.CommonUI.PlotReview.CommonPoltReviewGroupData")

function CommonPoltReviewData.Create4CharAct(heroGrowCfg)
  local CPRData = CommonPoltReviewData.New()
  CPRData:SetCPRBgResName(heroGrowCfg.story_review_bg, true)
  
  local function __CreateAvgItem(avgCfg, avgPlayCtrl)
    local avgId = avgCfg.id
    local avgCfg = ConfigData.story_avg[avgId]
    local groupENName = string.format(SectorEnum.SectorAvgItemDesc[SectorEnum.eSectorLevelItemType.Normal], tostring(avgCfg.number))
    local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
    local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
    local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, {avgId})
    if avgPlayCtrl:IsAvgUnlock(avgId) then
      CPRGroupData:SetAvgGroupDataIsUnlock(true)
      CPRGroupData:SetAvgGroupDataBlueDotFunc(function()
        return not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetHeroGrowAvgReview(heroGrowCfg.id, avgId)
      end)
      CPRGroupData:SetAvgGroupDataOperateData(function()
        PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetHeroGrowAvgReview(heroGrowCfg.id, avgId)
      end)
      CPRData:AddAvgGroup(CPRGroupData)
      return true
    end
    local str1, str2
    str1 = groupName
    str2 = groupENName
    local stageId = ControllerManager:GetController(ControllerTypeId.AvgPlay):GetPreUnlockSectorStage(avgId)
    if stageId ~= nil then
      local stageCfg = ConfigData.sector_stage[stageId]
      if stageCfg ~= nil then
        str2 = string.format(SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.OnlyNumber], tostring(stageCfg.num))
        local sectorCfg = ConfigData.sector[stageCfg.sector]
        str1 = LanguageUtil.GetLocaleText(sectorCfg.name)
      end
    end
    local unlockDes = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7304)), str1, str2)
    CPRGroupData:SetAvgGroupDataIsUnlock(false, unlockDes)
    CPRData:AddAvgGroup(CPRGroupData)
    return false
  end
  
  local function __CreateStageItem(stageId, stageAvgList)
    local stageCfg = ConfigData.sector_stage[stageId]
    local sectorCfg = ConfigData.sector[stageCfg.sector]
    local groupENName = string.format(SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.OnlyNumber], tostring(stageCfg.num))
    local groupName = LanguageUtil.GetLocaleText(stageCfg.name)
    local groupDes = LanguageUtil.GetLocaleText(stageCfg.story_review_introduce)
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, stageAvgList)
    if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
      CPRGroupData:SetAvgGroupDataIsUnlock(true)
      CPRGroupData:SetAvgGroupDataBlueDotFunc(function()
        return not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetHeroGrowAvgReview(heroGrowCfg.id, stageId)
      end)
      CPRGroupData:SetAvgGroupDataOperateData(function()
        PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetHeroGrowAvgReview(heroGrowCfg.id, stageId)
      end)
      CPRData:AddAvgGroup(CPRGroupData)
      return true
    end
    local unlockDes = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7304)), sectorName, groupENName)
    CPRGroupData:SetAvgGroupDataIsUnlock(false, unlockDes)
    CPRData:AddAvgGroup(CPRGroupData)
    return false
  end
  
  local mainSectorId = heroGrowCfg.main_stage
  local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[mainSectorId][SectorLevelDetailEnum.eDifficulty.normal]
  local totalCount = 0
  local unLockCount = 0
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for _, stageId in ipairs(sectorStageCfg) do
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 1)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1, i)
      if avgCfg ~= nil then
        totalCount = totalCount + 1
        if __CreateAvgItem(avgCfg, avgPlayCtrl) then
          unLockCount = unLockCount + 1
        end
      end
    end
    local stageAvgList = ConfigData.story_avg.stageAvgDic[stageId]
    if stageAvgList ~= nil then
      totalCount = totalCount + 1
      if __CreateStageItem(stageId, stageAvgList) then
        unLockCount = unLockCount + 1
      end
    end
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 2)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2, i)
      if avgCfg ~= nil then
        totalCount = totalCount + 1
        if __CreateAvgItem(avgCfg, avgPlayCtrl) then
          unLockCount = unLockCount + 1
        end
      end
    end
  end
  CPRData:SetCPRUnlockNum(totalCount, unLockCount)
  return CPRData
end

function CommonPoltReviewData.Create4CarnivalACt(carnivalCfg)
  local CPRData = CommonPoltReviewData.New()
  local mainSectorId = carnivalCfg.main_stage
  local sectorCfg = ConfigData.sector[mainSectorId]
  local bgRes = sectorCfg.pic_big
  bgRes = PathConsts:GetSectorBackgroundPath(bgRes)
  CPRData:SetCPRBgResName(bgRes, false)
  CPRData:SetCPRBgResAllScreen(true)
  
  local function __CreateAvgItem(avgCfg, avgPlayCtrl)
    local avgId = avgCfg.id
    local avgCfg = ConfigData.story_avg[avgId]
    local groupENName = string.format(SectorEnum.SectorAvgItemDesc[SectorEnum.eSectorLevelItemType.Normal], tostring(avgCfg.number))
    local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
    local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
    local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, {avgId})
    if avgPlayCtrl:IsAvgUnlock(avgId) then
      CPRGroupData:SetAvgGroupDataIsUnlock(true)
      CPRGroupData:SetAvgGroupDataBlueDotFunc(function()
        return not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetCarnivalAvg(carnivalCfg.id, avgId)
      end)
      CPRGroupData:SetAvgGroupDataOperateData(function()
        PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetCarnivalAvg(carnivalCfg.id, avgId)
      end)
      CPRData:AddAvgGroup(CPRGroupData)
      return true
    end
    local str1, str2
    str1 = groupName
    str2 = groupENName
    local stageId = ControllerManager:GetController(ControllerTypeId.AvgPlay):GetPreUnlockSectorStage(avgId)
    if stageId ~= nil then
      local stageCfg = ConfigData.sector_stage[stageId]
      if stageCfg ~= nil then
        str2 = string.format(SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.OnlyNumber], tostring(stageCfg.num))
        local sectorCfg = ConfigData.sector[stageCfg.sector]
        str1 = LanguageUtil.GetLocaleText(sectorCfg.name)
      end
    end
    local unlockDes = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7304)), str1, str2)
    CPRGroupData:SetAvgGroupDataIsUnlock(false, unlockDes)
    CPRData:AddAvgGroup(CPRGroupData)
    return false
  end
  
  local function __CreateStageItem(stageId, stageAvgList)
    local stageCfg = ConfigData.sector_stage[stageId]
    local sectorCfg = ConfigData.sector[stageCfg.sector]
    local groupENName = string.format(SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.OnlyNumber], tostring(stageCfg.num))
    local groupName = LanguageUtil.GetLocaleText(stageCfg.name)
    local groupDes = LanguageUtil.GetLocaleText(stageCfg.story_review_introduce)
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, stageAvgList)
    if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
      CPRGroupData:SetAvgGroupDataIsUnlock(true)
      CPRGroupData:SetAvgGroupDataBlueDotFunc(function()
        return not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetCarnivalAvg(carnivalCfg.id, stageId)
      end)
      CPRGroupData:SetAvgGroupDataOperateData(function()
        PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetCarnivalAvg(carnivalCfg.id, stageId)
      end)
      CPRData:AddAvgGroup(CPRGroupData)
      return true
    end
    local unlockDes = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7304)), sectorName, groupENName)
    CPRGroupData:SetAvgGroupDataIsUnlock(false, unlockDes)
    CPRData:AddAvgGroup(CPRGroupData)
    return false
  end
  
  local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[mainSectorId][SectorLevelDetailEnum.eDifficulty.normal]
  local totalCount = 0
  local unLockCount = 0
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for _, stageId in ipairs(sectorStageCfg) do
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 1)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1, i)
      if avgCfg ~= nil then
        totalCount = totalCount + 1
        if __CreateAvgItem(avgCfg, avgPlayCtrl) then
          unLockCount = unLockCount + 1
        end
      end
    end
    local stageAvgList = ConfigData.story_avg.stageAvgDic[stageId]
    if stageAvgList ~= nil then
      totalCount = totalCount + 1
      if __CreateStageItem(stageId, stageAvgList) then
        unLockCount = unLockCount + 1
      end
    end
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 2)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2, i)
      if avgCfg ~= nil then
        totalCount = totalCount + 1
        if __CreateAvgItem(avgCfg, avgPlayCtrl) then
          unLockCount = unLockCount + 1
        end
      end
    end
  end
  CPRData:SetCPRUnlockNum(totalCount, unLockCount)
  return CPRData
end

function CommonPoltReviewData.Create4CharActV3(actId)
  local CPRData = CommonPoltReviewData.New()
  local heroliteCfg = ConfigData.activity_herolite_ui_config[actId]
  if heroliteCfg ~= nil then
    CPRData:SetCPRBgResName(heroliteCfg.story_review_bg, true)
  end
  local cfgs = ConfigData.activity_herolite_avg[actId]
  
  local function __CreateAvgItem(avgCfg, avgPlayCtrl)
    local avgId = avgCfg.id
    local avgCfg = ConfigData.story_avg[avgId]
    local groupENName = string.format(SectorEnum.SectorAvgItemDesc[SectorEnum.eSectorLevelItemType.Normal], tostring(avgCfg.number))
    local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
    local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
    local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, {avgId})
    if avgPlayCtrl:IsAvgUnlock(avgId) then
      CPRGroupData:SetAvgGroupDataIsUnlock(true)
      CPRGroupData:SetAvgGroupDataBlueDotFunc(function()
        return not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetHeroGrowV3AvgReview(actId, avgId)
      end)
      CPRGroupData:SetAvgGroupDataOperateData(function()
        PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetHeroGrowV3AvgReview(actId, avgId)
      end)
      CPRData:AddAvgGroup(CPRGroupData)
      return true
    end
    local str1, str2
    str1 = groupName
    str2 = groupENName
    local stageId = ControllerManager:GetController(ControllerTypeId.AvgPlay):GetPreUnlockSectorStage(avgId)
    if stageId ~= nil then
      local stageCfg = ConfigData.sector_stage[stageId]
      if stageCfg ~= nil then
        str2 = string.format(SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.OnlyNumber], tostring(stageCfg.num))
        local sectorCfg = ConfigData.sector[stageCfg.sector]
        str1 = LanguageUtil.GetLocaleText(sectorCfg.name)
      end
    end
    local avgCfg = cfgs[avgId]
    local unlockDes = LanguageUtil.GetLocaleText(avgCfg.text)
    CPRGroupData:SetAvgGroupDataIsUnlock(false, unlockDes)
    CPRData:AddAvgGroup(CPRGroupData)
    return false
  end
  
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local ids = {}
  for k, v in pairs(cfgs) do
    table.insert(ids, v.avg_id)
  end
  table.sort(ids)
  local totalCount = 0
  local unLockCount = 0
  for _, avgId in ipairs(ids) do
    local avgCfg = ConfigData.story_avg[avgId]
    if avgCfg ~= nil then
      totalCount = totalCount + 1
      if __CreateAvgItem(avgCfg, avgPlayCtrl) then
        unLockCount = unLockCount + 1
      end
    end
  end
  CPRData:SetCPRUnlockNum(totalCount, unLockCount)
  return CPRData
end

function CommonPoltReviewData:ctor()
  self.bgResName = nil
  self.isCharBg = false
  self.totalNum4Show = nil
  self.totalUnlockedNum4Show = nil
  self.avgGroupList = nil
end

function CommonPoltReviewData:SetCPRBgResName(bgResName, isCharBg)
  self.bgResName = bgResName
  self.isCharBg = isCharBg
end

function CommonPoltReviewData:SetCPRBgResAllScreen(isAllScreen)
  self.isAllScreen = isAllScreen
end

function CommonPoltReviewData:SetCPRTitleName(titleName)
  self.titleName = titleName
end

function CommonPoltReviewData:SetCPRUnlockNum(totalNum4Show, totalUnlockedNum4Show)
  self.totalNum4Show = totalNum4Show
  self.totalUnlockedNum4Show = totalUnlockedNum4Show
end

function CommonPoltReviewData:AddAvgGroup(CPRGroupData)
  if self.avgGroupList == nil then
    self.avgGroupList = {}
  end
  table.insert(self.avgGroupList, CPRGroupData)
end

function CommonPoltReviewData:GetCPRBgResName()
  return self.bgResName, self.isCharBg
end

function CommonPoltReviewData:GetCPRTitleName()
  return self.titleName
end

function CommonPoltReviewData:GetCPRBgIsAllScreen()
  return self.isAllScreen
end

function CommonPoltReviewData:GetCPRAvgGroupList()
  if self.avgGroupList == nil then
    self.avgGroupList = {}
  end
  return self.avgGroupList
end

function CommonPoltReviewData:GetCPRAvgGroupUnlockNum()
  return self.totalNum4Show, self.totalUnlockedNum4Show
end

function CommonPoltReviewData:RemoveDuplicatedAvgGroupList()
  local removedCount, removedUnlockCount
  if self.avgGroupList ~= nil and #self.avgGroupList > 1 then
    local firstAvgGD = self.avgGroupList[1]
    local secondAvgGD = self.avgGroupList[2]
    local firstAvgId = firstAvgGD:GetAvgGroupAvgIdList()[1]
    local secondAvgId = secondAvgGD:GetAvgGroupAvgIdList()[1]
    local firstAvgCfg = ConfigData.story_avg[firstAvgId]
    local secondAvgCfg = ConfigData.story_avg[secondAvgId]
    if firstAvgCfg.group_id == secondAvgCfg.group_id then
      table.removebyvalue(self.avgGroupList, firstAvgGD)
      removedCount = 1
      if firstAvgGD:GetAvgGroupIsUnlock() then
        removedUnlockCount = 1
      end
    end
  end
  return removedCount or 0, removedUnlockCount or 0
end

return CommonPoltReviewData
