local module = class("cellPetStarColorItem", G_UIModuleBase)

function module.bind()
  return {
    activeEmpty = false,
    activeShowRoot = true,
    activeDisable = false,
    activeSelected = false,
    imgPetColor = ""
  }
end

function module.methods()
  return {
    onClickDefault = function(self)
      self:onClick()
    end,
    onClickContent = function(self)
      self:onClick()
    end
  }
end

function module:show()
  L_CatalogStore:listenCallFunc(L_CatalogStore.event.setStarColor, self.onEvent_setStarColor, self)
end

function module:hide()
  L_CatalogStore:unListenCallFunc(L_CatalogStore.event.setStarColor, self.onEvent_setStarColor, self)
end

function module:refresh()
  local colorId = self.bind.colorId
  local hasColor = 0 < colorId
  self.bind.activeEmpty = colorId < 0
  self.bind.activeDisable = colorId == 0
  self.bind.activeShowRoot = hasColor
  if hasColor then
    self.bind.imgPetColor = string.format("UI/Atlas/PetStarColor/tex_petillustrative_btn_starlight_%d.png", colorId)
  end
  self:refreshSelect()
end

function module:refreshSelect()
  self.bind.activeSelected = self.parent.curId == self.bind.colorId
end

function module:onEvent_setStarColor()
  self:refreshSelect()
end

function module:onClick()
  self.parent:onPetColorItemClick(self.bind.colorId)
  L_CatalogStore:setStarColor()
end

return module
