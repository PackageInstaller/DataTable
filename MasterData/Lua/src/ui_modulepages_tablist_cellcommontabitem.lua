local _TabTpl = L_GameTpl:getCommonTabTpl()
local module = class("cellCommonTabItem", G_UIModuleBase)
local _DefSelectColor = C_Color(0.588, 0.976, 1)
local _DefSelectHighColor = C_Color.white

function module.bind()
  return {
    txt_name = "",
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
  self.bind.txt_name = L_Lang:get(_TabTpl:getName(tpl))
  self.bind.img_icon = _TabTpl:getIcon(tpl)
  self.bind.img_icon_d = _TabTpl:getIcon(tpl)
  self.bind.tabId = self.bind.id
  self.bind.active_line = not self.bind.isLast
  local selectColor = _TabTpl:getColor(tpl)
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
  if not string.isEmpty(self.bind.redKey) and self.bindComponents.transRed then
    L_ReddotManager:registerReddot(self.bindComponents.transRed, self.bind.redKey)
  end
  if self.bindComponents.imgLinePreComp then
    self.bindComponents.imgLinePreComp.gameObject:ActiveTrans(not self.bind.isStart)
  end
end

function module:setSelectStatus(isSelected)
  local alpha = isSelected and 1 or 0.75
  local fillAmount = isSelected and 0.5 or 1
  self:setComponentAlpha(self.bindComponents.txtNameComp, alpha)
  self:setComponentAlpha(self.bindComponents.imgIconComp, alpha)
  self:setComponentFillAmount(self.bindComponents.imgLinePreComp, fillAmount)
  self:setComponentFillAmount(self.bindComponents.imgLineBackComp, fillAmount)
end

function module:setComponentAlpha(component, alpha)
  if component == nil then
    return
  end
  local color = component.color
  color.a = alpha
  component.color = color
end

function module:setComponentFillAmount(component, value)
  if component == nil then
    return
  end
  component.fillAmount = value
end

return module
