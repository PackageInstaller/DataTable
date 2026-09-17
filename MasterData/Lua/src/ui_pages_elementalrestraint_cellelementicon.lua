local this = class("cellElementIcon", G_UIModuleBase)

function this.bind()
  return {
    iconBgActive = false,
    icon = "",
    iconColor = C_Color.white,
    ringColor = C_Color.white
  }
end

return this
