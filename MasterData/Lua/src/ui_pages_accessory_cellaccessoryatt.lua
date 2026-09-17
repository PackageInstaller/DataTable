local this = class("cellAccessoryAtt", G_UIModuleBase)

function this.bind()
  return {
    txt_desc = "",
    color_desc = C_Color(1, 1, 1, 1),
    go_bg = false,
    txt_number = "",
    color_number = C_Color(1, 1, 1, 1),
    go_starNode = false,
    go_number = false,
    go_clockBg = false,
    go_lock = false,
    alpha_lock = 1
  }
end

function this.methods()
  return {
    onEnter = function(self)
      self.bind.go_clockBg = true
      self.bind.go_bg = self.bind.showBg and not self.bind.go_clockBg
    end,
    onExit = function(self)
      self.bind.go_clockBg = false
      self.bind.go_bg = self.bind.showBg and not self.bind.go_clockBg
    end
  }
end

function this:open()
  self.bind.go_number = true
  self.bind.txt_desc = self.bind.name
  self.bind.txt_number = self.bind.number
  self.bind.go_bg = self.bind.showBg
  self.bind.go_lock = self.bind.bLock
  if self.bind.bLock then
    local _, color = C_ColorUtility.TryParseHtmlString("#564320" .. "99")
    self.bind.color_desc = color
    self.bind.color_number = color
    self.bind.alpha_lock = 0.6
  else
    local _, color = C_ColorUtility.TryParseHtmlString("#564320" .. "FF")
    self.bind.color_desc = color
    self.bind.color_number = color
    self.bind.alpha_lock = 1
  end
end

return this
