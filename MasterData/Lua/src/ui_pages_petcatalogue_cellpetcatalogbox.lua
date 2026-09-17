local module = class("cellPetCatalogBox", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {isAttrView = false}
end

function module.bind()
  return {
    listPet = {
      moduleName = "pages/petCatalogue/cellCatalogPet"
    },
    cellSize = C_Vector2(2080, 1021)
  }
end

function module.methods()
  return {}
end

function module:refresh()
  self.bindComponents.boxListGrid.constraintCount = self.bind.objPerRow
  if self.parent and self.parent.getIsAttrView then
    self.data.isAttrView = self.parent:getIsAttrView()
  end
  local temp = {}
  for i = 1, #self.bind.petList do
    table.insert(temp, {
      isAttrView = self.data.isAttrView,
      petId = self.bind.petList[i].petId,
      onClickCb = function(cell)
        self.bind.onClickCb(cell)
      end,
      catalogId = self.bind.pageIdxBase + i
    })
  end
  self.bind.listPet:clear()
  self.bind.listPet:insert_array(temp)
  if C_ResolutionUtility.CheckSuperWidthScreen() then
    self.bind.cellSize = C_Vector2(2740, 1021)
  end
  if not L_DeviceTpl:getIsPc() then
    self.bind.cellSize = C_Vector2(1920, 666)
    self.bindComponents.boxListGrid.padding.left = 88
  end
end

function module:setAttrView(isAttr)
  if self.isBind then
    self.data.isAttrView = isAttr
    if self.modules.listPet then
      for _, cell in pairs(self.modules.listPet) do
        cell:refreshAttrView(isAttr)
      end
    end
  end
end

function module:getItemByIndex(index)
  if self == nil or self.bindComponents == nil then
    return nil
  end
  return self.bindComponents.boxList:GetItemById(index).uiBinding
end

function module:refreshRedDot()
  if self.isBind and self.modules.listPet then
    for _, cell in pairs(self.modules.listPet) do
      cell:refreshRedDot()
    end
  end
end

return module
