---@class EventManager
local EventPerformance = require "EventManager"
local BattleCore = require "BattleCore"


--事件触发条件方法注册
function EventPerformance:registerBattleEventPerformance()

    --在配置范围内显示特殊格子
    local function doPerfShowSpecialFloor(param)
        local blockId = param.tileKey
        local length = param.length or 1
        local width = param.width or 1
        local offset = param.offset or {0, 0, 0, nil}--x,y,z,Scale
        local nowPrefEventId = self.nowPreEventfConfig.id
        local battleManager = BattleCore:getBattleMgr()
        local battleMap = battleManager:getMap()
        local idList = battleMap:selectRangeByBlockIdAndTrain(blockId, width, length)
        local showManager = battleManager:getShowManager()
        local path = param.name
        --LuaLogger.ds(">>>>>idList<<<<<", tablex.dump(param))
        showManager:creatSpecialAreaObj(path, idList, offset, nowPrefEventId)
    end

    --在配置范围内显示特效格子(延时)
    local function doPerfShowEffectDelay(param)
        local blockId = param.tileKey
        local length = param.length or 1
        local width = param.width or 1
        local offset = param.offset or {0, 0, 0, nil}--x,y,z,Scale
        local delayTime = param.delay
        local battleManager = BattleCore:getBattleMgr()
        local battleMap = battleManager:getMap()
        local idList = battleMap:selectRangeByBlockIdAndTrain(blockId, width, length)
        local showManager = battleManager:getShowManager()
        local path = param.name

        if delayTime <= 0 then
            showManager:creatSpecialAreaObj(path, idList, offset)
        else
            DLuaTimer:DoAfter(delayTime/100, function()
                showManager:creatSpecialAreaObj(path, idList, offset)
            end)
        end
    end


    --1 在配置范围内显示特殊格子
    self.performanceFunc[GE.EventPerformance.DoPerfShowSpecialFloor] = doPerfShowSpecialFloor
    --2 在配置范围内显示特效格子(延时)
    self.performanceFunc[GE.EventPerformance.DoPerfShowEffectDelay] = doPerfShowEffectDelay
end

return EventPerformance