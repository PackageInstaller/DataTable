
------------ import ------------
local EventTrigger      = CS.UnityEngine.EventSystems.EventTrigger
local EventTriggerEntry = EventTrigger.Entry
-- local EventTriggerType  = CS.UnityEngine.EventSystems.EventTriggerType
------------ import ------------


------------ define ------------
local EventTriggerType = typeof(EventTrigger)
------------ define ------------

---@class EventTriggerMB
---@field Env                           	EventTriggerMB                                     
---@field controller                    	Engine.Modules.LuaBehaviour
local EventTriggerMB = Class('EventTriggerMB')

function EventTriggerMB:__init()

end


function EventTriggerMB:__delete()

end


function EventTriggerMB:Awake()
    ---@type UnityEngine.EventSystems.EventTrigger
    self.eventTrigger = self.controller.gameObject:GetComponent(EventTriggerType)
end


-- function EventTriggerMB:Start()
    
-- end


function EventTriggerMB:OnDestroy()
    -- if not isNull(self.eventTrigger) then
    --     self.eventTrigger.triggers:RemoveAll()
    -- end

    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()

end


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function EventTriggerMB:RegEventTriggerEntry(triggerType, callback)
    ---@type UnityEngine.EventSystems.EventTrigger
    local eventTrigger = self.eventTrigger
    if isNull(eventTrigger) then
        return
    end
    local enterUIEntry = EventTriggerEntry()
    enterUIEntry.eventID = triggerType
    enterUIEntry.callback:AddListener(function (eventData)
        if callback then
            callback(eventData)
        end
    end)
    eventTrigger.triggers:Add(enterUIEntry)
end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return EventTriggerMB
