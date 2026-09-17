local this = class("cellWorldBuffIcon", G_UIModuleBase)
local _WorldBuffTpl = L_GameTpl:getWorldBuffTpl()

function this.bind()
  return {icon = ""}
end

function this.methods()
  return {}
end

function this:open()
  local worldBuffId = self.bind.id
  local tpl = _WorldBuffTpl:getTplById(worldBuffId)
  self.bind.icon = _WorldBuffTpl:getBuffIcon(tpl)
end

return this
