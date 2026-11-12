local CharFgCtrl = class("CharFgCtrl", BaseCtrl)
local MoveBarPos = {
  -805.2,
  -483.6,
  -162,
  159.6,
  481.2,
  802.8
}
local PanelToTab = {
  [PanelId.CharInfo] = 1,
  [PanelId.CharSkill] = 2,
  [PanelId.CharEquipment] = 4,
  [PanelId.CharPotential] = 3,
  [PanelId.CharTalent] = 5,
  [PanelId.CharacterRelation] = 6,
  [PanelId.CharUpPanel] = 1
}
local TabTextKey = {
  "CharacterInfo_Tab1",
  "CharacterInfo_Tab2",
  "CharacterInfo_Tab4",
  "CharacterInfo_Tab3",
  "CharacterInfo_Tab5",
  "CharacterInfo_Tab6"
}
CharFgCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goBack = {},
  btnTab = {
    nCount = 6,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  imgOn = {nCount = 6},
  txtTabOn = {nCount = 6, sComponentName = "TMP_Text"},
  txtTabOff = {nCount = 6, sComponentName = "TMP_Text"},
  layoutOff = {nCount = 6},
  reddot = {nCount = 6},
  imgMoveBar = {sComponentName = "Transform"},
  Tab = {sNodeName = "--Tab--"},
  aniSafeRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btnTabSwitchLeft = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_SwitchLeft"
  },
  btnTabSwitchRight = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_SwitchRight"
  },
  goTabSwitch = {}
}
CharFgCtrl._mapEventConfig = {
  RefreshCharFg = "OnEvent_RefreshFg",
  RefreshCharTopBar = "RefreshTopBar",
  RefreshCharTopBarText = "OnEvent_SetTopBarText",
  ChangeCharFgTab = "OnEvent_ChangeTab",
  ChangeCharTopBar = "OnEvent_ChangeTopBar"
}

function CharFgCtrl:InitTab()
  self.nTab = PanelToTab[self._panel.nPanelId]
  self._mapNode.imgMoveBar.localPosition = Vector3(MoveBarPos[self.nTab], 4.5, 0)
  for i = 1, 6 do
    NovaAPI.SetTMPText(self._mapNode.txtTabOn[i], ConfigTable.GetUIText(TabTextKey[i]))
    NovaAPI.SetTMPText(self._mapNode.txtTabOff[i], ConfigTable.GetUIText(TabTextKey[i]))
    self._mapNode.imgOn[i]:SetActive(PanelToTab[self._panel.nPanelId] == i)
    self._mapNode.txtTabOn[i].gameObject:SetActive(PanelToTab[self._panel.nPanelId] == i)
    self._mapNode.layoutOff[i].gameObject:SetActive(PanelToTab[self._panel.nPanelId] ~= i)
  end
end

function CharFgCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Role_Upgrade, self._panel.nCharId, self._mapNode.reddot[1])
  RedDotManager.RegisterNode(RedDotDefine.Role_Talent, self._panel.nCharId, self._mapNode.reddot[5])
  RedDotManager.RegisterNode(RedDotDefine.Role_Relation, self._panel.nCharId, self._mapNode.reddot[6])
end

function CharFgCtrl:RefreshTopBar()
  local nPanelId = self._panel.nPanelId
  local panelCfg = self.tbPanelCfg[nPanelId]
  if nil ~= panelCfg then
    if panelCfg.bShowTopBar then
      self._mapNode.TopBar.gameObject:SetActive(true)
      self._mapNode.TopBar:InitTopBar(nPanelId)
      if nPanelId == PanelId.CharTalent then
        local mapCharCfg = ConfigTable.GetData_Character(self._panel.nCharId)
        self._mapNode.TopBar:CreateCoin({
          mapCharCfg.FragmentsId
        })
      elseif nPanelId == PanelId.CharUpPanel then
        local nGrade = ConfigTable.GetData_Character(self._panel.nCharId).Grade
        local tbAdvanceLevel = PlayerData.Char:GetAdvanceLevelTable()
        local curGradeLevelArr = tbAdvanceLevel[nGrade]
        local playerCharData = PlayerData.Char:GetCharDataByTid(self._panel.nCharId)
        local nLevel = playerCharData.nLevel
        local nAdvance = playerCharData.nAdvance
        local maxAdvance = -1
        for i = 1, #curGradeLevelArr do
          maxAdvance = maxAdvance + 1
          if nAdvance + 1 == i then
            local MaxLevel = curGradeLevelArr[nAdvance + 1]
            if nLevel == MaxLevel then
              self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("UITitle_CharUp2"))
            elseif nLevel < MaxLevel then
              self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("UITitle_CharUp1"))
            end
          end
        end
      end
    else
      self._mapNode.TopBar.gameObject:SetActive(false)
    end
  end
  if self._panel.bSecondPanel then
    self:OnEvent_ChangeTopBar(false)
  end
end

function CharFgCtrl:Awake()
  self:InitTab()
end

function CharFgCtrl:OnEnable()
  self.tbPanelCfg = self._panel:GetPanelShowCfg()
  local tbSubPanel = self._panel:GetSubPanel()
  if tbSubPanel[self._panel.nPanelId] or self._panel.bSecondPanel then
    self._mapNode.aniSafeRoot:Play("CharFgPanel_out", 0, 1)
  else
    self._mapNode.aniSafeRoot:Play("CharFgPanel_in")
  end
  self:RegisterRedDot()
  if self._panel.tbCharList ~= nil then
    self._mapNode.goTabSwitch.gameObject:SetActive(1 < #self._panel.tbCharList)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:RefreshTopBar()
  end
  
  cs_coroutine.start(wait)
end

function CharFgCtrl:OnDisable()
end

function CharFgCtrl:OnDestroy()
end

function CharFgCtrl:OnEvent_RefreshFg()
  self:RegisterRedDot()
end

function CharFgCtrl:OnEvent_ChangeTab(bOpen)
  if bOpen then
    self._mapNode.aniSafeRoot:Play("CharFgPanel_in")
  else
    self._mapNode.aniSafeRoot:Play("CharFgPanel_out")
  end
end

function CharFgCtrl:OnEvent_ChangeTopBar(bShowBack)
  self._mapNode.goBack:SetActive(bShowBack)
end

function CharFgCtrl:OnBtnClick_Tab(btn, nIndex)
  if self.nTab == nIndex then
    return
  end
  local nNextPanel = table.keyof(PanelToTab, nIndex)
  self._mapNode.imgMoveBar:DOLocalMoveX(MoveBarPos[nIndex], 0.1):SetUpdate(true)
  self._mapNode.imgOn[self.nTab]:SetActive(false)
  self._mapNode.txtTabOn[self.nTab].gameObject:SetActive(false)
  self._mapNode.layoutOff[self.nTab].gameObject:SetActive(true)
  self._mapNode.imgOn[nIndex]:SetActive(true)
  self._mapNode.txtTabOn[nIndex].gameObject:SetActive(true)
  self._mapNode.layoutOff[nIndex].gameObject:SetActive(false)
  self.nTab = nIndex
  if nNextPanel then
    EventManager.Hit(EventId.CharRelatePanelOpen, nNextPanel, self._panel.nCharId)
  end
end

function CharFgCtrl:OnEvent_SetTopBarText(sTitle)
  self._mapNode.TopBar:SetTitleTxt(sTitle)
end

function CharFgCtrl:OnBtnClick_SwitchLeft()
  EventManager.Hit("SwitchCurChar", true)
end

function CharFgCtrl:OnBtnClick_SwitchRight()
  EventManager.Hit("SwitchCurChar", false)
end

return CharFgCtrl
