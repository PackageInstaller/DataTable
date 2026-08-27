local UISpring24Notice = class("UISpring24Notice", UIBaseWindow)
local base = UIBaseWindow

function UISpring24Notice:OnInit()
  base.OnInit(self)
end

function UISpring24Notice:InitSpring24Notice(springData)
  self.springData = springData
  self.timer = TimerManager:StartTimer(3, function()
    self:Delete()
  end, self, true)
end

function UISpring24Notice:OnDelete()
  base.OnDelete(self)
  if self.timer then
    TimerManager:StopTimer(self.timer)
    self.timer = nil
  end
end

return UISpring24Notice
