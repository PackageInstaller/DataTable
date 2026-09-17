local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local playermodel = require("model.playermodel")
local alert_manager = require("controller.alert_manager")
local task_data = require("data.task_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_proceed_data = require("data.activity_proceed_data")
local activity_vipbuy_data = require("data.activity_vipbuy_data")
local activity_bp_conf = require("data.activity_modules.activity_bp_conf")
local activity_warorder_time_conf = require("data.activity_218.activity_warorder_time_conf")
local var_0_12 = 0
local var_0_13 = 1
local var_0_14 = 2

function ACTIVITY_OBJ_NEW:init_activity_warorder_info(arg_1_1)
	if self._id ~= ACTIVITY_WARORDER_ID then
		return
	end

	self.freecostId = activity_bp_conf[self._id] and activity_bp_conf[self._id].freecost

	self:initWarOrderMaxLevel()
	self:getWarOrderLevelInfoByServer(function()
		if type(arg_1_1) == "function" then
			arg_1_1()
		end
	end)
end

function ACTIVITY_OBJ_NEW:initWarOrderMaxLevel()
	self._maxLevel = 1

	while activity_proceed_data[self._id .. "warorder-" .. self._maxLevel] do
		self._maxLevel = self._maxLevel + 1
	end
end

function ACTIVITY_OBJ_NEW:getWarOrderMaxLevel()
	return self._maxLevel
end

function ACTIVITY_OBJ_NEW:canWarOrderLevelUp(arg_5_1)
	return arg_5_1 + self:getCurWarOrderLevel() <= self._maxLevel
end

function ACTIVITY_OBJ_NEW:getWarOrderExp(arg_6_1)
	local var_6_0 = self._id .. self.needKey .. (arg_6_1 or self:getCurWarOrderLevel())

	if not activity_proceed_data[var_6_0] then
		return 0
	end

	local var_6_1 = activity_proceed_data[var_6_0].item1

	if self:isWarOrderSVIP() then
		return item_manager:getItemNumber(var_6_1)
	else
		return item_manager:getItemNumber(var_6_1) * (activity_vipbuy_data["svip_" .. self._id].magnification or 1)
	end
end

function ACTIVITY_OBJ_NEW:getActivityWarOrderFreeCostNum()
	return item_manager:getItemNumber(self.freecostId)
end

function ACTIVITY_OBJ_NEW.warorder_daily_update(arg_8_0)
	return
end

function ACTIVITY_OBJ_NEW:getActivityWarOrderTaskData()
	return self.WarOrderTaskList
end

function ACTIVITY_OBJ_NEW:getActivityWarOrderLevelData()
	return self.WarOrderLevelList
end

function ACTIVITY_OBJ_NEW.getWarOrderDrop(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return {}
	end

	local var_11_0 = drop_manager:getAllDrops(arg_11_1)

	if drop_manager:getGold(arg_11_1) > 0 then
		table.insert(var_11_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(arg_11_1)
		})
	end

	if drop_manager:getDiamond(arg_11_1) > 0 then
		table.insert(var_11_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(arg_11_1)
		})
	end

	return var_11_0
end

local var_0_16 = 1

function ACTIVITY_OBJ_NEW:getWarOrderVipGiftList()
	if activity_bp_conf[self._id].sp_preview_drop_id then
		return self:getWarOrderDrop(activity_bp_conf[self._id].sp_preview_drop_id)
	end

	local var_12_0 = {}
	local var_12_1 = 1

	while activity_proceed_data[self._id .. self.needKey .. var_12_1 * var_0_16] do
		if activity_proceed_data[self._id .. self.needKey .. var_12_1 * var_0_16].specialDrop then
			for iter_12_0, iter_12_1 in pairs((self:getWarOrderDrop(activity_proceed_data[self._id .. self.needKey .. var_12_1 * var_0_16].specialDrop))) do
				iter_12_1.level = var_12_1 * var_0_16

				if iter_12_1.dropid ~= "diamond" then
					table.insert(var_12_0, iter_12_1)
				end
			end
		end

		var_12_1 = var_12_1 + 1
	end

	local var_12_3 = {}

	for iter_12_2, iter_12_3 in pairs(var_12_0) do
		if not var_12_3[iter_12_3.dropid] then
			var_12_3[iter_12_3.dropid] = iter_12_3
		else
			var_12_3[iter_12_3.dropid].dropNum = var_12_3[iter_12_3.dropid].dropNum + iter_12_3.dropNum
		end
	end

	local var_12_4 = self:getVipDiamondNum()

	if var_12_4 > 0 and #var_12_3 < 4 then
		table.insert(var_12_3, {
			dropid = "diamond",
			dropNum = var_12_4
		})
	end

	local var_12_5 = {}

	for iter_12_4, iter_12_5 in pairs(var_12_3) do
		table.insert(var_12_5, iter_12_5)
	end

	return var_12_5
end

function ACTIVITY_OBJ_NEW:getVipDiamondNum()
	local var_13_1 = 1
	local var_13_2 = 0

	while activity_proceed_data[self._id .. self.needKey .. 1] do
		if activity_proceed_data[self._id .. self.needKey .. 1].specialDrop then
			for iter_13_0, iter_13_1 in pairs((self:getWarOrderDrop(activity_proceed_data[self._id .. self.needKey .. 1].specialDrop))) do
				if iter_13_1.dropid == "diamond" then
					var_13_2 = var_13_2 + iter_13_1.dropNum
				end
			end
		end

		var_13_1 = var_13_1 + 1
	end

	return var_13_2
end

function ACTIVITY_OBJ_NEW:isHasCanCompleteWarOrderTask()
	if not self.WarOrderTaskList then
		return false
	end

	local var_14_0 = false

	for iter_14_0, iter_14_1 in pairs(self.WarOrderTaskList) do
		if iter_14_1.status == 0 and iter_14_1.percent == 100 then
			var_14_0 = true

			break
		end
	end

	return var_14_0
end

function ACTIVITY_OBJ_NEW:getWarOrderTaskReward(arg_15_1)
	self:getTaskReward(arg_15_1, function(arg_16_0, arg_16_1)
		if arg_16_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_16_1)
		self:getActivityWarOrderTask()
		self:requestWarOrderLevelInfo()
	end)
end

function ACTIVITY_OBJ_NEW:getWarOrdernum()
	return item_manager:getItemNumber(activity_bp_conf[self._id].cost_item or 6800601)
end

function ACTIVITY_OBJ_NEW:getWarOrderLevelInfoByServer(arg_18_1)
	network:rpc("get_activity_war_order_level_info", {
		activityid = self._id
	}, function(arg_19_0)
		if arg_19_0.result ~= 1 then
			return
		end

		self.timeId = arg_19_0.timeid
		self.needKey = activity_warorder_time_conf[self.timeId].proceedid .. "-" or "warorder-"

		local var_19_0 = {}

		for iter_19_0, iter_19_1 in pairs(arg_19_0.list) do
			var_19_0[iter_19_1.id] = {}
			var_19_0[iter_19_1.id].status = iter_19_1.status
			var_19_0[iter_19_1.id].id = iter_19_1.id
			var_19_0[iter_19_1.id].drop = activity_proceed_data[self._id .. self.needKey .. iter_19_1.id].drop
			var_19_0[iter_19_1.id].specialDrop = activity_proceed_data[self._id .. self.needKey .. iter_19_1.id].specialDrop
		end

		self.WarOrderLevelList = var_19_0

		table.insert(self.WarOrderLevelList, {
			id = "?",
			status = UN_KONW
		})

		if type(arg_18_1) == "function" then
			arg_18_1()
		end
	end)
end

function ACTIVITY_OBJ_NEW:requestWarOrderLevelInfo()
	self:getWarOrderLevelInfoByServer(function()
		activity_manager:fireEvent(activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, {
			list = self.WarOrderLevelList,
			listLen = #self.WarOrderLevelList
		})
		activity_manager:updateActivityAlert("warorder_level", self._id, self:isHasWarOrderRewardCanGet())
	end)
end

function ACTIVITY_OBJ_NEW:getWarOrderLayerName()
	return activity_bp_conf[self._id].layerName
end

function ACTIVITY_OBJ_NEW:get_warorder_id()
	return self._id
end

function ACTIVITY_OBJ_NEW:getCurWarOrderLevel()
	if not self.WarOrderLevelList then
		return
	end

	for iter_24_0 = 1, #self.WarOrderLevelList do
		if self.WarOrderLevelList[iter_24_0].status == var_0_12 then
			return self.WarOrderLevelList[iter_24_0].id
		end
	end

	return #self.WarOrderLevelList
end

function ACTIVITY_OBJ_NEW:getCurWarOrderLevelProceed(arg_25_1)
	local var_25_0 = arg_25_1 or self:getCurWarOrderLevel()
	local var_25_1 = self._id .. self.needKey .. var_25_0

	if not activity_proceed_data[self._id .. self.needKey .. var_25_0] then
		var_25_0 = var_25_0 - 1
		var_25_1 = self._id .. self.needKey .. var_25_0
	end

	local var_25_2 = activity_proceed_data[var_25_1].num1
	local var_25_3 = activity_proceed_data[self._id .. self.needKey .. var_25_0 - 1] or {
		num1 = 0
	}
	local var_25_4 = item_manager:getItemNumber(activity_proceed_data[var_25_1].item1)

	if self:isWarOrderSVIP() then
		var_25_4 = math.ceil(var_25_4 * (activity_vipbuy_data["svip_" .. self._id].magnification or 1))
	end

	return (var_25_4 - var_25_3.num1) / (var_25_2 - var_25_3.num1) * 100, var_25_4 - var_25_3.num1 .. "/" .. var_25_2 - var_25_3.num1
end

function ACTIVITY_OBJ_NEW:isWarOrderSVIP()
	return item_manager:haveItem(activity_vipbuy_data["allvip_" .. self._id].checkitem)
end

function ACTIVITY_OBJ_NEW:getWarOrderTaskRewardOneKey()
	self:getWarOrderTaskInfo(nil, function(arg_28_0)
		global_gain(arg_28_0)
	end, true, nil, "warorder")
end

function ACTIVITY_OBJ_NEW:requestWarOrderTaskInfo()
	self:getWarOrderTaskInfo(nil, nil, false, nil, "warorder")
end

function ACTIVITY_OBJ_NEW:getWarOrderTaskInfo(arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
	network:rpc("get_activity_war_order_task_info", {
		activityid = self._id,
		stage = arg_30_1,
		isautoget = arg_30_3,
		statkey = arg_30_4,
		usemodule = arg_30_5
	}, function(arg_31_0)
		if arg_31_0.result ~= 1 then
			return
		end

		self.WarOrderTaskList = {}

		for iter_31_0, iter_31_1 in pairs(arg_31_0.list) do
			iter_31_1.name = task_data[iter_31_1.taskid].name
			iter_31_1.task_des = task_data[iter_31_1.taskid].task_des
			iter_31_1.image = task_data[iter_31_1.taskid].image
			iter_31_1.drop = task_data[iter_31_1.taskid].drop
			iter_31_1.jump = task_data[iter_31_1.taskid].jump
			iter_31_1.order = task_data[iter_31_1.taskid].order

			if iter_31_1.status == 1 then
				iter_31_1.percent = -1
			end

			table.insert(self.WarOrderTaskList, iter_31_1)
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = self.WarOrderTaskList,
			listLen = #self.WarOrderTaskList
		})
		activity_manager:updateActivityAlert("warorder_task", self._id, self:isHasCanCompleteWarorderTask())

		if type(arg_30_2) == "function" then
			arg_30_2(arg_31_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_warorder_multi_pt_reward(arg_32_1, arg_32_2)
	network:rpc("get_war_order_reward", {
		activityid = self._id,
		order = arg_32_1,
		index = arg_32_2
	}, function(arg_33_0)
		if arg_33_0.result ~= 1 then
			return
		end

		global_gain(arg_33_0)

		if arg_33_0.costitem then
			for iter_33_0, iter_33_1 in pairs(arg_33_0.costitem) do
				item_manager:deleteItem(iter_33_1.itemid, iter_33_1.num)
			end
		end

		self:requestWarOrderLevelInfo()
	end)
end

function ACTIVITY_OBJ_NEW:refresh_task_one_item(arg_34_1)
	network:rpc("refresh_warorder_task_one_item", {
		activityid = self._id,
		index = arg_34_1
	}, function(arg_35_0)
		local function var_35_0()
			global_ShowBlockWords("刷新成功")

			self.WarOrderTaskList = {}

			for iter_36_0, iter_36_1 in pairs(arg_35_0.list) do
				iter_36_1.name = task_data[iter_36_1.taskid].name
				iter_36_1.task_des = task_data[iter_36_1.taskid].task_des
				iter_36_1.image = task_data[iter_36_1.taskid].image
				iter_36_1.drop = task_data[iter_36_1.taskid].drop
				iter_36_1.jump = task_data[iter_36_1.taskid].jump
				iter_36_1.order = task_data[iter_36_1.taskid].order

				if iter_36_1.status == 1 then
					iter_36_1.percent = -1
				end

				table.insert(self.WarOrderTaskList, iter_36_1)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
				list = self.WarOrderTaskList,
				listLen = #self.WarOrderTaskList
			})
			activity_manager:updateActivityAlert("warorder_task", self._id, self:isHasCanCompleteWarorderTask())
		end

		if arg_35_0.result == 1 then
			item_manager:deleteItem(self.freecostId, 1)
			var_35_0()
		elseif arg_35_0.result == 2 then
			playermodel.diamond = playermodel.diamond - 10

			global_update_gold_stone_diamond(nil, nil, 10)
			var_35_0()
		elseif arg_35_0.result == 3 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end
	end)
end

function ACTIVITY_OBJ_NEW:getCurShowType()
	return self.curShowType or 1
end

function ACTIVITY_OBJ_NEW.setCurShowType(arg_38_0, arg_38_1)
	arg_38_0.curShowType = arg_38_1
end

function ACTIVITY_OBJ_NEW:getWarOrderLevelUpCost(arg_39_1)
	local var_39_0 = self:getCurWarOrderLevel() + arg_39_1 - 1

	if not activity_proceed_data[self._id .. self.needKey .. var_39_0] then
		return 0
	end

	local var_39_1 = item_manager:getItemNumber(activity_proceed_data[self._id .. self.needKey .. var_39_0].item1)
	local var_39_2 = activity_vipbuy_data["svip_" .. self._id].magnification or 1

	if self:isWarOrderSVIP() then
		var_39_1 = math.ceil(var_39_1 * var_39_2)
	end

	local var_39_3 = activity_proceed_data[self._id .. self.needKey .. var_39_0].num1 - var_39_1

	if self:isWarOrderSVIP() then
		var_39_3 = math.ceil(var_39_3 / var_39_2)
	end

	return math.abs(var_39_3 * activity_vipbuy_data["allvip_" .. self._id].proportion)
end

function ACTIVITY_OBJ_NEW:getWarOrderLevelupCanGetDrop(arg_40_1)
	local var_40_0 = self:getCurWarOrderLevel()

	if var_40_0 + arg_40_1 > self._maxLevel then
		return {}
	end

	local var_40_1 = 1
	local var_40_2 = {}

	while var_40_1 <= arg_40_1 do
		if activity_proceed_data[self._id .. self.needKey .. var_40_0 + 1 - 1].specialDrop then
			for iter_40_0, iter_40_1 in pairs((self:getWarOrderDrop(activity_proceed_data[self._id .. self.needKey .. var_40_0 + 1 - 1].specialDrop))) do
				iter_40_1.level = var_40_0 + var_40_1 - 1
				var_40_2[var_40_1] = var_40_2[var_40_1] or {}

				table.insert(var_40_2[var_40_1], iter_40_1)
			end
		end

		if activity_proceed_data[self._id .. self.needKey .. var_40_0 + 1 - 1].drop then
			for iter_40_2, iter_40_3 in pairs((self:getWarOrderDrop(activity_proceed_data[self._id .. self.needKey .. var_40_0 + 1 - 1].drop))) do
				iter_40_3.level = var_40_0 + var_40_1 - 1
				var_40_2[var_40_1] = var_40_2[var_40_1] or {}

				table.insert(var_40_2[var_40_1], iter_40_3)
			end
		end

		var_40_1 = var_40_1 + 1
	end

	return var_40_2
end

function ACTIVITY_OBJ_NEW:buyWarOrderActivityLevel(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local function var_41_0(arg_42_0, arg_42_1)
		if arg_42_0 ~= 1 then
			global_ShowBlockWords(L_BUY_BATTLEPASS_LEVEL[arg_42_0])

			return
		end

		if arg_42_1.cost_items then
			for iter_42_0, iter_42_1 in pairs(arg_42_1.cost_items) do
				item_manager:deleteItem(iter_42_1.entityid, iter_42_1.num)
			end
		end

		playermodel.diamond = playermodel.diamond - arg_42_1.cost_diamond

		global_update_gold_stone_diamond(nil, nil, arg_42_1.cost_diamond)
		global_gain(arg_42_1)
		self:requestWarOrderLevelInfo()
	end

	network:rpc("activity_bp_buy_proceed", {
		activityid = self._id,
		level = arg_41_1
	}, function(arg_43_0)
		var_41_0(arg_43_0.result, arg_43_0)
	end)
end

function ACTIVITY_OBJ_NEW:getWarOrderTaskReward(arg_44_1)
	self:getTaskReward(arg_44_1, function(arg_45_0, arg_45_1)
		if arg_45_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_45_1)
		self:requestWarOrderTaskInfo()
	end)
end

function ACTIVITY_OBJ_NEW:getWarOrderLevelReward(arg_46_1)
	self:getActivityWarOrderProceedAward(arg_46_1, function(arg_47_0, arg_47_1)
		if arg_47_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_47_1)
		self:requestWarOrderLevelInfo()
	end)
end

function ACTIVITY_OBJ_NEW:getActivityWarOrderProceedAward(arg_48_1, arg_48_2)
	if not self:isHaveModule("bp") then
		if arg_48_2 then
			arg_48_2(0)
		end

		return
	end

	if self._status ~= ACTIVITY_ACTIVING then
		if arg_48_2 then
			arg_48_2(2)
		end

		return
	end

	network:rpc("get_activity_bp_proceed_award", {
		activityid = self._id,
		index = arg_48_1
	}, function(arg_49_0)
		if arg_49_0.result == 1 then
			AnalyticManager.get_activity_proceed_award({
				activityid = self._id,
				index = arg_48_1
			})

			if arg_48_2 then
				arg_48_2(1, arg_49_0)
			end
		elseif arg_48_2 then
			arg_48_2(arg_49_0.result)
		end
	end)
end

function ACTIVITY_OBJ_NEW:isHasCanCompleteWarorderTask()
	if not self.WarOrderTaskList or #self.WarOrderTaskList == 0 then
		return false
	end

	local var_50_0 = false

	for iter_50_0, iter_50_1 in pairs(self.WarOrderTaskList) do
		if iter_50_1.status == 0 and iter_50_1.percent == 100 then
			var_50_0 = true

			break
		end
	end

	return var_50_0
end

function ACTIVITY_OBJ_NEW:isHasWarOrderRewardCanGet()
	local var_51_0 = false

	if not self.WarOrderLevelList or #self.WarOrderLevelList == 0 then
		return false
	end

	for iter_51_0, iter_51_1 in ipairs(self.WarOrderLevelList) do
		if iter_51_1.status == var_0_13 or iter_51_1.status == var_0_14 and self:isWarOrderVIP() then
			var_51_0 = true

			break
		end
	end

	return var_51_0
end

function ACTIVITY_OBJ_NEW:isWarOrderVIP()
	return item_manager:haveItem(activity_vipbuy_data["vip_" .. self._id].checkitem) or item_manager:haveItem(activity_vipbuy_data["allvip_" .. self._id].checkitem)
end

function ACTIVITY_OBJ_NEW.isCanPlayWarOrder(arg_53_0)
	if require("controller.time_check_manager"):getCurTime() < global_get_time_by_date(activity_warorder_time_conf[1].starttime) then
		return false
	else
		return true
	end
end

function ACTIVITY_OBJ_NEW:isCanShowWarOrder(arg_54_1)
	self:getWarOrderLevelInfoByServer(function()
		if type(arg_54_1) == "function" then
			arg_54_1(self:isCanPlayWarOrder() == true and self.timeId ~= nil or self:isCanPlayWarOrder() == false)
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_warorder_module_finishtime()
	return self.timeId and activity_warorder_time_conf[self.timeId].finishtime
end

function ACTIVITY_OBJ_NEW:updateWarOrderEntranceAlert()
	if activity_manager:getAlertStatus(self._id, "warorder_level") then
		alert_manager:register_alert(ALERT_BATTLE_PASS)
	else
		alert_manager:unregister_alert(ALERT_BATTLE_PASS, true)
	end

	if activity_manager:getAlertStatus(self._id, "warorder_task") then
		alert_manager:register_alert(ALERT_BATTLE_PASS_TASK)
	else
		alert_manager:unregister_alert(ALERT_BATTLE_PASS_TASK, true)
	end
end
