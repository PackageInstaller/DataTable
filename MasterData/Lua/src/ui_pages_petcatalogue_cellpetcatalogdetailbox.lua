local module = class("cellPetCatalogDetailBox", G_UIModuleBase)

function module.bind()
  return {
    list_pet = {
      moduleName = "pages/petCatalogue/cellCatalogPet"
    }
  }
end

function module.methods()
  return {}
end

function module:refresh()
  if not self.isBind then
    return
  end
  local petList = self.bind.petList or {}
  local onClickCb = self.bind.onClickCb
  local temp = {}
  for i = 1, #petList do
    table.insert(temp, {
      petId = petList[i].petId,
      idx = petList[i].idx,
      onClickCb = function(cell)
        onClickCb(cell)
      end
    })
  end
  self.bind.list_pet:freshAll(temp)
  self:refreshSelection(self.bind.curPetId)
end

function module:refreshSelection(curPetId)
  if not self.isBind then
    return
  end
  for i = 1, #self.bind.list_pet do
    local cell = self.bind.list_pet:getItemCls(i)
    if cell then
      cell:setSelect(cell.bind.petId == curPetId)
    end
  end
end

return module
