local module = class("cellPetStationedPxielPet", require("ui.pages.pet.cellPixelPet"))

function module:setPetDataContent(guid, params)
  module.super.setPetDataContent(self, guid, params)
  self.bind.selected = params.pointEnter and true or false
  local scale = params.inInHomeHub and 1.6 or 1
  self._pixelIconModule:setImgTranScale(scale)
  self.bind.dropItem = false
  if params.isDropItem then
    self:refreshDropItem(guid)
    if self.bindComponents.masterIconTrans then
      local uiPos = self.bindComponents.masterIconTrans.anchoredPosition
      self.bindComponents.masterIconTrans.anchoredPosition = C_Vector2(uiPos.x, 0)
    end
  end
end

function module:refreshPetStatus()
  self._pixelIconModule:outLineShow(self.bind.inInHomeHub or self.bind.pointEnter)
end

function module:refreshView()
  module.super.refreshView(self)
  self:setSelectPetBox(self.bind.inInHomeHub, self.bind.pointEnter)
  if self.bind.pointEnter then
    self._pixelIconModule:playPixelGif()
  else
    self._pixelIconModule:stopPixelGif()
  end
  self:refreshPetStatus()
end

function module:open()
  module.super.open(self)
  if self.bindComponents.removeBtn then
    self.bindComponents.removeBtn.onClick:RemoveAllListeners()
    self.bindComponents.removeBtn.onClick:AddListener(function()
      if self.bind.removeCallback then
        self.bind.removeCallback(self)
      end
    end)
  end
end

function module:close()
  module.super.close(self)
  if self.bindComponents and self.bindComponents.removeBtn then
    self.bindComponents.removeBtn.onClick:RemoveAllListeners()
  end
end

return module
