local module = class("cellLevelUpMaterialItem", G_UIModuleBase)

function module.bind()
  return {
    iconPath = "",
    numTxt = "",
    qualityIconPath = ""
  }
end

return module
