local UIDormTransAnima = class("UIDormTransAnima", UIBaseWindow)
local base = UIBaseWindow
local cs_Ease = CS.DG.Tweening.Ease
local cs_DoTween = CS.DG.Tweening.DOTween

function UIDormTransAnima:OnInit()
  local se = cs_DoTween.Sequence()
  se:Insert(0, self.ui.img_Mask.transform:DOSizeDelta(Vector2.New(4096, 4096), 0.75))
  se:InsertCallback(0, BindCallback(self, self._OnSceneOpen))
  se:Pause()
  se:SetAutoKill(false)
  self._seq = se
end

function UIDormTransAnima:InitDormTransAnima(startPos, waitTime, onStarFunc, onEndFunc)
  self._onStarFunc = onStarFunc
  self._onEndFunc = onEndFunc
  self.ui.ani_Node:Stop()
  self.ui.twenn_Gear:DOPause()
  self:_InitDormTransTimer(waitTime or 1)
  self.ui.img_Mask.transform.localPosition = startPos ~= nil and startPos or Vector3.zero
  self._seq:Restart()
end

function UIDormTransAnima:_InitDormTransTimer(waitTime)
  self._timerID = TimerManager:StartTimer(waitTime, self._OnSceneClose, self, true, false, false)
end

function UIDormTransAnima:_OnSceneOpen()
  self:_PlayIcon()
  if self._onStarFunc ~= nil then
    self._onStarFunc()
  end
end

function UIDormTransAnima:_OnSceneClose()
  self.ui.canvasGroup:DOKill()
  self.ui.canvasGroup.alpha = 1
  self.ui.canvasGroup:DOFade(0, 0.25):SetRecyclable(true):OnComplete(function()
    self.ui.twenn_Gear:DOPause()
    self._seq:Pause()
    self.ui.ani_Node:Stop()
    self:Hide()
  end)
  if self._onEndFunc ~= nil then
    self._onEndFunc()
  end
end

function UIDormTransAnima:_PlayIcon()
  self.ui.ani_Node:Play()
  self.ui.twenn_Gear:DORestart()
end

function UIDormTransAnima:OnDelete()
  self.ui.twenn_Gear:DOKill()
  self.ui.ani_Node:Stop()
  self.ui.canvasGroup:DOKill()
  if self._seq ~= nil then
    self._seq:Kill()
    self._seq = nil
  end
  if self._timerID ~= nil then
    TimerManager:StopTimer(self._timerID)
    self._timerID = nil
  end
end

return UIDormTransAnima
