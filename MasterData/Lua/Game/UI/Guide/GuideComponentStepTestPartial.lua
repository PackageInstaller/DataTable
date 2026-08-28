--region import

--endregion

--region defines

--endregion

---@class GuideComponentStepTestPartial
local GuideComponentStepTestPartial = Class('GuideComponentStepTestPartial')


function GuideComponentStepTestPartial:__init()
    self.__eventGuideSkipModule = Events.AddListener(Constants.EventNames.EVENT_GUIDE_SKIP_MODULE, function() 
        self:Stop()
        self.context:SetSkipBlockerCondition(false)
    end)
end

function GuideComponentStepTestPartial:__delete()
    if self.__eventGuideSkipModule then
        Events.RemoveListener(Constants.EventNames.EVENT_GUIDE_SKIP_MODULE, self.__eventGuideSkipModule)
        self.__eventGuideSkipModule = nil
    end
    self.context = nil
end

--region logic

---Start
---@param data SystemGuideModuleStepVo
function GuideComponentStepTestPartial:Start(data)
    self:Stop()
    local CoYield = CoYield
    self.co = CoStart(function() 
        ---@type GuideComponent
        local context = self.context
        context:LoadGuidePrefab()

        local state = context:CheckStepTrigger(data)
        if state and state ~= Constants.GuideModuleState.CompleteStep then return end
        -- Events.Broadcast(Constants.EventNames.EVENT_GUIDE_SHOW_GUIDE_LAYER)
        context:SetGuidePrefabActive(true)

        context:CheckUI()

        context:SetIsWaitExecuteNextStep(true)

        printInfo("guide---------------->>>>  开始 显示 对应 action = %s   eventInfo = %s", data.actionInfo, data.eventInfo)
        --- 显示动作
        Events.Broadcast(Constants.EventNames.EVENT_GUIDE_SHOW_ACTION, data)
        context:SetIsStartWait(true)
        --- 等待执行下一阶段
        while context:GetIsWaitExecuteNextStep() do
            CoYield()
        end

        context:SetIsStartWait(false)
        context:SetIsInGuiding(false)
        context:SetGuidePrefabActive(false)
        self.co = nil
    end)
end

function GuideComponentStepTestPartial:Stop()
    if isNotNull(self.co) then
        CoStop(self.co)
        self.co = nil
    end
    ---@type GuideComponent
    local context = self.context
    context:SetIsStartWait(false)
    context:SetIsInGuiding(false)
    context:SetGuidePrefabActive(false)
    self.co = nil
end

--endregion

--region get/set

---SetContext
---@param context GuideComponent
function GuideComponentStepTestPartial:SetContext(context)
    self.context = context
end

--endregion


return GuideComponentStepTestPartial
