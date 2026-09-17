local this = class("cellPetRecommendType", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    recommendList = {
      moduleName = "modulePages/unit/cellPetRecommend"
    },
    typeTitle = ""
  }
end

function this:open()
  self:refreshInfo()
end

function this:refreshInfo()
  self.bind.recommendList:clear()
  if not self.bind.petList then
    return
  end
  local cellList = {}
  for _, petConfigId in pairs(self.bind.petList) do
    local tpl = petTpl:getTplById(petConfigId)
    local isUnlock = L_CatalogStore:isGetPet(petConfigId) and true or false
    table.insert(cellList, {
      heroConfigId = self.bind.heroConfigId,
      petConfigId = petConfigId,
      petIcon = petTpl:getPetIcon(tpl),
      name = petTpl:getName(tpl),
      possessActive = isUnlock and L_PetStore:getPetNum(petConfigId) == 0,
      unlockActive = isUnlock,
      lockActive = not isUnlock
    })
  end
  self.bind.recommendList:insert_array(cellList)
end

return this
