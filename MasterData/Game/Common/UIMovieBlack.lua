local UIMovieBlack = class("UIMovieBlack", UIBaseWindow)
local cs_DoTween = CS.DG.Tweening.DOTween

function UIMovieBlack:OnInit()
end

function UIMovieBlack:SlowClose(time, callback)
  local doTweenSequence = cs_DoTween.Sequence()
  doTweenSequence:Append(self.ui.up:DOLocalMoveY(self.ui.up.sizeDelta.y, time):SetRelative(true))
  doTweenSequence:Join(self.ui.down:DOLocalMoveY(-self.ui.down.sizeDelta.y, time):SetRelative(true))
  doTweenSequence:AppendCallback(function()
    self:Delete()
    if callback ~= nil then
      callback()
    end
    self.doTweenSequence = nil
  end)
  doTweenSequence:SetAutoKill(true)
  self.doTweenSequence = doTweenSequence
end

function UIMovieBlack:OnDelete()
  if self.doTweenSequence ~= nil then
    self.doTweenSequence:Kill()
    self.doTweenSequence = nil
  end
  UIBaseWindow.OnDelete(self)
end

return UIMovieBlack
