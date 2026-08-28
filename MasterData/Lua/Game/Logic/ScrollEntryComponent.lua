---
--- Created by THL.
---

local ECSComponent = import("Frame.ECS.ECSComponent")
---@class ScrollEntryComponent
local ScrollEntryComponent = Class("ScrollEntryComponent", ECSComponent)

function ScrollEntryComponent:__init()
    self._data = {}             --滚动的数据
end

function ScrollEntryComponent:__delete()
    self._data = nil
end

function ScrollEntryComponent:Initial(jsonData)
    self._data = {}
    if jsonData then
        self._data = jsonData
    end
end

--
function ScrollEntryComponent:GetData()
    return self._data
end

return ScrollEntryComponent
