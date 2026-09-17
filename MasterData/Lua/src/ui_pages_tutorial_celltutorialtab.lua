local item = class("cellTutorialTab", G_UIModuleBase)

function item.bind()
  return {
    txt_name = "",
    txt_nameEn = "",
    color_txt_name = nil,
    color_txt_name_E = nil,
    img_icon = "",
    color_icon = nil,
    tabId = -1,
    active_line = false,
    active_taskNode = false,
    img_taskType = nil,
    color_taskTypeImg = nil
  }
end

function item:refresh()
  self.bind.tabId = self.bind.id
end

function item:refreshSelect(isSelect)
  if isSelect then
    self.bind.color_icon = C_Color(0.8117647, 0.5294118, 0.2235294, 1)
    self.bind.color_txt_name = C_Color(0.8117647, 0.5294118, 0.2235294, 1)
    self.bind.color_txt_name_E = C_Color(0.8117647, 0.5294118, 0.2235294, 0.8)
  else
    self.bind.color_icon = C_Color(0.7529412, 0.6901961, 0.627451, 1)
    self.bind.color_txt_name = C_Color(0.7529412, 0.6901961, 0.627451, 1)
    self.bind.color_txt_name_E = C_Color(0.7529412, 0.6901961, 0.627451, 0.8)
  end
end

return item
