---@class LuaAsyncMgr
local LuaAsyncMgr = class("LuaAsyncMgr")

function LuaAsyncMgr:ctor()
    self:init()
end

function LuaAsyncMgr:Clear()
    self:init()
end

function LuaAsyncMgr:init()
    self._tmpId = 10000
    self._finishId = 0
    -- self._loopAsync = {}
    -- self._frameAsync = {}
    -- self._timeAsync = {}
    self._asyncEventList = {}
end

---异步等待（帧数）
---@param frame int 等待帧数
function LuaAsyncMgr:FrameDelay(frame, callback)
    self._tmpId = self._tmpId + 1
    local frameDelayCo = coroutine.create(function()
        coroutine.yield()
        if callback then
            callback()
        end
        self:RemoveAsyncEvent(self._finishId)
    end)
    local data = {
        id = self._tmpId,
        type = 1,
        nowFrame = 0,
        waitFrame = frame,
        func = frameDelayCo
    }
    -- self._frameAsync[self._tmpId] = data
    self._asyncEventList[self._tmpId] = data
    return self._tmpId
end

---异步等待（时间）
---@param time float 等待时间
---@return int _tmpId 异步id
function LuaAsyncMgr:Delay(time, callback)
    self._tmpId = self._tmpId + 1
    -- print("LuaAsyncMgr:Delay",self._tmpId)
    local delayCo = coroutine.create(function()
        coroutine.yield()
        if callback then
            callback()
        end
        self:RemoveAsyncEvent(self._finishId)
    end)
    local data = {
        id = self._tmpId,
        type = 2,
        nowTime = 0,
        waitTime = time,
        func = delayCo
    }
    -- self._timeAsync[self._tmpId] = data
    self._asyncEventList[self._tmpId] = data
    return self._tmpId
end

---异步for循环
---每帧只循环一次
---@param loopTimes int 循环次数(-1为无限次)
---@param onLoop Action<int> 每次循环时回调（带当前循环次数的参数）
---@param callback Action 所有循环完成后回调
function LuaAsyncMgr:FrameLoop(loopTimes, onLoop, callback)
    self._tmpId = self._tmpId + 1
    local data = {
        id = self._tmpId,
        type = 3,
        nowTimes = 0,
        loopTimes = loopTimes,
        func = onLoop,
        callback = callback
    }
    -- self._loopAsync[self._tmpId] = data
    self._asyncEventList[self._tmpId] = data
    return self._tmpId
end

function LuaAsyncMgr:RemoveAsyncEvent(id)
    -- print("LuaAsyncMgr:RemoveAsyncEvent",id)
    self._asyncEventList[id] = nil
    -- self._loopAsync[id] = nil
    -- self._frameAsync[id] = nil
    -- self._timeAsync[id] = nil
end

function LuaAsyncMgr:Update()
    local currentTime = Time.deltaTime
    if (tablex.size(self._asyncEventList) > 0) then
        -- print("LuaAsyncMgr _asyncEventList",tablex.size(self._asyncEventList))
        for id, data in pairs(self._asyncEventList) do
            if (data.type == 3) then
                if (data.nowTimes == data.loopTimes) then
                    if (data.callback) then
                        data.callback()
                    end
                    self:RemoveAsyncEvent(data.id)
                else
                    data.nowTimes = data.nowTimes + 1
                    if (data.func) then
                        data.func(data.nowTimes)
                    end
                end
            elseif (data.type == 2) then
                if (data.nowTime >= data.waitTime) then
                    self._finishId = data.id
                    coroutine.resume(data.func)
                else
                    data.nowTime = data.nowTime + currentTime
                end
            elseif (data.type == 1) then
                if (data.nowFrame >= data.waitFrame) then
                    self._finishId = data.id
                    coroutine.resume(data.func)
                else
                    data.nowFrame = data.nowFrame + 1
                end
            else
                LuaLogger.ds("LuaAsyncMgr:Update wrong type",data.type)
            end
        end
    end

    -- if (tablex.size(self._loopAsync) > 0) then
    --     for id, data in pairs(self._loopAsync) do
    --         if (data.nowTimes == data.loopTimes) then
    --             if (data.callback) then
    --                 data.callback()
    --             end
    --             self:RemoveAsyncEvent(data.id)
    --         else
    --             data.nowTimes = data.nowTimes + 1
    --             if (data.func) then
    --                 data.func(data.nowTimes)
    --             end
    --         end
    --     end
    -- end

    -- if (tablex.size(self._frameAsync) > 0) then
    --     for id, data in pairs(self._frameAsync) do
    --         if (data.nowFrame >= data.waitFrame) then
    --             self._finishId = data.id
    --             coroutine.resume(data.func)
    --         else
    --             data.nowFrame = data.nowFrame + 1
    --         end
    --     end
    -- end
    -- if (tablex.size(self._timeAsync) > 0) then
    --     for id, data in pairs(self._timeAsync) do
    --         if (data.nowTime >= data.waitTime) then
    --             self._finishId = data.id
    --             coroutine.resume(data.func)
    --         else
    --             data.nowTime = data.nowTime + currentTime
    --         end
    --     end
    -- end
end

return LuaAsyncMgr