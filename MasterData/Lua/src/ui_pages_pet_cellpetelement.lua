local module = class("cellPetElement", G_UIModuleBase)
local elementTypeTpl = L_GameTpl:getElementTypeTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {}
end

function module.bind()
  return {icon = ""}
end

function module.methods()
  return {
    onClick_element = function(self)
      L_UI:open("pageElementalRestraint", {
        elements = self.bind.allElement
      })
    end
  }
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
end

function module:refreshInfo()
  if self.bind.element then
    self.bind.icon = elementTypeTpl:getPetElem(elementTypeTpl:getTplById(self.bind.element))
  end
end

function module:close()
end

return module
