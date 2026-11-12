local CharDevelopmentCtrl = class("CharDevelopmentCtrl", BaseCtrl)
local CharState = {
  Upgrade = 1,
  Advance = 2,
  Max = 3
}
CharDevelopmentCtrl._mapNodeConfig = {
  txtName = {sComponentName = "TMP_Text"},
  imgRareName = {sComponentName = "Image"},
  imgCharColor = {sComponentName = "Image"},
  imgTag = {nCount = 3},
  txtTag = {nCount = 3, sComponentName = "TMP_Text"},
  txtElement = {sComponentName = "TMP_Text"},
  imgElementIcon = {sComponentName = "Image"},
  Upgrade = {
    sNodeName = "---Upgrade---",
    sCtrlName = "Game.UI.CharacterInfoEx.CharUpgradeCtrl"
  },
  Advance = {
    sNodeName = "---Advance---",
    sCtrlName = "Game.UI.CharacterInfoEx.CharAdvanceCtrl"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  redDotAdInfo = {nCount = 3},
  btnOpenAdInfo = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenPreview"
  }
}
CharDevelopmentCtrl._mapEventConfig = {
  CharDevelopmentRefresh = "OnEvent_Refresh",
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel",
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelBack",
  [EventId.UIBackConfirm] = "OnEvent_UIBack",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  CraftingSuccess = "OnEvent_ItemChanged",
  ConsumableUsed = "OnEvent_ItemChanged",
  AutoFillSuccess = "OnEvent_ItemChanged",
  CharRefreshActor2D = "OnEvent_RefreshActor2D",
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}

function CharDevelopmentCtrl:RefreshContent()
  if self._panel.nPanelId ~= PanelId.CharUpPanel then
    return
  end
  self.nCharId = self._panel.nCharId
  self:RegisterRedDot(self.nCharId)
  self:RefreshData()
  self:RefreshInfo()
  self:SwitchState()
end

function CharDevelopmentCtrl:RefreshData()
  self.playerCharData = PlayerData.Char:GetCharDataByTid(self.nCharId)
  local nLevel = self.playerCharData.nLevel
  local nAdvance = self.playerCharData.nAdvance
  local nGrade = ConfigTable.GetData_Character(self.nCharId).Grade
  self.State = CharState.Upgrade
  local tbAdvanceLevel = PlayerData.Char:GetAdvanceLevelTable()
  self.curGradeLevelArr = tbAdvanceLevel[nGrade]
  local curGradeLevelArr = self.curGradeLevelArr
  self.maxAdvance = -1
  for i = 1, #curGradeLevelArr do
    self.maxAdvance = self.maxAdvance + 1
    if nAdvance + 1 == i then
      self.MaxLevel = curGradeLevelArr[nAdvance + 1]
      if nLevel == self.MaxLevel then
        self.State = CharState.Advance
      elseif nLevel < self.MaxLevel then
        self.State = CharState.Upgrade
      end
    end
  end
  if self.MaxLevel == nil then
    self.MaxLevel = nLevel
  end
  if nAdvance == self.maxAdvance and self.State == CharState.Advance then
    self.State = CharState.Max
  end
  local nUpgradeId = 10000 + nGrade * 1000 + nLevel + 1
  local mapUpgrade = ConfigTable.GetData("CharacterUpgrade", nUpgradeId, true)
  local maxExp = 9999
  if mapUpgrade ~= nil then
    maxExp = mapUpgrade.Exp
  end
  self.mapCurLevel = {
    nLevel = nLevel,
    nExp = self.playerCharData.nRankExp,
    nMaxLevel = self.MaxLevel,
    nMaxExp = maxExp,
    nMatExp = 0,
    nNextMaxLv = curGradeLevelArr[nAdvance + 2] or self.MaxLevel
  }
end

function CharDevelopmentCtrl:RefreshInfo()
  local mapCfg = ConfigTable.GetData_Character(self.nCharId)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  self:SetSprite_FrameColor(self._mapNode.imgRareName, mapCfg.Grade, AllEnum.FrameType_New.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", self.nCharId)
  local sColor, tbTag
  if mapCharDescCfg ~= nil then
    sColor = mapCharDescCfg.CharColor
    tbTag = mapCharDescCfg.Tag
  else
    sColor = ""
    tbTag = {}
  end
  local _, colorChar = ColorUtility.TryParseHtmlString(sColor)
  NovaAPI.SetImageColor(self._mapNode.imgCharColor, colorChar)
  for i = 1, 3 do
    local nTag = tbTag[i]
    if nTag then
      self._mapNode.imgTag[i]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTag[i], ConfigTable.GetData("CharacterTag", nTag).Title)
    else
      self._mapNode.imgTag[i]:SetActive(false)
    end
  end
  local sName = AllEnum.ElementIconType.Icon .. mapCfg.EET
  self:SetAtlasSprite(self._mapNode.imgElementIcon, "12_rare", sName)
  NovaAPI.SetTMPColor(self._mapNode.txtElement, AllEnum.ElementColor[mapCfg.EET])
  NovaAPI.SetTMPText(self._mapNode.txtElement, ConfigTable.GetUIText("T_Element_Attr_" .. mapCfg.EET))
end

function CharDevelopmentCtrl:SwitchState()
  self.isCanSendAdvance = false
  self.isCanSendAdvanceNext = false
  self._mapNode.Upgrade.gameObject:SetActive(self.State ~= CharState.Advance)
  self._mapNode.Advance.gameObject:SetActive(self.State == CharState.Advance)
  if self.State == CharState.Advance then
    EventManager.Hit("RefreshCharTopBarText", ConfigTable.GetUIText("UITitle_CharUp2"))
    self._mapNode.Advance:Refresh(self.nCharId, self.mapCurLevel, self.maxAdvance)
    if PanelManager.CheckPanelOpen(PanelId.CharSucBar) then
      self.isCanSendAdvance = true
    else
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_CharDevelopmentAdvance")
    end
  else
    EventManager.Hit("RefreshCharTopBarText", ConfigTable.GetUIText("UITitle_CharUp1"))
    self._mapNode.Upgrade:Refresh(self.nCharId, self.mapCurLevel, self.maxAdvance, self.State == CharState.Max)
    if self.mapCurLevel.nLevel >= 10 and self.mapCurLevel.nMaxLevel == 20 then
      if PanelManager.CheckPanelOpen(PanelId.CharSucBar) then
        self.isCanSendAdvanceNext = true
      else
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_CharDevelopmentAdvanceNext")
      end
    end
  end
end

function CharDevelopmentCtrl:RegisterRedDot(nCharId)
  if nil == nCharId then
    return
  end
  for _, v in ipairs(self._mapNode.redDotAdInfo) do
    RedDotManager.RegisterNode(RedDotDefine.Role_AdvanceReward, nCharId, v)
  end
end

function CharDevelopmentCtrl:PlaySwitchAnim(nClosePanelId, nOpenPanelId, bBack)
  if nClosePanelId == PanelId.CharUpPanel then
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  end
  if nOpenPanelId == PanelId.CharUpPanel then
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    EventManager.Hit("ChangeCharFgTab", false)
    EventManager.Hit("PlayCharBgLeftAnim", true)
  end
end

function CharDevelopmentCtrl:RefreshActor2D()
  if self._panel.nPanelId == PanelId.CharUpPanel then
    EventManager.Hit(EventId.CharBgRefresh, PanelId.CharUpPanel, self.nCharId)
  end
end

function CharDevelopmentCtrl:FadeIn()
end

function CharDevelopmentCtrl:Awake()
end

function CharDevelopmentCtrl:OnEnable()
  self:RefreshContent()
  if self._panel.nPanelId ~= PanelId.CharUpPanel then
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  end
end

function CharDevelopmentCtrl:OnDisable()
end

function CharDevelopmentCtrl:OnDestroy()
end

function CharDevelopmentCtrl:OnBtnClick_OpenPreview()
  EventManager.Hit(EventId.OpenPanel, PanelId.CharAdvancePreview, self.maxAdvance, self.nCharId, self.curGradeLevelArr)
end

function CharDevelopmentCtrl:OnEvent_Refresh()
  self:RefreshData()
  self:SwitchState()
end

function CharDevelopmentCtrl:OnEvent_RefreshPanel()
  self:RefreshContent()
end

function CharDevelopmentCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, false)
  self:RefreshContent()
end

function CharDevelopmentCtrl:OnEvent_PanelBack(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, true)
  self:RefreshContent()
end

function CharDevelopmentCtrl:OnEvent_UIBack(nPanelId)
  if self._panel._nPanelId ~= nPanelId or self._panel.nPanelId ~= PanelId.CharUpPanel then
    return
  end
  EventManager.Hit(EventId.CharRelatePanelClose)
  EventManager.Hit("ChangeCharFgTab", true)
  EventManager.Hit("PlayCharBgLeftAnim", false)
end

function CharDevelopmentCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId or self._panel.nPanelId ~= PanelId.CharUpPanel then
    return
  end
  PanelManager.Home()
end

function CharDevelopmentCtrl:OnEvent_ItemChanged()
  if self._panel.nPanelId ~= PanelId.CharUpPanel then
    return
  end
  self:RefreshData()
  self:SwitchState()
end

function CharDevelopmentCtrl:OnEvent_RefreshActor2D()
  self:RefreshActor2D()
end

function CharDevelopmentCtrl:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.CharSucBar then
    if self.isCanSendAdvance then
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_CharDevelopmentAdvance")
      self.isCanSendAdvance = false
    elseif self.isCanSendAdvanceNext then
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_CharDevelopmentAdvanceNext")
      self.isCanSendAdvanceNext = false
    end
  end
end

return CharDevelopmentCtrl
