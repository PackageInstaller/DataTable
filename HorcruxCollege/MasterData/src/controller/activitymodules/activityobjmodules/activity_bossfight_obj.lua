local network = require("network.network")
local chapter_data = require("data.chapter_data")
local levelmode_data = require("data.levelmode_data")
local drop_manager = require("controller.drop_manager")
local level_manager = require("controller.level_manager")
local activity_manager = require("controller.activity_manager")
local adventure_score_awards_data = require("data.adventure_score_awards_data")

function ACTIVITY_OBJ_NEW:get_activity_bossfight_info()
	local var_1_0 = ACTIVITY_ID_TO_MODETYPE_FUNC.boss_fight(self._id)

	network:rpc("get_activity_bossfight_info", {
		activityid = self._id
	}, function(arg_2_0)
		self.bossfightRewardList = {}
		self.bossFightPatrolList = arg_2_0.lock_data
		self.bossfightTotalScore = arg_2_0.canexchangescore

		if arg_2_0.awardlist and next(arg_2_0.awardlist) then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.awardlist) do
				local var_2_0 = string.format("awardmodetype_%d_%d", var_1_0, iter_2_0)

				if adventure_score_awards_data[var_2_0].score <= self.bossfightTotalScore then
					self.bossfightRewardIndex = iter_2_0
				end

				table.insert(self.bossfightRewardList, {
					havereceived = iter_2_1.havereceived,
					needScore = adventure_score_awards_data[var_2_0].score,
					dropid = adventure_score_awards_data[var_2_0].dropid
				})
			end
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_BOSSFIGHT_INFO_UPDATE)
	end)
end

function ACTIVITY_OBJ_NEW:get_activity_bossfight_reward(arg_3_1, arg_3_2)
	network:rpc("get_activity_bossfight_reward", {
		activityid = self._id,
		mode = arg_3_1,
		level = arg_3_2 .. "-" .. 1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			global_gain(arg_4_0)
			self:get_activity_bossfight_info()
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_adventure_score_awards(arg_5_1)
	network:rpc("get_adventure_score_awards", {
		modetype = ACTIVITY_ID_TO_MODETYPE_FUNC.boss_fight(self._id),
		rank = arg_5_1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			global_gain(arg_6_0)
			self:get_activity_bossfight_info()
		end
	end)
end

function ACTIVITY_OBJ_NEW:getBossFightRewardIndex()
	return self.bossfightRewardIndex or 0
end

function ACTIVITY_OBJ_NEW:getBossFightRewardScore()
	return self.bossfightTotalScore
end

function ACTIVITY_OBJ_NEW:getBossFightRewardList()
	return self.bossfightRewardList
end

function ACTIVITY_OBJ_NEW:getBossFightRewardpercent(arg_10_1)
	local var_10_0 = 0
	local var_10_1 = ACTIVITY_ID_TO_MODETYPE_FUNC.boss_fight(self._id)
	local var_10_2 = adventure_score_awards_data[string.format("awardmodetype_%d_%d", var_10_1, arg_10_1 - 1)]
	local var_10_3 = adventure_score_awards_data[string.format("awardmodetype_%d_%d", var_10_1, arg_10_1)]
	local var_10_4 = adventure_score_awards_data[string.format("awardmodetype_%d_%d", var_10_1, arg_10_1 + 1)]

	if var_10_2 then
		var_10_0 = (var_10_2.score + var_10_3.score) / 2
	end

	local var_10_5 = var_10_3.score - var_10_0 + var_10_3.score

	if var_10_4 then
		var_10_5 = (var_10_4.score + var_10_3.score) / 2
	end

	if var_10_0 > self.bossfightTotalScore then
		return 0
	elseif var_10_5 < self.bossfightTotalScore then
		return 100
	else
		return (var_10_5 - var_10_0) / (self.bossfightTotalScore - var_10_0)
	end
end

function ACTIVITY_OBJ_NEW:getBossFightLevelList()
	local var_11_0 = {}
	local var_11_1 = ACTIVITY_ID_TO_MODETYPE_FUNC.boss_fight(self._id)

	for iter_11_0, iter_11_1 in pairs(levelmode_data) do
		if iter_11_1.modetype == var_11_1 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	if next(var_11_0) then
		table.sort(var_11_0, function(arg_12_0, arg_12_1)
			return arg_12_0.order < arg_12_1.order
		end)
	end

	return var_11_0
end

function ACTIVITY_OBJ_NEW:getBossFightPatrolList()
	local var_13_0 = self:getBossFightLevelList()
	local var_13_1 = {}

	for iter_13_0 = 1, #var_13_0 do
		for iter_13_1 = 1, var_13_0[iter_13_0].totalchapter do
			local var_13_2 = var_13_0[iter_13_0].totalchapter * (iter_13_0 - 1) + iter_13_1
			local var_13_3 = var_13_0[iter_13_0].name .. string.format(L_EXPEDITION_EXAMINE .. "%d", iter_13_1)

			if self.bossFightPatrolList[var_13_0[iter_13_0].totalchapter * (iter_13_0 - 1) + iter_13_1] and self.bossFightPatrolList[var_13_2].servants then
				var_13_1[var_13_2] = self.bossFightPatrolList[var_13_2]
			else
				local var_13_4 = {}

				var_13_4.dropid = level_manager.getCurLevelData(var_13_0[iter_13_0].mode, iter_13_1 .. "-1").equip_drop
				var_13_1[var_13_2] = var_13_4
			end

			var_13_1[var_13_2].mode = var_13_0[iter_13_0].mode
			var_13_1[var_13_2].curChapter = iter_13_1
			var_13_1[var_13_2].name = var_13_3
		end
	end

	return var_13_1
end

function ACTIVITY_OBJ_NEW:getBossfightLockServants()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.bossFightPatrolList) do
		if iter_14_1.servants then
			for iter_14_2, iter_14_3 in ipairs(iter_14_1.servants) do
				table.insert(var_14_0, iter_14_3)
			end
		end
	end

	return var_14_0
end

function ACTIVITY_OBJ_NEW:canStartFightBoss(arg_15_1, arg_15_2)
	if not chapter_data[arg_15_1 .. "-" .. arg_15_2].patrol_time then
		return true
	end

	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(self.bossFightPatrolList) do
		if iter_15_1.chapter == arg_15_1 .. "-" .. arg_15_2 then
			var_15_0 = iter_15_1
		end
	end

	if not var_15_0 then
		return true
	end

	return var_15_0.time == nil
end

function ACTIVITY_OBJ_NEW:getActivityBossFightFormation(arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1

	for iter_16_0, iter_16_1 in ipairs(self.bossFightPatrolList) do
		if iter_16_1.chapter == arg_16_1 .. "-" .. arg_16_2 then
			var_16_1 = iter_16_1
		end
	end

	if var_16_1 and var_16_1.servants then
		for iter_16_2, iter_16_3 in ipairs(var_16_1.servants) do
			var_16_0[iter_16_2] = {
				locked = true,
				fight_girl = iter_16_3,
				pos = iter_16_2
			}
		end
	else
		for iter_16_4 = 1, 5 do
			var_16_0[iter_16_4] = {
				pos = iter_16_4
			}
		end

		var_16_0 = require("controller.formation.formation_bossfight_manager"):getInstance():getFormationInfo()[1] or var_16_0
	end

	return var_16_0
end
