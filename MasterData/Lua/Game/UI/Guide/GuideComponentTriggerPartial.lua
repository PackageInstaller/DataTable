
------------ import ------------
local UIModule          = CS.Engine.UI.UIModule
------------ import ------------


------------ define ------------
--- 触发类型
local TriggerType  = Constants.GuideTriggerType
local yield_return = coroutine.yield
------------ define ------------

---@class GuideComponentTriggerPartial
local GuideComponentTriggerPartial = Class('GuideComponentTriggerPartial')

function GuideComponentTriggerPartial:__init()

end


function GuideComponentTriggerPartial:__delete()
    self.context =  nil
end


function GuideComponentTriggerPartial:Awake()
end


function GuideComponentTriggerPartial:Start()
end


function GuideComponentTriggerPartial:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- logic begin --
---------------------------------------------------

---CheckTriggerType
---@param triggerType number
---@param triggerParams string
function GuideComponentTriggerPartial:CheckTriggerType(triggerType, triggerParams)
    --- 检查进入界面
    if triggerType == TriggerType.EnterView or triggerType == TriggerType.QuitView then
        local CurrentScreen = UIModule.CurrentScreen
        if CurrentScreen == nil then return false end
        local dialogs = CurrentScreen.dialogs
        if dialogs.Count <= 0 then return false end

        local dialog = dialogs[dialogs.Count - 1]
        local Argument = dialog.Argument
        local id = Argument.id
        return id == triggerParams
    
    elseif triggerType == TriggerType.ForcedTrigger then
        ---@type GuideComponent
        local context = self.context
        return context:GetIsForcedTrigger()

    end
    return false

end

function GuideComponentTriggerPartial:CheckTriggerState(triggerType)
    if triggerType == TriggerType.EnterView then
        --- CheckTriggerType 方法中已经检测过 dialog count 直接取最后一个
        local dialogs = UIModule.CurrentScreen.dialogs
        ---@type Engine.UI.UILuaDialog
        local dialog  = dialogs[dialogs.Count - 1]
        while not dialog.IsShow or not dialog.HasFocus do
            yield_return()
        end
        return true

    elseif triggerType == TriggerType.ForcedTrigger then
        ---@type GuideComponent
        local context = self.context
        return context:GetIsForcedTrigger()

    end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function GuideComponentTriggerPartial:SetContext(context)
    self.context = context
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return GuideComponentTriggerPartial
