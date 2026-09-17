local module = class("cellTextMenu", G_UIModuleBase)

function module.bind()
  return {
    txt_normal = "",
    txt_active = "",
    tabId = nil
  }
end

function module.methods()
  return {}
end

return module
