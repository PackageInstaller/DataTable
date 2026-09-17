local module = class("moduleTowerFormationCell", G_UIModuleBase)

function module.bind()
  return {
    heroUnit = {
      moduleName = "modulePages/cellIconUnit"
    },
    petUnit = L_Const.ModuleInfo.CellIcon,
    petActive = false
  }
end

function module:refresh()
  self.modules.heroUnit:setHeroDataContent(self.bind.heroId, {
    callback = function(cell)
    end
  })
  if self.bind.petId and self.bind.petId ~= 0 then
    self.bind.petActive = true
    self.modules.petUnit:setPetDataContent(self.bind.petId, {hideHead = true})
  else
    self.bind.petActive = false
  end
end

return module
