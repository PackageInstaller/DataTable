--[[ 
-----------------------------------------------------
@filename       : MainExplorePlayerAiCtrl
@Description    : 主线探索玩家 AI
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExplorePlayerAiCtrl", Class.impl(mainExplore.MainExploreBaseAiCtrl))

--构造
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
    super.dtor(self)
end

function initData(self)
    super.initData(self)

    -- 特殊设置的操作能力
    self.mControlEnable = true

    -- 同步坐标的时间
    self.mSyncPosTime = sysParam.SysParamManager:getValue(SysParamType.MAIN_EXPLORE_SYNC_TIME, 5)
    self._syncPosTime = 0
end

function create(self, thing)
    super.create(self, thing)
end

function reset(self)
    super.reset(self)
end

function addEvents(self)
    super.addEvents(self)
    GameDispatcher:addEventListener(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, self.onJoystickUpdateHandler, self)
end

function removeEvents(self)
    super.removeEvents(self)
    GameDispatcher:removeEventListener(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, self.onJoystickUpdateHandler, self)
end

-- 摇杆更新
function onJoystickUpdateHandler(self, args)
    self:joyStickMove(args.deltaTime, args.deltaRatioX, args.deltaRatioY)
end

-- 帧循环
function step(self, deltaTime)
    super.step(self, deltaTime)

    self._syncPosTime = self._syncPosTime + deltaTime
    if(self._syncPosTime >= self.mSyncPosTime)then
        self._syncPosTime = 0
        -- 网络稳定且正常情况下，同步坐标给后端
        if(not socket.SocketController:isReconnecting() and not socket.SocketController:isBanReconnect())then
            local playerPos = self.mThing:getThingVo():getPosition()
            GameDispatcher:dispatchEvent(EventName.REQ_SYNC_MAIN_EXPLORE_POS, {playerPos = playerPos})
        end
    end
    
    self:keyboardMove(deltaTime, gs.Input.GetAxis("MainExploreHorizontal"), gs.Input.GetAxis("MainExploreVertical"))
    self.mThing:setAniSpeed(self.mThing:getPlayerConfigVo().normalAnimationSpeed * mainExplore.MainExplorePlayerProxy:getMoveSpeed() / self.mThing:getPlayerConfigVo().normalSpeed)
    
    local allDupPassData = mainExplore.MainExploreManager:getAllDupPassData()
    if(allDupPassData)then
        -- if(mainExplore.MainExploreManager:getRemindVisible())then
            mainExplore.MainExplorePlayerProxy:setReminThing(nil, nil, nil)
        -- end
        mainExplore.MainExplorePlayerProxy:setInteractThingList(nil)
        mainExplore.MainExplorePlayerProxy:setIntroduceThing(nil)
        mainExplore.MainExplorePlayerProxy:setAttackThing(nil)
    else
        -- if(mainExplore.MainExploreManager:getRemindVisible())then
            local remindThing, allCount, finishCount = self:getRemindThing()
            mainExplore.MainExplorePlayerProxy:setReminThing(remindThing, allCount, finishCount)
        -- end
        local _envionmentThingList, interactThingList, _attackThing, introduceThing = self:findThing()
        mainExplore.MainExplorePlayerProxy:setEnvionmentThingList(_envionmentThingList)
        mainExplore.MainExplorePlayerProxy:setInteractThingList(interactThingList)
        mainExplore.MainExplorePlayerProxy:setIntroduceThing(introduceThing)
        mainExplore.MainExplorePlayerProxy:setAttackThing(_attackThing)
    end
end

function findThing(self)
    local _envionmentThingList, interactThingList = nil
    local _attackThing, _introduceThing = nil, nil, nil
    if(self.mThing and self.mThing:getThingVo())then
        local playerConfigVo = self.mThing:getPlayerConfigVo()
        local thingDic = mainExplore.MainExploreSceneThingManager:getThingDic()
        if(thingDic)then
            for eventType, thingList in pairs(thingDic) do
                for i = 1, #thingList do
                    local targetThing = thingList[i]
                    local targetEventConfigVo = targetThing:getEventConfigVo()
                    if(targetEventConfigVo.totalType == mainExplore.TotalType.NORMAL)then
                        if(not _introduceThing and targetEventConfigVo.introduceId > 0)then
                            if(not mainExplore.MainExploreManager:isIntroduceIdFinish(targetEventConfigVo.introduceId))then
                                -- 处于初次介绍范围
                                if(math.v3Distance(self.mThing:getThingVo():getPosition(), targetThing:getThingVo():getPosition()) <= targetEventConfigVo.introduceRange)then
                                    _introduceThing = targetThing
                                end
                            end
                        end
                        if(not _introduceThing)then
                            if(eventType == mainExplore.EventType.DUP_MONSTER or eventType == mainExplore.EventType.DUP_BOSS)then
                                -- 处于玩家视野范围
                                if(mainExplore.isInUmbrella(targetThing:getTrans(), self.mThing:getTrans(), playerConfigVo.findAngle, playerConfigVo.findRange))then
                                    _attackThing = targetThing
                                end
                            else
                                -- 处于目标物交互范围
                                if(math.v3Distance(self.mThing:getThingVo():getPosition(), targetThing:getThingVo():getPosition()) <= targetEventConfigVo.interactRange)then
                                    interactThingList = interactThingList or {} 
                                    if(targetEventConfigVo.eventType == mainExplore.EventType.CAMP_ADD_HP)then
                                        -- 营地是否满足：1、战员有血量亏损；2、营地剩余回血次数大于0
                                        local targetEventVo = mainExplore.MainExploreManager:getEventVo(false, targetEventConfigVo.eventId)
                                        if(#mainExplore.MainExploreManager:getMainExploreHeroVoList(targetEventConfigVo.mapId) > 0 and targetEventVo:getEffecctList()[1] > 0)then
                                            table.insert(interactThingList, targetThing)
                                        end
                                    else
                                        table.insert(interactThingList, targetThing)
                                    end
                                end
                            end
                        end
                    elseif(targetEventConfigVo.totalType == mainExplore.TotalType.ENVIRONMENT)then
                        _envionmentThingList = _envionmentThingList or {}
                        -- 处于目标物交互范围
                        if(math.v3Distance(self.mThing:getThingVo():getPosition(), targetThing:getThingVo():getPosition()) <= targetEventConfigVo.interactRange)then
                            table.insert(_envionmentThingList, targetThing)
                        end
                    end
                end
            end
        end
    end
    return _envionmentThingList, interactThingList, _attackThing, _introduceThing
end

function getRemindThing(self)
	local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
    local remindEventId, allCount, finishCount = mainExplore.MainExploreManager:getStepRemindEventId(mapId)
    if(remindEventId)then
        local eventConfigVo = mainExplore.MainExploreSceneManager:getEventConfigVo(mapId, remindEventId)
        local thingList = mainExplore.MainExploreSceneThingManager:getThingList(eventConfigVo.eventType)
        if(thingList)then
            for i = 1, #thingList do
                local targetThing = thingList[i]
                if(targetThing:getEventConfigVo().eventId == remindEventId)then
                    return targetThing, allCount, finishCount
                end
            end
        end
    end
    return nil, nil, nil
end

-- 使用键盘移动
function keyboardMove(self, deltaTime, deltaX, deltaY)
    if(not self.mThing or not self.mThing:getNavMeshAgent())then
        return
    end
    if(not self.mControlEnable)then
        self.mThing:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
        return
    end
    if(self.mThing:getBehaviorState() ~= mainExplore.BehaviorState.IDLE and self.mThing:getBehaviorState() ~= mainExplore.BehaviorState.KEYBOARD_MOVE and self.mThing:getBehaviorState() ~= mainExplore.BehaviorState.PLAYER_ATTACK)then
        return
    end
    if (deltaX ~= 0 or deltaY ~= 0) then
        self.mThing:setBehaviorState(mainExplore.BehaviorState.KEYBOARD_MOVE, nil, nil)

        local sceneCameraTrans = mainExplore.MainExploreCamera:getSceneCameraTrans()
        local dir = sceneCameraTrans.rotation * gs.Vector3(deltaX, 0, deltaY).normalized
        if(not mainExplore.isZeroVector3(dir))then
            local targetRotation = gs.Quaternion.LookRotation(dir)
            if (gs.Quaternion.Angle(gs.Quaternion.Euler(self.mThing:getThingVo():getRotation()), targetRotation) > 1) then
                self.mThing:getThingVo():setRotation(gs.Quaternion.Slerp(gs.Quaternion.Euler(self.mThing:getThingVo():getRotation()), targetRotation, 10 * deltaTime))
            end
        end
        -- local speed = math.abs(math.abs(deltaX) > math.abs(deltaY) and deltaX or deltaY) * self.mThing:getPlayerConfigVo().normalSpeed -- 选择按的最大的哪一个按键来判断主角是不是全力冲刺
        self.mThing:agentMove(math.Vector3(dir.x, mainExplore.MainExplorePlayerProxy:getGravity(), dir.z) * mainExplore.MainExplorePlayerProxy:getMoveSpeed() * deltaTime)
    else
        if(self.mThing:getBehaviorState() == mainExplore.BehaviorState.KEYBOARD_MOVE)then
            self.mThing:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
        end
    end
end

-- 使用摇杆移动
function joyStickMove(self, deltaTime, deltaX, deltaY)
    if(not self.mThing or not self.mThing:getNavMeshAgent())then
        return
    end
    if(not self.mControlEnable)then
        self.mThing:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
        return
    end
    if(self.mThing:getBehaviorState() ~= mainExplore.BehaviorState.IDLE and self.mThing:getBehaviorState() ~= mainExplore.BehaviorState.JOYSTICK_MOVE and self.mThing:getBehaviorState() ~= mainExplore.BehaviorState.PLAYER_ATTACK)then
        return
    end
    if (deltaX ~= 0 or deltaY ~= 0) then
        self.mThing:setBehaviorState(mainExplore.BehaviorState.JOYSTICK_MOVE, nil, nil)

        local sceneCameraTrans = mainExplore.MainExploreCamera:getSceneCameraTrans()
        local dir = sceneCameraTrans.rotation * gs.Vector3(deltaX, 0, deltaY).normalized
        if(not mainExplore.isZeroVector3(dir))then
            local targetRotation = gs.Quaternion.LookRotation(dir)
            if (gs.Quaternion.Angle(gs.Quaternion.Euler(self.mThing:getThingVo():getRotation()), targetRotation) > 1) then
                self.mThing:getThingVo():setRotation(gs.Quaternion.Slerp(gs.Quaternion.Euler(self.mThing:getThingVo():getRotation()), targetRotation, 10 * deltaTime))
            end
        end
        -- local speed = math.abs(math.abs(deltaX) > math.abs(deltaY) and deltaX or deltaY) * self.mThing:getPlayerConfigVo().normalSpeed -- 选择按的最大的哪一个按键来判断主角是不是全力冲刺
        self.mThing:agentMove(math.Vector3(dir.x, mainExplore.MainExplorePlayerProxy:getGravity(), dir.z) * mainExplore.MainExplorePlayerProxy:getMoveSpeed() * deltaTime)
    else
        if(self.mThing:getBehaviorState() == mainExplore.BehaviorState.JOYSTICK_MOVE)then
            self.mThing:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
        end
    end
end

-- 设置玩家操控能力
function setControlEnable(self, enable)
    self.mControlEnable = enable
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
