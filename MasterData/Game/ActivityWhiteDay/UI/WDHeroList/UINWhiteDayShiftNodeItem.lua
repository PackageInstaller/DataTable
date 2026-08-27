local UINWhiteDayShiftNodeItem = class("UINWhiteDayShiftNodeItem", UIBaseNode)
local base = UIBaseNode

function UINWhiteDayShiftNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_optionItem, self, self.__OnClick)
end

function UINWhiteDayShiftNodeItem:InitWDShiftItem(typeCfg, clickCallback)
  if typeCfg == nil then
    self.typeIndex = nil
    self.ui.img_Icon.gameObject:SetActive(false)
    self.ui.tex_Option:SetIndex(1)
  else
    self.typeIndex = typeCfg.group_id
    self.ui.img_Icon.gameObject:SetActive(true)
    self.ui.img_Icon:SetIndex(self.typeIndex - 1)
    self.ui.tex_Option:SetIndex(0, LanguageUtil.GetLocaleText(typeCfg.effect_text))
  end
  self.clickCallback = clickCallback
end

function UINWhiteDayShiftNodeItem:__OnClick()
  if self.clickCallback ~= nil then
    self.clickCallback(self.typeIndex)
  end
end

function UINWhiteDayShiftNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayShiftNodeItem
