local module = class("cellHeroVoiceItem", G_UIModuleBase)

function module.bind()
  return {
    title = "",
    new = false,
    lock = false,
    info = false,
    infoText = "",
    openText = false,
    choice = false
  }
end

function module.methods()
  return {
    onClick_btn = function(self)
      if not self.bind.info then
        self:emit("voiceToggle", self.bind.id, self.bind.new, self.bind.audioEvent)
      else
        L_HeroVoiceManager:stopHeroVoice()
      end
      self.bind.new = false
      self.bind.isInfoOpen = not self.bind.isInfoOpen
      self:refresh()
      FrameScheduler.add(function()
        local parentItem = self.parent
        if parentItem then
          parentItem:checkItemPos(self.uiBinding, self.bind.isInfoOpen, "voiceScroll")
        end
      end, 1, self.uiBinding)
      if not string.isEmpty(self.bind.action) then
        self.parent.parent:playerAnim(self.bind.action)
      end
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
