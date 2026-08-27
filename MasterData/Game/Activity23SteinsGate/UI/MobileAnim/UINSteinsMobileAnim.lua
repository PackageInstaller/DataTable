local base = UIBaseNode
local UINSteinsMobileAnim = class("UINSteinsMobileAnim", base)

function UINSteinsMobileAnim:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSteinsMobileAnim:PlayTextureAnim(isBack, mobileGo, callback)
  mobileGo:SetActive(false)
  self._animIdx = isBack and #self.ui.textureList or 1
  self:_SetTexture()
  self.ui.rawImg.enabled = true
  self._animTimer = TimerManager:StartTimer(0.03, function()
    self._animIdx = self._animIdx + (isBack and -1 or 1)
    if self._animIdx > #self.ui.textureList or self._animIdx <= 0 then
      self.ui.rawImg.enabled = false
      if not isBack and self._animIdx == #self.ui.textureList then
        return
      end
      mobileGo:SetActive(true)
      TimerManager:StopTimer(self._animTimer)
      if callback then
        callback()
      end
      return
    end
    self:_SetTexture()
  end, self, false)
end

function UINSteinsMobileAnim:_SetTexture()
  self.ui.rawImg.texture = self.ui.textureList[self._animIdx]
end

function UINSteinsMobileAnim:OnDelete()
  TimerManager:StopTimer(self._animTimer)
  base.OnDelete(self)
end

return UINSteinsMobileAnim
