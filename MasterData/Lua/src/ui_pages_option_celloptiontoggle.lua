local this = class("cellOptionToggle", G_UIModuleBase)
local _optionClassTpl = L_GameTpl:getOptionDataClassTpl()

function this.bind()
  return {
    itemId = 1,
    iconIn = nil,
    iconOff = nil,
    txtTitleIn = nil,
    txtTitleOff = nil,
    txtDecorationIn = "",
    txtDecorationOff = "",
    line = true
  }
end

function this:refresh()
  self.bind.txtTitleIn = self.bind.title
  self.bind.txtTitleOff = self.bind.title
  local tpl = _optionClassTpl:getTplById(self.bind.itemId)
  local decoration = _optionClassTpl:getDecoration(tpl)
  local icon = _optionClassTpl:getIcon(tpl)
  self.bind.txtDecorationIn = decoration
  self.bind.txtDecorationOff = decoration
  self.bind.iconIn = icon
  self.bind.iconOff = icon
  if self.bind.itemId == 8 then
    self.bind.line = false
  end
end

return this
