local CharBgTrialPanel = class("CharBgTrialPanel", BasePanel)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
CharBgTrialPanel._bIsMainPanel = false
CharBgTrialPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
CharBgTrialPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoTrial/CharBgTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharBgTrialCtrl"
  },
  {
    sPrefabPath = "CharacterInfoTrial/CharacterInfoTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharacterInfoTrialCtrl"
  },
  {
    sPrefabPath = "CharacterInfoTrial/CharSkillTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharSkillTrialCtrl"
  },
  {
    sPrefabPath = "CharacterInfoTrial/CharPotentialTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharPotentialTrialCtrl"
  },
  {
    sPrefabPath = "CharacterInfoTrial/CharTalentTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharTalentTrialCtrl"
  },
  {
    sPrefabPath = "CharacterInfoTrial/CharFgTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharFgTrialCtrl"
  }
}
CharBgTrialPanel._mapEventConfig = {
  [EventId.CharRelatePanelOpen] = "OnEvent_CharRelatePanelOpen",
  [EventId.CharRelatePanelClose] = "OnEvent_CharRelatePanelClose"
}
local char_panel_show_cfg = {
  [PanelId.CharInfoTrial] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = 0,
    L2DPosX = 0,
    weaponPosX = 28
  },
  [PanelId.CharSkillTrial] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = -26.8,
    L2DPosX = -0.62,
    weaponPosX = 28
  },
  [PanelId.CharPotentialTrial] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = -31.4,
    L2DPosX = -6.8,
    weaponPosX = 28
  },
  [PanelId.CharTalentTrial] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.None,
    bgPosX = -33.8,
    L2DPosX = -26,
    weaponPosX = 28
  }
}
local char_sub_panel = {
  [PanelId.CharUpPanel] = true
}
local panel_switch_anim_cfg = {
  [PanelId.CharInfoTrial] = {
    [PanelId.CharSkillTrial] = {nL2dTime = 0.2, nBgTime = 0},
    [PanelId.CharPotentialTrial] = {nL2dTime = 0.3, nBgTime = 0},
    [PanelId.CharTalentTrial] = {nL2dTime = 0, nBgTime = 0}
  },
  [PanelId.CharSkillTrial] = {
    [PanelId.CharInfoTrial] = {nL2dTime = 0.3, nBgTime = 0},
    [PanelId.CharPotentialTrial] = {nL2dTime = 0.3, nBgTime = 0.3},
    [PanelId.CharTalentTrial] = {nL2dTime = 0.3, nBgTime = 0.3}
  },
  [PanelId.CharPotentialTrial] = {
    [PanelId.CharInfoTrial] = {nL2dTime = 0.3, nBgTime = 0},
    [PanelId.CharSkillTrial] = {nL2dTime = 0.3, nBgTime = 0.3},
    [PanelId.CharTalentTrial] = {nL2dTime = 0.3, nBgTime = 0.3}
  },
  [PanelId.CharTalentTrial] = {
    [PanelId.CharInfoTrial] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharSkillTrial] = {nL2dTime = 0, nBgTime = 0.3},
    [PanelId.CharPotentialTrial] = {nL2dTime = 0, nBgTime = 0.3}
  }
}

function CharBgTrialPanel:Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.CharBgPanel)
end

function CharBgTrialPanel:GetPanelAnimCfg(nClosePanelId, nOpenPanelId)
  if nil == panel_switch_anim_cfg[nClosePanelId] then
    return
  end
  if nil == panel_switch_anim_cfg[nClosePanelId][nOpenPanelId] then
    return
  end
  return panel_switch_anim_cfg[nClosePanelId][nOpenPanelId]
end

function CharBgTrialPanel:GetPanelAnimTime(nClosePanelId, nOpenPanelId)
  local tbCfg = self:GetPanelAnimCfg(nClosePanelId, nOpenPanelId)
  if nil ~= tbCfg then
    return tbCfg.nBgTime, tbCfg.nL2dTime
  end
end

function CharBgTrialPanel:PlayPanelSwitchAnim(trContent, nWidth, nTime)
  EventManager.Hit(EventId.TemporaryBlockInput, nTime)
  local tweener = trContent:DOAnchorPosX(nWidth, nTime):SetUpdate(true)
  local tbCfg = self:GetPanelAnimCfg(self.nClosePanelId, self.nPanelId)
  if nil ~= tbCfg and nil ~= tbCfg.uiEaseType then
    tweener:SetEase(tbCfg.uiEaseType)
  end
  return tweener
end

function CharBgTrialPanel:GetPanelShowCfg()
  return char_panel_show_cfg
end

function CharBgTrialPanel:GetSubPanel()
  return char_sub_panel
end

function CharBgTrialPanel:Awake()
  self.nPanelId = 0
  self.nCharId = 0
  self.tbCharList = {}
  self.panelStack = {}
  self.bSecondPanel = false
  local tbParam = self._tbParam
  if type(tbParam) == "table" then
    self.nPanelId = tbParam[1]
    if nil ~= tbParam[2] then
      self.configData = ConfigTable.GetData_Character(tbParam[2])
      self.mapCharTrialInfo = PlayerData.Char:CreateTrialChar({
        self.configData.ViewId
      })[self.configData.ViewId]
      self.nCharId = self.mapCharTrialInfo.nId
    end
  end
  table.insert(self.panelStack, self.nPanelId)
  Actor2DManager.ForceUseL2D(false)
end

function CharBgTrialPanel:OnEnable()
end

function CharBgTrialPanel:OnDisable()
  if PanelManager.CheckPanelOpen(PanelId.GachaSpin) then
    Actor2DManager.ForceUseL2D(true)
  end
end

function CharBgTrialPanel:OnEvent_CharRelatePanelOpen(nPanelId, ncharId, tbCharList, param1)
  self.nClosePanelId = self.nPanelId
  self.nPanelId = nPanelId
  self.bSecondPanel = false
  if nil ~= ncharId then
    self.nCharId = ncharId
  end
  if nil ~= tbCharList then
    self.tbCharList = tbCharList
  end
  if nil ~= param1 then
    self.param1 = param1
  end
  if char_sub_panel[nPanelId] then
    table.insert(self.panelStack, nPanelId)
  end
  EventManager.Hit(EventId.CharRelatePanelAdvance, self.nClosePanelId, nPanelId)
end

function CharBgTrialPanel:OnEvent_CharRelatePanelClose(bForceClose)
  if #self.panelStack <= 1 or bForceClose then
    self:Close()
    return
  end
  self.nClosePanelId = self.nPanelId
  local nLastPanelId = self.panelStack[#self.panelStack]
  if self.nClosePanelId ~= nLastPanelId then
    self:Close()
    return
  end
  local nOpenPanelId = self.panelStack[#self.panelStack - 1]
  table.remove(self.panelStack, #self.panelStack)
  self.nPanelId = nOpenPanelId
  self.bSecondPanel = false
  local panelCfg = char_panel_show_cfg[self.nClosePanelId]
  if nil ~= panelCfg then
    EventManager.Hit(EventId.CharRelatePanelBack, self.nClosePanelId, nOpenPanelId)
  end
end

return CharBgTrialPanel
