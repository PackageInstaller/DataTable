local RaidCtrl = class("RaidCtrl", BaseCtrl)
RaidCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePop"
  },
  aniReward = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  RaidCount = {
    sNodeName = "---RaidCount---",
    sCtrlName = "Game.UI.Raid.RaidCountCtrl"
  },
  Reward = {
    sNodeName = "---Reward---",
    sCtrlName = "Game.UI.Raid.RaidRewardCtrl"
  }
}
RaidCtrl._mapEventConfig = {
  RaidShowReward = "OnEvent_Reward",
  RaidShowPop = "OnEvent_RaidShowPop",
  RaidEnableClose = "OnEvent_EnableClose"
}

function RaidCtrl:OpenCount()
  self.ctrlPop = self._mapNode.RaidCount
  self._mapNode.RaidCount:Open(self.nId, self.nEnergy, self.nType, self.nActId)
end

function RaidCtrl:OpenReward(tbReward, mapLevelBefore, mapChangeInfo)
  EventManager.Hit(EventId.SetTopBarVisible, false)
  self.ctrlPop = self._mapNode.Reward
  self._mapNode.Reward:Open(tbReward, mapLevelBefore, mapChangeInfo, self._mapNode.aniReward)
end

function RaidCtrl:Awake()
  self.ctrlPop = nil
  local tbParam = self:GetPanelParam()
  self.nActId = 0
  if type(tbParam) == "table" then
    self.nId = tbParam[1]
    self.nEnergy = tbParam[2]
    self.nType = tbParam[3]
    if tbParam[4] ~= nil then
      self.nActId = tbParam[4]
    end
  end
  self._mapNode.Reward.gameObject:SetActive(false)
  self._mapNode.RaidCount.gameObject:SetActive(false)
end

function RaidCtrl:OnEnable()
  self._mapNode.blur:SetActive(true)
  self:OpenCount()
  self._mapNode.TopBar:AddEnergyAddBtnCallBack(function()
    EventManager.Hit(EventId.ClosePanel, PanelId.Raid)
  end)
end

function RaidCtrl:OnDisable()
end

function RaidCtrl:OnDestroy()
end

function RaidCtrl:OnEvent_Reward(tbReward, mapLevelBefore, mapChangeInfo)
  self._mapNode.btnBlur.interactable = false
  if self.ctrlPop then
    self.ctrlPop:PlayOutAni()
    self.ctrlPop = nil
  end
  self:AddTimer(1, 0.2, function()
    self:OpenReward(tbReward, mapLevelBefore, mapChangeInfo)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function RaidCtrl:OnEvent_RaidShowPop(bShow)
  if not bShow then
    self:OnBtnClick_ClosePop()
  else
    self.gameObject:SetActive(true)
    self._mapNode.blur:SetActive(true)
    self:OpenCount()
  end
end

function RaidCtrl:OnBtnClick_ClosePop()
  EventManager.Hit(EventId.SetTopBarVisible, true)
  if self.ctrlPop then
    self.ctrlPop:PlayOutAni()
    self.ctrlPop = nil
  end
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    self._mapNode.blur:SetActive(false)
    EventManager.Hit(EventId.ClosePanel, PanelId.Raid)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function RaidCtrl:OnEvent_EnableClose()
  self._mapNode.btnBlur.interactable = true
end

return RaidCtrl
