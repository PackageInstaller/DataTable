--[[ 
-----------------------------------------------------
@filename       : MainExploreEffectExecutor
@Description    : 主线探索效果执行器
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreEffectExecutor", Class.impl())

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
function getEffectExecutor(self, eventConfigVo)
	if(eventConfigVo.eventType == mainExplore.EventType.AWARD_BOX)then				-- 宝箱
	elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_MONSTER)then		-- 小怪副本
		return LuaPoolMgr:poolGet(require('game/mainExplore/executor/effect/MainExploreEffectExecuter_2'))
	elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_BOSS)then			-- BOSS副本
		return LuaPoolMgr:poolGet(require('game/mainExplore/executor/effect/MainExploreEffectExecuter_2'))
	elseif(eventConfigVo.eventType == mainExplore.EventType.DELIVERY)then			-- 传送门
	elseif(eventConfigVo.eventType == mainExplore.EventType.HIDE_TALK)then			-- 隐藏对话
	elseif(eventConfigVo.eventType == mainExplore.EventType.GOODS)then				-- 物资箱
	elseif(eventConfigVo.eventType == mainExplore.EventType.REMIND_TIP)then			-- 指引提示
	elseif(eventConfigVo.eventType == mainExplore.EventType.ANCHOR_CORE)then		-- 锚点核心
	elseif(eventConfigVo.eventType == mainExplore.EventType.NPC_TALK)then			-- NPC对话
	elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_OPEN)then		-- 障碍物（开）
	elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_CLOSE)then		-- 障碍物（关）
	elseif(eventConfigVo.eventType == mainExplore.EventType.OBSTACLE_SWITCHER)then	-- 障碍物控制开关
		return LuaPoolMgr:poolGet(require('game/mainExplore/executor/effect/MainExploreEffectExecuter_1'))
	elseif(eventConfigVo.eventType == mainExplore.EventType.CAMP_ADD_HP)then		-- 营地
	elseif(eventConfigVo.eventType == mainExplore.EventType.TRAP_DEL_HP)then		-- 陷阱
	elseif(eventConfigVo.eventType == mainExplore.EventType.DECELERATE_AREA)then	-- 减速地带
	end
	return LuaPoolMgr:poolGet(require('game/mainExplore/executor/effect/MainExploreBaseEffectExecuter'))
end

function getEffectDic(self)
	if(not self.mEffectDic)then
		self.mEffectDic = {}
	end
	return self.mEffectDic
end

function getEffect(self, sn)
	return self:getEffectDic()[sn]
end

function addEffect(self, effect)
	local dic = self:getEffectDic()
	dic[effect:getSn()] = effect
end

function removeEffect(self, sn)
	local effect = self:getEffect(sn)
	if(effect)then
		LuaPoolMgr:poolRecover(effect)
		self:getEffectDic()[sn] = nil
	end
end

function createEffect(self, eventConfigVo, dataMsgList, delEventList, addEventList, updateEventList, callFun)
	self:removeEffect(eventConfigVo.eventId)
	local effect = self:getEffectExecutor(eventConfigVo)
	effect:setSn(eventConfigVo.eventId)
	effect:setEffectCall(callFun)
	effect:startPlay(eventConfigVo, dataMsgList, delEventList, addEventList, updateEventList)
	self:addEffect(effect)
end

function resetEffect(self)
	if(self.mEffectDic)then
		for sn, effect in pairs(self.mEffectDic) do
			LuaPoolMgr:poolRecover(effect)
		end
		self.mEffectDic = nil
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
