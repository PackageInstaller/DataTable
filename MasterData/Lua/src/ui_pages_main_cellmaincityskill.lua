local this = class("cellMainCitySkill", G_UIModuleBase)

function this.bind()
  return {
    btn_petSkill = false,
    img_pet = "",
    color_press = C_Color.white
  }
end

function this.methods()
  return {
    onClick_skill = function(self)
      self:emit("onClick_skill")
    end
  }
end

function this:open()
  self.isTmpActive = true
  self.isAcvive = false
end

function this:setBtnActive(isActive)
  self.isAcvive = isActive
  self.bind.btn_petSkill = self.isAcvive and self.isTmpActive
end

function this:setBtnTmpActive(isActive)
  self.isTmpActive = isActive
  self.bind.btn_petSkill = self.isAcvive and self.isTmpActive
end

function this:setImgPet(img)
  self.bind.img_pet = img
end

function this:setColorPress(color)
  self.bind.color_press = color
end

return this
