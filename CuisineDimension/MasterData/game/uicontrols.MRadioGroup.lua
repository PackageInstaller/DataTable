local MRadioGroup = class("MRadioGroup")

function MRadioGroup:ctor(params)
  params = params or {}
  self.currentName = nil
  self.buttons = {}
  self.chooseCb = params.chooseCb or function(sender)
  end
  self.unchooseCb = params.unchooseCb or function(sender)
  end
end

function MRadioGroup:add(btn)
  self.buttons[btn:getName()] = btn
  self.unchooseCb(btn)
end

function MRadioGroup:choose(btn)
  return self:chooseByName(btn:getName())
end

function MRadioGroup:chooseByName(btnName)
  if self.currentName == btnName then
    return false
  end
  if self.currentName then
    local lastBtn = self.buttons[self.currentName]
    self.unchooseCb(lastBtn)
  end
  for name, btn in pairs(self.buttons) do
    if name ~= btnName then
      btn:setHighlighted(false)
      btn:setTouchEnabled(true)
    end
  end
  self.buttons[btnName]:setHighlighted(true)
  self.buttons[btnName]:setTouchEnabled(false)
  self.chooseCb(self.buttons[btnName])
  self.currentName = btnName
  return true
end

function MRadioGroup:unchooseByName(btnName)
  if self.currentName ~= btnName then
    return false
  end
  if self.currentName then
    local lastBtn = self.buttons[self.currentName]
    self.unchooseCb(lastBtn)
  end
  for name, btn in pairs(self.buttons) do
    btn:setHighlighted(false)
    btn:setTouchEnabled(true)
  end
  self.currentName = nil
end

function MRadioGroup:hide()
  for name, btn in pairs(self.buttons) do
    btn:hide()
  end
end

function MRadioGroup:show()
  for name, btn in pairs(self.buttons) do
    btn:show()
  end
end

function MRadioGroup:getCurrentChooseName()
  return self.currentName
end

return MRadioGroup
