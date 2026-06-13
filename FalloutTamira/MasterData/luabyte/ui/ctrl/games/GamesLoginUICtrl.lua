local GamesLoginUICtrl = BaseClass("GamesLoginUICtrl", BaseUICtrl)
local M = GamesLoginUICtrl







function M:Init()
    self._animationTime = self._view.animator.runtimeAnimatorController.animationClips[0].length
    self._delayTimer = TimerManager:GetInstance():GetTimer(self._animationTime, Bind(self, self._OnDelayTimerComplete), nil, true)
end


function M:OnEnter()
    GameHelper.PlayAudioById(1245)
    self._view.animator:Play("GamesLoginUI",0,0)
    self._delayTimer:Start()
end


function M:_OnDelayTimerComplete()
    UIContextMgr:GetInstance():Show("GamesMainUI")
    self:Close()
end


function M:OnDispose()
    if self._delayTimer then
        self._delayTimer:Stop()
    end

    self._delayTimer = nil
    self._animationTime = nil
    M.super.OnDispose(self)
end





return GamesLoginUICtrl
