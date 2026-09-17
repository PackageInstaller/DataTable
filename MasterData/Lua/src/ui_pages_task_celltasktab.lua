local item = class("cellTaskTab", G_UIModuleBase)

function item.bind()
  return {
    txtNameOn = "",
    txtNameOff = "",
    txtNameSubOn = "",
    txtNameSubOff = "",
    txtIconOn = "",
    txtIconOff = "",
    activeLine = false,
    tabId = 0,
    activeRed = false,
    activeTraceOn = false,
    activeTraceOff = false
  }
end

return item
