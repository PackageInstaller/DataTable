local var_0_0 = {}
local activity_manager = require("controller.activity_manager")
local shop_manager = require("controller.shop_manager")
local item_manager = require("controller.item_manager")
local task_manager = require("controller.task_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_6 = 11
local var_0_7 = activity_manager:getActivityObj(11)
local task_data = require("data.task_data")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local activity_compound_data = require("data.activity_compound_data")
local activity_compound_index_data = require("data.activity_compound_index_data")
local var_0_13 = "ABE"
local network = require("network.network")

function var_0_0.compound_activity_items(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	network:rpc("compound_activity_items", {
		id = var_0_6,
		item_1 = arg_1_1,
		item_2 = arg_1_2,
		item_3 = arg_1_3,
		num = arg_1_4
	}, function(arg_2_0)
		if arg_1_5 then
			arg_1_5(arg_2_0.result, arg_2_0)
		end
	end)
end

function var_0_0.get_compound_record(arg_3_0, arg_3_1)
	network:rpc("get_compound_record", {
		id = var_0_6
	}, function(arg_4_0)
		if arg_3_1 then
			arg_3_1(arg_4_0.result, arg_4_0)
		end
	end)
end

function var_0_0.get_compound_illustrated(arg_5_0, arg_5_1)
	network:rpc("get_compound_illustrated", {
		id = var_0_6
	}, function(arg_6_0)
		if arg_5_1 then
			arg_5_1(arg_6_0.result, arg_6_0)
		end
	end)
end

function var_0_0.get_compound_total_num(arg_7_0, arg_7_1)
	network:rpc("get_compound_total_num", {
		id = var_0_6
	}, function(arg_8_0)
		if arg_7_1 then
			arg_7_1(arg_8_0.result, arg_8_0)
		end
	end)
end

function var_0_0.get_ninifa_info(arg_9_0, arg_9_1)
	network:rpc("get_swim_level_config", {
		id = var_0_6
	}, function(arg_10_0)
		if arg_9_1 then
			arg_9_1(arg_10_0)
		end
	end)
end

function var_0_0.buy_explore_times(arg_11_0, arg_11_1)
	network:rpc("activity_buy_explore_times", {
		id = var_0_6
	}, function(arg_12_0)
		if arg_11_1 then
			arg_11_1(arg_12_0)
		end
	end)
end

function var_0_0.getActivityEndTime(arg_13_0)
	if not activity_manager.entranceList[var_0_7:getEntranceId()] then
		return
	end

	return global_get_time_by_date(activity_manager.entranceList[var_0_7:getEntranceId()].finishtime) - time_check_manager:getCurTime()
end

local var_0_15 = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384,
	32768,
	65536,
	131072,
	262144,
	524288,
	1048576,
	2097152,
	4194304,
	8388608,
	16777216,
	33554432,
	67108864,
	134217728,
	268435456,
	536870912,
	1073741824,
	2147483648
}

function var_0_0:isCompoundUnLock(arg_14_1)
	local var_14_0 = math.ceil(activity_compound_data[arg_14_1].index / 32)
	local var_14_1 = (activity_compound_data[arg_14_1].index - 1) % 32 + 1

	if not self.illustratedList[var_14_0] then
		return true
	end

	return bit.band(self.illustratedList[var_14_0], var_0_15[var_14_1]) == 0
end

function var_0_0.getMaterialsByQuality(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(activity_compound_index_data) do
		if item_data[iter_15_1.item_Id].equip_quality == arg_15_1 and item_manager:haveItem(iter_15_1.item_Id) then
			var_15_0[iter_15_1.item_Id] = {
				have_count = item_manager:getItemNumber(iter_15_1.item_Id)
			}
		end
	end

	return var_15_0
end

function var_0_0:startCompound(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self:compound_activity_items(arg_16_1, arg_16_2, arg_16_3, arg_16_4, function(arg_17_0, arg_17_1)
		if arg_17_0 ~= 1 then
			return
		end

		if arg_17_1.stat == 2 then
			global_ShowBlockWords(L_ACTIVITY_NINIFA.ITEM_NOT_ENOUGH)

			return
		elseif arg_17_1.stat == 3 then
			global_ShowBlockWords(L_ACTIVITY_NINIFA.OTHER_ERROR)

			return
		end

		item_manager:deleteItem(arg_16_1, arg_16_4)
		item_manager:deleteItem(arg_16_2, arg_16_4)
		item_manager:deleteItem(arg_16_3, arg_16_4)
		global_gain({
			items = {
				arg_17_1.item
			}
		})
		activity_manager:fireEvent(activity_manager.activityEventId.ITEM_COMPOUND_SUCCESSED)
	end)
end

function var_0_0.checkCanCoumpound(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if not arg_18_1 or not arg_18_2 or not arg_18_3 then
		global_ShowBlockWords(L_ACTIVITY_NINIFA.MATERIALS_NOT_ENOUGH)

		return false
	end

	if not arg_18_4 or arg_18_4 < 0 then
		global_ShowBlockWords(L_ACTIVITY_NINIFA.PARA_ERROR)

		return false
	end

	if not item_manager:isHaveEnoughItem(arg_18_1, arg_18_4) or not item_manager:isHaveEnoughItem(arg_18_2, arg_18_4) or not item_manager:isHaveEnoughItem(arg_18_3, arg_18_4) then
		global_ShowBlockWords(L_ACTIVITY_NINIFA.ITEM_NOT_ENOUGH)

		return false
	end

	if item_data[arg_18_1].equip_quality ~= item_data[arg_18_2].equip_quality or item_data[arg_18_1].equip_quality ~= item_data[arg_18_3].equip_quality or item_data[arg_18_3].equip_quality ~= item_data[arg_18_2].equip_quality then
		global_ShowBlockWords(L_ACTIVITY_NINIFA.DIF_QUALITY)

		return false
	end

	return true
end

function var_0_0:getCompoundIllustratedFromSever()
	self:get_compound_illustrated(function(arg_20_0, arg_20_1)
		if arg_20_0 ~= 1 then
			return
		end

		self.illustratedList = arg_20_1.illustrate

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_ILLUSTRATE_UPDATE)
	end)
end

function var_0_0:getCompoundRecordFromSever()
	self:get_compound_record(function(arg_22_0, arg_22_1)
		if arg_22_0 ~= 1 then
			return
		end

		self.compoundRecord = arg_22_1.record

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_RECORD_UPDATE)
	end)
end

function var_0_0:getIllustrateData()
	local var_23_0 = {}
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in pairs(activity_compound_data) do
		if iter_23_0 ~= var_0_13 then
			var_23_1 = var_23_1 + 1
			var_23_0[var_23_1] = iter_23_1
			var_23_0[var_23_1].isUnLock = self:isCompoundUnLock(iter_23_0)
		end
	end

	return var_23_0, var_23_1
end

function var_0_0:getRecordData()
	local var_24_0 = {}
	local var_24_1 = 0

	for iter_24_0, iter_24_1 in pairs(self.compoundRecord) do
		var_24_1 = var_24_1 + 1
		var_24_0[var_24_1] = not activity_compound_data[iter_24_1] and {
			result_item = 2040015,
			id = var_0_13,
			need_item1 = activity_compound_index_data[string.sub(iter_24_1, 1, 1)].item_Id,
			need_item2 = activity_compound_index_data[string.sub(iter_24_1, 2, 2)].item_Id,
			need_item3 = activity_compound_index_data[string.sub(iter_24_1, 3, 3)].item_Id
		} or activity_compound_data[iter_24_1]
	end

	return var_24_0, var_24_1
end

function var_0_0:getCompoundTotalNumFormServer()
	self:get_compound_total_num(function(arg_26_0, arg_26_1)
		if arg_26_0 ~= 1 then
			return
		end

		activity_manager:fireEvent(activity_manager.activityEventId.TOTAL_COMPOUND_NUM_UPDATE, {
			data = arg_26_1.totalNums
		})
	end)
end

function var_0_0.getActivityTaskFormServer(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or 1

	var_0_7:getActivityTaskList(arg_27_1, function(arg_28_0, arg_28_1)
		if arg_28_0 ~= 1 then
			return
		end

		if not arg_28_1.list or not next(arg_28_1.list) then
			return
		end

		if arg_28_1.gold > 0 or arg_28_1.diamond > 0 or next(arg_28_1.items) then
			global_gain(arg_28_1)
		end

		local var_28_0 = {}

		for iter_28_0, iter_28_1 in pairs(arg_28_1.list) do
			task_data[iter_28_1.taskid].status = iter_28_1.status
			task_data[iter_28_1.taskid].taskid = iter_28_1.taskid
			task_data[iter_28_1.taskid].percent = iter_28_1.percent
			task_data[iter_28_1.taskid].finished = task_data[iter_28_1.taskid].finished

			if iter_28_1.status == 0 and arg_27_0:canTaskShow(arg_28_1.list, task_data[iter_28_1.taskid].pre, task_data[iter_28_1.taskid].continue_task) then
				table.insert(var_28_0, task_data[iter_28_1.taskid])
			end
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			data = var_28_0
		})
	end)
end

function var_0_0.canTaskShow(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if not arg_29_1 then
		return false
	end

	if not arg_29_2 then
		for iter_29_0, iter_29_1 in pairs(arg_29_1) do
			if iter_29_1.taskid == tonumber(arg_29_3) then
				return iter_29_1.status == 0
			end
		end
	end

	for iter_29_2, iter_29_3 in pairs(arg_29_1) do
		if iter_29_3.taskid == tonumber(arg_29_2) then
			return iter_29_3.status ~= 0
		end
	end

	return true
end

function var_0_0.getTaskReward(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return
	end

	var_0_7:getTaskReward(arg_30_1, function(arg_31_0, arg_31_1)
		if arg_31_0 == 1 then
			global_gain(arg_31_1)
			arg_30_0:getActivityTaskFormServer()
		else
			global_ShowBlockWords("OTHER_ERROR")
		end
	end)
end

function var_0_0:getNinifaExploreInfo()
	self:get_ninifa_info(function(arg_33_0)
		if arg_33_0.result ~= 1 then
			return
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_EXPLORE_DATA_UPDATE, {
			data = arg_33_0
		})
	end)
end

function var_0_0:buyExploreTimes()
	self:buy_explore_times(function(arg_35_0, arg_35_1)
		if arg_35_0 == 2 then
			global_ShowBlockWords("活动过期")

			return
		elseif arg_35_0 == 3 then
			global_ShowBlockWords(L_ACTIVITY_NINIFA.BUY_TOMANY_TIME)

			return
		elseif arg_35_0 == 4 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})

			return
		end

		playermodel.diamond = playermodel.diamond - arg_35_1.cost_diamond

		global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
	end)
end

return var_0_0
