local AchievementCtrl = class("AchievementCtrl", BaseCtrl)
AchievementCtrl._mapNodeConfig = {
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btnAchievement = {
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_Detail"
  },
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rtHomePage = {
    sCtrlName = "Game.UI.AchievementEx.AchievementHomepageCtrl"
  },
  rtDetail = {
    sCtrlName = "Game.UI.AchievementEx.AchievementDetailCtrl"
  }
}
AchievementCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome"
}
AchievementCtrl._mapRedDotConfig = {}

function AchievementCtrl:Awake()
end

function AchievementCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
  self._mapNode.animRoot:Play("AchievementPanel_in")
end

function AchievementCtrl:FadeOut()
end

function AchievementCtrl:OnEnable()
  self._mapNode.rtHomePage.gameObject:SetActive(false)
  self._mapNode.rtDetail.gameObject:SetActive(false)
  
  local function callback()
    self._mapNode.rtHomePage:OnEvent_ReceiveReward()
    self._mapNode.rtDetail:UpdateData()
    if self._panel.nDetailIdx ~= nil and self._panel.nDetailIdx > 0 then
      self._mapNode.rtDetail.gameObject:SetActive(true)
      self._mapNode.rtDetail:OpenDetail(self._panel.nDetailIdx)
      self.bDetail = true
    else
      self._mapNode.rtHomePage.gameObject:SetActive(true)
    end
    PlayerData.Achievement:CheckReddot()
  end
  
  PlayerData.Achievement:SendAchievementInfoReq(callback)
  self.bDetail = false
  self:RegisterReddot()
end

function AchievementCtrl:OnDisable()
end

function AchievementCtrl:OnDestroy()
end

function AchievementCtrl:OnRelease()
end

function AchievementCtrl:OnBtnClick_Detail(btn, nIdx)
  self._mapNode.rtDetail:OpenDetail(nIdx)
  self._mapNode.rtHomePage.gameObject:SetActive(false)
  self._mapNode.rtDetail.gameObject:SetActive(true)
  self.bDetail = true
  self._panel.nDetailIdx = nIdx
end

function AchievementCtrl:RegisterReddot(...)
  for k, v in pairs(self._mapNode.btnAchievement) do
    local goReddot = v.transform:Find("AnimRoot/reddot").gameObject
    RedDotManager.RegisterNode(RedDotDefine.Achievement_Tab, k, goReddot)
  end
end

function AchievementCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.bDetail then
    self._mapNode.rtHomePage.gameObject:SetActive(true)
    self._mapNode.rtDetail.gameObject:SetActive(false)
    self.bDetail = false
    self._panel.nDetailIdx = 0
    self._mapNode.animRoot:Play("AchievementPanel_in")
  else
    self._panel.nDetailIdx = 0
    EventManager.Hit(EventId.CloesCurPanel)
  end
end

function AchievementCtrl:OnEvent_BackHome(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self._panel.nDetailIdx = 0
  PanelManager.Home()
end

return AchievementCtrl
