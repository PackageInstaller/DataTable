local var_0_0 = {}
local battle_pass_level_data = require("data.battle_pass_level_data")
local network = require("network.network")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local var_0_7 = 2

function var_0_0.get_battle_pass_list(arg_1_0, arg_1_1)
	network:rpc("get_battle_pass_list", {}, function(arg_2_0)
		if arg_1_1 then
			arg_1_1(arg_2_0.result, arg_2_0.list)
		end
	end)
end

function var_0_0.get_battle_pass_reward(arg_3_0, arg_3_1, arg_3_2)
	network:rpc("get_battle_pass_reward", {
		level = arg_3_1
	}, function(arg_4_0)
		if arg_3_2 then
			arg_3_2(arg_4_0.result, arg_4_0)
		end
	end)
end

function var_0_0.getCurBattlePassLevel(arg_5_0)
	local var_5_0 = 1
	local var_5_1 = 1

	while 0 < var_5_0 and battle_pass_level_data[var_5_1] do
		needItem = battle_pass_level_data[var_5_1].need_item
		var_5_0 = item_manager:getItemNumber(needItem)

		if var_5_0 < battle_pass_level_data[var_5_1].need_num then
			return var_5_1
		end

		var_5_1 = var_5_1 + 1
	end

	return var_5_1
end

function var_0_0:getBattlePassExp(arg_6_1)
	local var_6_0 = arg_6_1 or self:getCurBattlePassLevel()

	if not battle_pass_level_data[var_6_0] then
		return 0
	end

	return item_manager:getItemNumber(battle_pass_level_data[var_6_0].need_item)
end

function var_0_0.queryBattlePassTaskData(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 then
		return battle_pass_level_data[arg_7_1]
	end

	return battle_pass_level_data[arg_7_1][arg_7_2]
end

function var_0_0.getBattlePassMaxLevel(arg_8_0)
	local var_8_0 = 1

	while battle_pass_level_data[var_8_0] do
		var_8_0 = var_8_0 + 1
	end

	return var_8_0
end

function var_0_0:getCurLevelProceed(arg_9_1)
	local var_9_0 = arg_9_1 or self:getCurBattlePassLevel()

	if not battle_pass_level_data[var_9_0] then
		var_9_0 = var_9_0 - 1
	end

	local var_9_1 = battle_pass_level_data[var_9_0].need_num
	local var_9_2 = battle_pass_level_data[var_9_0 - 1] or {
		need_num = 0
	}
	local var_9_3 = item_manager:getItemNumber(battle_pass_level_data[var_9_0].need_item)

	return (var_9_3 - var_9_2.need_num) / (var_9_1 - var_9_2.need_num) * 100, var_9_3 - var_9_2.need_num .. "/" .. var_9_1 - var_9_2.need_num
end

function var_0_0:getBattlePassListFromSever()
	self:get_battle_pass_list(function(arg_11_0, arg_11_1)
		if arg_11_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.GET_LIST_FAILED)

			return
		end

		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			var_11_0[iter_11_0] = battle_pass_level_data[iter_11_0]
			var_11_0[iter_11_0].stat = iter_11_1.stat
		end

		self.battlePassStat = var_11_0

		activity_manager:fireEvent(activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, {
			list = var_11_0,
			listLen = #var_11_0
		})
	end)
end

function var_0_0:getBattlePassReward(arg_12_1)
	self:get_battle_pass_reward(arg_12_1, function(arg_13_0, arg_13_1)
		if arg_13_0 == 2 then
			global_ShowBlockWords(L_BATTLE_PASS.GET_REWARD_FAILED)

			return
		elseif arg_13_0 == 3 then
			global_ShowBlockWords(L_BATTLE_PASS.NOT_HAVE_LEVEL)

			return
		elseif arg_13_0 == 4 then
			global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

			return
		end

		global_gain(arg_13_1)
		self:getBattlePassListFromSever()
		AnalyticManager.battlepassAward({
			level = arg_12_1
		})
	end)
end

function var_0_0.getBattlePassDrop(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return {}
	end

	local var_14_0 = drop_manager:getAllDrops(arg_14_1)

	if drop_manager:getGold(arg_14_1) > 0 then
		table.insert(var_14_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(arg_14_1)
		})
	end

	if drop_manager:getDiamond(arg_14_1) > 0 then
		table.insert(var_14_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(arg_14_1)
		})
	end

	return var_14_0
end

function var_0_0:isHasRewardCanGet()
	for iter_15_0, iter_15_1 in pairs(self.battlePassStat) do
		if iter_15_1.stat == var_0_7 then
			return true
		end
	end

	return false
end

return var_0_0
