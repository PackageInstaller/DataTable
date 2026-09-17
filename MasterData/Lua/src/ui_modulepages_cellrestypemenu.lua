local module = class("cellResTypeMenu", G_UIModuleBase)

function module.bind()
  return {
    go_active = false,
    go_normal = false,
    img_icon_normal = "",
    img_icon_active = ""
  }
end

function module.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind.type)
    end
  }
end

function module:open()
  module.super.open(self)
  if self.bindComponents.reddotSmall then
    if self.bind.reddotKey then
      L_ReddotManager:registerReddot(self.bindComponents.reddotSmall, self.bind.reddotKey)
    elseif self.bindComponents.reddotSmall then
      self.bindComponents.reddotSmall.gameObject:SetActive(false)
    end
  end
end

return module
