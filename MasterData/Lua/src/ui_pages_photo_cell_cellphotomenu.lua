local this = class("cellPhotoMenu", G_UIModuleBase)

function this.bind()
  return {
    id = 0,
    img_iconOn = nil,
    img_iconOff = nil,
    txt_NameOff = "",
    font_NameOff = 18,
    txt_NameOn = "",
    font_NameOn = 18,
    goOn = nil,
    goOff = nil
  }
end

function this.methods()
  return {
    onClick_menu = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBgFalse)
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose")
      self:emit("onClick_menu", self.bind.id)
    end
  }
end

function this:show()
  if self.parent and self.parent.refreshMaskableList then
    self.parent:refreshMaskableList()
  end
end

function this:refresh()
  if self.bind.tabGroup then
    self.bindComponents.tabItem.Group = self.bind.tabGroup
  end
  self:refreshView()
end

function this:refreshView()
  if L_DeviceTpl:getIsPc() then
    self.bind.font_NameOn = 18
    self.bind.font_NameOff = 18
  else
    self.bind.font_NameOn = 22
    self.bind.font_NameOff = 22
  end
  if self.isBind and self.bind.tabGroup and (self.bind.goOn == nil or self.bind.goOff == nil) then
    self.bind.goOn = self.bind.tabGroup.SelectedId == self.bind.id
    self.bind.goOff = self.bind.tabGroup.SelectedId ~= self.bind.id
  end
end

function this:refreshSelect()
  if self.isBind and self.bind.tabGroup then
    self.bind.goOn = self.bind.tabGroup.SelectedId == self.bind.id
    self.bind.goOff = self.bind.tabGroup.SelectedId ~= self.bind.id
  end
end

function this:clearTabGroup()
  if self.bindComponents and self.bindComponents.tabItem then
    self.bindComponents.tabItem.isOn = false
    self.bindComponents.tabItem.Group = nil
  end
end

function this:playOpenAnim()
  self.bindComponents.anim_photoMenu:Play("anim_cellphotomenu")
end

return this
