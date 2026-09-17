local this = class("modulePetAttrUp", G_UIModuleBase)
local _petStarSoulTpl = L_GameTpl:getPetStarSoulTpl()
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    attrList = {
      moduleName = "pages/Pet/cellPetAttrUpItem"
    }
  }
end

function this:setShowPetGuid(petGuid)
  self.petGuid = petGuid
end

function this:refreshUI(tpl)
  if not tpl or not self.petGuid then
    return
  end
  local pet = L_PetStore:getPetItem(self.petGuid)
  local property
  if not math.isEmpty(pet.hero_id) then
    property = L_PetStore:getPetProperty(pet, nil, nil, nil, false)
  else
    property = L_PetStore:getPetOriginalProperty(pet, nil, nil, false)
  end
  if not pet or not property then
    return
  end
  local attrs = _petStarSoulTpl:getUpgradeAttr(tpl)
  if not attrs or table.isEmpty(attrs) then
    return
  end
  local cellAttrs = {}
  for attrId, addVal in pairs(attrs) do
    local btTpl = _battleInfoTpl:getTplById(attrId)
    if btTpl then
      local curVal = L_PetStore:getPetAttFinalValue(property, attrId, self.petGuid)
      table.insert(cellAttrs, {
        attrIcon = _battleInfoTpl:getIcon(btTpl),
        name = _battleInfoTpl:getName(btTpl),
        value = _battleInfoTpl:getShowTxtComma(attrId, curVal),
        nextVal = _battleInfoTpl:getShowTxtComma(attrId, curVal + addVal)
      })
    end
  end
  self.bind.attrList:clear()
  self.bind.attrList:insert_array(cellAttrs)
end

function this:playStarUpEffect()
  self.bindComponents.animation:Play("anim_modulePetAttrUp_starup")
end

return this
