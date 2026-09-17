local module = class("cellPetHeroProperty", G_UIModuleBase)

function module.bind()
  return {
    name = "",
    value = "",
    icon = "",
    go_icon = true,
    go_empty = false,
    go_bg = false
  }
end

return module
