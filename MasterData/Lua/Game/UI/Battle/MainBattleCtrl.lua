local AdventureModuleHelper = CS.AdventureModuleHelper
local LocalData = require("GameCore.Data.LocalData")
local MainBattleCtrl = class("MainBattleCtrl", BaseCtrl)
MainBattleCtrl._mapNodeConfig = {
  BossHUDPanel = {
    sNodeName = "BossHUDPanel",
    sCtrlName = "Game.UI.Battle.BossPanelCtrl"
  },
  CinemaModePanel = {
    sNodeName = "CinemaModePanel",
    sCtrlName = "Game.UI.Battle.CinemaModeCtrl"
  },
  PopupTipsPanel = {
    sNodeName = "PopupTipsPanel",
    sCtrlName = "Game.UI.Battle.TipsPanelCtrl"
  },
  JumpTimelinePanel = {
    sNodeName = "JumpTimelinePanel",
    sCtrlName = "Game.UI.Battle.JumpTimelineCtrl"
  },
  AutoBattlePanel = {
    sNodeName = "AutoBattlePanel",
    sCtrlName = "Game.UI.Battle.AutoBattleCtrl"
  },
  InfinityAutoPanel = {
    sNodeName = "InfinityAutoPanel",
    sCtrlName = "Game.UI.Battle.InfinityAutoCtrl"
  }
}
MainBattleCtrl._mapEventConfig = {
  OpenCinema = "OnEvent_OpenCinema",
  CloseCinema = "OnEvent_CloseCinema",
  OpenTipsPanel = "OnEvent_OpenTips",
  ShowJumpTimeline = "OnEvent_ShowJumpTimeline",
  HideJumpTimeline = "OnEvent_HideJumpTimeline",
  ChangeAutoBattleState = "OnEvent_ChangeAutoBattleState",
  ChangeAutoBattleStateClose = "OnEvent_ChangeAutoBattleStateClose"
}

function MainBattleCtrl:Awake()
end

function MainBattleCtrl:OnEnable()
  self._mapNode.PopupTipsPanel.gameObject:SetActive(false)
  self.battleType = self._panel.BattleType == nil and GameEnum.worldLevelType.Mainline or self._panel.BattleType
  self.dynamicType = self._panel.DynamicType
  local tbParam = self._panel._tbParam
  local floorId = tbParam and tbParam[2]
  self._mapNode.AutoBattlePanel:SetBattleType(self.battleType, self.dynamicType, floorId)
  if self.battleType == GameEnum.worldLevelType.InfinityTower then
    local sKey = "PlayerAutoBattleState" .. self.battleType
    local sData = LocalData.GetPlayerLocalData(sKey)
    local nState = tonumber(sData == nil and "0" or sData)
    self._mapNode.InfinityAutoPanel.gameObject:SetActive(nState == 1)
  end
end

function MainBattleCtrl:OnDisable()
end

function MainBattleCtrl:OnDestroy()
end

function MainBattleCtrl:SetBattleType(nType)
end

function MainBattleCtrl:OnEvent_OpenCinema()
  self._mapNode.CinemaModePanel:OpenUI()
end

function MainBattleCtrl:OnEvent_CloseCinema()
  self._mapNode.CinemaModePanel:CloseUI()
end

function MainBattleCtrl:OnEvent_ShowJumpTimeline()
  self._mapNode.JumpTimelinePanel:OpenUI()
end

function MainBattleCtrl:OnEvent_HideJumpTimeline()
  self._mapNode.JumpTimelinePanel:CloseUI()
end

function MainBattleCtrl:OnEvent_OpenTips(sTip)
  self._mapNode.PopupTipsPanel.gameObject:SetActive(true)
  self._mapNode.PopupTipsPanel:OpenUI(sTip)
end

function MainBattleCtrl:OnEvent_ChangeAutoBattleState(isAuto)
  if self.battleType == GameEnum.worldLevelType.InfinityTower then
    if isAuto then
      self._mapNode.InfinityAutoPanel.gameObject:SetActive(true)
      self._mapNode.InfinityAutoPanel:PlayAin(true)
    else
      PlayerData.InfinityTower:SetAutoNextLv(false)
      self._mapNode.InfinityAutoPanel:SetAutoLevelState(false)
      self._mapNode.InfinityAutoPanel:PlayAin(false)
    end
  end
end

function MainBattleCtrl:OnEvent_ChangeAutoBattleStateClose()
  if self.battleType == GameEnum.worldLevelType.InfinityTower then
    PlayerData.InfinityTower:SetAutoNextLv(false)
    self._mapNode.InfinityAutoPanel:SetAutoLevelState(false)
  end
end

return MainBattleCtrl
