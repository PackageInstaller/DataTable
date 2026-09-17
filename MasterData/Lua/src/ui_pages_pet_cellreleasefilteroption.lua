local this = class("cellReleaseFilterOption", G_UIModuleBase)
local ActiveColor = C_Color(1, 1, 1, 1)
local NormalColor = C_Color(0, 0, 0, 0.3)
local filterContentTpl = L_GameTpl:getSystemFiltercontentTpl()

function this.bind()
  return {
    go_icon = true,
    img_icon = nil,
    iconStr = nil,
    showIcon = false,
    showFilterIcon = false,
    color_icon = ActiveColor,
    txt_name = "",
    txt_name_on = "",
    go_active = false,
    singleOff = false,
    singleOn = false,
    multiOff = false,
    multiOn = false,
    go_sortIndex = false,
    txt_sortIndex = "",
    go_icon_off = true,
    go_icon_on = true,
    img_item_on = nil,
    img_item_off = nil,
    go_item_off = false,
    go_item_on = false,
    active_item_img_on = true,
    active_item_img_off = true,
    active_sort_img_on = false,
    active_sort_img_off = false
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      local curActive = self.bind.go_active
      if curActive and self.bind.keepOneSelected then
        return
      end
      self:emit("onClick_select", self.bind.subId, not curActive)
    end
  }
end

function this:refresh()
  if not self.isBind then
    return
  end
  local tpl = filterContentTpl:getTplById(self.bind.subId)
  self.bind.name = filterContentTpl:getFilterContent(tpl)
  self:updateIcon()
  self:setActive(self.bind.go_active)
end

function this:updateIcon()
  local icon = self.bind.iconStr or self.bind.img_icon
  local showIcon = self.bind.showIcon or self.bind.showFilterIcon or not string.isEmpty(icon)
  self.bind.go_icon_off = not showIcon
  self.bind.go_icon_on = not showIcon
  self.bind.go_item_off = showIcon
  self.bind.go_item_on = showIcon
  self.bind.active_item_img_on = true
  self.bind.active_item_img_off = true
  self.bind.active_sort_img_on = false
  self.bind.active_sort_img_off = false
  if showIcon then
    self.bind.img_item_off = icon
    self.bind.img_item_on = icon
  end
end

function this:setActive(active)
  self.bind.go_active = active
  local txtColor = active and L_Const.colorHtml.white001 or L_Const.colorHtml.grey003
  self.bind.txt_name = L_GameUtil.fillColor(self.bind.name, txtColor)
  self.bind.txt_name_on = L_GameUtil.fillColor(self.bind.name, txtColor)
  local hasFilterIcon = self.bind.showIcon or self.bind.showFilterIcon or not string.isEmpty(self.bind.iconStr or self.bind.img_icon)
  self.bind.go_icon = hasFilterIcon or not active
  self:updateIcon()
  self.bind.color_icon = active and ActiveColor or NormalColor
  self:setActiveSingleOrMultiOn(self.bind.keepOneSelected)
end

function this:setSortIndex(active, index)
  self.bind.go_sortIndex = active
  self.bind.txt_sortIndex = tostring(index)
  local hasFilterIcon = self.bind.showIcon or self.bind.showFilterIcon or not string.isEmpty(self.bind.iconStr or self.bind.img_icon)
  self.bind.go_icon = hasFilterIcon or not active
  self:updateIcon()
end

function this:setActiveSingleOrMultiOn(active)
  self.bind.singleOff = active
  self.bind.singleOn = active
  self.bind.multiOff = not active
  self.bind.multiOn = not active
end

return this
