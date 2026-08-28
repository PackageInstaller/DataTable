
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
-- ---@type ClubGVGUtils
-- local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
-- local GVGConstants     = ClubGVGUtils.Constants
--endregion

---@class ClubGVGDriverData
local ClubGVGDriverData = Class('ClubGVGDriverData')

function ClubGVGDriverData:__init()
    self._triggerSeconds = 0
    self._triggerList    = {}
    -- ---@type ClubGVGConstants.ReportId
    -- self._reportId = reportId
    -- self._data     = data
end


function ClubGVGDriverData:__delete()
    self._triggerList     = nil
end


--region init 


--endregion 


--region logic 

---@param data {triggerType: number, id:number, data:table|nil}
function ClubGVGDriverData:Add(data)
    table.insert(self._triggerList, data)

end

---@param triggerType number | nil
---@param id number
---@return boolean 是否需要回收
function ClubGVGDriverData:Remove(triggerType, id)
    -- for i, value in ipairs(self._triggerList) do
    --     if value.triggerType == triggerType and value.id == id then
    --         local triggerData = table.remove(self._triggerList, i)
    --         return triggerData, #self._triggerList == 0
    --     end
    -- end
    local index = self:Find(triggerType, id)
    if index ~= nil then
        local triggerList = self._triggerList
        local triggerData = table.remove(triggerList, index)
        return triggerData, #triggerList == 0
    end
    return nil
end

---@return number | nil
function ClubGVGDriverData:Find(triggerType, id)
    for i, value in ipairs(self._triggerList) do
        if value.triggerType == triggerType and value.id == id then
            return i
        end
    end
    return nil
end

function ClubGVGDriverData:Reset()
    self._triggerSeconds = 0
    for key in pairs(self._triggerList) do
        self._triggerList[key] = nil
    end
end


--endregion 


--region get/set 

function ClubGVGDriverData:GetTriggerList()
    return self._triggerList
end

---endregion 


--region handler 


---endregion 


return ClubGVGDriverData
