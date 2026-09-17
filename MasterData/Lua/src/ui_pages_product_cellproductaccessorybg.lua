local this = class("cellProductAccessoryBg", G_UIModuleBase)

function this.bind()
  return {
    active_bg1 = false,
    active_bg2 = false,
    size_self = C_Vector2(392, 1116),
    size_bg1 = C_Vector2(392, 1116),
    size_bg2 = C_Vector2(392, 1116)
  }
end

function this.methods()
  return {}
end

function this:open()
  self:initBgCell()
end

function this:initBgCell()
  self.bind.active_bg1 = math.floor(self.bind.index % 2) > 0
  self.bind.active_bg2 = math.floor(self.bind.index % 2) <= 0
  local height = self.bind.height < 1116 and 1116 or self.bind.height
  self.bind.size_bg1 = C_Vector2(392, height)
  self.bind.size_bg2 = C_Vector2(392, height)
  self.bind.size_self = C_Vector2(392, height)
end

return this
