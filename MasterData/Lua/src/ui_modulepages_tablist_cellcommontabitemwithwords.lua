local _TabTpl = L_GameTpl:getCommonTabTpl()
local module = class("cellCommonTabItemWithWords", G_UIModuleBase)
local _DefSelectColor = C_Color(0.588, 0.976, 1)
local _DefSelectHighColor = C_Color.white

function module.bind()
  return {
    txt_name_on = "",
    txt_name_off = "",
    img_icon = "",
    img_icon_d = "",
    color_selected_circle = _DefSelectColor,
    color_selected_point = _DefSelectColor,
    color_selected_high = _DefSelectHighColor,
    tabId = -1,
    active_line = false
  }
end

function module.methods()
  return {}
end

function module:open()
  local tpl = _TabTpl:getTplById(self.bind.id)
  self.bind.txt_name_on = L_Lang:get(_TabTpl:getName(tpl))
  self.bind.txt_name_off = L_Lang:get(_TabTpl:getName(tpl))
  self.bind.img_icon = _TabTpl:getIcon(tpl)
  self.bind.img_icon_d = _TabTpl:getIcon(tpl)
  self.bind.tabId = self.bind.id
  self.bind.active_line = not self.bind.isLast
  local selectColor = ""
  if string.isEmpty(self.bind.customColor) then
    selectColor = _TabTpl:getColor(tpl)
    if string.isEmpty(selectColor) then
      self.bind.color_selected_circle = _DefSelectColor
      self.bind.color_selected_point = _DefSelectColor
      self.bind.color_selected_high = _DefSelectHighColor
    else
      local _, color = C_ColorUtility.TryParseHtmlString(selectColor)
      self.bind.color_selected_circle = color
      self.bind.color_selected_point = color
      self.bind.color_selected_high = color
    end
  else
    local _, customColor = C_ColorUtility.TryParseHtmlString(self.bind.customColor)
    selectColor = customColor
    self.bind.color_selected_circle = customColor
    self.bind.color_selected_point = customColor
    self.bind.color_selected_high = customColor
  end
  if not string.isEmpty(self.bind.redKey) and self.bindComponents.transRed then
    L_ReddotManager:registerReddot(self.bindComponents.transRed, self.bind.redKey)
  end
end

return module
