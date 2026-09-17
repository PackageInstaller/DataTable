local this = class("cellPhotoEditTab", G_UIModuleBase)
local fontInfo = {
  [1] = "sdf_a00",
  [2] = "sdf_b00"
}

function this.bind()
  return {
    txt_name = "",
    txt_nameOff = "",
    font_name = 20,
    font_nameOff = 20,
    txt_nameEn = nil,
    txt_nameEnOff = nil,
    tabId = 0,
    icon_On = nil,
    icon_Off = nil,
    activeLine = nil
  }
end

function this.methods()
  return {}
end

function this:open()
  self.bindComponents.tabItem.Group = self.bind.tabGroup
  if self.bind.isTextTab1 and self.bindComponents.imgRectOff then
    self.bindComponents.imgRectOff.localRotation = C_Quaternion.Euler(C_Vector3(0, 0, 180))
  end
end

function this:refresh()
  if self.bindComponents.txtNameOn then
    if self.bind.font then
      FrameScheduler.add(function()
        if self.isBind then
          self.bindComponents.txtNameOn:SetFontAsset(self.bind.font)
          self.bindComponents.txtNameOff:SetFontAsset(self.bind.font)
        end
      end)
    else
      self.bindComponents.txtNameOn:SetFontAsset(fontInfo[1])
      self.bindComponents.txtNameOff:SetFontAsset(fontInfo[1])
    end
  end
  self:refreshView()
end

function this:refreshView()
  if L_DeviceTpl:getIsPc() then
    self.bind.font_name = 20
    self.bind.font_nameOff = 20
  else
    self.bind.font_name = 22
    self.bind.font_nameOff = 22
  end
end

function this:close()
end

return this
