local module = class("cellHistoryItem", G_UIModuleBase)

function module.bind()
  return {
    cardIconPath = "",
    cardQualityAndNameTxt = "",
    cardPoolNameTxt = "",
    raffleTimeTxt = ""
  }
end

return module
