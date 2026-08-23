local StormConst = require("app.view.module.storm.const.StormConst")
local DebugStormComp = class("DebugStormComp", require("app.fairyGUI.debug.UI_DebugStormComp"))

function DebugStormComp:ctor()
	self._isAutoIng = false
	self._newDataComming = false
	self._curStormId = 0
	self._stromDebugList = {}

	self:_init()
end

function DebugStormComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_INFO, self._getStormInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEFINISH, self._onRcvBattleEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEBEGIN, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_AWARD, self._onRecAwardFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_BREAK, self._onBreakFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_STORMINFO, self._onCurStageBack, self)
	g.core.network.GameNetProxy:send_C2S_Storm_Info({})
end

function DebugStormComp:_init()
	self.m_onKeyStorm:addClickListener(handler(self, self._onOneKeyStorm))
end

function DebugStormComp:_getStormInfo()
	self._newDataComming = true

	g.core.network.GameNetProxy:send_C2S_Storm_StormInfo({
		storm_id = g.core.model.User.stormData:getCurSmallStorm().info.id
	})
end

function DebugStormComp:_onOneKeyStorm()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.STORM) then
		self:showLog("功能未解锁")

		return
	end

	if self._isAutoIng then
		return
	end

	if not self._newDataComming then
		return
	end

	if g.core.model.User.stormData:getCurSmallStorm().info.id ~= self._curStormId then
		self:showLog("关卡切换，重新点击一键")
		g.core.network.GameNetProxy:send_C2S_Storm_StormInfo({
			storm_id = g.core.model.User.stormData:getCurSmallStorm().info.id
		})

		return
	end

	g.core.battle.BattleShowResult:disableAll()

	self._isAutoIng = true

	self:showLog("扫荡中...")
	self:doOneKeyStorm()
end

function DebugStormComp:doOneKeyStorm()
	local var_6_0 = self:getNextEventId()

	if not var_6_0 then
		self:showLog("当前通关，点击扫荡下一章节")

		self._isAutoIng = false

		g.core.network.GameNetProxy:send_C2S_Storm_StormInfo({
			storm_id = g.core.model.User.stormData:getCurSmallStorm().info.id
		})

		return
	end

	local var_6_1 = g.core.config.storm_event_info.get(var_6_0.ev_id)

	if var_6_1.event_type == StormConst.EVENT_TYPE.MONSTER or var_6_1.event_type == StormConst.EVENT_TYPE.MUL_TEAM_MONSTER then
		if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_TIRED) < 1 then
			self:showLog("疲劳值不足")

			self._isAutoIng = false

			return
		end

		self:showLog("打怪升级")
		g.core.network.GameNetProxy:send_C2S_Storm_ChallengeBegin({
			storm_id = self._curStormId,
			cell_id = var_6_0.ev_id
		})
	elseif var_6_1.event_type == StormConst.EVENT_TYPE.NORMAL_AWARD then
		self:showLog("金币 + 5")
		g.core.network.GameNetProxy:send_C2S_Storm_Award({
			storm_id = self._curStormId,
			cell_id = var_6_0.ev_id
		})
	elseif var_6_1.event_type == StormConst.EVENT_TYPE.SPECAIL_BARRIER then
		if g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, var_6_1.event_value1) >= var_6_1.cost_success then
			self:showLog("炸毁障碍")
			g.core.network.GameNetProxy:send_C2S_Storm_Break({
				storm_id = self._curStormId,
				cell_id = var_6_0.ev_id
			})
		else
			self:showLog("缺少破坏障碍物资源")

			self._isAutoIng = false
		end
	end
end

function DebugStormComp:getNextEventId()
	if not next(self._stromDebugList) then
		return nil
	end

	return (table.remove(self._stromDebugList, 1))
end

function DebugStormComp:_onRecAwardFinish()
	self:newScheduleOnce(function()
		self:doOneKeyStorm()
	end, 1)
end

function DebugStormComp:_onBreakFinish()
	self:newScheduleOnce(function()
		self:doOneKeyStorm()
	end, 1)
end

function DebugStormComp:_onCurStageBack(arg_12_1, arg_12_2, arg_12_3)
	self._curStormId = arg_12_3.storm_id
	self._stromDebugList = {}

	local var_12_0 = g.core.model.User.stormData:getCurSmallStorm().events

	if not next(var_12_0) then
		return
	end

	self._stromDebugList = clone(var_12_0)

	for iter_12_0, iter_12_1 in ipairs(self._stromDebugList) do
		if iter_12_1.ev_id % 1000 > 100 and iter_12_1.ev_id % 1000 < 200 then
			iter_12_1.sortIndex = 2
		elseif iter_12_1.ev_id % 1000 > 200 and iter_12_1.ev_id % 1000 < 300 then
			iter_12_1.sortIndex = 1
		elseif iter_12_1.ev_id % 1000 > 300 and iter_12_1.ev_id % 1000 < 400 then
			iter_12_1.sortIndex = 4
		elseif iter_12_1.ev_id % 1000 > 400 then
			iter_12_1.sortIndex = 3
		end
	end

	table.sort(self._stromDebugList, function(arg_13_0, arg_13_1)
		if arg_13_0.sortIndex ~= arg_13_1.sortIndex then
			return arg_13_0.sortIndex > arg_13_1.sortIndex
		end

		if arg_13_0.ev_id ~= arg_13_1.ev_id then
			return arg_13_0.ev_id < arg_13_1.ev_id
		end

		return false
	end)
end

function DebugStormComp:_onRcvBattleBegin(arg_14_1, arg_14_2, arg_14_3)
	g.core.battle.BattleProxy:fastBattle(arg_14_3.battle_id)
end

function DebugStormComp:_onRcvBattleEnd(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_3.is_win then
		self:newScheduleOnce(function()
			self:doOneKeyStorm()
		end, 1)
	else
		self._isAutoIng = false

		self:showLog("战斗失败")
		self:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 0.5)
	end
end

function DebugStormComp:showLog(arg_18_1)
	self.m_challenge_log:setText(arg_18_1)
end

function DebugStormComp:onUnload()
	g.core.battle.BattleShowResult:enableAll()
end

return DebugStormComp
