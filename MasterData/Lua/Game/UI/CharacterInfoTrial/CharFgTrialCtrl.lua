local CharFgTrialCtrl = class("CharFgTrialCtrl", BaseCtrl)
local MoveBarPos = {
  -483.6,
  -162,
  159.6,
  481.2
}
local PanelToTab = {
  [PanelId.CharInfoTrial] = 1,
  [PanelId.CharSkillTrial] = 2,
  [PanelId.CharPotentialTrial] = 3,
  [PanelId.CharTalentTrial] = 4
}
local TabTextKey = {
  "CharacterInfo_Tab1",
  "CharacterInfo_Tab2",
  "CharacterInfo_Tab4",
  "CharacterInfo_Tab5"
}
CharFgTrialCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goBack = {},
  goResBarAnimRoot = {},
  btnTab = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  imgOn = {nCount = 4},
  txtTabOn = {nCount = 4, sComponentName = "TMP_Text"},
  txtTabOff = {nCount = 4, sComponentName = "TMP_Text"},
  layoutOff = {nCount = 4},
  imgMoveBar = {sComponentName = "Transform"},
  Tab = {sNodeName = "--Tab--"},
  aniSafeRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  }
}
CharFgTrialCtrl._mapEventConfig = {
  RefreshCharFg = "OnEvent_RefreshFg",
  RefreshCharTopBar = "RefreshTopBar",
  RefreshCharTopBarText = "OnEvent_SetTopBarText",
  ChangeCharFgTab = "OnEvent_ChangeTab",
  ChangeCharTopBar = "OnEvent_ChangeTopBar"
}

function CharFgTrialCtrl:InitTab()
  self.nTab = PanelToTab[self._panel.nPanelId]
  self._mapNode.imgMoveBar.localPosition = Vector3(MoveBarPos[self.nTab], 4.5, 0)
  for i = 1, 4 do
    NovaAPI.SetTMPText(self._mapNode.txtTabOn[i], ConfigTable.GetUIText(TabTextKey[i]))
    NovaAPI.SetTMPText(self._mapNode.txtTabOff[i], ConfigTable.GetUIText(TabTextKey[i]))
    self._mapNode.imgOn[i]:SetActive(PanelToTab[self._panel.nPanelId] == i)
    self._mapNode.txtTabOn[i].gameObject:SetActive(PanelToTab[self._panel.nPanelId] == i)
    self._mapNode.layoutOff[i].gameObject:SetActive(PanelToTab[self._panel.nPanelId] ~= i)
  end
end

function CharFgTrialCtrl:RefreshTopBar()
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
      end
    else
      self._mapNode.TopBar.gameObject:SetActive(false)
    end
  end
  if self._panel.bSecondPanel then
    self:OnEvent_ChangeTopBar(false, true)
  end
end

function CharFgTrialCtrl:Awake()
  self:InitTab()
end

function CharFgTrialCtrl:OnEnable()
  self.tbPanelCfg = self._panel:GetPanelShowCfg()
  local tbSubPanel = self._panel:GetSubPanel()
  if tbSubPanel[self._panel.nPanelId] or self._panel.bSecondPanel then
    self._mapNode.aniSafeRoot:Play("CharFgPanel_out", 0, 1)
  else
    self._mapNode.aniSafeRoot:Play("CharFgPanel_in")
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:RefreshTopBar()
  end
  
  cs_coroutine.start(wait)
end

function CharFgTrialCtrl:OnDisable()
end

function CharFgTrialCtrl:OnDestroy()
end

function CharFgTrialCtrl:OnEvent_RefreshFg()
end

function CharFgTrialCtrl:OnEvent_ChangeTab(bOpen)
  if bOpen then
    self._mapNode.aniSafeRoot:Play("CharFgPanel_in")
  else
    self._mapNode.aniSafeRoot:Play("CharFgPanel_out")
  end
end

function CharFgTrialCtrl:OnEvent_ChangeTopBar(bShowBack, bShowRes)
  self._mapNode.goBack:SetActive(bShowBack)
  self._mapNode.goResBarAnimRoot:SetActive(bShowRes)
end

function CharFgTrialCtrl:OnBtnClick_Tab(btn, nIndex)
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

function CharFgTrialCtrl:OnEvent_SetTopBarText(sTitle)
  self._mapNode.TopBar:SetTitleTxt(sTitle)
end

return CharFgTrialCtrl
