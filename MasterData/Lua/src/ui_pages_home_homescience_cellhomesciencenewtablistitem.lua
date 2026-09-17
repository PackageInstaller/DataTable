local _TabTpl = L_GameTpl:getCommonTabTpl()
local module = class("cellHomeScienceNewTabListItem", G_UIModuleBase)
local _DefSelectColor = C_Color(0.588, 0.976, 1)
local _DefSelectHighColor = C_Color.white

function module.bind()
  return {
    id = 0,
    go_off = true,
    go_on = false,
    txt_nameOff = "",
    txt_nameOn = "",
    img_selected = "",
    img_selected_2 = "",
    color_selected = nil
  }
end

function module.methods()
  return {}
end

function module:open()
  local tpl = _TabTpl:getTplById(self.bind.id)
  self.bind.txt_name = L_Lang:get(_TabTpl:getName(tpl))
  self.bind.img_icon = _TabTpl:getIcon(tpl)
  self.bind.img_icon_d = self.bind.img_icon
  self.bind.tabId = self.bind.id
  self.bind.active_line = not self.bind.isLast
  self.bind.txt_nameOff = L_Lang:get(_TabTpl:getName(tpl))
  self.bind.txt_nameOn = self.bind.txt_nameOff
  self.bind.img_selected = _TabTpl:getIcon(tpl)
  self.bind.img_selected_2 = self.bind.img_selected
  local selectColor = _TabTpl:getColor(tpl)
  if string.isEmpty(selectColor) then
    self.bind.color_selected = _DefSelectHighColor
  else
    local _, color = C_ColorUtility.TryParseHtmlString(selectColor)
    self.bind.color_selected = color
  end
  if not string.isEmpty(self.bind.redKey) and self.bindComponents.transRed then
    L_ReddotManager:registerReddot(self.bindComponents.transRed, self.bind.redKey)
  end
end

return module
