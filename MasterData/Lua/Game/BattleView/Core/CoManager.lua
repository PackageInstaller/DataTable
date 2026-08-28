--[[
    author:luqucheng
    time:2020-09-23 17:22:58
]]
local cs_coroutine = import('XLua.cs_coroutine')

local CoManager = {}
CoManager._Id = 1
CoManager._CoArray = {}



function CoManager:AddCo( co, tag )
    self._Id  = self._Id + 1
    table.insert(self._CoArray, {co = co, id = self._Id, tag = tag})
    -- print("CoManager:" .. #self._CoArray)
    return self._Id
end

function CoManager:RemoveCoByTag( tag )
    for i,v in fipairs(self._CoArray) do
        if v.tag == tag then
            table.remove(self._CoArray, i)
            self:__ClearCoData(v)
        end
    end
    -- print("CoManager:" .. #self._CoArray)
end

function CoManager:RemoveCoById( id )
    for i,v in fipairs(self._CoArray) do
        if v.id == id then
            table.remove(self._CoArray, i)
            self:__ClearCoData(v)
            -- print("CoManager:" .. #self._CoArray)
            return
        end
    end
end

function CoManager:Dispose()
    for i,v in ipairs(self._CoArray) do
        self:__ClearCoData(v)
    end
    self._CoArray = {}
    self._Id = 1
end

function CoManager:__ClearCoData( coData )
    if coData.co then
        cs_coroutine.stop(coData.co)
        coData = nil
    end
end

return CoManager