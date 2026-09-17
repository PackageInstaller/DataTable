local this = class("cellActivityPartySkillItem", G_UIModuleBase)

function this.bind()
  return {activeSelect = false, img_icon = ""}
end

function this.methods()
  return {
    onClick = function(self)
      self:updateSelectState()
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function this:preOpen(options)
end

function this:open()
end

function this:refresh()
  self:updateSelectState()
end

function this:updateSelectState()
  if self.bind.selectMode then
    self._isSelect = not self._isSelect
    self.bind.activeSelect = self._isSelect == true
  end
end

return this
