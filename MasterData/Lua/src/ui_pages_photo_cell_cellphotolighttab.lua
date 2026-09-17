local this = class("cellPhotoLightTab", G_UIModuleBase)

function this.bind()
  return {
    isOn = true,
    tabId = 0,
    color = C_Color.white,
    icon = "",
    iconSelect = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  self.bindComponents.tabItem.Group = self.bind.tabGroup
  if self.bind.tabId == 1 then
    self.bind.icon = "UI/Altlas/photo/tex_photo_lighting_word_01 1"
    self.bind.iconSelect = "UI/Altlas/photo/tex_photo_lighting_word_01 1"
  elseif self.bind.tabId == 2 then
    self.bind.icon = "UI/Altlas/photo/tex_photo_lighting_word_02 1"
    self.bind.iconSelect = "UI/Altlas/photo/tex_photo_lighting_word_02 1"
  elseif self.bind.tabId == 3 then
    self.bind.icon = "UI/Altlas/photo/tex_photo_lighting_word_03 1"
    self.bind.iconSelect = "UI/Altlas/photo/tex_photo_lighting_word_03 1"
  end
end

function this:refresh()
end

function this:close()
end

return this
