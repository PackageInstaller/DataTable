-- @FileName:   FieldExplorationSceneController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-24 20:37:52
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.controller.FieldExplorationSceneController', Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
    self.mDupTime = 0

end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:clearMap()
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.ENTER_NEW_MAP, self.onEnterMapHandler, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_GAME_START, self.onStartGame, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_GAME_OVER, self.onGameOver, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_GAME_AGIN, self.onPlayAgin, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 开始加载前
function beforeLoad(self)
    UIFactory:startForcibly()

    local dup_id = fieldExploration.FieldExplorationManager:getDupId()
    self.mDupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(dup_id)
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)

    if not self.mSceneConfig then
        logError("拿不到场景配置")
        return
    end

    self:initScene()
end

function initScene(self)
    local heroSceneConfig = fieldExploration.FieldExplorationManager:getCurHeroConfigVo()
    local born_pos = self.mSceneConfig.born_pos
    local createPos = {x = born_pos[1], y = born_pos[2], z = born_pos[3]}

    fieldExploration.FieldExplorationPlayerThing:create({id = heroSceneConfig.id, tid = heroSceneConfig.heroTid, config = heroSceneConfig, createPos = createPos, angle = 0}, function (thing)
        self.mPlayerThing = thing

        --打开主界面UI
        GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONSCENEUI)

        UIFactory:closeForcibly()
    end)
end

function onPlayAgin(self)
    self:clearData()
    self:initScene()
end

function onStartGame(self)
    self.mEventList = table.copy(self.mSceneConfig.eventList)
    self.mSceneEventThingList = {}

    --游戏时间
    self.mDupTime = 0
    self.lateUpdateEventTime = -1
    self.lateCheckEventTime = 2

    self:clearTimeSn()
    self:refreshDupTime()
    self.mFrameSn = LoopManager:addFrame(1, -1, self, self.refreshDupTime)

    guide.GuideCondition:condition30()
end

function onGameOver(self, isPass)
    if self.mPlayerThing then
        local attr = self.mPlayerThing:getAttr()
        local score = attr.score
        local dup_id = fieldExploration.FieldExplorationManager:getDupId()

        local cmd = {activity_id = fieldExploration.FieldExplorationManager:getActivityId(), dup_id = dup_id, score = score, gameTime = math.floor(self.mDupTime), isPass = isPass}
        GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_REQSAVA_SCORE, cmd)
    end

    self:clearTimeSn()
end

-- function getSurplusDupTime(self)
--     return self.mDupConfigVo.time - self.mDupTime
-- end

function refreshDupTime(self)
    self.mDupTime = self.mDupTime + LoopManager:getDeltaTime()
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAMETIME_UPDATE, self.mDupTime)

    if self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Time_Over then
        --时间到了
        if self.mDupTime >= self.mDupConfigVo.time then
            GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAME_OVER, false)
            return
        end
    elseif self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Push_Box then
        --时间到了
        if self.mDupTime >= self.mDupConfigVo.time then
            GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAME_OVER, false)
            return
        end

        if self.mDupTime - self.lateCheckEventTime >= 1 then
            local isOver = true
            for event_id, eventThing in pairs(self.mSceneEventThingList) do
                local skilList = eventThing:getAllSkill()
                for skill_id, skill in pairs(skilList) do
                    if skill.config.type == FieldExplorationConst.EVENTSKILLTYPE_PASSAGE then
                        if not skill:getIsPass() then
                            isOver = false
                            break
                        end
                    end
                end
                if not isOver then
                    break
                end
            end

            if isOver then
                GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAME_OVER, true)
            end

            self.lateCheckEventTime = self.mDupTime
        end
    elseif self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.EventDie then
        if self.mDupTime - self.lateCheckEventTime >= 0.5 then
            local isOver = true
            for _, event_tid in pairs(self.mDupConfigVo.settlement_param) do
                if self:getSceneEventCountByTid(event_tid) > 0 then
                    isOver = false
                    break
                end
            end

            if isOver then
                GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAME_OVER, true)
            end

            self.lateCheckEventTime = self.mDupTime
        end
    end

    if self.mDupTime - self.lateUpdateEventTime >= 0.5 then
        self:onUpdateEvent()
        self.lateUpdateEventTime = self.mDupTime
    end
end

--刷新障碍物/道具之类的场景事件
function onUpdateEvent(self)
    if self.mEventList then
        for i = #self.mEventList, 1, -1 do
            local event = self.mEventList[i]
            if self.mDupTime >= event.show_time then
                local eventConfigVo = fieldExploration.FieldExplorationManager:getEventConfigVo(event.event_id)
                if eventConfigVo then
                    local data = {id = event.id, tid = event.event_id, config = event, createTime = self.mDupTime, createPos = event.createPos, angle = event.createAngle, scale = event.scale}

                    local eventThing = nil
                    if eventConfigVo.type == FieldExplorationConst.EventThing_Boom then
                        eventThing = fieldExploration.FieldExplorationBoomEventThing:create(data)
                    elseif eventConfigVo.type == FieldExplorationConst.EventThing_Passage then
                        eventThing = fieldExploration.FieldExplorationPassageEventThing:create(data)
                    elseif eventConfigVo.type == FieldExplorationConst.EventThing_Lift then
                        eventThing = fieldExploration.FieldExplorationLiftEventThing:create(data)
                    elseif eventConfigVo.type == FieldExplorationConst.EventThing_PToggle then
                        eventThing = fieldExploration.FieldExplorationPToggleEventThing:create(data)
                    elseif eventConfigVo.type == FieldExplorationConst.EventThing_Portal then
                        eventThing = fieldExploration.FieldExplorationPortalEventThing:create(data)
                    else
                        eventThing = fieldExploration.FieldExplorationPropEventThing:create(data)
                    end

                    self.mSceneEventThingList[event.id] = eventThing
                end
                table.remove(self.mEventList, i)
            end
        end

        for _, eventThing in pairs(self.mSceneEventThingList) do
            local data = eventThing:getData()
            if data.config.durationTime > 0 then
                if self.mDupTime >= data.createTime + data.config.durationTime then
                    self:deleteSceneEvent(data.id)
                end
            end
        end
    end
end

function getSceneEvent(self, id)
    if not self.mSceneEventThingList then
        return nil
    end
    return self.mSceneEventThingList[id]
end

function getSceneEventByTid(self, event_tid)
    for event_id, eventThing in pairs(self.mSceneEventThingList) do
        if eventThing:getData().tid == event_tid then
            return eventThing
        end
    end
end

function getSceneEventCountByTid(self, event_tid)
    local count = 0
    for event_id, eventThing in pairs(self.mSceneEventThingList) do
        if eventThing:getData().tid == event_tid then
            count = count + 1
        end
    end
    return count
end

--清楚场景事件
function deleteSceneEvent(self, id)
    local eventThing = self.mSceneEventThingList[id]
    if eventThing then
        eventThing:recover()
        self.mSceneEventThingList[id] = nil
    end
end

function onEnterMapHandler(self, mapType)
    if mapType ~= self:getMapType() then
        self:clearData()
    end
end

function clearData(self)
    self:clearTimeSn()

    if self.mPlayerThing then
        self.mPlayerThing:recover()
        self.mPlayerThing = nil
    end

    if self.mSceneEventThingList then
        for _, eventThing in pairs(self.mSceneEventThingList) do
            eventThing:recover()
        end
        self.mSceneEventThingList = nil
    end

    GameDispatcher:dispatchEvent(EventName.CLOSE_FIELDEXPLORATIONSCENEUI)
end

function clearTimeSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

-- 关闭当前地图
function clearMap(self)
    super.clearMap(self)
    self:clearData()
end

--获取当前的游戏时间
function getDupTime(self)
    return self.mDupTime
end

function getPlayerThing(self)
    return self.mPlayerThing
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.FIELD_EXPLORATION
end

-- 地图资源名
function getMapID(self)
    if self.mDupConfigVo then
        self.mSceneConfig = fieldExploration.FieldExplorationManager:getSceneConfigVo(self.mDupConfigVo.scene_id)
        return self.mSceneConfig.scene_id
    end
end

return _M
