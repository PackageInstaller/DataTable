local this = class("cellLanguage", G_UIModuleBase)

function this.bind()
  return {
    img_gou = false,
    img_border = false,
    txt_language = "",
    txt_capacity = "",
    txt_using = false
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick", self.bind.txt_language, self.bind.code, self.bind.id)
    end
  }
end

return this
