local this = class("cellPetStageItem", G_UIModuleBase)

function this.bind()
  return {
    itemIcon = "",
    unlockActive = false,
    selectActive = false,
    vXActive = false
  }
end

return this
