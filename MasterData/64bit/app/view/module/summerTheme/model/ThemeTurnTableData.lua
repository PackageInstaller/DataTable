local var_0_0 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local var_0_2 = g.core.config.activity_theme_info
local var_0_3 = g.core.config.game_turntable_group_info
local var_0_4 = g.core.config.game_turntable_reward_info
local var_0_5 = g.core.config.game_turntable_box_info
local ThemeTurnTableData = class("ThemeTurnTableData", require("app.core.model.BaseData"))

function ThemeTurnTableData:ctor()
	self:initData()
end

function ThemeTurnTableData:initData()
	self._activeStartTime = 0
	self._activeThemeType = nil
	self._activeThemeValue = nil
	self._sourceType = var_0_0.CONFIG_TABLE
	self._miniGameId = 0
	self._gameBaseInfo = nil
	self._gameRewardList = {}
	self._gameRewardWholeProb = 0
	self._gameProgressList = {}
	self._gameProgMaxNum = 0
	self._gameMaxTurnNum = 0
	self._gameCurTurnNum = 0
end

function ThemeTurnTableData:startByActivityData(arg_3_1)
	self._activeThemeType = arg_3_1:getActivityType()
	self._activeThemeValue = arg_3_1:getConfigActivityValue()
	self._sourceType = arg_3_1:getActivitySourceType()
	self._activeStartTime = arg_3_1:getStartTime()

	local var_3_0 = var_0_2.get(self._activeThemeValue)

	self._miniGameId = var_3_0.minigame_id

	if var_3_0.minigame_type == 2 and self._miniGameId > 0 and #self._gameRewardList == 0 then
		self._gameRewardList = {}
		self._gameProgressList = {}
		self._gameRewardWholeProb = 0
		self._gameMaxTurnNum = 0

		if var_0_3.fetch(self._miniGameId) then
			self._gameBaseInfo = var_0_3.get(self._miniGameId)
		end

		for iter_3_0 = 1, var_0_4.getLength() do
			local var_3_1 = var_0_4.indexOf(iter_3_0)

			if var_3_1.game_id == self._miniGameId then
				local var_3_2 = {
					cfg = var_3_1
				}

				var_3_2.turnNum = 0

				table.insert(self._gameRewardList, var_3_2)

				self._gameRewardWholeProb = self._gameRewardWholeProb + var_3_1.size
				self._gameMaxTurnNum = self._gameMaxTurnNum + ((var_3_1.times > 0 or nil) and (var_3_1.times or 9999999))
			end
		end

		table.sort(self._gameRewardList, function(arg_4_0, arg_4_1)
			return arg_4_0.cfg.num < arg_4_1.cfg.num
		end)

		for iter_3_1 = 1, var_0_5.getLength() do
			local var_3_3 = var_0_5.indexOf(iter_3_1)

			if var_3_3.minigame_id == self._miniGameId then
				local var_3_4 = {
					cfg = var_3_3
				}

				var_3_4.isGet = false

				table.insert(self._gameProgressList, var_3_4)

				self._gameProgMaxNum = math.max(self._gameProgMaxNum, var_3_3.times)
			end
		end

		table.sort(self._gameProgressList, function(arg_5_0, arg_5_1)
			return arg_5_0.cfg.times < arg_5_1.cfg.times
		end)
	end
end

function ThemeTurnTableData:getBaseInfo()
	return self._gameBaseInfo
end

function ThemeTurnTableData:getCurTurnNum()
	return self._gameCurTurnNum
end

function ThemeTurnTableData:getMaxTurnNum()
	return self._gameMaxTurnNum
end

function ThemeTurnTableData:getRewardList()
	return self._gameRewardList
end

function ThemeTurnTableData:getRewardWholeProb()
	return self._gameRewardWholeProb
end

function ThemeTurnTableData:getProgressList()
	return self._gameProgressList
end

function ThemeTurnTableData:getProgMaxNum()
	return self._gameProgMaxNum
end

function ThemeTurnTableData:isTurnTableClose(arg_13_1)
	local var_13_0 = g.core.model.User.themeData:getActivityData(self._activeThemeValue)

	if not var_13_0 or var_13_0:getActivityState() == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.EXPIRE then
		if not arg_13_1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		end

		return true
	end

	return false
end

function ThemeTurnTableData:isProgAwardCanGet(arg_14_1)
	if not self._gameProgressList[arg_14_1] then
		return false
	end

	if not self._gameProgressList[arg_14_1].isGet and self._gameCurTurnNum >= self._gameProgressList[arg_14_1].cfg.times then
		return true
	end

	return false
end

function ThemeTurnTableData:isHaveProgAwardCanGet()
	if not self._gameBaseInfo then
		return false
	end

	if self:isTurnTableClose(true) then
		return false
	end

	for iter_15_0 = 1, #self._gameProgressList do
		if self:isProgAwardCanGet(iter_15_0) then
			return true
		end
	end

	return false
end

function ThemeTurnTableData:isHaveFiveTurnRes()
	if not self._gameBaseInfo then
		return false
	end

	if self:isTurnTableClose(true) then
		return false
	end

	if not self:isHaveNTurnTimes(5) then
		return false
	end

	return g.core.utils.Tools.isCountEnoughByTVS({
		type = self._gameBaseInfo.use_type_five,
		value = self._gameBaseInfo.use_value_five,
		size = self._gameBaseInfo.use_size_five
	}, true)
end

function ThemeTurnTableData:isHaveNTurnTimes(arg_17_1)
	arg_17_1 = arg_17_1 or 1

	return arg_17_1 <= self._gameMaxTurnNum - self._gameCurTurnNum
end

function ThemeTurnTableData:updateRewardList(arg_18_1)
	if type(arg_18_1) ~= "table" then
		return
	end

	for iter_18_0 = 1, #arg_18_1 do
		for iter_18_1 = 1, #self._gameRewardList do
			if self._gameRewardList[iter_18_1].cfg.id == arg_18_1[iter_18_0].id then
				self._gameRewardList[iter_18_1].turnNum = arg_18_1[iter_18_0].num

				break
			end
		end
	end
end

function ThemeTurnTableData:updateProgressList(arg_19_1)
	if type(arg_19_1) ~= "table" then
		return
	end

	for iter_19_0 = 1, #arg_19_1 do
		for iter_19_1 = 1, #self._gameProgressList do
			if self._gameProgressList[iter_19_1].cfg.id == arg_19_1[iter_19_0] then
				self._gameProgressList[iter_19_1].isGet = true

				break
			end
		end
	end
end

function ThemeTurnTableData:onS2CTurnTableGetInfo(arg_20_1)
	self._gameCurTurnNum = arg_20_1.play_times or 0

	self:updateRewardList(arg_20_1.hit_count)
	self:updateProgressList(arg_20_1.awarded_ids)
end

function ThemeTurnTableData:onS2CTurnTableOnce(arg_21_1)
	self._gameCurTurnNum = arg_21_1.play_times or 0

	self:updateRewardList(arg_21_1.hit_count)
end

function ThemeTurnTableData:onS2CTurnTableFive(arg_22_1)
	self._gameCurTurnNum = arg_22_1.play_times or 0

	self:updateRewardList(arg_22_1.hit_count)
end

function ThemeTurnTableData:onS2CTurnTableReward(arg_23_1)
	self:updateProgressList(arg_23_1.awarded_ids)
end

function ThemeTurnTableData:refreshRedPointData(arg_24_1)
	self._gameCurTurnNum = arg_24_1.play_times or self._gameCurTurnNum

	self:updateProgressList(arg_24_1.awarded_ids)
end

return ThemeTurnTableData
