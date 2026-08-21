_class("UI_CN6_N35_GameClothesAward", UICustomWidget)
UI_CN6_N35_GameClothesAward = UI_CN6_N35_GameClothesAward

function UI_CN6_N35_GameClothesAward:OnShow()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._count = self:GetUIComponent("UILocalizedTMP", "count")
end

function UI_CN6_N35_GameClothesAward:SetData(icon, count, callback)
  self._icon:LoadImage(icon)
  self._count:SetText(tostring(count))
  self._callback = callback
end

function UI_CN6_N35_GameClothesAward:IconOnClick(go)
  if self._callback then
    local pos = go.transform.position
    self._callback(pos)
  end
end
