_class("UIDiscoveryGiftControllerAward", UICustomWidget)
UIDiscoveryGiftControllerAward = UIDiscoveryGiftControllerAward

function UIDiscoveryGiftControllerAward:Constructor()
end

function UIDiscoveryGiftControllerAward:OnShow()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._tex = self:GetUIComponent("UILocalizationText", "tex")
  self._anim = self:GetUIComponent("Animation", "UIDiscoveryGiftControllerAward")
  self._alpha = self:GetUIComponent("CanvasGroup", "Root")
end

function UIDiscoveryGiftControllerAward:OnHide()
end

function UIDiscoveryGiftControllerAward:SetData(award, click, yieldTime)
  self._click = click
  self._award = award
  local assetid = self._award.templateId
  local count = self._award.count
  self._itemid = assetid
  local cfg = Cfg.cfg_item[assetid]
  self._icon:LoadImage(cfg.Icon)
  self._tex:SetText(count)
  if yieldTime and 0 < yieldTime then
    self._alpha.alpha = 0
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._anim:Play("uieff_UIDiscoveryGiftControllerAward_in")
    end)
  else
    self._alpha.alpha = 1
  end
end

function UIDiscoveryGiftControllerAward:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIDiscoveryGiftControllerAward:IconOnClick(go)
  if self._click then
    self._click(self._itemid, go.transform.position)
  end
end
