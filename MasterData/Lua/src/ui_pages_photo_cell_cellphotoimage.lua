local this = class("cellPhotoImage", G_UIModuleBase)

function this.bind()
  return {
    id = 0,
    txtName = "",
    imgIcon = "",
    isCollect = false
  }
end

function this:methods()
  return {
    onClick_handle = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Action_Change")
      self:emit("onClick_handle", self.bind.id, self.bind.txtName)
    end
  }
end

function this:refresh()
  if self.bind.tabGroup and self.bind.tabGroup then
    self.bindComponents.tabItem.Group = self.bind.tabGroup
  end
end

function this:clearTabGroup()
  if self.bindComponents and self.bindComponents.tabItem then
    self.bindComponents.tabItem.Group = nil
  end
end

return this
