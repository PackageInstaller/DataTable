local CommonShowBornStateCustom = BaseClass("CommonShowBornStateCustom" , require("RoleBehavior.BaseState"))
local M = CommonShowBornStateCustom

function M:OnEnter()
    self:_PlayAction(self._behaviorType)
    --先关掉动态骨骼，0.2秒之后开放，避免再次播放瞬切动作时穿帮
    if self._ctrl and not IsNull(self._ctrl:GetShowGirl()) then 
        self._ctrl:GetShowGirl().EnableBoneCloths = false
    end
    if self._enableBoneClothsTimer then 
        self._enableBoneClothsTimer:Stop()
    end
    self._enableBoneClothsTimer = TimerManager:GetInstance():GetTimer(0.2, self._OnDisableBone, self, true)
    self._enableBoneClothsTimer:Start()
end

function M:_OnDisableBone()
    if self._ctrl and not IsNull(self._ctrl:GetShowGirl()) then 
        self._ctrl:GetShowGirl().EnableBoneCloths = true
    end
    self._enableBoneClothsTimer = nil
end

function M:OnDispose()
    if self._enableBoneClothsTimer then 
        self._enableBoneClothsTimer:Stop()
    end
    self._enableBoneClothsTimer = nil
    M.super.OnDispose(self)
end

function M:_OnPlayAnimComplete()
    self:ChangeState(RoleStateName.Idle)
end

return M 