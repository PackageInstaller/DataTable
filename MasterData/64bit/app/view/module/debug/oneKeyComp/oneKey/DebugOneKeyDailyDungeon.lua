local var_0_0 = g.core.model.User.shopData
local var_0_1 = g.core.model.User.dailyDungeonData
local var_0_2 = g.core.config.daily_dungeon_info
local var_0_3 = g.core.config.daily_dungeon_stage_info
local DebugOneKeyDailyDungeon = class("DebugOneKeyDailyDungeon", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyDailyDungeon:ctor()
	self.super.ctor(self)

	self._infoKeyDict = {
		6,
		7,
		8,
		9
	}
end

function DebugOneKeyDailyDungeon:initData()
	self._oneKeyName = "一键日常副本"
	self._needAddEventList = {
		[g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEBEGIN] = handler(self, self._onS2CChallengeBegin),
		[g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEFINISH] = handler(self, self._onS2CChallengeFinish)
	}
end

function DebugOneKeyDailyDungeon:doOneKey()
	if self:hasSending() then
		return
	end

	local var_3_0 = self:getChallengeId()

	if var_3_0 > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_DailyDungeon_ChallengeBegin({
				id = var_3_0
			})
		end)

		return
	else
		self._isFinish = true

		return "挑战次数不足"
	end
end

function DebugOneKeyDailyDungeon:_onS2CChallengeBegin(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:send(function()
		g.core.battle.BattleProxy:fastBattle(arg_5_4.battle_id)
	end)

	return "挑战开始"
end

function DebugOneKeyDailyDungeon:_onS2CChallengeFinish(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return var_0_3.get(arg_7_4.id).name .. " 挑战结束"
end

function DebugOneKeyDailyDungeon:getChallengeId()
	for iter_8_0, iter_8_1 in ipairs(self._infoKeyDict) do
		if var_0_1:checkChapterOpenState(iter_8_0) == 0 and var_0_0:getLeftCount(var_0_2.get(iter_8_0).dungeon_num) > 0 then
			local var_8_0

			for iter_8_2, iter_8_3 in var_0_3.ipairs() do
				if iter_8_3.daily_dungeon_type == iter_8_0 and var_0_1:checkStageOpenState(iter_8_3.id) >= 3 then
					var_8_0 = iter_8_3
				end
			end

			if var_8_0 then
				return var_8_0.id
			end
		end
	end

	return 0
end

return DebugOneKeyDailyDungeon
