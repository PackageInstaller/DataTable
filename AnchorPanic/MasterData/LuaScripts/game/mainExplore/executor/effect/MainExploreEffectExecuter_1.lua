--[[ 
-----------------------------------------------------
@filename       : MainExploreEffectExecuter_1
@Description    : 主线探索效果执行器：障碍物相关
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreEffectExecuter_1", Class.impl('game/mainExplore/executor/effect/MainExploreBaseEffectExecuter'))

function __initData(self)
	super.__initData(self)

	self.mTimeOutIndex = nil
	self.mTweenTime = 0.3
	self.mTweenerList = {}
end

function startPlay(self, eventConfigVo, dataMsgList, delEventList, addEventList, updateEventList)
    if(delEventList)then
        for i = #delEventList, 1, -1 do
            local delEventVo = mainExplore.MainExploreManager:getEventVo(false, delEventList[i])
			local delEventConfigVo = mainExplore.MainExploreSceneManager:getEventConfigVo(eventConfigVo.mapId, delEventVo:getEventId())
			local thingVo = mainExplore.MainExploreSceneManager:getThingVo(delEventVo:getEventId())
			local thing = mainExplore.MainExploreSceneThingManager:getThing(thingVo)
			if(thing)then
				if(delEventConfigVo.eventType == mainExplore.EventType.OBSTACLE_OPEN or delEventConfigVo.eventType == mainExplore.EventType.OBSTACLE_CLOSE)then
					gs.TransQuick:LPosY(thing:getTrans(), 0)
					table.insert(self.mTweenerList, TweenFactory:move2LPosY(thing:getTrans(), -2, self.mTweenTime, gs.DT.Ease.Linear))
				end
			end
        end
    end

    if(addEventList)then
        for i = #addEventList, 1, -1 do
			local addData = table.remove(addEventList, i)
            local addEventVo = mainExplore.MainExploreManager:addEventVo(false, addData)
            if(addEventVo)then
                mainExplore.MainExploreSceneManager:removeThingVo(addEventVo:getEventId())
                mainExplore.MainExploreSceneManager:addThingVo(addEventVo:getEventId(), nil, nil)

				local addEventConfigVo = mainExplore.MainExploreSceneManager:getEventConfigVo(eventConfigVo.mapId, addEventVo:getEventId())
				local thingVo = mainExplore.MainExploreSceneManager:getThingVo(addEventVo:getEventId())
				local thing = mainExplore.MainExploreSceneThingManager:getThing(thingVo)
				if(thing)then
					if(addEventConfigVo.eventType == mainExplore.EventType.OBSTACLE_OPEN or addEventConfigVo.eventType == mainExplore.EventType.OBSTACLE_CLOSE)then
						gs.TransQuick:LPosY(thing:getTrans(), -2)
						table.insert(self.mTweenerList, TweenFactory:move2LPosY(thing:getTrans(), 0, self.mTweenTime, gs.DT.Ease.Linear))
					end
				end
            end
        end
    end

    if(updateEventList)then
        local tempEventVo = nil
        for i = #updateEventList, 1, -1 do
            tempEventVo = LuaPoolMgr:poolGet(mainExplore.MainExploreEventVo)
            tempEventVo:setData(updateEventList[1])
			if(tempEventVo:getEventId() == eventConfigVo.eventId)then
				table.remove(updateEventList, i)

				local thingVo = mainExplore.MainExploreSceneManager:getThingVo(tempEventVo:getEventId())
				local thing = mainExplore.MainExploreSceneThingManager:getThing(thingVo)
				if(thing)then
					local effectEventConfigVo = mainExplore.MainExploreSceneManager:getEventConfigVo(eventConfigVo.mapId, tempEventVo:getEffecctList()[1])
					if(effectEventConfigVo)then
						if(effectEventConfigVo.eventType == mainExplore.EventType.OBSTACLE_OPEN)then
							table.insert(self.mTweenerList, TweenFactory:scaleTo01(thing:getTrans(), thing:getScale().z, 0.5, self.mTweenTime, gs.DT.Ease.Linear))
							gs.Message.Show(_TT(63022))
						elseif(effectEventConfigVo.eventType == mainExplore.EventType.OBSTACLE_CLOSE)then
							table.insert(self.mTweenerList, TweenFactory:scaleTo01(thing:getTrans(), thing:getScale().z, 1, self.mTweenTime, gs.DT.Ease.Linear))
							gs.Message.Show(_TT(63023))
						end
					else
						gs.TransQuick:Scale(thing:getTrans(), 1, 1, 1)
					end
				end
			end
        end
        if(tempEventVo)then
            LuaPoolMgr:poolRecover(tempEventVo)
        end
    end

	local function finishCall()
		mainExplore.MainExploreEffectExecutor:removeEffect(self:getSn())
	end
	self.mTimeOutIndex = LoopManager:setTimeout(self.mTweenTime, self, finishCall)
end

function __reset(self)
	super.__reset(self)

	for i = 1, #self.mTweenerList do
		self.mTweenerList[i]:Kill()
	end
	self.mTweenerList = {}

	if self.mTimeOutIndex then
		LoopManager:clearTimeout(self.mTimeOutIndex)
		self.mTimeOutIndex = nil
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(63023):	"机关状态当前为关"
	语言包: _TT(63022):	"机关状态当前为开"
]]
