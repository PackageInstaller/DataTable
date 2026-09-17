local module = class("cellCatalogTalent", G_UIModuleBase)
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()

function module.bind()
  return {img_icon = ""}
end

function module.methods()
  return {}
end

function module:refresh()
  local laborId = self.bind.id
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  self.bind.img_icon = _homeLaborTypeTpl:getLaborIcon(homeLaborTypeTpl)
end

return module
