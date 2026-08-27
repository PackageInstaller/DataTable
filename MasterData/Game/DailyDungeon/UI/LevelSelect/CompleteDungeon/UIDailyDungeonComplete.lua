local UIDailyDungeonComplete = class("UIDailyDungeonComplete", UIBaseWindow)
local base = UIBaseWindow

function UIDailyDungeonComplete:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickBg)
end

function UIDailyDungeonComplete:InitDailyDungeonComplete(nameStr)
  self.ui.tex_Tips:SetIndex(0, nameStr)
  local length = self.ui.anima.clip.length
  self.timerId = TimerManager:StartTimer(length, function()
    self:_OnClickBg()
  end, nil, true)
  self.ui.anima:Play()
end

function UIDailyDungeonComplete:_OnClickBg()
  self:Delete()
end

function UIDailyDungeonComplete:OnDelete()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnDelete(self)
end

return UIDailyDungeonComplete
