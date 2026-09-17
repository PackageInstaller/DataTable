local module = class("cellUniqueSkill", G_UIModuleBase)

function module.bind()
  return {
    propertyNameTxt = "",
    changedValueTxt = "",
    icon = ""
  }
end

return module
