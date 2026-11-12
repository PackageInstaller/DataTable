local QuestNewbieCtrl = class("QuestNewbieCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local ConfigData = require("GameCore.Data.ConfigData")
QuestNewbieCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rtTeamFormation = {
    sCtrlName = "Game.UI.QuestNewbie.TeamFormation.QuestNewbieFormationCtrl"
  },
  rtTutorial = {
    sCtrlName = "Game.UI.QuestNewbie.Tutorial.TutorialLevelCtrl"
  },
  goTutorialBg = {},
  btnTab = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  imgLock = {nCount = 2},
  tabUnlock = {nCount = 2},
  cvTabLayout = {
    nCount = 2,
    sNodeName = "layoutOff",
    sComponentName = "CanvasGroup"
  },
  imgOn = {nCount = 2},
  trTabOff = {
    sComponentName = "RectTransform"
  },
  trTabOn = {
    sComponentName = "RectTransform"
  },
  txtTabOn = {nCount = 2, sComponentName = "TMP_Text"},
  txtTabOff = {nCount = 2, sComponentName = "TMP_Text"},
  rtImgMoveBar = {
    sNodeName = "imgMoveBar",
    sComponentName = "RectTransform"
  },
  layoutOff = {nCount = 2},
  redDot = {nCount = 2}
}
QuestNewbieCtrl._mapEventConfig = {
  QuestNewbiePanelChangeTab = "OnEvent_ChangeTab"
}
QuestNewbieCtrl._mapRedDotConfig = {
  [RedDotDefine.TaskNewbie_TeamFormation] = {sNodeName = "redDot", nNodeIndex = 1},
  [RedDotDefine.TaskNewbie_Tutorial] = {sNodeName = "redDot", nNodeIndex = 2}
}
local MoveBarPos = {
  [1] = 0,
  [2] = 120
}
local functionType = {
  [1] = GameEnum.OpenFuncType.DailyQuest,
  [2] = GameEnum.OpenFuncType.TutorialLevel
}

function QuestNewbieCtrl:RefreshContent()
  self._mapNode.rtTeamFormation.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestNewbieTab.TeamFormation)
  self._mapNode.rtTutorial.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestNewbieTab.Tutorial)
  self._mapNode.goTutorialBg.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestNewbieTab.Tutorial)
  if self._panel.nCurTab == AllEnum.QuestNewbieTab.Tutorial then
    PlayerData.TutorialData:RefreshRedDot(false)
    self._mapNode.rtTutorial:Refresh()
  elseif self._panel.nCurTab == AllEnum.QuestNewbieTab.TeamFormation then
    self._mapNode.rtTeamFormation:Refresh()
  end
  self.nLastTab = self._panel.nCurTab
end

function QuestNewbieCtrl:InitTab()
  self._mapNode.rtImgMoveBar.localPosition = Vector3(MoveBarPos[self._panel.nCurTab], 4.5, 0)
  for i = 1, #self._mapNode.txtTabOn do
    NovaAPI.SetTMPText(self._mapNode.txtTabOn[i], ConfigTable.GetUIText("QuestNewbiePanel_Tab_" .. i))
    NovaAPI.SetTMPText(self._mapNode.txtTabOff[i], ConfigTable.GetUIText("QuestNewbiePanel_Tab_" .. i))
    self._mapNode.imgOn[i]:SetActive(self._panel.nCurTab == i)
    self._mapNode.txtTabOn[i].gameObject:SetActive(self._panel.nCurTab == i)
    self._mapNode.layoutOff[i].gameObject:SetActive(self._panel.nCurTab ~= i)
  end
end

function QuestNewbieCtrl:InitMoveBarPos()
  MoveBarPos = {}
  for i = 1, #self._mapNode.txtTabOn do
    local tab = self._mapNode.trTabOn:Find("tab" .. i)
    if tab.gameObject.activeSelf then
      local pos = tab.localPosition.x
      MoveBarPos[i] = pos
    end
  end
end

function QuestNewbieCtrl:RefreshTabUnlock()
  for i = 1, #self._mapNode.txtTabOn do
    local nFuncType = functionType[i]
    local bUnlock = false
    if nFuncType == 0 then
      bUnlock = true
    else
      bUnlock = PlayerData.Base:CheckFunctionUnlock(nFuncType, false)
    end
    self._mapNode.imgLock[i].gameObject:SetActive(not bUnlock)
    self._mapNode.tabUnlock[i].gameObject:SetActive(bUnlock)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cvTabLayout[i], bUnlock and 1 or 0.5)
  end
end

function QuestNewbieCtrl:OnBtnClick_Tab(btn, nIndex)
  if self._panel.nCurTab == nIndex then
    return
  end
  local nFuncType = functionType[nIndex]
  if nFuncType ~= 0 then
    local bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(nFuncType, true)
    if not bFuncUnlock then
      return
    end
  end
  self._mapNode.imgOn[self._panel.nCurTab]:SetActive(false)
  self._mapNode.rtImgMoveBar:DOLocalMoveX(MoveBarPos[nIndex], 0.1):SetUpdate(true)
  self._mapNode.txtTabOn[self._panel.nCurTab].gameObject:SetActive(false)
  self._mapNode.layoutOff[self._panel.nCurTab].gameObject:SetActive(true)
  self._mapNode.imgOn[nIndex]:SetActive(true)
  self._mapNode.txtTabOn[nIndex].gameObject:SetActive(true)
  self._mapNode.layoutOff[nIndex].gameObject:SetActive(false)
  self._panel.nCurTab = nIndex
  self:RefreshContent()
end

function QuestNewbieCtrl:OnEvent_ChangeTab(nJumpTab)
  self._panel.nCurTab = nJumpTab
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:InitMoveBarPos()
    self:InitTab()
    self:RefreshTabUnlock()
    self:RefreshContent()
    EventManager.Hit(EventId.SetTransition)
  end
  
  cs_coroutine.start(wait)
end

function QuestNewbieCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nJumpTab = 0
  if nil ~= next(tbParam) then
    nJumpTab = tbParam[1]
  end
  if self._panel.nCurTab == nil then
    local nTotalCount, nReceivedCount = PlayerData.TutorialData:GetProgress()
    local bTutorialComplete = nTotalCount <= nReceivedCount
    local bTeamFormationComplete = PlayerData.Quest:CheckTeamFormationAllCompleted()
    self._panel.nCurTab = AllEnum.QuestNewbieTab.TeamFormation
    if bTeamFormationComplete and not bTutorialComplete then
      self._panel.nCurTab = AllEnum.QuestNewbieTab.Tutorial
    end
  end
  self.nLastTab = 0
  if nJumpTab ~= 0 then
    self._panel.nCurTab = nJumpTab
  end
  local sAnimName = "QuestNewbiePanel_in"
  local nAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {sAnimName})
  self.animRoot:Play(sAnimName, 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:InitMoveBarPos()
    self:InitTab()
    self:RefreshTabUnlock()
    self:RefreshContent()
    EventManager.Hit(EventId.SetTransition)
  end
  
  cs_coroutine.start(wait)
end

function QuestNewbieCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

return QuestNewbieCtrl
