local this = class("cellSituationPetItem", G_UIModuleBase)
local _situationTabTpl = L_GameTpl:getSituationTabTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()

function this.bind()
  return {
    activeDel = nil,
    module_pixelPet = {
      moduleName = "pages/pet/cellPixelPet"
    }
  }
end

function this.methods()
  return {
    onClickAdd = function(self)
      self:emit("onClickAdd", self.bind.guid, self.bindComponents.darkenSafeHelper)
    end,
    onClickRemove = function(self)
      self:emit("onClickRemove", self.bind.guid, self.bindComponents.darkenSafeHelper)
    end
  }
end

function this:init()
end

function this:open()
end

function this:refresh()
  self:refreshIcon()
  self:refreshBtns()
end

function this:refreshIcon()
  self.modules.module_pixelPet:setPetDataContent(self.bind.guid, {
    filterType = L_PetConst.filterPetBox.grade,
    isHideCrown = true
  })
end

function this:refreshBtns()
  local guid = self.bind.guid
  local have = L_SituationManager:hasPet(guid)
  self.bind.activeDel = have
  if self.bind.activeDel then
    self.bindComponents.darkenSafeHelper:SetGray()
  else
    self.bindComponents.darkenSafeHelper:ResetColors()
  end
end

function this:refreshSelectRoot(guid)
  self.modules.module_pixelPet:setSelectNew(self.bind.guid == guid)
end

function this:close()
end

return this
