local SuccessBarCtrl = class("SuccessBarCtrl", BaseCtrl)
local nFrameHeight = 70
local nStartHeight = 48
SuccessBarCtrl._mapNodeConfig = {
  BarBg = {
    sComponentName = "RectTransform"
  },
  aniFrame = {sNodeName = "imgFrameBg", sComponentName = "Animator"},
  rtFrame = {
    sNodeName = "imgFrameBg",
    sComponentName = "RectTransform"
  },
  Mask = {
    sComponentName = "RectTransform"
  }
}
SuccessBarCtrl._mapEventConfig = {}

function SuccessBarCtrl:PlayAni(nType, tbAni, nSpeed)
  self.tbAni = tbAni
  self._mapNode.aniFrame:Play("SuccessBar_in" .. nType)
  local nTime = 0.6
  if nSpeed then
    self._mapNode.aniFrame.speed = nSpeed
    nTime = 0.6 / nSpeed
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:AddTimer(1, nTime, "PlayContentAni", true, true, true)
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.BlockInput, true)
end

function SuccessBarCtrl:PlayContentAni()
  local nAniCount = #self.tbAni
  local nHeight = self._mapNode.BarBg.rect.height
  local nTotalHeight = (nHeight + nFrameHeight) / 2 - nStartHeight
  self._mapNode.aniFrame.enabled = false
  self._mapNode.rtFrame:DOLocalMoveY(nTotalHeight, 0.167):SetUpdate(true):SetEase(Ease.OutCubic)
  self._mapNode.Mask:DOSizeDelta(Vector2(0, nHeight), 0.167):SetUpdate(true):SetEase(Ease.OutCubic)
  local sequence = DOTween.Sequence()
  for i = 1, nAniCount do
    sequence:AppendCallback(function()
      if self.tbAni[i].bMulti then
        for _, v in ipairs(self.tbAni[i]) do
          v:SetTrigger("tIn")
        end
      else
        self.tbAni[i]:SetTrigger("tIn")
      end
      if i == nAniCount then
        EventManager.Hit(EventId.BlockInput, false)
        self:StartShowSkinPanel()
      end
    end)
    sequence:AppendInterval(0.067)
    sequence:SetUpdate(true)
  end
end

function SuccessBarCtrl:StartShowSkinPanel()
  if PlayerData.CharSkin:CheckNewSkin() then
    self:AddTimer(1, 0.8, function()
      PlayerData.CharSkin:TryOpenSkinShowPanel()
      self:ClosePanel()
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.8)
  end
end

function SuccessBarCtrl:ClosePanel()
  if self._panel.callback then
    self._panel.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.CharSucBar)
end

function SuccessBarCtrl:Awake()
end

function SuccessBarCtrl:OnEnable()
end

function SuccessBarCtrl:OnDisable()
  EventManager.Hit(EventId.BlockInput, false)
  if not PanelManager.CheckPanelOpen(PanelId.ReceiveSpecialReward) then
    PlayerData.CharSkin:TryOpenSkinShowPanel()
  end
end

function SuccessBarCtrl:OnDestroy()
end

return SuccessBarCtrl
