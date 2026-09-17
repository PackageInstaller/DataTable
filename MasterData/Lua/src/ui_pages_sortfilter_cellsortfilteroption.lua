local this = class("cellSortFilterOption", G_UIModuleBase)
local ActiveColor = C_Color(1, 1, 1, 1)
local NormalColor = C_Color(0, 0, 0, 0.3)
local UnSelectColorEnum = {
  [0] = C_Color(1, 1, 1, 1),
  [1] = C_Color(0.3, 0.3, 0.32, 1)
}

function this.bind()
  return {
    go_icon_off = true,
    go_icon_on = true,
    go_item_off = false,
    go_item_on = false,
    color_icon = ActiveColor,
    txt_name = "",
    txt_name_on = "",
    go_active = false,
    go_sortIndex = false,
    txt_sortIndex = nil,
    singleOff = false,
    singleOn = false,
    multiOff = false,
    multiOn = false,
    img_sort_on = nil,
    img_sort_off = nil,
    img_item_on = nil,
    img_item_off = nil,
    active_item_img_on = true,
    active_item_img_off = true,
    active_sort_img_on = false,
    active_sort_img_off = false,
    color_item_off = UnSelectColorEnum[1],
    color_sort_off = UnSelectColorEnum[1]
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
      if self.isIndependent then
        if self.gourpId ~= 0 then
          if self.callback then
            self.callback()
          end
          if not self.bind.go_active then
            self:setActive(true)
          end
        elseif self.bind.go_active then
          self:setActive(false)
        else
          self:setActive(true)
        end
      end
    end
  }
end

function this:refresh()
  if self.bind ~= nil then
    if self.bind.color_item_off then
      self.bind.color_item_off = UnSelectColorEnum[self.bind.maskType or 0]
    end
    if self.bind.color_sort_off then
      self.bind.color_sort_off = UnSelectColorEnum[self.bind.maskType or 0]
    end
    self:updateIcon()
  end
end

function this:updateIcon()
  local showIcon = self.bind.showIcon or false
  self.bind.go_icon_on = not showIcon
  self.bind.go_icon_off = not showIcon
  self.bind.go_item_off = showIcon
  self.bind.go_item_on = showIcon
  if showIcon then
    local isSort = self.bind.useSortImg or false
    self.bind.active_item_img_on = not isSort
    self.bind.active_item_img_off = not isSort
    self.bind.active_sort_img_on = isSort
    self.bind.active_sort_img_off = isSort
    if isSort then
      self.bind.img_sort_on = self.bind.iconStr
      self.bind.img_sort_off = self.bind.iconStr
    else
      self.bind.img_item_off = self.bind.iconStr
      self.bind.img_item_on = self.bind.iconStr
    end
  end
end

function this:setActive(active)
  self.bind.go_active = active
  local txtColor = active and L_Const.colorHtml.white001 or L_Const.colorHtml.grey003
  self.bind.txt_name = L_GameUtil.fillColor(self.bind.name, txtColor)
  self.bind.txt_name_on = L_GameUtil.fillColor(self.bind.name, txtColor)
  self.bind.go_icon = not active
  self.bind.color_icon = active and ActiveColor or NormalColor
end

function this:SetIsSort()
  self.bind.singleOff = false
  self.bind.singleOn = false
  self.bind.multiOff = true
  self.bind.multiOn = false
end

function this:setSortIndex(active, index)
  self.bind.go_sortIndex = active
  self.bind.txt_sortIndex = tostring(index)
  self.bind.go_icon = not active
end

function this:setActiveSingleOrMultiOn(active)
  self.bind.singleOff = active
  self.bind.singleOn = active
  self.bind.multiOff = not active
  self.bind.multiOn = not active
end

function this:setSettingMode(_name, callback, gourpId)
  self.bind.name = _name
  self.callback = callback
  self.gourpId = gourpId
  self:setActiveSingleOrMultiOn(true)
  self:setSortIndex(false, 0)
  self.isIndependent = true
end

function this:getIsOn()
  return self.bind.go_active
end

return this
