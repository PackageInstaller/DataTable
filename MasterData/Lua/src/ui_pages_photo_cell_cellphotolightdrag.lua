local this = class("cellPhotoLightDrag", G_UIModuleBase)

function this.bind()
  return {
    isOn = false,
    icon = "",
    rectPos = nil
  }
end

function this.methods()
  return {
    onDrag_light = function(self, screenPos)
      self:emit("onDrag_light", self.bind.tabId, screenPos)
    end,
    onEndDrag_light = function(self, screenPos)
      self:emit("onEndDrag")
      self:clearPos()
    end
  }
end

function this:open()
  if self.bind.tabId == 1 then
    self.bind.icon = "UI/Altlas/photo/tex_photo_lighting_word_01"
  elseif self.bind.tabId == 2 then
    self.bind.icon = "UI/Altlas/photo/tex_photo_lighting_word_02"
  elseif self.bind.tabId == 3 then
    self.bind.icon = "UI/Altlas/photo/tex_photo_lighting_word_03"
  end
end

function this:refresh()
end

function this:close()
end

function this:clearPos()
  self.bind.rectPos = C_Vector3.zero
end

return this
