local this = class("moduleEqualModeSwitch", G_UIModuleBase)

function this.bind()
  return {
    active_btnEqualMode = false,
    active_contentEqualModeTip = false,
    txt_tip = ""
  }
end

function this.methods()
  return {
    onClick_btnEqualMode = function(self)
      if self.callback then
        self.callback()
      end
    end,
    onClick_showTip = function(self)
      self.bind.active_contentEqualModeTip = not self.bind.active_contentEqualModeTip
    end
  }
end

function this:initModule(callback)
  self.pvpMode = true
  self.bind.txt_tip = L_WordsTpl:getValue("ui_kiboDuel_04")
  self.callback = callback
end

function this:setActive(active)
  if self.pvpMode then
    self.bind.active_btnEqualMode = active
  end
end

function this:setTipActive(active)
  self.bind.active_contentEqualModeTip = active
end

function this:refreshModule(mode)
  self.equalMode = mode
end

return this
