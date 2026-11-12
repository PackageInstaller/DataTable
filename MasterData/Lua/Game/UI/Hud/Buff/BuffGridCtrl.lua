local BuffGridCtrl = class("BuffGridCtrl", BaseCtrl)
local nImpendingTime = 2
local DefaultWidth = 46
local DefaultHeight = 64
BuffGridCtrl._mapNodeConfig = {
  imgBuffBg = {sComponentName = "Image"},
  TMPCount = {sComponentName = "TMP_Text"},
  canvasGroup = {
    sComponentName = "CanvasGroup",
    sNodeName = "imgBuffBg"
  }
}
BuffGridCtrl._mapEventConfig = {}

function BuffGridCtrl:Awake()
end

function BuffGridCtrl:FadeIn()
end

function BuffGridCtrl:FadeOut()
end

function BuffGridCtrl:OnEnable()
  self.compRtAnim = self.gameObject:GetComponent(typeof(CS.HpBarRectTransform))
  self.rootAnim = self.gameObject:GetComponent("Animator")
  self.rtRoot = self.gameObject:GetComponent("RectTransform")
  self.timer = nil
end

function BuffGridCtrl:OnDisable()
end

function BuffGridCtrl:OnDestroy()
end

function BuffGridCtrl:OnRelease()
end

function BuffGridCtrl:SetBuff(nBuffId, nCount, nTime)
  self.rtRoot.sizeDelta = Vector2(DefaultWidth, DefaultHeight)
  local mapBuff = ConfigTable.GetData_Buff(nBuffId)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 1)
  self:SetPngSprite(self._mapNode.imgBuffBg, mapBuff.Icon)
  self.rootAnim:Play("rtBuff_in")
  if 99 < nCount then
    NovaAPI.SetTMPText(self._mapNode.TMPCount, "99+")
  elseif 1 < nCount then
    NovaAPI.SetTMPText(self._mapNode.TMPCount, string.format("%d", nCount))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPCount, "")
  end
  if nTime < 0 then
    if self.timer ~= nil then
      self.timer:Cancel()
      self.timer = nil
    end
  elseif nTime <= nImpendingTime then
    self:BuffImpendingAnim(0, true)
    if self.timer ~= nil then
      self.timer:Cancel()
      self.timer = nil
    end
  else
    self:BuffImpendingAnim(0, false)
    if self.timer ~= nil then
      self.timer:Cancel()
    end
    self.timer = self:AddTimer(1, nTime - nImpendingTime, "BuffImpendingAnim", true, true, nil, true)
  end
end

function BuffGridCtrl:SetShield()
  if self.timer ~= nil then
    self.timer:Cancel()
  end
  self.timer = nil
  self.rtRoot.sizeDelta = Vector2(DefaultWidth, DefaultHeight)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 1)
  self:SetPngSprite(self._mapNode.imgBuffBg, "Icon/Buff/Icon_CommonBuff_Shield")
  NovaAPI.SetTMPText(self._mapNode.TMPCount, "")
  self.rootAnim:Play("rtBuff_in")
end

function BuffGridCtrl:CancelBuff(callback)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  self.compRtAnim:SetTarget(Vector2(0, DefaultHeight), 0.5, 0)
  if self.timer ~= nil then
    self.timer:Cancel()
  end
  self:BuffImpendingAnim(0, false)
  self.rootAnim:Play("rtBuff_out")
  
  local function EndCallback()
    if callback ~= nil then
      callback()
    end
  end
  
  self.timer = self:AddTimer(1, 0.5, EndCallback, true, true, nil, true)
end

function BuffGridCtrl:BuffImpendingAnim(_, bShow)
  if bShow then
    self.rootAnim:Play("rtBuff_Impending")
  else
    self.rootAnim:Play("Empty")
  end
end

function BuffGridCtrl:InterrputAnim()
  self.compRtAnim.enabled = false
end

return BuffGridCtrl
