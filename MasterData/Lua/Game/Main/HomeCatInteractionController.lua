
--region global define
local isNull    = isNull
local import    = import
local isNotNull = isNotNull

--endregion

--region import
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")

local parseUtils = CS.ParseUtils
--endregion

--region define

local CatState = {
    Idle            = 1, 
    Sleep           = 2, 
    Interaction     = 3, --- 交互
    DeepInteraction = 4, --- 深度交互
}

--- 进入睡眠需要的时间
local SleepTriggerSeconds               = 10
--- 退出深度交互需要的时间
local QuitDeepInteractionTriggerSeconds = 0.75
--- 退出交互需要的时间
local QuitInteractionTriggerSeconds     = 4
--- 进入深度交互需要的时间
local DeepInteractionTriggerTime        = 1
--- 启用心跳特效所需时间
local HeartStreamEnableTime             = 2

--endregion

---@class HomeCatInteractionController
local HomeCatInteractionController = Class('HomeCatInteractionController')

function HomeCatInteractionController:__init()
    self._catState        = CatState.Idle
    self._seconds         = 0
    ---@type CatTouchController
    self._touchController = nil
    self._actionIndex     = 1
    self._maxActionIndex  = #CardProgressionConstants.CatTouchActionFlag
    self._isEnabled       = false
    
    self._heartStreamEffGo = nil
    self._heartStreamEffs = nil
    self._heartStreamEnableTime = nil
end


function HomeCatInteractionController:__delete()
    self._touchController = nil
    self._heartStreamEffs = nil
end

--region init 

--endregion 


--region logic 

function HomeCatInteractionController:SwitchStateByTouch()
    local catState = self._catState
    if catState == CatState.Sleep then
        ---@type CatTouchController
        local controller = self:GetTouchController()
        if controller ~= nil and controller:IsSleep() then
            controller:EnterIdle()
            self._catState = CatState.Idle
            self._seconds = 0
        end

    elseif catState == CatState.Idle then
        ---@type CatTouchController
        local controller = self:GetTouchController()
        if controller ~= nil and controller:IsIdle() then
            controller:PlayActionByIndex(self._actionIndex)
            self._actionIndex = self._actionIndex == self._maxActionIndex and 1 or (self._actionIndex + 1)

            self:UpdateHandShowState(true)
            self._catState = CatState.Interaction
            self._seconds  = 0

        end

    elseif catState == CatState.Interaction then
        if self._seconds >= DeepInteractionTriggerTime then
            ---@type CatTouchController
            local controller = self:GetTouchController()
            if controller and self._interactionUpdate == nil and controller:IsInteractionLoop() then
                controller:EnterDeepInteraction()
                self._catState = CatState.DeepInteraction
                self._seconds = 0
                self._heartStreamEnableTime = 0
                self:UpdateHandShowState(false)
                
            end
        end

    elseif catState == CatState.DeepInteraction then
        if not self._isEnabledHeartStream then
            self:EnabledHeartStreamEffs(true)
        end
        self._seconds = 0
        
    end

end

function HomeCatInteractionController:SwitchStateByTimer(intervalTime)
    local catState = self._catState
    if self._quit or self:IsInactive() then
        return
    end
    if catState == CatState.Idle then
        if self._seconds >= SleepTriggerSeconds then
            self._catState = CatState.Sleep
            ---@type CatTouchController
            local controller = self:GetTouchController()
            if controller then
                controller:EnterSleep()
            end
            self._seconds = 0
        else
            self._seconds  = self._seconds + intervalTime
            
        end

    elseif catState == CatState.Interaction then
        if self._seconds >= QuitInteractionTriggerSeconds then
            self:QuitInteraction()
        else
            self._seconds  = self._seconds + intervalTime
            if self._interactionUpdate and self._interactionUpdate() then
                self._interactionUpdate = nil
            end
        end

    elseif catState == CatState.DeepInteraction then
        if self._seconds >= QuitDeepInteractionTriggerSeconds then
            ---@type CatTouchController
            local controller = self:GetTouchController()
            if controller then
                self:QuitDeepInteraction()
            end
        else
            self._seconds = self._seconds + intervalTime
            
        end

    else
        self._seconds = 0

    end

end

function HomeCatInteractionController:QuitInteraction()
    ---@type CatTouchController
    local controller = self:GetTouchController()
    if controller then
        controller:EnterStanding()
        self._catState = CatState.Idle
        self:UpdateHandShowState(false)
    end
    self._seconds = 0
end

function HomeCatInteractionController:QuitDeepInteraction()
    ---@type CatTouchController
    local controller = self:GetTouchController()
    if controller then
        self._quit = true
        CfUtils.ConditionAppend("CatTouchStatus.DeepInteraction")
        CoStart(function()
            controller:QuitDeepInteraction()
            CoYield()
            self._heartStreamEnableTime = nil
            self:EnabledHeartStreamEffs(false)
            controller:EnterStanding()
            -- self:UpdateHandShowState(false)
            self._quit = false
            self._catState = CatState.Idle
            self._seconds = 0
            CfUtils.ConditionRemove("CatTouchStatus.DeepInteraction")
        end)
    end
end

function HomeCatInteractionController:OnClearCatInteractionAction()
    local state = checkNumber(CfUtils.GetLocalData(Constants.UICacheDataKeys.HOME_BOARD_STATE, "1"))
    if state ~= 2 then
        return
    end
    local catState    = self._oldCatState or self._catState
    self._oldCatState = nil
    if catState == CatState.Interaction then
        self:QuitInteraction()
    elseif catState == CatState.DeepInteraction then
        self:QuitDeepInteraction()
    end
end

function HomeCatInteractionController:UpdateHandShowState(isShow, isImmediate)
    if isShow then
        if self._interactionUpdate then
            return
        end
        ---@type CatTouchController
        local controller = self:GetTouchController()
        self:PreloadDeepInteractionEffect()

        self._interactionUpdate = function ()
            if not controller:IsInteractionLoop() then
                return false
            end
            local position
            local isEmpty = string.isEmpty(self._heartStreamPosition)
            if isEmpty then
                local trans = controller:GetCatTrans()
                local node = trans:Find("Unity_Export_Grp/DeformationScale_Grp/DeformationSystem/root_move_jnt/Root_M/Spine1_M/Chest_M/Neck_M/Head_M/tongue_Jnt1")
                if isNull(node) then
                    node = trans:Find("Unity_Export_Grp/DeformationScale_Grp/DeformationSystem/root_move_jnt")
                end
                position = isNotNull(node) and node.position or Vector3.zero
            else
                position = parseUtils.ParseVector3(self._heartStreamPosition)
            end
            
            Events.Broadcast(Constants.EventNames.UIEventHomeShowOrHideHand, true, position)
            if isNotNull(self._heartStreamEffGo) then
                self._heartStreamEffGo.transform.position = position

            end
            return true
        end
        
    else
        self._interactionUpdate = nil
        Events.Broadcast(Constants.EventNames.UIEventHomeShowOrHideHand, false, nil, isImmediate)

    end
end

function HomeCatInteractionController:PreloadDeepInteractionEffect()
    if self._isPreloadEffect or isNotNull(self._heartStreamEffGo) then
        return
    end
    self._isPreloadEffect = true
    ---@type CatTouchController
    local controller = self:GetTouchController()
    local catTrans = controller:GetCatTrans()
    if isNull(catTrans) then
        self._isPreloadEffect = false
        return
    end
    CardProgressionUtils.LoadGameObjectAsync(CardProgressionConstants.PrefabPath.fx_CatTouch_HeartStream, catTrans.parent, function (go)
        self._heartStreamEffGo = go
        local particleSystems = go:GetComponentsInChildren(CardProgressionConstants.CompType.ParticleSystemType)
        self._heartStreamEffs = particleSystems
        self._isPreloadEffect = false
    end)

end

function HomeCatInteractionController:EnabledHeartStreamEffs(isEnabled)
    if isNull(self._heartStreamEffs) then
        return
    end
    self._isEnabledHeartStream = isEnabled
    CardProgressionUtils.EnabledParticleSystemsEmission(self._heartStreamEffs, isEnabled)
end

--endregion 


--region get/set 

---GetTouchController
---@return CatTouchController
function HomeCatInteractionController:GetTouchController()
    ---由于这里是引用 CardProgressionControllerRole 中的控制器 需要检查下控制器是否被销毁了
    if self._touchController and not self._touchController.IsDestroy then
        return self._touchController
    end
    
    ---@type CardProgressionUtils
    local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
    ---@type CardProgressionControllerRole
    local env                  = CardProgressionUtils.GetRoleControllerEnv()
    if env == nil then return end
    ---@type CatTouchController
    local touchController = env:GetTouchController()
    self._touchController = touchController
    return touchController
end

function HomeCatInteractionController:IsInactive()
    return self._isEnabled == false or self._catState == CatState.Sleep
end

function HomeCatInteractionController:OnEnable(cardId)
    self._isEnabled = true
end

function HomeCatInteractionController:SetCardId(cardId, skinId)
    if (cardId ~= nil and cardId ~= 0 and self._cardId ~= cardId) or (skinId ~= nil and skinId ~= 0 and self._skinId ~= skinId) then
        self._cardId = cardId
        self._skinId = skinId
        ---@type CardPositionVo
        local cardPositionVo = CardConfMgr:GetInstance():GetCardPosByCardId(cardId, skinId)
        self._heartStreamPosition = cardPositionVo.heartStreamPosition
    end
end

function HomeCatInteractionController:OnDisable()
    --- 节点被隐藏说明 退出了主界面 这里直接切换成idle
    self._isEnabled   = false
    self._oldCatState = self._catState
    self._catState    = CatState.Idle
    self._seconds     = 0
    self:OnClearCatInteractionAction()
    self:UpdateHandShowState(false, true)
end

---endregion 


--region handler 


---endregion 


return HomeCatInteractionController
