local this = class("modulePetDecryptRoulette", G_UIModuleBase)

function this.bind()
  return {
    list_decryptPet = {
      moduleName = "pages/petDecryptRoulette/cellDecryptPet"
    }
  }
end

function this.method()
  return {}
end

function this:refreshPetData(data)
  self.bind.list_decryptPet:clear()
  self.bind.list_decryptPet:insert_array(data)
end

function this:setPetRouletteActive(selectIndex)
  for i, v in pairs(self.modules.list_decryptPet) do
    v:setSelectState(v.bind.index == selectIndex)
  end
end

return this
