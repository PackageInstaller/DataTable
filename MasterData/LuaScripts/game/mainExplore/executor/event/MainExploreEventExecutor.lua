--[[ 
-----------------------------------------------------
@filename       : MainExploreEventExecutor
@Description    : 主线探索事件执行器
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreEventExecutor", Class.impl())

--构造函数
function ctor(self)
	self.mIsLog = true
end

function __print(self, str)
	if(self.mIsLog)then 
		print(str) 
	end
end

-- 根据事件类型获取事件执行器
function getEventExecutor(self, eventConfigVo)
	if(eventConfigVo.eventType == mainExplore.EventType.AWARD_BOX)then				-- 宝箱
	elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_MONSTER)then		-- 小怪副本
		return LuaPoolMgr:poolGet(require('game/mainExplore/executor/event/MainExploreEventExecuter_1'))
	elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_BOSS)then			-- BOSS副本
		return LuaPoolMgr:poolGet(require('game/mainExplore/executor/event/MainExploreEventExecuter_1'))
	elseif(eventConfigVo.eventType == mainExplore.EventType.DELIVERY)then			-- 传送门
	elseif(eventConfigVo.eventType == mainExplore.EventType.HIDE_TALK)then			-- 隐藏对话
	elseif(eventConfigVo.eventType == mainExplore.EventType.GOODS)then				-- 物资箱
	elseif(eventConfigVo.eventType == mainExplore.EventType.REMIND_TIP)then			-- 指引提示
	elseif(eventConfigVo.eventType == mainExplore.EventType.ANCHOR_CORE)then		-- 锚点核心
	elseif(eventConfigVo.eventType == mainExplore.EventType.NPC_TALK)then			-- NPC对话
	elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_OPEN)then		-- 障碍物（开）
	elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_CLOSE)then		-- 障碍物（关）
	elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_SWITCHER)then	-- 障碍物控制开关
	elseif(eventConfigVo.eventType == mainExplore.EventType.CAMP_ADD_HP)then		-- 营地
	elseif(eventConfigVo.eventType == mainExplore.EventType.TRAP_DEL_HP)then		-- 陷阱
	elseif(eventConfigVo.eventType == mainExplore.EventType.DECELERATE_AREA)then	-- 减速地带
	end
	return LuaPoolMgr:poolGet(require('game/mainExplore/executor/event/MainExploreBaseEventExecuter'))
end

-- 检查触发事件
function checkTriggerEvent(self, eventConfigVo, paramsDic)
	local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
	local executer = self:getEventExecutor(eventConfigVo)
	executer:checkTriggerEvent(mapId, eventConfigVo, paramsDic)
	LuaPoolMgr:poolRecover(executer)
end

-- 触发之后检测触发事件效果
function checkTriggerEventEffect(self, eventId, awardMsgList, dataMsgList, delEventList, addEventList, updateEventList, finishCall)
	local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
	local eventConfigVo = mainExplore.MainExploreSceneManager:getEventConfigVo(mapId, eventId)
	local executer = self:getEventExecutor(eventConfigVo)
	executer:checkTriggerEventEffect(mapId, eventConfigVo, awardMsgList, dataMsgList, delEventList, addEventList, updateEventList, finishCall)
	LuaPoolMgr:poolRecover(executer)
end

-- 检查返回地图后待表现效果
function checkWaitEffect(self)
    local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
	local list = mainExplore.MainExploreManager:getWaitEventEffectList()
	for i = 1, #list do
		local waitEffectVo = list[i]
		local eventConfigVo = mainExplore.MainExploreSceneManager:getEventConfigVo(mapId, waitEffectVo.eventId)
        if(eventConfigVo.eventType == mainExplore.EventType.AWARD_BOX)then                  -- 宝箱
        elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_MONSTER)then            -- 小怪副本
			mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, _TT(63012, waitEffectVo.paramList[1]))
        elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_BOSS)then               -- BOSS副本
			mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, _TT(63012, waitEffectVo.paramList[1]))
        elseif(eventConfigVo.eventType == mainExplore.EventType.DELIVERY)then               -- 传送门
        elseif(eventConfigVo.eventType == mainExplore.EventType.HIDE_TALK)then           	-- 隐藏对话
        elseif(eventConfigVo.eventType == mainExplore.EventType.GOODS)then                  -- 物资箱
        elseif(eventConfigVo.eventType == mainExplore.EventType.REMIND_TIP)then             -- 指引提示
        elseif(eventConfigVo.eventType == mainExplore.EventType.ANCHOR_CORE)then            -- 锚点核心
        elseif(eventConfigVo.eventType == mainExplore.EventType.NPC_TALK)then            	-- NPC对话
		elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_OPEN)then			-- 障碍物（开）
		elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_CLOSE)then			-- 障碍物（关）
		elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_SWITCHER)then		-- 障碍物控制开关
		elseif(eventConfigVo.eventType == mainExplore.EventType.CAMP_ADD_HP)then			-- 营地
			local eventVo = mainExplore.MainExploreManager:getEventVo(false, waitEffectVo.eventId)
			if(eventVo:getEffecctList()[1] > 0)then
				mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, _TT(63024), waitEffectVo.paramList[1])
			end
		elseif(eventConfigVo.eventType == mainExplore.EventType.TRAP_DEL_HP)then			-- 陷阱
		elseif(eventConfigVo.eventType == mainExplore.EventType.DECELERATE_AREA)then		-- 减速地带（后端没有详细位置，所以不经过后端，客户端自己处理）
        else
            self:__print(string.format("检查返回地图后待表现效果，找不到事件类型%s", eventConfigVo.eventType))
        end
	end
	mainExplore.MainExploreManager:recoveryWaitEventEffectList()
end

-- 更新触发状态列表
function updateTriggerStateList(self, stateList, isRecovery)
	for i = 1, #stateList do
		self:updateTriggerState(stateList[i], isRecovery)
	end
end

-- 更新触发状态
function updateTriggerState(self, state, isRecovery)
	if(state == mainExplore.TriggerState.NONE)then							-- 无
	elseif(state == mainExplore.TriggerState.GAME_PAUSE)then    			-- 游戏暂停
		if(isRecovery)then
			mainExplore.MainExploreManager:setRate(nil)
		else
			mainExplore.MainExploreManager:setRate(0)
		end
	elseif(state == mainExplore.TriggerState.PLAYER_FORBID_CONTROL)then    	-- 玩家不可操作
		mainExplore.MainExplorePlayerProxy:getThing():getAiCtrl():setControlEnable(isRecovery)
	elseif(state == mainExplore.TriggerState.MONSTER_FORBID_FIND_AI)then    -- 怪物取消索敌
		local monsterThingList = mainExplore.MainExploreSceneThingManager:getThingList(mainExplore.EventType.DUP_MONSTER)
		if(monsterThingList)then
			for _, thing in pairs(monsterThingList) do
				thing:getAiCtrl():setFindAiEnable(isRecovery)
			end
		end
		local bossThingList = mainExplore.MainExploreSceneThingManager:getThingList(mainExplore.EventType.DUP_BOSS)
		if(bossThingList)then
			for _, thing in pairs(bossThingList) do
				thing:getAiCtrl():setFindAiEnable(isRecovery)
			end
		end
	elseif(state == mainExplore.TriggerState.PLAYER_HIDE)then    			-- 主角模型隐藏
		mainExplore.MainExplorePlayerProxy:getThing():setVisible(isRecovery)
	elseif(state == mainExplore.TriggerState.MONSTER_HIDE)then    			-- 怪物模型隐藏
		local monsterThingList = mainExplore.MainExploreSceneThingManager:getThingList(mainExplore.EventType.DUP_MONSTER)
		if(monsterThingList)then
			for _, thing in pairs(monsterThingList) do
				thing:setEnableUpdate(isRecovery)
				thing:setVisible(isRecovery)
			end
		end
		local bossThingList = mainExplore.MainExploreSceneThingManager:getThingList(mainExplore.EventType.DUP_BOSS)
		if(bossThingList)then
			for _, thing in pairs(bossThingList) do
				thing:setEnableUpdate(isRecovery)
				thing:setVisible(isRecovery)
			end
		end
	elseif(state == mainExplore.TriggerState.CAMERA_UPDATE_ENABLE)then		-- 相机更新能力
		mainExplore.MainExploreCamera:setIsUpdate(isRecovery)
	elseif(state == mainExplore.TriggerState.UI_VISIBLE_ENABLE)then			-- 界面UI显示能力
		GameDispatcher:dispatchEvent(EventName.UPDATE_MAIN_EXPORE_UI_VISIBLE, isRecovery)
	else
        Debug:log_error("MainExploreEventExecutor", "未设置对应触发状态" .. state)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(63024):	"营地可以回血啦"
]]
