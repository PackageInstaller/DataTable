local this = class("cellBattleElement", G_UIModuleBase)
local elementTypeTpl = L_GameTpl:getElementTypeTpl()

function this.bind()
  return {icon = ""}
end

function this:open()
  self.bind.icon = elementTypeTpl:getPetElem(elementTypeTpl:getTplById(self.bind.elementId))
end

function this:refresh()
end

return this
