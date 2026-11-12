local CharBgPanel = class("CharBgPanel", BasePanel)
CharBgPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharBgPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharBgCtrl"
  },
  {
    sPrefabPath = "CharacterInfoEx/CharacterInfoPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharacterInfoCtrl"
  },
  {
    sPrefabPath = "CharacterInfoEx/CharDevelopmentPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharDevelopmentCtrl"
  },
  {
    sPrefabPath = "CharSkill/CharSkillPanel.prefab",
    sCtrlName = "Game.UI.CharSkill.CharSkillCtrl"
  },
  {
    sPrefabPath = "CharacterInfoEx/CharPotentialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharPotentialCtrl"
  },
  {
    sPrefabPath = "CharacterInfoEx/CharTalentPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharTalentCtrl"
  },
  {
    sPrefabPath = "CharacterInfoEx/CharEquipmentPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharEquipmentCtrl"
  },
  {
    sPrefabPath = "CharacterInfoEx/CharFgPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharFgCtrl"
  },
  {
    sPrefabPath = "CharacterInfoEx/CharacterRelationPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharacterRelationCtrl"
  }
}
CharBgPanel._mapEventConfig = {
  [EventId.CharRelatePanelOpen] = "OnEvent_CharRelatePanelOpen",
  [EventId.CharRelatePanelClose] = "OnEvent_CharRelatePanelClose"
}
local char_panel_show_cfg = {
  [PanelId.CharInfo] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = 0,
    L2DPosX = 0,
    weaponPosX = 28
  },
  [PanelId.CharUpPanel] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = 0,
    L2DPosX = -0.92,
    weaponPosX = 28
  },
  [PanelId.CharSkill] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = -26.8,
    L2DPosX = -0.62,
    weaponPosX = 28
  },
  [PanelId.CharEquipment] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = -29.1,
    L2DPosX = -4,
    weaponPosX = 28
  },
  [PanelId.CharPotential] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = -31.4,
    L2DPosX = -6.8,
    weaponPosX = 28
  },
  [PanelId.CharTalent] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.None,
    bgPosX = -33.8,
    L2DPosX = -26,
    weaponPosX = 28
  },
  [PanelId.CharacterRelation] = {
    bShowTopBar = true,
    type = AllEnum.CharBgPanelShowType.L2D,
    bgPosX = -60,
    L2DPosX = -3,
    weaponPosX = 28
  }
}
local char_sub_panel = {
  [PanelId.CharUpPanel] = true
}
local panel_switch_anim_cfg = {
  [PanelId.CharUpPanel] = {
    [PanelId.CharInfo] = {nL2dTime = 0.3, nBgTime = 0}
  },
  [PanelId.CharInfo] = {
    [PanelId.CharUpPanel] = {nL2dTime = 0.3, nBgTime = 0},
    [PanelId.CharSkill] = {nL2dTime = 0.2, nBgTime = 0},
    [PanelId.CharEquipment] = {
      nL2dTime = 0.4,
      nBgTime = 0,
      uiEaseType = Ease.InOutSine,
      bgEaseType = Ease.InOutCubic
    },
    [PanelId.CharacterRelation] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharPotential] = {nL2dTime = 0.3, nBgTime = 0},
    [PanelId.CharTalent] = {nL2dTime = 0, nBgTime = 0}
  },
  [PanelId.CharSkill] = {
    [PanelId.CharInfo] = {nL2dTime = 0.3, nBgTime = 0},
    [PanelId.CharEquipment] = {nL2dTime = 0.25, nBgTime = 0.25},
    [PanelId.CharacterRelation] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharPotential] = {nL2dTime = 0.3, nBgTime = 0.3},
    [PanelId.CharTalent] = {nL2dTime = 0.3, nBgTime = 0.3}
  },
  [PanelId.CharEquipment] = {
    [PanelId.CharInfo] = {
      nL2dTime = 0.4,
      nBgTime = 0,
      uiEaseType = Ease.InOutSine,
      bgEaseType = Ease.InOutCubic
    },
    [PanelId.CharSkill] = {nL2dTime = 0.25, nBgTime = 0.25},
    [PanelId.CharacterRelation] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharPotential] = {nL2dTime = 0.3, nBgTime = 0.3},
    [PanelId.CharTalent] = {nL2dTime = 0.3, nBgTime = 0.3}
  },
  [PanelId.CharacterRelation] = {
    [PanelId.CharInfo] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharEquipment] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharSkill] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharPotential] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharTalent] = {nL2dTime = 0, nBgTime = 0}
  },
  [PanelId.CharPotential] = {
    [PanelId.CharInfo] = {nL2dTime = 0.3, nBgTime = 0},
    [PanelId.CharEquipment] = {nL2dTime = 0.3, nBgTime = 0.3},
    [PanelId.CharSkill] = {nL2dTime = 0.3, nBgTime = 0.3},
    [PanelId.CharacterRelation] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharTalent] = {nL2dTime = 0.3, nBgTime = 0.3}
  },
  [PanelId.CharTalent] = {
    [PanelId.CharInfo] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharEquipment] = {nL2dTime = 0, nBgTime = 0.3},
    [PanelId.CharSkill] = {nL2dTime = 0, nBgTime = 0.3},
    [PanelId.CharacterRelation] = {nL2dTime = 0, nBgTime = 0},
    [PanelId.CharPotential] = {nL2dTime = 0, nBgTime = 0.3}
  }
}

function CharBgPanel:Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.CharBgPanel)
end

function CharBgPanel:GetPanelAnimCfg(nClosePanelId, nOpenPanelId)
  if nil == panel_switch_anim_cfg[nClosePanelId] then
    return
  end
  if nil == panel_switch_anim_cfg[nClosePanelId][nOpenPanelId] then
    return
  end
  return panel_switch_anim_cfg[nClosePanelId][nOpenPanelId]
end

function CharBgPanel:GetPanelAnimTime(nClosePanelId, nOpenPanelId)
  local tbCfg = self:GetPanelAnimCfg(nClosePanelId, nOpenPanelId)
  if nil ~= tbCfg then
    return tbCfg.nBgTime, tbCfg.nL2dTime
  end
end

function CharBgPanel:PlayPanelSwitchAnim(trContent, nWidth, nTime)
  EventManager.Hit(EventId.TemporaryBlockInput, nTime)
  local tweener = trContent:DOAnchorPosX(nWidth, nTime):SetUpdate(true)
  local tbCfg = self:GetPanelAnimCfg(self.nClosePanelId, self.nPanelId)
  if nil ~= tbCfg and nil ~= tbCfg.uiEaseType then
    tweener:SetEase(tbCfg.uiEaseType)
  end
  return tweener
end

function CharBgPanel:GetPanelShowCfg()
  return char_panel_show_cfg
end

function CharBgPanel:GetSubPanel()
  return char_sub_panel
end

function CharBgPanel:Awake()
  self.nPanelId = 0
  self.nCharId = 0
  self.tbCharList = {}
  self.panelStack = {}
  self.bSecondPanel = false
  self.nUpgradeIndex = 1
  local tbParam = self._tbParam
  if type(tbParam) == "table" then
    self.nPanelId = tbParam[1]
    if nil ~= tbParam[2] then
      self.nCharId = tbParam[2]
    end
    if nil ~= tbParam[3] then
      self.tbCharList = tbParam[3]
    end
    if nil ~= tbParam[4] then
      self.param1 = tbParam[4]
    end
  end
  table.insert(self.panelStack, self.nPanelId)
end

function CharBgPanel:OnEnable()
end

function CharBgPanel:OnDisable()
end

function CharBgPanel:OnEvent_CharRelatePanelOpen(nPanelId, nCharId, tbCharList, param1)
  self.nClosePanelId = self.nPanelId
  self.nPanelId = nPanelId
  self.bSecondPanel = false
  if nil ~= nCharId then
    self.nCharId = nCharId
  end
  if nil ~= tbCharList then
    self.tbCharList = tbCharList
  end
  if nil ~= param1 then
    self.param1 = param1
  end
  if char_sub_panel[nPanelId] then
    table.insert(self.panelStack, nPanelId)
  elseif self.panelStack[#self.panelStack] == self.nClosePanelId then
    table.remove(self.panelStack, #self.panelStack)
    table.insert(self.panelStack, nPanelId)
  end
  EventManager.Hit(EventId.CharRelatePanelAdvance, self.nClosePanelId, nPanelId)
end

function CharBgPanel:OnEvent_CharRelatePanelClose(bForceClose)
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

return CharBgPanel
