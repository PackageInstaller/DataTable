local this = class("modulePhotoListTitle", G_UIModuleBase)

function this.bind()
  return {
    img_empty = false,
    txt_content = false,
    btn_Tmp = false
  }
end

function this.methods()
  return {
    onValueChanged_grid = function(self, isOn)
      self:emit("onClickToggle", isOn)
      if not isOn then
        self.bind.txt_content = false
        self.bind.btn_Tmp = false
      else
        self.bind.txt_content = true
        self.bind.btn_Tmp = true
      end
    end
  }
end

function this:open()
  this.super.open(self)
  self:initModule()
end

function this:close()
  this.super.close(self)
end

function this:initModule()
end

return this
