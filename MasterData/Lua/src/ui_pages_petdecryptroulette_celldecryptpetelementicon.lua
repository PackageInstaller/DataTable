local this = class("cellDecryptPetElementIcon", G_UIModuleBase)
local _elementTpl = L_GameTpl:getElementTypeTpl()

function this.bind()
  return {img_element = ""}
end

function this:refresh()
  self.bind.img_element = self:getElementIcon()
end

function this:getElementIcon()
  local elementCfg = _elementTpl:getTplById(self.bind.elementId)
  return _elementTpl:getPetElem(elementCfg)
end

return this
