local this = class("cellPixelPetLevel", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()

function this.bind()
  return {
    levelValue = "",
    active_one = false,
    active_two = false,
    levelIcon = "",
    levelIconMain = "",
    levelIconSub = ""
  }
end

function this.methods()
  return {}
end

function this:refreshData(data, petConfigId)
  if data == nil or type(data) == "table" and table.isEmpty(data) then
    return
  end
  local levelValue = data
  local configId = petConfigId
  if type(data) == "table" then
    levelValue = data.levelValue
    configId = data.petConfigId
  end
  self.bind.levelValue = levelValue or ""
  self:refreshElementIcons(configId)
end

function this:refreshElementIcons(petConfigId)
  if not petConfigId then
    self.bind.active_one = false
    self.bind.active_two = false
    self.bind.levelIcon = ""
    self.bind.levelIconMain = ""
    self.bind.levelIconSub = ""
    return
  end
  local tpl = _petTpl:getTplById(petConfigId)
  if not tpl then
    return
  end
  local element = _petTpl:getElement(tpl)
  local mainElementId = element[1]
  local subElementId = element[2]
  local mainElementTypeTpl = mainElementId and _elementTypeTpl:getTplById(mainElementId)
  if subElementId ~= nil and 0 < subElementId then
    self.bind.active_one = false
    self.bind.active_two = true
    local subElementTypeTpl = _elementTypeTpl:getTplById(subElementId)
    self.bind.levelIconMain = mainElementTypeTpl and _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.main) or ""
    self.bind.levelIconSub = subElementTypeTpl and _elementTypeTpl:getElementIcon(subElementTypeTpl, L_Const.elementIconType.sub) or ""
  else
    self.bind.active_one = true
    self.bind.active_two = false
    self.bind.levelIcon = mainElementTypeTpl and _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.single) or ""
  end
end

return this
