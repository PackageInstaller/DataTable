local UISectorLevelDetail = class("UISectorLevelDetail", UIBaseWindow)
local base = UIBaseWindow
local UINLevelDetail = require("Game.Sector.SectorLevelDetail.UINLevelDtail")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local LevelDetailExtrData = require("Game.Sector.SectorLevelDetail.LevelDetailExtrData")
local cs_MessageCommon = CS.MessageCommon

function UISectorLevelDetail:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBack)
  self.resloader = CS.ResLoader.Create()
  self.levelDetailNode = UINLevelDetail.New()
  self.levelDetailNode:Init(self.ui.detailNode)
  self.levelDetailNode:InitLevelDtail(self.resloader)
  self.isPushBack2Stack = false
  self.ui.tex_Tips.gameObject:SetActive(false)
end

function UISectorLevelDetail:CloseLvDetailShowAudio()
  self.levelDetailNode:CloseLvDetailNodeShowAudio()
end

function UISectorLevelDetail:InitSectorLevelDetail(sectorId, sectorStageId, isLocked, levelDetailExtrData)
  local stageCfg = ConfigData.sector_stage[sectorStageId]
  if stageCfg == nil then
    error("Can't find sector stageCfg, stageId = " .. tostring(sectorStageId))
    return
  end
  local sectorCfg = ConfigData.sector[stageCfg.sector]
  if sectorCfg.sector_type == SectorLevelDetailEnum.eSectorType.WarChess then
    self:__InitWarchessDetailNode(sectorId, stageCfg, isLocked)
  elseif stageCfg.is_warchess then
    self:__InitWarchessDetailNode(sectorId, stageCfg, isLocked, levelDetailExtrData)
  elseif stageCfg.is_brotato then
    self:__InitBrotatoDetailNode(sectorId, stageCfg, isLocked, levelDetailExtrData)
  else
    self:__InitNormalDetailNode(sectorId, stageCfg, isLocked, levelDetailExtrData)
  end
  self:Refresh_NodeCouldReviewStoryList(levelDetailExtrData)
end

function UISectorLevelDetail:InitSectorLevelAvgDetail(sectorId, avgCfg, playAvgCompleteFunc, isLocked, levelDetailExtrData)
  self:CleanLastDetail()
  if self.isPushBack2Stack then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnClickSectorLevelDetailBackBtn):SetTopStatusResData({
    ConstGlobalItem.SKey
  }):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(sectorId, avgCfg.id, SectorLevelDetailEnum.eDetailType.Avg)
  self.levelDetailNode:SetLevelDetailExtrData2Node(levelDetailExtrData)
  self.levelDetailNode:InitAvgDetail(avgCfg, playAvgCompleteFunc, sectorId, isLocked)
  self.ui.tex_Tips.gameObject:SetActive(false)
  self:Refresh_NodeCouldReviewStoryList(levelDetailExtrData)
end

function UISectorLevelDetail:InitInfinityLevelDetailNode(sectorId, levelData, levelDetailExtrData)
  self:CleanLastDetail()
  if self.isPushBack2Stack then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnClickSectorLevelDetailBackBtn):SetTopStatusResData({
    ConstGlobalItem.SKey
  }):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(sectorId)
  self.levelDetailNode:InitInfinityLevelDetailNode(levelData, sectorId)
  self:Refresh_NodeCouldReviewStoryList(levelDetailExtrData)
  self.ui.tex_Tips.gameObject:SetActive(true)
  local isComplete = PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(levelData.cfg.id)
  local tips = ""
  if isComplete then
    tips = ConfigData:GetTipContent(TipContent.EndLessRepetitionTips)
  else
    tips = ConfigData:GetTipContent(TipContent.EndLessUnfinishedTips)
  end
  self.ui.tex_Tips.text = tips
end

function UISectorLevelDetail:InitPeriodicChallengeDetailNode(challengeId, eChallengeType, levelDetailExtrData)
  self:CleanLastDetail()
  if self.isPushBack2Stack then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnClickSectorLevelDetailBackBtn):SetTopStatusResData({
    ConstGlobalItem.SKey
  }):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(nil, challengeId, SectorLevelDetailEnum.eDetailType.PeriodicChallenge)
  self.levelDetailNode:InitPeriodicChallengeDetailNode(challengeId, eChallengeType)
  self:Refresh_NodeCouldReviewStoryList(levelDetailExtrData)
end

function UISectorLevelDetail:InitWeeklyChallengeDetailNode(challengeId, isLocked, levelDetailExtrData)
  self:CleanLastDetail()
  if self.isPushBack2Stack then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnClickSectorLevelDetailBackBtn):SetTopStatusResData({
    ConstGlobalItem.SKey
  }):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(nil, challengeId, SectorLevelDetailEnum.eDetailType.WeeklyChallenge)
  self.levelDetailNode:InitWeeklyChallengeDetailNode(challengeId, isLocked)
  self:Refresh_NodeCouldReviewStoryList(levelDetailExtrData)
end

function UISectorLevelDetail:__InitWarchessDetailNode(sectorId, stageCfg, isLocked, levelDetailExtrData)
  self:CleanLastDetail()
  if self.isPushBack2Stack then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(sectorId)
  self.levelDetailNode:SetLevelDetailExtrData2Node(levelDetailExtrData)
  self.levelDetailNode:InitWarchessDetailNode(sectorId, stageCfg, isLocked)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnClickSectorLevelDetailBackBtn):SetTopStatusResData({
    stageCfg.cost_strength_id
  }):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
end

function UISectorLevelDetail:__InitBrotatoDetailNode(sectorId, stageCfg, isLocked, levelDetailExtrData)
  self:CleanLastDetail()
  if self.isPushBack2Stack then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnClickSectorLevelDetailBackBtn):SetTopStatusResData({
    ConstGlobalItem.SKey
  }):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.isPushBack2Stack = true
  self.stageId = sectorStageId
  self.stageCfg = stageCfg
  self:GetBackgroundTexture(sectorId, self.stageCfg.id, SectorLevelDetailEnum.eDetailType.Stage)
  self.levelDetailNode:SetLevelDetailExtrData2Node(levelDetailExtrData)
  self.levelDetailNode:InitBrotatoDetailNode(self.stageCfg, sectorId, isLocked)
  self.ui.tex_Tips.gameObject:SetActive(false)
end

function UISectorLevelDetail:__InitNormalDetailNode(sectorId, stageCfg, isLocked, levelDetailExtrData)
  self:CleanLastDetail()
  if self.isPushBack2Stack then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnClickSectorLevelDetailBackBtn):SetTopStatusResData({
    ConstGlobalItem.SKey
  }):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.isPushBack2Stack = true
  self.stageId = sectorStageId
  self.stageCfg = stageCfg
  self:GetBackgroundTexture(sectorId, self.stageCfg.id, SectorLevelDetailEnum.eDetailType.Stage)
  self.levelDetailNode:SetLevelDetailExtrData2Node(levelDetailExtrData)
  self.levelDetailNode:InitLevelDetailNode(self.stageCfg, sectorId, isLocked)
  self.ui.tex_Tips.gameObject:SetActive(false)
end

function UISectorLevelDetail:CleanLastDetail()
  self.levelDetailNode:SetShowAdditionBuffList(nil)
end

function UISectorLevelDetail:GetLevelDetailWidthAndDuration()
  return self.levelDetailNode:GetNLevelDetailWidthAndDuration()
end

function UISectorLevelDetail:SetLevelDetaiHideStartEvent(hideStartEvent)
  self.hideStartEvent = hideStartEvent
end

function UISectorLevelDetail:SetLevelDetaiHideEndEvent(hideEndEvent)
  self.hideEndEvent = hideEndEvent
end

function UISectorLevelDetail:OnClickSectorLevelDetailBackBtn(toHome)
  if self.levelDetailNode:IsRunningEnterFmtCo() then
    return
  end
  self.isPushBack2Stack = false
  if self.levelDetailNode ~= nil then
    self.levelDetailNode:PlayMoveTween(false)
  end
  if self.hideStartEvent ~= nil then
    self.hideStartEvent(toHome)
  end
end

function UISectorLevelDetail:OnClickBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UISectorLevelDetail:RefreshDtailNormalNode()
  if self.levelDetailNode ~= nil then
    self.levelDetailNode:RefreshDtailNormalNode()
  end
end

function UISectorLevelDetail:SetCloseWhenClickEmpty(flag)
  self.ui.btn_Close.gameObject:SetActive(flag)
end

function UISectorLevelDetail:OnShow()
  base.OnShow(self)
  self.levelDetailNode:OnShow()
end

function UISectorLevelDetail:OnHide()
  self.levelDetailNode:OnHide()
  if self.hideEndEvent ~= nil then
    self.hideEndEvent()
  end
end

function UISectorLevelDetail:GetBackgroundTexture(sectorId, challengeId, detailType)
  if self._tempSectorId == sectorId and self._tempStageId == challengeId and self._tempDetailType == self._tempDetailType then
    return
  end
  self._tempSectorId = sectorId
  self._tempStageId = challengeId
  self._tempDetailType = detailType
  self.ui.img_LevelPic.texture = ExplorationManager:GetSectorHeadTexture(sectorId, challengeId, detailType, self.resloader)
end

function UISectorLevelDetail:SetAdditionBuffList(buffList)
  self.levelDetailNode:SetShowAdditionBuffList(buffList)
end

function UISectorLevelDetail:SetActivityEndButCouldReview(isActivityRunning)
  self.levelDetailNode.__couldNotStatrBattle = not isActivityRunning
  self.levelDetailNode:SetLevelDetailActIsFinishUI(not isActivityRunning)
end

function UISectorLevelDetail:SetDetailCustomEnterFmtCallback(callback)
  self.levelDetailNode:SetDetailNodeCustomEnterFmtCallback(callback)
end

function UISectorLevelDetail:SetDetailExBattleStartCallback(callback)
  self.levelDetailNode:SetDetailNodeExBattleStartCallback(callback)
end

function UISectorLevelDetail:SetDetailSelectCanEnterCallback(callback)
  self.levelDetailNode:SetDetailNodeSelectCanEnterCallback(callback)
end

function UISectorLevelDetail:SetDetailCloseCallUICallback(callback)
  self.levelDetailNode:SetDetailCloseCallUICallback(callback)
end

function UISectorLevelDetail:SetDetailReopenCallUICallback(callback)
  self.levelDetailNode:SetDetailReopenCallUICallback(callback)
end

function UISectorLevelDetail:Refresh_NodeCouldReviewStoryList(levelDetailExtrData)
  local storyIdList, storySubTitleList
  if levelDetailExtrData ~= nil then
    storyIdList, storySubTitleList = levelDetailExtrData:Get_AdditionalReviewStoryList()
  end
  self.levelDetailNode:SetCouldReviewStoryList(storyIdList, storySubTitleList)
end

function UISectorLevelDetail:GetNewLevelDetailExtrData()
  return LevelDetailExtrData.New()
end

function UISectorLevelDetail:OnDelete()
  self.levelDetailNode:Delete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UISectorLevelDetail
