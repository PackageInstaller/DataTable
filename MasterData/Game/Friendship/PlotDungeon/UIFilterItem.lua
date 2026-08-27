local UIFilterItem = class("UIFilterItem", UIBaseNode)
local base = UIBaseNode

function UIFilterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CampItem, self, self.__onclick)
end

function UIFilterItem:InitFWithData(careerId, isDouble, allText)
  self.careerId = careerId
  self.isDouble = isDouble
  if careerId == 0 then
    self.itemName = allText
  else
    local careerCfg = ConfigData.career[careerId]
    self.itemName = LanguageUtil.GetLocaleText(careerCfg.name)
  end
  self.ui.tex_CampName.text = self.itemName
end

function UIFilterItem:__onclick()
  if self.clickEvent ~= nil then
    self.clickEvent(self.careerId, self.itemName)
  end
end

function UIFilterItem:OnDelete()
  base.OnDelete(self)
end

return UIFilterItem
