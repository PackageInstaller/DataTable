local this = class("moduleProductInfoDesc_egg", G_UIModuleBase)
local _petEggTpl = L_GameTpl:getPetEggTpl()

function this.bind()
  return {
    txt_shortDesc = "",
    txt_longDesc = "",
    active_descLayout = false
  }
end

function this.methods()
  return {}
end

function this:setData(eggGuid, buildingGuid)
  self.moduleData = self.moduleData or {}
  self.moduleData.eggGuid = eggGuid
  self.moduleData.buildingGuid = buildingGuid
  self.moduleData.petEggData = L_PetStore:getPetEggItem(self.moduleData.eggGuid)
end

function this:refreshUI()
  local petEggTpl = _petEggTpl:getTplById(self.moduleData.petEggData.configId)
  self.bind.txt_shortDesc = _petEggTpl:getDesc(petEggTpl)
  self.bind.txt_longDesc = _petEggTpl:getSpecialDesc(petEggTpl)
end

return this
