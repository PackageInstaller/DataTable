local UIBrotatoLobbyMain = class("UIBrotatoLobbyMain", UIBaseWindow)
local base = UIBaseWindow
local RankingNode = require("Game.ActivityBrotatoLobby.UI.UINBrotatoRank")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local BrotatoEnum = require("Game.ActivityBrotatoLobby.BrotatoEnum")
local UINBrotatoSelectDifficulty = require("Game.ActivityBrotatoLobby.UI.UINSelectDifficulty.UINBrotatoSelectDifficulty")
local UINBrotatoTaskInfoItem = require("Game.ActivityBrotatoLobby.UI.UINTaskNode.UINBrotatoTaskInfoItem")
local FirstAwardTitleIndex = 0

function UIBrotatoLobbyMain:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.obj_rewardItem)
  self.ui.obj_rewardItem:SetActive(false)
  self.rankNode = RankingNode.New()
  self.rankNode:Init(self.ui.obj_rank)
  self.selectDifficultyNode = UINBrotatoSelectDifficulty.New()
  self.selectDifficultyNode:Init(self.ui.obj_ModeSelect)
  self.brotatoTaskInfoItem = UINBrotatoTaskInfoItem.New()
  self.brotatoTaskInfoItem:Init(self.ui.obj_BrotatoTaskInfoItem)
  UIUtil.AddButtonListener(self.ui.btn_start, self, self.OnStartGameBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickRankBtn)
  UIUtil.AddButtonListener(self.ui.btn_Rule, self, self.OnClickRuleBtn)
end

function UIBrotatoLobbyMain:InitBrotatoMain(ctrl, cfgData, endTime, maxScore, closeCallback)
  self.mainCtrl = ctrl
  self.cfgData = cfgData
  self.closeCallback = closeCallback
  local date = TimeUtil:TimestampToDate(endTime)
  self.ui.tex_time.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
  if cfgData ~= nil and cfgData.type_difficulty == BrotatoEnum.EGameStartType.SelectDifficulty then
    self.brotatoTaskInfoItem:Show()
    self.brotatoTaskInfoItem:InitTaskInfoItem(cfgData.id)
  else
    self.brotatoTaskInfoItem:Hide()
  end
  if cfgData ~= nil and cfgData.type_difficulty == BrotatoEnum.EGameStartType.DirectStart and maxScore < cfgData.join_score then
    self.ui.obj_reward:SetActive(true)
    self.ui.tex_Point:SetIndex(0, tostring(cfgData.join_score))
    for k, v in pairs(cfgData.join_reward) do
      local rewardItem = self.rewardItemPool:GetOne()
      local itemCfg = ConfigData.item[k]
      rewardItem:InitItemWithCount(itemCfg, v)
    end
  else
    self.ui.obj_reward:SetActive(false)
  end
  self:ChangeBrotatoMainUIState(BrotatoEnum.EMainUiState.Start)
end

function UIBrotatoLobbyMain:ChangeBrotatoMainUIState(newState)
  if self.mainUiState == newState then
    return
  end
  self.mainUiState = newState
  if newState == BrotatoEnum.EMainUiState.Start then
    self.ui.obj_ButtonGroup:SetActive(true)
    self.selectDifficultyNode:Hide()
  elseif newState == BrotatoEnum.EMainUiState.SelectDifficulty then
    self.ui.obj_ButtonGroup:SetActive(false)
    self.selectDifficultyNode:Show()
  end
end

function UIBrotatoLobbyMain:OnStartGameBtnClick()
  local canContinue, continueStageId = self.mainCtrl:GetIsBrotatoCanContinue()
  if canContinue then
    self.mainCtrl:StartBrotatoGame(continueStageId)
    return
  end
  if self.mainCtrl:GetIsNeedSelectDifficulty() then
    self:ChangeBrotatoMainUIState(BrotatoEnum.EMainUiState.SelectDifficulty)
    self.selectDifficultyNode:InitBrotatoSelectDifficultyNode(self.mainCtrl:GetBrotatoTinyGameDifficultyCfg(), function(stageId)
      self.mainCtrl:StartBrotatoGame(stageId)
    end)
  else
    self.mainCtrl:StartBrotatoGame(self.mainCtrl:GetBrotatoTinyGameCfg().stage_id)
  end
end

function UIBrotatoLobbyMain:BackAction()
  if self.mainUiState == BrotatoEnum.EMainUiState.SelectDifficulty then
    self:ChangeBrotatoMainUIState(BrotatoEnum.EMainUiState.Start)
    return false
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
    self.closeCallback = nil
  end
  self:Delete()
end

function UIBrotatoLobbyMain:OnQuitGameBtnClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIBrotatoLobbyMain:OnClickRankBtn()
  self.mainCtrl:ReqGetRankPageData(function(allFrindRank, mineGrade, rankIndex)
    self.rankNode:ShowBrotatoRank(allFrindRank, mineGrade, rankIndex)
  end)
end

function UIBrotatoLobbyMain:OnClickRuleBtn()
  if self.cfgData ~= nil then
    local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
    GuidePicture.OpenGuidePicture(self.cfgData.snake_guide_id)
  end
end

function UIBrotatoLobbyMain:OnDelete()
  if self.rewardItemPool ~= nil then
    self.rewardItemPool:DeleteAll()
    self.rewardItemPool = nil
  end
  if self.brotatoTaskInfoItem ~= nil then
    self.brotatoTaskInfoItem:Delete()
  end
  base.OnDelete(self)
end

return UIBrotatoLobbyMain
