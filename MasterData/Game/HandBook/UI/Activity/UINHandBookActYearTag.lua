local UINHandBookActYearTag = class("UINHandBookActYearTag", UIBaseNode)
local base = UIBaseNode

function UINHandBookActYearTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.yearItem, self, self.OnClickActYearTag)
end

function UINHandBookActYearTag:InitHandBookActYearTag(year, callback)
  self._year = year
  self.ui.tex_Year.text = tostring(self._year)
  self._callback = callback
end

function UINHandBookActYearTag:RefreshActYearTag(year)
  local flag = self._year == year
  self.ui.img_Selected:SetActive(flag)
  local color = self.ui.tex_Year.color
  color.a = flag and 1 or 0.2
  self.ui.tex_Year.color = color
end

function UINHandBookActYearTag:OnClickActYearTag()
  if self._callback ~= nil then
    self._callback(self._year)
  end
end

return UINHandBookActYearTag
