local this = class("modulePetCatalogueExpendInfo", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    go_Self = true,
    list_Pet = {
      moduleName = "pages/petCatalogue/cellCatalogPet"
    }
  }
end

function this.methods()
  return {
    onClickShrink = function(self)
      self.bind.go_Self = false
      self.callShowBox()
    end
  }
end

function this:close(options)
  this.super.close(self, options)
end

function this:InitModule(petTab, tempListBoxAction)
  self.callShowBox = tempListBoxAction
  self.bind.list_Pet:clear()
  self.bind.list_Pet:insert_array(petTab)
end

return this
