
--通用的角色展示，含旋转、点击等功能(自定义)
local CommonShowCtrlWithCustom = BaseClass("CommonShowCtrlWithCustom" ,require("RoleBehavior.Ctrls.CommonShowCtrl") )
local M = CommonShowCtrlWithCustom


function  M:InitState()
    -- body
    self:AddState(RoleStateName.Born,require("RoleBehavior.States.CommonShow.CommonShowBornStateCustom"),true,self._behaviorTypeBorn)
    self:AddState(RoleStateName.Idle,require("RoleBehavior.States.CommonShow.CommonShowIdleStateCustom"),false,self._behaviorTypeIdle)
    self:AddState(RoleStateName.TouchGirl, require("RoleBehavior.States.CommonShow.CommonShowTouchState"))
    self:AddState(RoleStateName.RamdonShow,require("RoleBehavior.States.CommonShow.CommonShowRandomStateCustom"))
end

function M:OnSwipe(gesture)
    --出生3秒不要滑动
    if  Time.realtimeSinceStartup - self._enterTime < 3 then 
        return 
    end
    M.super.OnSwipe(self,gesture)
end


return M 
