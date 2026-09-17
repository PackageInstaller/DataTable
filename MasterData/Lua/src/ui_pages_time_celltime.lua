local item = class("cellTime", G_UIModuleBase)

function item.bind()
  return {
    txt_time = "",
    showBg = false,
    bgColor = C_Color(1, 1, 1, 0.2),
    amount = 1
  }
end

function item.methods()
  return {}
end

function item:open()
  item.super.open(self)
end

function item:close()
  item.super.close(self)
end

function item:refresh()
  if self.isBind then
    if not self.bind.time then
      self.bind.txt_time = ""
      self.bind.bgColor = C_Color(0, 0, 0, 0.75)
    else
      if self.bind.index % 2 ~= 0 then
        self.bind.txt_time = ""
        self.bind.showBg = false
      else
        self.bind.txt_time = self:dealTime(self.bind.time)
        self.bind.showBg = true
        if self.bind.isEnd then
          self.bind.amount = 0.5
        end
      end
      self.bind.bgColor = C_Color(1, 1, 1, 0.2)
    end
  end
end

function item:dealTime(hour)
  local nextHour = 0
  if 24 <= hour then
    nextHour = L_WordsTpl:getValue("ui_timeMessage_11") .. hour - 24
    if 48 <= hour then
      nextHour = L_WordsTpl:getValue("ui_timeMessage_12") .. hour - 48
    end
  else
    nextHour = hour
  end
  local format = "%s:00"
  return string.format(format, nextHour)
end

return item
