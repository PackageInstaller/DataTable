local var_0_0 = {}
local var_0_1 = 100
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local var_0_5 = require("controller.item_manager")
local network = require("network.network")
local activity_proceed_data = require("data.activity_proceed_data")
local task_spring_festival_data = require("data.task_spring_festival_data")
local var_0_10 = 2

var_0_0.subsystemtime = {}

function var_0_0.get_subsystem_time(arg_1_0, arg_1_1)
	network:rpc("get_springfestival_time_conf", {
		activityid = var_0_1
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			arg_1_0.subsystemtime = arg_2_0.confs

			if arg_1_1 then
				arg_1_1(arg_2_0.confs)
			end
		else
			global_ShowBlockWords("活动不存在！")
		end
	end)
end

function var_0_0.get_nianshou_info(arg_3_0, arg_3_1)
	network:rpc("get_nianshou_info", {
		activityid = var_0_1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_4_0.items then
				for iter_4_0, iter_4_1 in pairs(arg_4_0.items) do
					var_0_5:setItemByServerItem(iter_4_1)
				end
			end
		else
			global_ShowBlockWords(ACTIVITY_NIANSHOU_WARN)
		end

		if arg_3_1 then
			arg_3_1(arg_4_0)
		end
	end)
end

function var_0_0.get_nianshou_award(arg_5_0, arg_5_1)
	network:rpc("get_nianshou_award", {
		activityid = var_0_1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			global_gain(arg_6_0)
			AnalyticManager.springFestivalNianShou()
		else
			global_ShowBlockWords(NIANSHOU_REWARD_WARN[arg_6_0.result])
		end

		if arg_5_1 then
			arg_5_1(arg_6_0.result)
		end
	end)
end

function var_0_0.get_nianshou_player_rank(arg_7_0, arg_7_1)
	network:rpc("get_nianshou_player_rank", {
		activityid = var_0_1
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			if arg_7_1 then
				arg_7_1(arg_8_0)
			end
		else
			global_ShowBlockWords(ACTIVITY_NIANSHOU_WARN)
		end
	end)
end

function var_0_0.get_nianshou_rank_data(arg_9_0, arg_9_1)
	network:rpc("get_nianshou_rank_data", {
		start = 0,
		stop = 99,
		activityid = var_0_1
	}, function(arg_10_0)
		if arg_10_0.result == 1 then
			if arg_9_1 then
				arg_9_1(arg_10_0.data)
			end
		else
			global_ShowBlockWords(ACTIVITY_NIANSHOU_WARN)
		end
	end)
end

function var_0_0:can_share()
	local var_11_0

	for iter_11_0, iter_11_1 in pairs(self.subsystemtime) do
		if iter_11_1.id == 8 then
			var_11_0 = iter_11_1

			break
		end
	end

	local var_11_1 = require("controller.time_check_manager"):getCurTime()

	if var_11_1 < global_get_time_by_date(var_11_0.starttime) or var_11_1 > global_get_time_by_date(var_11_0.finishtime) then
		return false
	end

	if config.packagechannel == "feiyu" then
		return FeiyuManager.canShare and FeiyuManager.canShare()
	else
		return true
	end
end

function var_0_0:get_activity_share_data(arg_12_1)
	if not self:can_share() then
		if arg_12_1 then
			arg_12_1(2)
		end

		return
	end

	network:rpc("get_activity_share_data", {
		id = var_0_1,
		channelid = DeviceManager:getChannelID()
	}, function(arg_13_0)
		if arg_12_1 then
			arg_12_1(arg_13_0.result, arg_13_0)
		end
	end)
end

function var_0_0.activity_share_success(arg_14_0, arg_14_1)
	network:rpc("activity_share_success", {
		id = var_0_1
	}, function(arg_15_0)
		print("activity share: ", dump(arg_15_0))

		if arg_15_0.result == 1 then
			if arg_15_0.items then
				global_gain({
					items = arg_15_0.items
				})
			end

			if arg_14_1 then
				arg_14_1(1)
			end
		elseif arg_14_1 then
			arg_14_1(arg_15_0.result)
		end
	end)
end

function var_0_0.get_total_share_award(arg_16_0, arg_16_1, arg_16_2)
	network:rpc("get_total_share_award", {
		id = var_0_1,
		index = arg_16_1
	}, function(arg_17_0)
		print("get total share: ", dump(arg_17_0))

		if arg_17_0.result == 1 then
			if arg_17_0.item then
				local var_17_0 = {
					items = {}
				}

				table.insert(var_17_0.items, arg_17_0.item)
				global_gain(var_17_0)
			end

			if arg_16_2 then
				arg_16_2(1)
			end
		elseif arg_16_2 then
			arg_16_2(arg_17_0.result)
		end
	end)
end

function var_0_0:getSystemTime()
	return self.subsystemtime
end

function var_0_0.getSpringBattlePassLevelData(arg_19_0)
	local var_19_0 = activity_manager:getActivityObj(var_0_1)

	if var_19_0 then
		var_19_0:getActivityProceed(function(arg_20_0, arg_20_1)
			if arg_20_0 ~= 1 then
				return
			end

			local var_20_0 = {}

			for iter_20_0, iter_20_1 in pairs(arg_20_1) do
				local var_20_1 = arg_19_0:switchBattlePassLevelStat(iter_20_1)

				var_20_0[iter_20_1.id] = {}
				var_20_0[iter_20_1.id].stat = iter_20_1.status
				var_20_0[iter_20_1.id].level = iter_20_1.id
				var_20_0[iter_20_1.id].drop = activity_proceed_data[var_0_1 .. "-" .. iter_20_1.id].drop
				var_20_0[iter_20_1.id].specialDrop = activity_proceed_data[var_0_1 .. "-" .. iter_20_1.id].specialDropdrop
			end

			arg_19_0.battlePassStat = var_20_0

			activity_manager:fireEvent(activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, {
				list = var_20_0,
				listLen = #var_20_0
			})
		end)
	end
end

function var_0_0:isHasCanGetLevel()
	if not self.battlePassStat then
		return false
	end

	for iter_21_0, iter_21_1 in pairs(self.battlePassStat) do
		if iter_21_1.stat == var_0_10 then
			return true
		end
	end

	return false
end

function var_0_0:switchBattlePassLevelStat(arg_22_1)
	if arg_22_1.status == 1 then
		return 1
	else
		if self:isBattlePassLevelFinished(arg_22_1.id) then
			return 2
		end

		return 3
	end
end

function var_0_0.isBattlePassLevelFinished(arg_23_0, arg_23_1)
	return var_0_5:isHaveEnoughItem(activity_proceed_data[var_0_1 .. "-" .. arg_23_1].item1, activity_proceed_data[var_0_1 .. "-" .. arg_23_1].num1)
end

function var_0_0:getCurBattlePassLevel()
	if not self.battlePassStat then
		return
	end

	for iter_24_0 = 1, #self.battlePassStat do
		if self.battlePassStat[iter_24_0].stat == 3 then
			return self.battlePassStat[iter_24_0].level
		end
	end

	return #self.battlePassStat + 1
end

function var_0_0:getBattlePassExp(arg_25_1)
	local var_25_0 = var_0_1 .. "-" .. (arg_25_1 or self:getCurBattlePassLevel())

	if not activity_proceed_data[var_25_0] then
		return 0
	end

	return var_0_5:getItemNumber(activity_proceed_data[var_25_0].item1)
end

function var_0_0:getCurLevelProceed(arg_26_1)
	local var_26_0 = arg_26_1 or self:getCurBattlePassLevel()
	local var_26_1 = var_0_1 .. "-" .. var_26_0

	if not activity_proceed_data[var_0_1 .. "-" .. var_26_0] then
		var_26_0 = var_26_0 - 1
		var_26_1 = var_0_1 .. "-" .. var_26_0
	end

	local var_26_2 = activity_proceed_data[var_26_1].num1
	local var_26_3 = activity_proceed_data[var_0_1 .. "-" .. var_26_0 - 1] or {
		num1 = 0
	}
	local var_26_4 = var_0_5:getItemNumber(activity_proceed_data[var_26_1].item1)

	print(var_26_4, var_26_2, arg_26_1)

	return (var_26_4 - var_26_3.num1) / (var_26_2 - var_26_3.num1) * 100, var_26_4 - var_26_3.num1 .. "/" .. var_26_2 - var_26_3.num1
end

function var_0_0.getActivityTaskData(arg_27_0)
	local var_27_0 = activity_manager:getActivityObj(var_0_1)

	if var_27_0 then
		var_27_0:getActivityTaskList(1, function(arg_28_0, arg_28_1)
			if arg_28_0 ~= 1 then
				return
			end

			arg_27_0.taskList = {}

			for iter_28_0, iter_28_1 in pairs(arg_28_1.list) do
				arg_27_0.taskList[task_spring_festival_data[iter_28_1.taskid].display_type] = arg_27_0.taskList[task_spring_festival_data[iter_28_1.taskid].display_type] or {}
				iter_28_1.name = task_spring_festival_data[iter_28_1.taskid].name
				iter_28_1.task_des = task_spring_festival_data[iter_28_1.taskid].task_des
				iter_28_1.image = task_spring_festival_data[iter_28_1.taskid].image
				iter_28_1.drop = task_spring_festival_data[iter_28_1.taskid].drop
				iter_28_1.jump = task_spring_festival_data[iter_28_1.taskid].jump
				iter_28_1.order = task_spring_festival_data[iter_28_1.taskid].order

				if iter_28_1.status == 1 then
					iter_28_1.percent = -1
				end

				table.insert(arg_27_0.taskList[task_spring_festival_data[iter_28_1.taskid].display_type], iter_28_1)
			end

			local function var_28_0(arg_29_0, arg_29_1)
				if arg_29_0.percent == arg_29_1.percent then
					return arg_29_0.order < arg_29_1.order
				else
					return arg_29_0.percent > arg_29_1.percent
				end
			end

			for iter_28_2, iter_28_3 in pairs(arg_27_0.taskList) do
				if iter_28_3 and next(iter_28_3) then
					table.sort(iter_28_3, var_28_0)
				end
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE)
		end, false)
	end
end

function var_0_0:getTaskDataByType(arg_30_1)
	if not self.taskList or not next(self.taskList) then
		return {}
	end

	return self.taskList[arg_30_1]
end

function var_0_0.getBattlePassDrop(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return {}
	end

	local var_31_0 = drop_manager:getAllDrops(arg_31_1)

	if drop_manager:getGold(arg_31_1) > 0 then
		table.insert(var_31_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(arg_31_1)
		})
	end

	if drop_manager:getDiamond(arg_31_1) > 0 then
		table.insert(var_31_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(arg_31_1)
		})
	end

	return var_31_0
end

function var_0_0.getBattlePassReward(arg_32_0, arg_32_1)
	local var_32_0 = activity_manager:getActivityObj(var_0_1)

	if var_32_0 then
		var_32_0:getActivityProceedAward(arg_32_1, function(arg_33_0, arg_33_1)
			if arg_33_0 ~= 1 then
				global_ShowBlockWords(L_BATTLE_PASS.FAIL)

				return
			end

			global_gain(arg_33_1)
			arg_32_0:getSpringBattlePassLevelData()
		end)
	end
end

function var_0_0.getTaskReward(arg_34_0, arg_34_1)
	local var_34_0 = activity_manager:getActivityObj(var_0_1)

	if var_34_0 then
		var_34_0:getTaskReward(arg_34_1, function(arg_35_0, arg_35_1)
			if arg_35_0 ~= 1 then
				global_ShowBlockWords(L_BATTLE_PASS.FAIL)

				return
			end

			global_gain(arg_35_1)
			arg_34_0:getActivityTaskData()
			arg_34_0:getSpringBattlePassLevelData()
		end)
	end
end

function var_0_0.deleteTaskData(arg_36_0)
	arg_36_0.taskList = {}
end

function var_0_0:isHasCanCompleteTask(arg_37_1)
	if not self.taskList then
		return false
	end

	if not arg_37_1 then
		for iter_37_0, iter_37_1 in pairs(self.taskList) do
			if iter_37_1[1].status == 0 and iter_37_1[1].percent == 100 then
				return true
			end
		end

		return false
	end

	if not self.taskList[arg_37_1] then
		return false
	end

	if self.taskList[arg_37_1][1].status == 0 and self.taskList[arg_37_1][1].percent == 100 then
		return true
	end

	return false
end

function var_0_0.getTaskRewardByType(arg_38_0, arg_38_1)
	local var_38_0 = activity_manager:getActivityObj(var_0_1)

	if var_38_0 then
		var_38_0:getTaskReward(nil, function(arg_39_0, arg_39_1)
			if arg_39_0 ~= 1 then
				global_ShowBlockWords(L_BATTLE_PASS.FAIL)

				return
			end

			global_gain(arg_39_1)
			arg_38_0:getActivityTaskData()
			arg_38_0:getSpringBattlePassLevelData()
		end, arg_38_1)
	end
end

return var_0_0
