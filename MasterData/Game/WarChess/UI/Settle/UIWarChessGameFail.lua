local base = UIBaseWindow
local UIWarChessGameFail = class("UIWarChessGameFail", base)

function UIWarChessGameFail:OnInit()
end

function UIWarChessGameFail:SetPlayOverCallback(callback)
  AudioManager:PlayAudioById(1236)
  TimerManager:StartTimer(2, callback, self, true)
end

function UIWarChessGameFail:OnDelete()
end

return UIWarChessGameFail
