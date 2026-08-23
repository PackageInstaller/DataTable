local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.TaskConst
local var_0_2 = g.core.model.User.arenaData
local DebugOneKeyArena = class("DebugOneKeyArena", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyArena:ctor()
	self.super.ctor(self)

	self._content = {}
end

function DebugOneKeyArena:initData()
	self._oneKeyName = "一键困兽争霸"
	self._needAddEventList = {
		[g.core.event.enum.EVENT_NET_S2C_ARENA_GETMAININFO] = handler(self, self._onS2CGetInfo),
		[g.core.event.enum.EVENT_NET_S2C_ARENA_CHALLENGEBEGIN] = handler(self, self._onS2CChallengeBegin),
		[g.core.event.enum.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD] = handler(self, self._onOneKeyGetTaskAward),
		[g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO] = handler(self, self._onGetTaskInfo)
	}
end

function DebugOneKeyArena:doOneKey()
	if self:hasSending() then
		return
	end

	if not self._isGetInfo then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Arena_GetMainInfo({})
		end)

		return
	end

	if (self._content.challenge_count or 0) > 0 then
		g.core.battle.BattleShowResult:disableAll()

		local var_3_0 = self:getChallengeRank()

		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Arena_ChallengeBegin({
				rank = var_3_0
			})
		end)

		return
	else
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 0.2)
	end

	if var_0_2:isExistTaskAward() then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GetModuleOneKeyTaskAward({
				module_id = var_0_0.TaskConst.MODULE_ID.ARENA
			})
		end)

		return
	end

	self._isFinish = true
end

function DebugOneKeyArena:_onS2CGetInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._content = arg_8_4
	self._isGetInfo = true

	return "获得竞技场信息"
end

function DebugOneKeyArena:_onS2CChallengeBegin(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self._isGetInfo = false

	return "挑战成功" .. ",剩余次数" .. (self._content.challenge_count or 0) - 1
end

function DebugOneKeyArena:_onOneKeyGetTaskAward(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self:send(function()
		g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
			module_id = var_0_1.MODULE_ID.ARENA
		})
	end)

	return "领取任务奖励成功"
end

function DebugOneKeyArena:_onGetTaskInfo(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	return "刷新任务数据"
end

function DebugOneKeyArena:getChallengeRank()
	local var_13_0 = clone(self._content.arena_units)

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.user.fight_value < arg_14_1.user.fight_value
	end)

	local var_13_1 = g.core.model.User:getFightValue()
	local var_13_2 = 0

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if self._content.rank ~= iter_13_1.rank then
			if var_13_1 < iter_13_1.user.fight_value then
				break
			else
				var_13_2 = iter_13_1.rank
			end
		end
	end

	if var_13_2 == 0 then
		var_13_2 = var_13_0[2].rank
	end

	return var_13_2
end

return DebugOneKeyArena
