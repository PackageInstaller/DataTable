local LotteryLoadingCtrl = BaseClass("LotteryLoadingCtrl", BaseUICtrl)
local M = LotteryLoadingCtrl

function M:Init()
    self._animationTime = self._view.LotteryLoading.runtimeAnimatorController.animationClips[0].length
end

function M:OnEnter(callback, extraHero)
    self._callback = callback
    self._delayTimer = TimerManager:GetInstance():GetTimer(self._animationTime, Bind(self, self._OnDelayTimerComplete), nil, true)
    --播放11抽语音
    local heroId = extraHero.ObjId
    self._curheroCfg = ConfigHelper.GetCfgByLua("hero", heroId)
    GameHelper.PlayAudioById(self._curheroCfg.luckyDraw)
    self._delayTimer:Start()
end

function M:_OnDelayTimerComplete()
    if self._callback then
        self._callback()
    end
    self._callback = nil
    self:Close()
end

function M:OnDispose()
    M.super.OnDispose(self)
    if self._delayTimer then
        self._delayTimer:Stop()
    end
    self._callback = nil
    self._curheroCfg = nil
end

return LotteryLoadingCtrl
