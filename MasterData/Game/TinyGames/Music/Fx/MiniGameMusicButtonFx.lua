local MiniGameMusicButtonFx = class("MiniGameMusicButtonFx", UIBaseNode)
local base = UIBaseNode

function MiniGameMusicButtonFx:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function MiniGameMusicButtonFx:InitMiniGameMusicButtonFx(closeTime, closeCallback)
  TimerManager:StopTimer(self._musicFxTimer)
  self._musicFxTimer = TimerManager:StartTimer(closeTime, function()
    if closeCallback ~= nil then
      closeCallback(self)
    end
  end, self, true)
end

function MiniGameMusicButtonFx:OnDelete()
  TimerManager:StopTimer(self._musicFxTimer)
  base.OnDelete(self)
end

return MiniGameMusicButtonFx
