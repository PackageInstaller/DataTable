local module = class("heroProperty", G_UIModuleBase)

function module.bind()
  return {
    toggle_state = false,
    name = "",
    active_icon = false,
    icon = "",
    curAttr = "",
    nextAttr = ""
  }
end

function module.methods()
  return {}
end

return module
