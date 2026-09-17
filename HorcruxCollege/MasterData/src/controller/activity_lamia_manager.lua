local var_0_0 = {}
local var_0_1 = 104
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local var_0_5 = require("controller.item_manager")
local network = require("network.network")
local task_chapter_lamia_data = require("data.task_chapter_lamia_data")
local activity_proceed_data = require("data.activity_proceed_data")
local activity_conf_data = require("data.activity_conf_data")
local levelmode_data = require("data.levelmode_data")
local city_data = require("data.city_data")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local city_area_data = require("data.city_area_data")

function var_0_0.open_activity_page(arg_1_0, arg_1_1, arg_1_2)
	network:rpc("open_activity_page", {
		id = arg_1_1
	}, function(arg_2_0)
		print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>", dump(arg_2_0))

		if arg_1_2 then
			arg_1_2(arg_2_0)
		end
	end)
end

function var_0_0.getEveryLevelExp(arg_3_0, arg_3_1)
	if not activity_proceed_data[var_0_1 .. "-" .. arg_3_1] then
		return 0
	end

	return activity_proceed_data[var_0_1 .. "-" .. arg_3_1].num1
end

function var_0_0.getLamiaChapterProgress(arg_4_0, arg_4_1)
	print("-------------------------", arg_4_1)

	if not arg_4_1 then
		return 0
	end

	local var_4_1 = 0
	local var_4_2 = 0
	local var_4_3 = {}

	for iter_4_0, iter_4_1 in pairs(city_data) do
		if iter_4_1.id == arg_4_1 then
			while iter_4_1["difficulty" .. 1] do
				for iter_4_2, iter_4_3 in pairs(levelmode_data) do
					if iter_4_3.mode == iter_4_1["difficulty" .. 1] then
						var_4_1 = var_4_1 + iter_4_3.totalchapter
						var_4_3[1] = iter_4_3.mode
					end
				end
			end
		end
	end

	if var_4_3 then
		for iter_4_4, iter_4_5 in pairs(var_4_3) do
			if playermodel.levelmode[iter_4_5] and playermodel.levelmode[iter_4_5].status then
				var_4_2 = var_4_2 + playermodel.levelmode[iter_4_5].status - 1
			end
		end
	end

	return (math.floor(var_4_2 / var_4_1 * 100))
end

function var_0_0.getLamiaTowerProgress(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return 0
	end

	local var_5_0 = {}
	local var_5_1 = 0
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in pairs(levelmode_data) do
		if iter_5_1.modetype == arg_5_1 then
			table.insert(var_5_0, iter_5_1.mode)
		end
	end

	if not next(var_5_0) then
		return 0
	end

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		var_5_1 = level_manager:getModeTotalChapter(iter_5_3) + var_5_1

		if playermodel.levelmode[iter_5_3] and playermodel.levelmode[iter_5_3].status then
			var_5_2 = var_5_2 + playermodel.levelmode[iter_5_3].status - 1
		end
	end

	return (math.floor(var_5_2 / var_5_1 * 100))
end

function var_0_0.getLamiaBtnTime(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(city_area_data) do
		if iter_6_1.id == arg_6_1 then
			while iter_6_1["startime" .. 1] do
				var_6_0[1] = iter_6_1["startime" .. 1]
			end
		end
	end

	return var_6_0[arg_6_2]
end

function var_0_0.getLamiaStoryID(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(city_area_data) do
		if iter_7_1.id == arg_7_1 then
			while iter_7_1["substory" .. 1] do
				var_7_0[1] = iter_7_1["substory" .. 1]
			end
		end
	end

	return var_7_0
end

function var_0_0.getActivityTaskData(arg_8_0)
	local var_8_0 = activity_manager:getActivityObj(var_0_1)

	if var_8_0 then
		var_8_0:getActivityTaskList(nil, function(arg_9_0, arg_9_1)
			if arg_9_0 ~= 1 then
				return
			end

			arg_8_0.taskList = {}

			for iter_9_0, iter_9_1 in pairs(arg_9_1.list) do
				arg_8_0.taskList[task_chapter_lamia_data[iter_9_1.taskid].display_type] = arg_8_0.taskList[task_chapter_lamia_data[iter_9_1.taskid].display_type] or {}
				iter_9_1.name = task_chapter_lamia_data[iter_9_1.taskid].name
				iter_9_1.task_des = task_chapter_lamia_data[iter_9_1.taskid].task_des
				iter_9_1.image = task_chapter_lamia_data[iter_9_1.taskid].image
				iter_9_1.drop = task_chapter_lamia_data[iter_9_1.taskid].drop
				iter_9_1.jump = task_chapter_lamia_data[iter_9_1.taskid].jump
				iter_9_1.order = task_chapter_lamia_data[iter_9_1.taskid].order

				if iter_9_1.status == 1 then
					iter_9_1.percent = -1
				end

				table.insert(arg_8_0.taskList[task_chapter_lamia_data[iter_9_1.taskid].display_type], iter_9_1)
			end

			local function var_9_0(arg_10_0, arg_10_1)
				if arg_10_0.percent == arg_10_1.percent then
					return arg_10_0.order < arg_10_1.order
				else
					return arg_10_0.percent > arg_10_1.percent
				end
			end

			for iter_9_2, iter_9_3 in pairs(arg_8_0.taskList) do
				if iter_9_3 and next(iter_9_3) then
					table.sort(iter_9_3, var_9_0)
				end
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE)
		end, false)
	end
end

function var_0_0:getTaskDataByType(arg_11_1)
	if not self.taskList or not next(self.taskList) then
		return {}
	end

	return self.taskList[arg_11_1]
end

function var_0_0.getBattlePassDrop(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return {}
	end

	local var_12_0 = drop_manager:getAllDrops(arg_12_1)

	if drop_manager:getGold(arg_12_1) > 0 then
		table.insert(var_12_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(arg_12_1)
		})
	end

	if drop_manager:getDiamond(arg_12_1) > 0 then
		table.insert(var_12_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(arg_12_1)
		})
	end

	return var_12_0
end

function var_0_0.getBattlePassReward(arg_13_0, arg_13_1)
	local var_13_0 = activity_manager:getActivityObj(var_0_1)

	if var_13_0 then
		var_13_0:getActivityProceedAward(arg_13_1, function(arg_14_0, arg_14_1)
			if arg_14_0 ~= 1 then
				global_ShowBlockWords(L_BATTLE_PASS.FAIL)

				return
			end

			global_gain(arg_14_1)
		end)
	end
end

function var_0_0.getTaskReward(arg_15_0, arg_15_1)
	local var_15_0 = activity_manager:getActivityObj(var_0_1)

	if var_15_0 then
		var_15_0:getTaskReward(arg_15_1, function(arg_16_0, arg_16_1)
			if arg_16_0 ~= 1 then
				global_ShowBlockWords(L_BATTLE_PASS.FAIL)

				return
			end

			global_gain(arg_16_1)
			arg_15_0:getActivityTaskData()
		end)
	end
end

function var_0_0.deleteTaskData(arg_17_0)
	arg_17_0.taskList = {}
end

function var_0_0:isHasCanCompleteTask(arg_18_1)
	if not self.taskList then
		return false
	end

	if not arg_18_1 then
		for iter_18_0, iter_18_1 in pairs(self.taskList) do
			if iter_18_1[1].status == 0 and iter_18_1[1].percent == 100 then
				return true
			end
		end

		return false
	end

	if not self.taskList[arg_18_1] then
		return false
	end

	if self.taskList[arg_18_1][1].status == 0 and self.taskList[arg_18_1][1].percent == 100 then
		return true
	end

	return false
end

function var_0_0:getTaskPercent()
	if not self.taskList then
		return false
	end

	local var_19_0 = 0
	local var_19_1 = 0

	for iter_19_0, iter_19_1 in pairs(self.taskList) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			var_19_0 = var_19_0 + 1
		end
	end

	for iter_19_4, iter_19_5 in pairs(self.taskList) do
		for iter_19_6, iter_19_7 in pairs(iter_19_5) do
			if iter_19_7.status == 0 and iter_19_7.percent == 100 or iter_19_7.status == 1 or iter_19_7.status == 2 then
				var_19_1 = var_19_1 + 1
			end
		end
	end

	return "" .. var_19_1 .. "/" .. var_19_0
end

function var_0_0.getTaskRewardByType(arg_20_0, arg_20_1)
	local var_20_0 = activity_manager:getActivityObj(var_0_1)

	if var_20_0 then
		var_20_0:getTaskReward(nil, function(arg_21_0, arg_21_1)
			if arg_21_0 ~= 1 then
				global_ShowBlockWords(L_BATTLE_PASS.FAIL)

				return
			end

			global_gain(arg_21_1)
			arg_20_0:getActivityTaskData()
		end, arg_20_1)
	end
end

function var_0_0.can_share(arg_22_0)
	if activity_conf_data[var_0_1] then
		if require("controller.time_check_manager"):getCurTime() > global_get_time_by_date(activity_conf_data[var_0_1].finishtime or "2023-02-08 00:00:00") then
			return false
		end

		if config.packagechannel == "feiyu" then
			do return FeiyuManager.canShare and FeiyuManager.canShare() end

			goto label_22_0
		end
	end

	do return true end

	::label_22_0::
end

function var_0_0:get_activity_share_data(arg_23_1)
	if not self:can_share() then
		if arg_23_1 then
			arg_23_1(2)
		end

		return
	end

	network:rpc("get_activity_share_data", {
		id = var_0_1,
		channelid = DeviceManager:getChannelID()
	}, function(arg_24_0)
		if arg_23_1 then
			arg_23_1(arg_24_0.result, arg_24_0)
		end
	end)
end

function var_0_0.activity_share_success(arg_25_0, arg_25_1)
	network:rpc("activity_share_success", {
		id = var_0_1
	}, function(arg_26_0)
		print("activity share: ", dump(arg_26_0))

		if arg_26_0.result == 1 then
			if arg_26_0.items then
				global_gain({
					items = arg_26_0.items
				})
			end

			if arg_25_1 then
				arg_25_1(1)
			end
		elseif arg_25_1 then
			arg_25_1(arg_26_0.result)
		end
	end)
end

function var_0_0.get_total_share_award(arg_27_0, arg_27_1, arg_27_2)
	network:rpc("get_activity_total_share_award", {
		id = var_0_1,
		index = arg_27_1
	}, function(arg_28_0)
		print("get total share: ", dump(arg_28_0))

		if arg_28_0.result == 1 then
			if arg_28_0.item then
				local var_28_0 = {
					items = {}
				}

				table.insert(var_28_0.items, arg_28_0.item)
				global_gain(var_28_0)
			end

			if arg_27_2 then
				arg_27_2(1)
			end
		elseif arg_27_2 then
			arg_27_2(arg_28_0.result)
		end
	end)
end

function var_0_0.get_task_endtime(arg_29_0)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(city_area_data) do
		if iter_29_1.id == 1 then
			while iter_29_1["endtime" .. 1] do
				var_29_0[1] = iter_29_1["endtime" .. 1]
			end
		end
	end

	return var_29_0
end

return var_0_0
