local base = UIBaseWindow
local UIWarChessGameWin = class("UIWarChessGameWin", base)

function UIWarChessGameWin:OnInit()
end

function UIWarChessGameWin:SetPlayOverCallback(callback, textIndex)
  self.ui.TextCN:SetIndex(textIndex or 0)
  AudioManager:PlayAudioById(1235)
  TimerManager:StartTimer(2, callback, self, true)
end

function UIWarChessGameWin:OnDelete()
end

return UIWarChessGameWin
