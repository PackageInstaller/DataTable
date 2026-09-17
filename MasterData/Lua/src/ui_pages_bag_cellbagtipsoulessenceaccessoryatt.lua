local this = class("cellBagTipSoulEssenceAccessoryAtt", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    txt_value = "",
    go_bg = true
  }
end

function this:open(options)
  if L_DeviceTpl:getIsMobile() then
    self.bindComponents.txt_value_fontsize.fontSize = 24.5
    self.bindComponents.txt_name_fontsize.fontSize = 24.5
  else
    self.bindComponents.txt_value_fontsize.fontSize = 20
    self.bindComponents.txt_name_fontsize.fontSize = 20
  end
end

return this
