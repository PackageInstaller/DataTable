local this = class("cellAccessorySuit", G_UIModuleBase)

function this.bind()
  return {
    txt_desc = "",
    color_imgPoint = C_Color.white,
    alpha_canvas = 1
  }
end

function this:open()
  self.bind.txt_desc = self.bind.txt_desc
  self.bind.color_imgPoint = self.bind.pointColor == nil and C_Color(0.30980392156862746, 0.3215686274509804, 0.36470588235294116, 0.5) or self.bind.pointColor
end

return this
