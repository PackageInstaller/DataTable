local this = class("cellSortFilterPetOption", G_UIModuleBase)
local LengthStyle = {
  Large = 318.3725,
  Normal = 218.6325,
  Small = 157.1894
}

function this.bind()
  return {
    go_active = false,
    go_activeOff = true,
    active_txtOn = true,
    active_txtOff = true,
    txt_nameOn = "",
    txt_nameOff = "",
    active_imgCenter = false,
    active_imgCenterOff = false,
    active_iconOff = false,
    active_iconOn = false,
    img_iconOff = "",
    color_iconOff = C_Color.white,
    color_iconElementOff = C_Color.white,
    img_iconOn = "",
    active_iconElementOn = false,
    active_iconElementOff = false,
    img_iconElementOn = "",
    img_iconElementOff = "",
    active_imgNormal = false,
    active_imgElementBg = false,
    active_bgPath = false,
    img_bgPath = "",
    img_bgElementPath = "",
    active_empty = false,
    active_normal = true,
    rectIconOffPos = C_Vector2(0, 0),
    rectIconOnPos = C_Vector2(0, 0)
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if self.bind.isEmpty then
        return
      end
      self:emit("onClick_select", self.bind)
    end
  }
end

function this:refresh()
  if self.bind ~= nil then
    self:refreshStyle()
    self:refreshView()
  end
end

function this:refreshStyle()
  if self.bind.isEmpty then
    self.bind.active_empty = true
    self.bind.active_normal = false
    return
  end
  self.bind.active_empty = false
  self.bind.active_normal = true
  if self.bind.useLarge or self.bind.useSmall then
    self.bindComponents.layout_cell.preferredWidth = self.bind.useSmall and LengthStyle.Small or LengthStyle.Large
  else
    self.bindComponents.layout_cell.preferredWidth = LengthStyle.Normal
  end
  if self.bind.showIcon then
    self.bind.active_txtOff = false
    self.bind.active_txtOn = false
    self.bind.active_imgCenter = true
    self.bind.active_imgCenterOff = true
  else
    self.bind.active_txtOff = true
    self.bind.active_txtOn = true
    self.bind.active_imgCenter = false
    self.bind.active_imgCenterOff = false
  end
  self.bind.active_imgNormal = false
  self.bind.active_imgElementBg = false
  self.bind.active_bgPath = false
  if self.bind.isElement then
    self.bind.active_imgElementBg = true
  elseif self.bind.useBgPath then
    self.bind.active_bgPath = true
  else
    self.bind.active_imgNormal = true
  end
  self.bind.active_iconElementOn = false
  self.bind.active_iconElementOff = false
  self.bind.active_iconOff = false
  self.bind.active_iconOn = false
  if self.bind.showIcon then
    if self.bind.isElement then
      self.bind.active_iconElementOn = true
      self.bind.active_iconElementOff = true
    else
      self.bind.active_iconOff = true
      self.bind.active_iconOn = true
    end
    if self.bind.iconOffColor then
      self.bind.color_iconOff = self.bind.iconOffColor
    end
    if self.bind.iconPos then
      self.bind.rectIconOffPos = self.bind.iconPos
      self.bind.rectIconOnPos = self.bind.iconPos
    end
  end
end

function this:refreshView()
  if self.bind.showIcon then
    if self.bind.isElement then
      self.bind.img_iconElementOff = self.bind.iconOffPath
      self.bind.img_iconElementOn = self.bind.iconOnPath
      self.bind.color_iconElementOff = self.bind.elementOffColor
    end
    self.bind.img_iconOff = self.bind.iconOffPath
    self.bind.img_iconOn = self.bind.iconOnPath
    self.bindComponents.img_iconOff:SetNativeSize()
    self.bindComponents.img_iconOn:SetNativeSize()
  else
    self.bind.txt_nameOff = self.bind.name
    self.bind.txt_nameOn = self.bind.name
  end
  if self.bind.useBgPath then
    self.bind.img_bgPath = self.bind.bgPath
    self.bind.img_bgElementPath = self.bind.bgPath
  end
end

function this:setActive(active)
  self.bind.go_active = active
end

function this:getIsOn()
  return self.bind.go_active
end

return this
