local this = class("cellPhotoScene", G_UIModuleBase)

function this.bind()
  return {
    txtName = "",
    imgIcon = "",
    isOn = false,
    activeCur = false,
    bgimg_icon = "",
    pos_img_name = nil,
    pos_txtname = nil,
    pos_txtorigin = nil,
    pos_img_shadow = nil
  }
end

function this:open()
  if L_DeviceTpl:getIsMobile() then
    self.bind.pos_img_name = C_Vector2(80.2, -32.64)
    self.bind.pos_txtname = C_Vector2(43, -26)
    self.bind.pos_txtorigin = C_Vector2(1.5, -34.3)
    self.bind.pos_img_shadow = C_Vector2(189.9, 5.6)
    self.bindComponents.txt_origin_fontsize.fontSize = 24
    self.bindComponents.txtName_fontsize.fontSize = 22
    self.bindComponents.img_name_size.sizeDelta = C_Vector2(200, 64)
    self.bind.bgimg_icon = "UI/Page/Photo/tex_photo_bg_03_2.png"
  end
  if L_DeviceTpl:getIsPc() then
    self.bind.pos_img_name = C_Vector2(56.6, -26.8)
    self.bind.pos_txtname = C_Vector2(13.6, -16.4)
    self.bind.pos_txtorigin = C_Vector2(0.58, -22.01)
    self.bindComponents.img_name_size.sizeDelta = C_Vector2(98, 40)
    self.bind.bgimg_icon = "UI/Page/Photo/tex_photo_bg_03 1.png"
  end
end

function this.methods()
  return {
    onClick_handle = function(self)
      self:emit("onClick_handle", self.bind.id)
    end
  }
end

return this
