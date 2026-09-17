local this = class("cellIconBagStarUnit", G_UIModuleBase)

function this.bind()
  return {go_active = true, go_deactive = false}
end

function this:open()
  self:refreshView()
end

function this:refresh()
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  if self.bind.isActiveStar == nil then
    self.bind.go_active = true
    self.bind.go_deactive = false
  else
    self.bind.go_active = self.bind.isActiveStar
    self.bind.go_deactive = not self.bind.isActiveStar
  end
end

return this
