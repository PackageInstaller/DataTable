local UINTaskVer2DayItem = class("UINTaskVer2DayItem", UIBaseNode)
local base = UIBaseNode

function UINTaskVer2DayItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickSelect)
end

function UINTaskVer2DayItem:InitTaskVer2DayItem(heroGrowData, day, callback)
  self._heroGrowData = heroGrowData
  self._day = day
  self._callback = callback
  self.ui.text:SetIndex(0, tostring(self._day))
  self.ui.bottom:SetActive(false)
end

function UINTaskVer2DayItem:RefreshTaskVer2DayState()
  local unlock = self._heroGrowData:IsHeroGrowDailyTaskIsUnlock(self._day)
  self.ui.blueDot:SetActive(unlock and not self._heroGrowData:IsLookedHeroGrowDailyTask(self._day))
  if not self.__isSelect then
    self.ui.text.text.color = unlock and self.ui.color_unlock or self.ui.color_locked
  end
end

function UINTaskVer2DayItem:RefreshTaskVer2DaySelect(day)
  self.__isSelect = day == self._day
  self.ui.bottom:SetActive(self.__isSelect)
  if self.__isSelect then
    self.ui.text.text.color = self.ui.color_selected
  else
    self:RefreshTaskVer2DayState()
  end
end

function UINTaskVer2DayItem:OnClickSelect()
  if self._callback ~= nil then
    self._callback(self._day)
  end
end

return UINTaskVer2DayItem
