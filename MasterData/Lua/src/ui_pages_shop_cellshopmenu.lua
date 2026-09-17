local module = class("cellShopMenu", G_UIModuleBase)

function module.bind()
  return {
    go_active = false,
    go_normal = false,
    img_icon_normal = "",
    img_icon_active = "",
    select_name = "",
    line = false
  }
end

function module.methods()
  return {
    onClick_select = function(self)
      if self.bind.line == true then
        return
      end
      self:emit("onClick_select", self.bind.type)
    end
  }
end

function module:open()
  module.super.open(self)
  self:refreshRect()
  if self.bindComponents.reddotSmall then
    if self.bind.reddotKey then
      L_ReddotManager:registerReddot(self.bindComponents.reddotSmall, self.bind.reddotKey)
    elseif self.bindComponents.reddotSmall then
      self.bindComponents.reddotSmall.gameObject:SetActive(false)
    end
  end
end

function module:refresh()
  self:refreshRect()
end

function module:refreshRect()
  if self.bind.line == true then
    self.bindComponents.cellMenu.sizeDelta = C_Vector2(40, 51)
    return
  end
  if self.bind.go_active == true then
    self.bindComponents.cellMenu.sizeDelta = C_Vector2(133, 51)
  else
    self.bindComponents.cellMenu.sizeDelta = C_Vector2(80, 51)
  end
end

return module
