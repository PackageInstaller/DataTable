local cls = class("cellEntrustTaskCondition_area", G_UIModuleBase)

function cls.bind()
  return {
    toggle_finish = false,
    txt_condition = "",
    color_txtCondition = C_Color.white,
    img_bgFinish = false,
    go_bg = false,
    go_line = false
  }
end

function cls:refresh()
  self.bind.toggle_finish = self.bind.bFinish
  self.bind.img_bgFinish = self.bind.bFinish
  self.bind.go_bg = self.bind.bFinish and true or false
  self.bind.go_line = false
  if self.bind.bFinish then
    local _, color = C_ColorUtility.TryParseHtmlString("#d87500")
    self.bind.color_txtCondition = color
  else
    local _, color = C_ColorUtility.TryParseHtmlString("#5f5952")
    self.bind.color_txtCondition = color
  end
end

return cls
