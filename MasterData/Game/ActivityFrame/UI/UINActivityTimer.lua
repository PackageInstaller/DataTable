local base = UIBaseNode
local UINActivityTimer = class("UINActivityTimer", base)

function UINActivityTimer:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActivityTimer:InitActivityTimer()
end

function UINActivityTimer:UpdActTimer(tile, timer, days)
  self.ui.tex_TimerTitle.text = tile
  self.ui.tex_Timer.text = timer
  self.ui.tex_Days.text = days
end

function UINActivityTimer:OnDelete()
  base.OnDelete(self)
end

return UINActivityTimer
