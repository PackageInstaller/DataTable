local this = class("cellPlayerCardPetPixelDisplay", G_UIModuleBase)

function this.bind()
  return {
    isActive_panelNone = false,
    isActive_panelSel = false,
    module_cellPixelPet = {
      moduleName = "pages/pet/cellPixelPet"
    },
    isActive_self = true,
    isActive_master = nil,
    isActive_nextLine = false
  }
end

function this.methods()
  return {
    onClick_none = function(self)
      self:onClick_none()
    end
  }
end

function this:setBoxMode()
end

function this:open()
  self._cellPixelPet = self.modules.module_cellPixelPet
  if not self.isBind then
    return
  end
  self:refreshView()
end

function this:refresh()
  self:refreshView()
end

function this:refreshView()
  if self.bind.isActive_panelNone then
    return
  end
  if not self.isBind then
    return
  end
  local isEmpty = math.isEmpty(self.bind.guid) or self.bind.guid == -1 or self.bind.guid == 0
  if isEmpty then
    self._cellPixelPet:setPetDataContent(self.bind.guid, {})
    self:setSelect(false)
    return
  end
  local serverData = L_PetStore:getPetItem(self.bind.guid)
  self._cellPixelPet:setPetDataContent(self.bind.guid, {
    choice = self.bind.go_select,
    filterType = L_PetConst.filterPetBox.grade,
    callback = handler(self, self.onClick_cell),
    petInfo = self.bind.petInfo,
    ignoreStatus = true
  })
  if self.bind.isActive_master ~= false then
    if self._cellPixelPet.bind.masterGroup then
      self.bind.isActive_master = true
    else
      self.bind.isActive_master = nil
    end
  else
    self.bind.isActive_master = false
  end
  if self.bind.isMastIcon ~= true then
    self.bind.isActive_master = false
  end
end

function this:setSelect(selected, index)
  self.bind.go_select = selected
  if not self.isBind then
    return
  end
  local cellPixelPet = self.modules.module_cellPixelPet
  cellPixelPet:setGifPlay(selected)
end

function this:onClick_cell()
  self:onClick_total()
  self:emit("onClick_selectCell", self.bind)
end

function this:onClick_none()
  self:onClick_total()
end

function this:onClick_total()
  self:emit("onClick_select", self.bind)
end

return this
