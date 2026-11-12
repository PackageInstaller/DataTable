local DormInteractiveAffinityCtrl = class("DormInteractiveAffinityCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DormInteractiveAffinityCtrl._mapNodeConfig = {
  rtProgress = {
    sNodeName = "---progress---"
  },
  rtReward = {
    sNodeName = "---reward---"
  },
  rtChar = {
    nCount = 6,
    sCtrlName = "Game.UI.Dorm.DormInteractive.DormInteractiveAffinityCharGridCtrl"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
DormInteractiveAffinityCtrl._mapEventConfig = {}
DormInteractiveAffinityCtrl._mapRedDotConfig = {}

function DormInteractiveAffinityCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function DormInteractiveAffinityCtrl:FadeIn()
end

function DormInteractiveAffinityCtrl:FadeOut()
end

function DormInteractiveAffinityCtrl:OnEnable()
  local param = self:GetPanelParam()
  self.tbData = param[1]
  self.callback = param[2]
  self:Refresh()
  self.animator:Play("DormCharInteractivePanel_in")
  WwiseAudioMgr:PostEvent("Home_UI_favourup")
  EventManager.Hit(EventId.TemporaryBlockInput, 3.3)
end

function DormInteractiveAffinityCtrl:OnDisable()
end

function DormInteractiveAffinityCtrl:OnDestroy()
end

function DormInteractiveAffinityCtrl:OnRelease()
end

function DormInteractiveAffinityCtrl:Refresh()
  for i = 1, 6 do
    if self.tbData[i] ~= nil then
      self._mapNode.rtChar[i].gameObject:SetActive(true)
      local nCharId = self.tbData[i].AffinityInfo.CharId
      local nGiftId = self.tbData[i].ItemInfo.Tid
      local nAffinity = self.tbData[i].AffinityInfo.nExpChange or 0
      self._mapNode.rtChar[i]:Refresh(nCharId, nAffinity, nGiftId)
    else
      self._mapNode.rtChar[i].gameObject:SetActive(false)
    end
  end
end

function DormInteractiveAffinityCtrl:OnBtnClick_Close(btn)
  self.animator:Play("DormCharInteractivePanel_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, function()
    if self.callback ~= nil and type(self.callback) == "function" then
      self.callback()
    end
    EventManager.Hit(EventId.ClosePanel, PanelId.DormInteractiveAffinityPanel)
  end, true, true, true, nil)
end

return DormInteractiveAffinityCtrl
