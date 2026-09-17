local module = class("cellHeroStoryItem", G_UIModuleBase)

function module.bind()
  return {
    name = "",
    new = false,
    lock = false,
    info = false,
    infoText = "",
    openText = false,
    choice = false,
    heroStory = Unity.Vector2(520, 60)
  }
end

function module.methods()
  return {
    onClick_btn = function(self)
      if not self.bind.info then
        self:emit("storyToggle", self.bind.id, self.bind.new)
      end
      self.bind.new = false
      self.bind.isInfoOpen = not self.bind.isInfoOpen
      self:refresh()
      FrameScheduler.add(function()
        local parentItem = self.parent
        if parentItem then
          parentItem:checkItemPos(self.uiBinding, self.bind.isInfoOpen, "storyScroll")
        end
      end, 1, self.uiBinding)
    end
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  self.bind.info = self.bind.isInfoOpen
  self.bind.choice = self.bind.isInfoOpen
end

return module
