local this = class("cellPropertyBg", G_UIModuleBase)

function this.bind()
  return {imgActive = false}
end

function this:open()
  self:refreshPlatform()
end

function this:refreshPlatform()
  if L_DeviceTpl:getIsMobile() then
    self.bindComponents.cellPropertyBg.preferredWidth = 691.1
  end
end

return this
