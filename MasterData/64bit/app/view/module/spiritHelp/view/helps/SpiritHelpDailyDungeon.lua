local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_2 = g.core.model.User.dailyDungeonData
local var_0_3 = g.core.config.daily_dungeon_info
local var_0_4 = g.core.config.daily_dungeon_stage_info
local var_0_5 = g.core.model.User.shopData
local SpiritHelpDailyDungeon = class("SpiritHelpDailyDungeon", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpDailyDungeon:initData()
	self._infoKeyDict = {
		6,
		7,
		8,
		9
	}
	self._cellName = "SpiritHelpCell1"
	self._isSelect = true
	self._needAddEventList = {
		[var_0_0.EVENT_NET_S2C_DAILY_DUNGEON_FAST_SPIRIT_HELP] = handler(self, self._onFastFinish)
	}
end

function SpiritHelpDailyDungeon:refreshState()
	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(self._infoKeyDict) do
		if var_0_2:checkChapterOpenState(iter_2_0) == 0 then
			for iter_2_2, iter_2_3 in var_0_4.ipairs() do
				if iter_2_3.daily_dungeon_type == iter_2_0 then
					local var_2_1 = var_0_2:checkStageOpenState(iter_2_3.id)

					if var_2_1 == 4 or var_2_1 == 3 then
						var_2_0 = true

						if var_0_5:getLeftCount(var_0_3.get(iter_2_0).dungeon_num) > 0 then
							self._state = var_0_1.STATE.NORMAL

							return
						end
					end
				end
			end
		end
	end

	if var_2_0 then
		self._state = var_0_1.STATE.FINISH
	else
		self._isTip = true
		self._tipStr = g.core.lang:get(409511)
		self._state = var_0_1.STATE.LOCK
	end
end

function SpiritHelpDailyDungeon:doing()
	local var_3_0 = self:getChallengeIdList()

	if #var_3_0 > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_DailyDungeon_Fast_Spirit_Help({
				is_helper = true,
				ids = var_3_0
			})
		end)

		return
	end

	self._isFinish = true
end

function SpiritHelpDailyDungeon:getChallengeIdList()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self._infoKeyDict) do
		if var_0_2:checkChapterOpenState(iter_5_0) == 0 and var_0_5:getLeftCount(var_0_3.get(iter_5_0).dungeon_num) > 0 then
			local var_5_1

			for iter_5_2, iter_5_3 in var_0_4.ipairs() do
				if iter_5_3.daily_dungeon_type == iter_5_0 then
					local var_5_2 = var_0_2:checkStageOpenState(iter_5_3.id)

					if var_5_2 == 4 or var_5_2 == 3 then
						var_5_1 = iter_5_3
					end
				end
			end

			if var_5_1 then
				table.insert(var_5_0, var_5_1.id)
			end
		end
	end

	return var_5_0
end

function SpiritHelpDailyDungeon:_onFastFinish(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	for iter_6_0, iter_6_1 in pairs(arg_6_4.awards or {}) do
		self:addCurDoAward(iter_6_1.awards or {})
	end

	self:setDoingState(var_0_1.DOING_STATE.SUCCESS)
end

return SpiritHelpDailyDungeon
