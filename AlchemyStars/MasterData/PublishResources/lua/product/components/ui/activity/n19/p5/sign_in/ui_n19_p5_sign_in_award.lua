_class("UIN19P5SignInAward", UICustomWidget)
UIN19P5SignInAward = UIN19P5SignInAward

function UIN19P5SignInAward:OnShow()
  self._iconRectDefaultSize = Vector2(175, 175)
  self.Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconRect = self:GetUIComponent("RectTransform", "Icon")
  self.pos = self:GetUIComponent("RectTransform", "pos")
  self.countPos = self:GetUIComponent("RectTransform", "Image")
  self.count = self:GetUIComponent("UILocalizationText", "count")
end

function UIN19P5SignInAward:Flush(idx, roleAsset, callback)
  local countPos
  if idx == 1 then
    countPos = Vector2(65, -68)
  else
    countPos = Vector2(47, -55)
  end
  self.countPos.anchoredPosition = countPos
  local pos = (idx - 1) * 18
  self.pos.anchoredPosition = Vector2(0, pos)
  self.callback = callback
  self.id = roleAsset.assetid
  local count = roleAsset.count
  self.count:SetText(count)
  local cfg = Cfg.cfg_item[self.id]
  if not cfg then
    Log.error("###[UIN19P5SignInAward] cfg is nil ! id --> ", self.id)
  end
  self.Icon:LoadImage(cfg.Icon)
  self:SetIcon()
end

function UIN19P5SignInAward:SetIcon()
  local isHead = false
  if self.id >= 3750000 and self.id <= 3759999 then
    isHead = true
  end
  if isHead then
    local whRate = 1
    if self.id >= 3751000 and self.id <= 3751999 then
      whRate = 0.8421052631578947
    elseif self.id >= 3752000 and self.id <= 3752999 then
      whRate = 0.6388888888888888
    elseif self.id >= 3753000 and self.id <= 3753999 then
      whRate = 0.6388888888888888
    end
    self._iconRect.sizeDelta = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.x * whRate)
  else
    self._iconRect.sizeDelta = self._iconRectDefaultSize
  end
end

function UIN19P5SignInAward:IconOnClick(go)
  if self.callback then
    self.callback(self.id, go)
  end
end
