--[[ 
-----------------------------------------------------
@filename       : MainExploreBaseEventExecuter
@Description    : 主线探索事件执行器基类
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreBaseEventExecuter", Class.impl())

--构造函数
function ctor(self)
	self.mIsLog = true
end

function __print(self, str)
	if(self.mIsLog)then 
		print(str) 
	end
end

function onAwake(self)
    self:initData()
end

function onRecover(self)
    self:removeUpdateFrameSn()
end

function initData(self)
end

function addUpdateFrameSn(self)
    self:removeUpdateFrameSn()
    self.mUpdateFrameSn = LoopManager:addFrame(1, 0, self, self.onUpdateFrameHandler)
end

function removeUpdateFrameSn(self)
    if (self.mUpdateFrameSn) then
        LoopManager:removeFrameByIndex(self.mUpdateFrameSn)
        self.mUpdateFrameSn = nil
    end
end

function onUpdateFrameHandler(self)
end

-- 准备请求触发事件
function checkTriggerEvent(self, mapId, eventConfigVo, paramList)
    local function callFun(isConfirm, cusParamList)
        -- 更新触发状态：恢复
        mainExplore.MainExploreEventExecutor:updateTriggerStateList(eventConfigVo.triggerStateList, true)
        if(isConfirm)then
            GameDispatcher:dispatchEvent(EventName.REQ_TRIGGER_MAIN_EXPLORE_EVENT, {eventId = eventConfigVo.eventId, paramList = cusParamList or {}})
        end
    end
    if(eventConfigVo.eventType == mainExplore.EventType.GOODS)then                          -- 物资箱
        -- 更新触发状态：设置
        mainExplore.MainExploreEventExecutor:updateTriggerStateList(eventConfigVo.triggerStateList, false)
        GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_EXPLORE_GOODS_INFO_PANEL, {mapId = mapId, eventVo = eventConfigVo, callFun = callFun})
    else
        callFun(true, paramList)
    end
end

-- 触发之后检测触发事件效果
function checkTriggerEventEffect(self, mapId, eventConfigVo, awardMsgList, dataMsgList, delEventList, addEventList, updateEventList, finishCall)
    local function _checkEffect(effectCallFun)
        local effectList = eventConfigVo:getEffecctList()
        self:__print(string.format("after - 事件%s触发后", eventConfigVo.eventId))
        if(eventConfigVo.eventType == mainExplore.EventType.AWARD_BOX)then                  -- 宝箱
            ShowAwardPanel:showPropsAwardMsg(awardMsgList, effectCallFun)
            return
        elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_MONSTER)then            -- 小怪副本
        elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_BOSS)then               -- BOSS副本
        elseif(eventConfigVo.eventType == mainExplore.EventType.DELIVERY)then               -- 传送门
            local playerThingVo = mainExplore.MainExplorePlayerProxy:getThingVo()
            playerThingVo:setPositionNow(math.Vector3(effectList[1] or dataMsgList[1], effectList[2] or dataMsgList[2], effectList[3] or dataMsgList[3]))
        elseif(eventConfigVo.eventType == mainExplore.EventType.HIDE_TALK)then              -- 隐藏对话
        elseif(eventConfigVo.eventType == mainExplore.EventType.GOODS)then                  -- 物资箱
            mainExplore.MainExploreManager:addGoods(mapId, dataMsgList[1])
            local goodsConfigVo = mainExplore.MainExploreSceneManager:getGoodsConfigVo(dataMsgList[1])
            mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, _TT(63009, goodsConfigVo:getName()))
        elseif(eventConfigVo.eventType == mainExplore.EventType.REMIND_TIP)then             -- 指引提示
        elseif(eventConfigVo.eventType == mainExplore.EventType.ANCHOR_CORE)then            -- 锚点核心
        elseif(eventConfigVo.eventType == mainExplore.EventType.NPC_TALK)then               -- NPC对话
		elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_OPEN)then			-- 障碍物（开）
		elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_CLOSE)then			-- 障碍物（关）
		elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_SWITCHER)then		-- 障碍物控制开关
            mainExplore.MainExploreEffectExecutor:createEffect(eventConfigVo, dataMsgList, delEventList, addEventList, updateEventList, effectCallFun)
            return
		elseif(eventConfigVo.eventType == mainExplore.EventType.CAMP_ADD_HP)then			-- 营地
            mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, _TT(63010, effectList[1] or dataMsgList[1]))
		elseif(eventConfigVo.eventType == mainExplore.EventType.TRAP_DEL_HP)then			-- 陷阱
            mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, string.substitute(_TT(63008), effectList[1] or dataMsgList[1]))
		elseif(eventConfigVo.eventType == mainExplore.EventType.DECELERATE_AREA)then		-- 减速地带（后端没有详细位置，所以不经过后端，客户端自己处理）
            local playerThing = mainExplore.MainExplorePlayerProxy:getThing()
            if(dataMsgList.updateState == 1)then
                mainExplore.MainExplorePlayerProxy:setMoveSpeed(playerThing:getPlayerConfigVo().normalSpeed * effectList[1] / 100)
                mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, _TT(63011, effectList[1]))
            else
                mainExplore.MainExplorePlayerProxy:setMoveSpeed(playerThing:getPlayerConfigVo().normalSpeed)
            end
        else
            self:__print(string.format("after - 触发后，找不到事件类型%s", eventConfigVo.eventType))
        end

        if(effectCallFun)then
            effectCallFun()
        end
    end

    local _finishCall = finishCall
    local function finishCall()
        self:afterUpdateEventList(mapId, delEventList, addEventList, updateEventList)
        -- 更新触发状态：恢复
        mainExplore.MainExploreEventExecutor:updateTriggerStateList(eventConfigVo.triggerStateList, true)
        -- 所有效果表现完检测下通关逻辑
        GameDispatcher:dispatchEvent(EventName.UPDATE_MAIN_EXPORE_PASS)

        if(_finishCall)then
            _finishCall()
        end
    end
    
    -- 更新触发状态：设置
    mainExplore.MainExploreEventExecutor:updateTriggerStateList(eventConfigVo.triggerStateList, false)

    local isPlayBefore, talkId = eventConfigVo:getEventTalkData()
    if(isPlayBefore ~= nil and talkId ~= nil)then
        if(isPlayBefore)then
            local function _storyFinishCall(successFlag, storyRo)
                _checkEffect(finishCall)
            end
            if not storyTalk.StoryTalkCondition:condition10(_storyFinishCall, storyTalk.Module.TYPE_MAIN_EXPLORE, mapId, eventConfigVo.eventId, nil) then
                _checkEffect(finishCall)
            end
            if(eventConfigVo.eventType == mainExplore.EventType.HIDE_TALK)then
                -- 刚开始进入触发剧情时，loading由剧情触发后关闭，否则在一切都ok后就立刻把加载界面关闭
                UIFactory:closeForcibly()
            end
        else
            local function _callFun()
                local function _storyFinishCall(successFlag, storyRo)
                    if(finishCall)then
                        finishCall()
                    end
                end
                if not storyTalk.StoryTalkCondition:condition10(_storyFinishCall, storyTalk.Module.TYPE_MAIN_EXPLORE, mapId, eventConfigVo.eventId, nil) then
                    if(finishCall)then
                        finishCall()
                    end
                end
                if(eventConfigVo.eventType == mainExplore.EventType.HIDE_TALK)then
                    -- 刚开始进入触发剧情时，loading由剧情触发后关闭，否则在一切都ok后就立刻把加载界面关闭
                    UIFactory:closeForcibly()
                end
            end
            _checkEffect(_callFun)
        end
    else
        _checkEffect(finishCall)
    end
end

-- 触发之后更新事件列表
function afterUpdateEventList(self, mapId, delEventList, addEventList, updateEventList)
    if(delEventList)then
        for i = #delEventList, 1, -1 do
            local delEventVo = mainExplore.MainExploreManager:getEventVo(false, delEventList[i])
            mainExplore.MainExploreManager:addEventVo(true, {event_id = delEventVo:getEventId(), event_effect = delEventVo:getEffecctList()})
    
            mainExplore.MainExploreSceneManager:removeThingVo(delEventVo:getEventId())
            mainExplore.MainExploreManager:delEventVo(false, delEventVo:getEventId())
        end
    end

    if(addEventList)then
        for i = #addEventList, 1, -1 do
            local addEventVo = mainExplore.MainExploreManager:addEventVo(true, addEventList[i])
            if(addEventVo)then
                mainExplore.MainExploreSceneManager:removeThingVo(addEventVo:getEventId())
                mainExplore.MainExploreSceneManager:addThingVo(addEventVo:getEventId(), nil, nil)
            end
        end
    end

    if(updateEventList)then
        local tempEventVo = nil
        for i = #updateEventList, 1, -1 do
            tempEventVo = LuaPoolMgr:poolGet(mainExplore.MainExploreEventVo)
            tempEventVo:setData(updateEventList[i])
            local delEventVo = mainExplore.MainExploreManager:getEventVo(false, tempEventVo:getEventId())
            if(delEventVo)then
                mainExplore.MainExploreSceneManager:removeThingVo(delEventVo:getEventId())
                mainExplore.MainExploreManager:delEventVo(false, delEventVo:getEventId())
                
                local addEventVo = mainExplore.MainExploreManager:addEventVo(false, updateEventList[i])
                if(addEventVo)then
                    mainExplore.MainExploreSceneManager:removeThingVo(addEventVo:getEventId())
                    mainExplore.MainExploreSceneManager:addThingVo(addEventVo:getEventId(), nil, nil)
                end
            end
        end
        if(tempEventVo)then
            LuaPoolMgr:poolRecover(tempEventVo)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
