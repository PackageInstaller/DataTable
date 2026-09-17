local module = class("cellProbabilityCardItem", G_UIModuleBase)

function module.bind()
  return {
    isProbabilityUp = false,
    iconPath = "",
    name = ""
  }
end

return module
