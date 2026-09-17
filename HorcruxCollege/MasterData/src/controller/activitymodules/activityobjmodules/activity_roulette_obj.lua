local network = require("network.network")
local activity_roulette_data = require("data.activity_roulette_data")
local activity_roulette_giftbag_data = require("data.activity_roulette_giftbag_data")
local activity_flop_conf_data = require("data.activity_flop_conf_data")
local activity_flop_giftbag_data = require("data.activity_flop_giftbag_data")
local item_data = require("data.item_data")
local activity_conf_data = require("data.activity_conf_data")
local common_roulette_data = require("data.common_roulette_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local var_0_12 = require("network.network")
local playermodel = require("model.playermodel")
local drop_data = require("data.drop_data")
local task_data = require("data.task_data")
local var_0_16 = 3
local var_0_17 = 2
local var_0_18 = 1

function ACTIVITY_OBJ_NEW.initModuleRoulette(arg_1_0, arg_1_1)
	return
end

function ACTIVITY_OBJ_NEW:getRouletteInfo()
	var_0_12:rpc("get_activity_roulette_info", {
		activityid = self._id
	}, function(arg_3_0)
		if arg_3_0.result == 1 then
			self._roulettePhase = arg_3_0.phase
			self._rouletteId = self._id .. "_" .. self._roulettePhase
			self._rouletteTotalNum = arg_3_0.totalNum
			self._rouletteHasNum = arg_3_0.hasNum
			self._rouletteFreeNum = arg_3_0.freeNum
			arg_3_0.hadDrop = arg_3_0.hadDrop or {}

			for iter_3_0, iter_3_1 in pairs(arg_3_0.hadDrop) do
				self.emptyRouletteList = self.emptyRouletteList or {}
				self.emptyRouletteList[iter_3_1] = true
			end

			self:setCommonRouletteSpecailDrop(arg_3_0.ids)
			activity_manager:fireEvent(activity_manager.activityEventId.ROULETTE_INFO_UPDATE)
		else
			global_ShowBlockWords(L_ACTIVITY_END)
		end
	end)
end

function ACTIVITY_OBJ_NEW:rouletteForOnce()
	var_0_12:rpc("roulette_for_one", {
		activityid = self._id
	}, function(arg_5_0)
		if arg_5_0.result == 3 then
			global_ShowBlockWords(item_data[activity_roulette_data[self._rouletteId].need_item].name .. L_SOUL_STRENGTH_PANEL_BTN_TITLE[4])

			return
		elseif arg_5_0.result == 4 then
			global_ShowBlockWords(L_ROULETTE_EMPTY)

			return
		elseif arg_5_0.result == 5 then
			global_ShowBlockWords(L_COMMONROULETTE_TEXT[5])

			return
		end

		for iter_5_0, iter_5_1 in pairs(arg_5_0.costItems) do
			item_manager:deleteItem(iter_5_1.itemid, iter_5_1.num)
		end

		local var_5_0, var_5_1, var_5_2, var_5_3, var_5_4 = global_get(arg_5_0)

		activity_manager:fireEvent(activity_manager.activityEventId.ROULETTE_FOR_ONE, {
			items = arg_5_0.items,
			originalItem = arg_5_0.originalItem,
			originalNum = arg_5_0.originalNum,
			originalItemAttr = arg_5_0.originalItemAttr
		})

		if self:isSpItem(var_5_4[1].dropid) and item_data[var_5_4[1].dropid].bag_item_type == kITEM_SKIN then
			LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
				modelid = activity_roulette_data[self._rouletteId].need_show,
				itemid = var_5_4[1].dropid
			})
		end

		if require("data.activity_roulette.activityconf." .. activity_conf_data[self._id].roulette).is_common and item_data[var_5_4[1].dropid].bag_item_type == kITEM_SKIN then
			LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
				modelid = activity_roulette_data[self._rouletteId].need_show,
				itemid = var_5_4[1].dropid
			})
		end

		self:getRouletteInfo()
	end)
end

function ACTIVITY_OBJ_NEW:rouletteForFive()
	var_0_12:rpc("roulette_for_five", {
		activityid = self._id
	}, function(arg_7_0)
		if arg_7_0.result == 3 then
			global_ShowBlockWords(item_data[activity_roulette_data[self._rouletteId].need_item].name .. L_SOUL_STRENGTH_PANEL_BTN_TITLE[4])

			return
		elseif arg_7_0.result == 4 then
			global_ShowBlockWords(L_ROULETTE_EMPTY)

			return
		elseif arg_7_0.result == 5 then
			global_ShowBlockWords(L_COMMONROULETTE_TEXT[5])

			return
		end

		for iter_7_0, iter_7_1 in pairs(arg_7_0.costItems) do
			item_manager:deleteItem(iter_7_1.itemid, iter_7_1.num)
		end

		local var_7_0, var_7_1, var_7_2, var_7_3, var_7_4 = global_get(arg_7_0)

		for iter_7_2, iter_7_3 in pairs(var_7_4) do
			if self:isSpItem(iter_7_3.dropid) and item_data[iter_7_3.dropid].bag_item_type == kITEM_SKIN then
				LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
					modelid = activity_roulette_data[self._rouletteId].need_show,
					itemid = iter_7_3.dropid
				})
			end

			if require("data.activity_roulette.activityconf." .. activity_conf_data[self._id].roulette).is_common and item_data[iter_7_3.dropid].bag_item_type == kITEM_SKIN then
				LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
					modelid = activity_roulette_data[self._rouletteId].need_show,
					itemid = iter_7_3.dropid
				})
			end
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ROULETTE_FOR_FIVE, {
			items = arg_7_0.items,
			originalItems = arg_7_0.originalItems
		})
		self:getRouletteInfo()
	end)
end

function ACTIVITY_OBJ_NEW:getRouletteLimitData()
	var_0_12:rpc("get_roulette_limit_data", {
		activityid = self._id
	}, function(arg_9_0)
		for iter_9_0, iter_9_1 in pairs(arg_9_0.limitData) do
			iter_9_1.currencytype = activity_roulette_giftbag_data[self._id .. "-" .. iter_9_0].currencytype
			iter_9_1.price = activity_roulette_giftbag_data[self._id .. "-" .. iter_9_0].price
			iter_9_1.dropid = activity_roulette_giftbag_data[self._id .. "-" .. iter_9_0].dropid
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ROULETTE_LIMIT_INFO_UPDATE, {
			data = arg_9_0.limitData
		})
	end)
end

function ACTIVITY_OBJ_NEW:buyRouletteLimitBag(arg_10_1, arg_10_2, arg_10_3)
	var_0_12:rpc("buy_roulette_limit_item", {
		activityid = self._id,
		order = arg_10_1,
		buyNum = arg_10_2
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			if arg_11_0.consumes then
				for iter_11_0, iter_11_1 in pairs(arg_11_0.consumes) do
					item_manager:deleteItem(iter_11_1.entityid, iter_11_1.num)
				end
			end

			if arg_11_0.costdiamond and arg_11_0.costdiamond ~= 0 then
				playermodel.diamond = playermodel.diamond - arg_11_0.costdiamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
			end

			LayerManager:removePopLayer()
			global_gain({
				items = arg_11_0.items
			})
			self:getRouletteLimitData()
			activity_manager:fireEvent(activity_manager.activityEventId.ROULETTE_LIMIT_BUY)
		elseif arg_11_0.result == 2 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[2])
		elseif arg_11_0.result == 3 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[3])
		elseif arg_11_0.result == 4 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[4])
		end
	end)
end

function ACTIVITY_OBJ_NEW:getRouletteEndTime()
	return global_get_time_by_date(activity_roulette_data[self._rouletteId].end_time) - time_check_manager:getCurTime()
end

function ACTIVITY_OBJ_NEW:getRouletteItemData()
	if require("data.activity_roulette.activityconf." .. activity_conf_data[self._id].roulette).is_empty then
		return self:getEmptyRouletteItemData()
	end

	local var_13_0 = drop_manager:getAllDropsNotMerge(activity_roulette_data[self._rouletteId].nomal_drop_id)
	local var_13_1
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4, var_13_5 = self:getRouletteSize()
	local var_13_6 = {
		var_13_4,
		var_13_4 + var_13_5 - 1,
		(var_13_4 - 1) * 2 + var_13_5
	}

	for iter_13_0, iter_13_1 in pairs((drop_manager:getAllDropsNotMerge(activity_roulette_data[self._rouletteId].best_drop_id))) do
		iter_13_1.quality = var_0_16
		iter_13_1.only = true
		var_13_1 = iter_13_1
	end

	for iter_13_2, iter_13_3 in pairs((drop_manager:getAllDropsNotMerge(activity_roulette_data[self._rouletteId].special_drop_id_1))) do
		iter_13_3.quality = var_0_17

		table.insert(var_13_3, iter_13_3)
	end

	for iter_13_4, iter_13_5 in pairs(var_13_0) do
		iter_13_5.quality = var_0_18

		table.insert(var_13_2, iter_13_5)
	end

	table.insert(var_13_2, 1, var_13_1)

	for iter_13_6 = 1, #var_13_6 do
		table.insert(var_13_2, var_13_6[iter_13_6], var_13_3[iter_13_6])
	end

	return var_13_2
end

function ACTIVITY_OBJ_NEW:getEmptyRouletteItemData()
	self.emptyRouletteList = self.emptyRouletteList or {}

	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2, var_14_3 = self:getRouletteSize()
	local var_14_4 = {
		1,
		var_14_2,
		var_14_2 + var_14_3 - 1,
		(var_14_2 - 1) * 2 + var_14_3
	}
	local var_14_5 = 1

	while drop_data[activity_roulette_data[self._rouletteId].best_drop_id]["rd_dropmodel_id" .. 1] do
		for iter_14_0, iter_14_1 in pairs((drop_manager:getAllDropsNotMerge(drop_data[activity_roulette_data[self._rouletteId].best_drop_id]["rd_dropmodel_id" .. 1]))) do
			iter_14_1.quality = var_0_17
			iter_14_1.is_empty = self.emptyRouletteList[drop_data[activity_roulette_data[self._rouletteId].best_drop_id]["rd_dropmodel_id" .. 1]] or false

			table.insert(var_14_1, iter_14_1)
		end

		var_14_5 = var_14_5 + 1
	end

	local var_14_7 = 1

	while drop_data[activity_roulette_data[self._rouletteId].nomal_drop_id]["rd_dropmodel_id" .. 1] do
		for iter_14_2, iter_14_3 in pairs((drop_manager:getAllDropsNotMerge(drop_data[activity_roulette_data[self._rouletteId].nomal_drop_id]["rd_dropmodel_id" .. 1]))) do
			iter_14_3.quality = var_0_18
			iter_14_3.is_empty = self.emptyRouletteList[drop_data[activity_roulette_data[self._rouletteId].nomal_drop_id]["rd_dropmodel_id" .. 1]] or false

			table.insert(var_14_0, iter_14_3)
		end

		var_14_7 = var_14_7 + 1
	end

	for iter_14_4 = 1, #var_14_4 do
		table.insert(var_14_0, var_14_4[iter_14_4], var_14_1[iter_14_4])
	end

	return var_14_0
end

function ACTIVITY_OBJ_NEW:isSpItem(arg_15_1)
	if require("data.activity_roulette.activityconf." .. activity_conf_data[self._id].roulette).is_common then
		return false
	end

	for iter_15_0, iter_15_1 in pairs((drop_manager:getAllDropsNotMerge(activity_roulette_data[self._rouletteId].best_drop_id))) do
		if iter_15_1.dropid == arg_15_1 then
			return true
		end
	end

	return false
end

function ACTIVITY_OBJ_NEW:isRareItem(arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in pairs((drop_manager:getAllDropsNotMerge(activity_roulette_data[self._rouletteId].special_drop_id_1))) do
		if iter_16_1.dropid == arg_16_1 and iter_16_1.dropNum == arg_16_2 then
			return true
		end
	end

	return false
end

function ACTIVITY_OBJ_NEW:getRouletteNeedItem()
	return activity_roulette_data[self._rouletteId].need_item
end

function ACTIVITY_OBJ_NEW:getRouletteShowModel()
	return activity_roulette_data[self._rouletteId].need_show
end

function ACTIVITY_OBJ_NEW:getRouletteNums()
	return self._rouletteTotalNum, self._rouletteHasNum
end

function ACTIVITY_OBJ_NEW:getCurphase()
	return self._roulettePhase
end

function ACTIVITY_OBJ_NEW:isRouletteCanFree()
	return self._rouletteFreeNum and self._rouletteFreeNum > 0
end

function ACTIVITY_OBJ_NEW:isHaveEnoughToRoulettes(arg_22_1)
	arg_22_1 = arg_22_1 or 1
	arg_22_1 = arg_22_1 - (self._rouletteFreeNum or 0)

	if arg_22_1 == 0 then
		return true
	end

	return item_manager:isHaveEnoughItem(activity_roulette_data[self._rouletteId].need_item, activity_roulette_data[self._rouletteId].need_num * arg_22_1)
end

function ACTIVITY_OBJ_NEW:isRouletteneedAlert()
	if not self._rouletteId then
		return activity_manager:getAlertStatus(self._id, "roulette")
	end

	if self._rouletteFreeNum and self._rouletteFreeNum > 0 then
		return true
	end

	return item_manager:isHaveEnoughItem(self:getRouletteNeedItem(), activity_roulette_data[self._rouletteId].need_num)
end

function ACTIVITY_OBJ_NEW:getRouletteSize()
	local var_24_0 = require("data.activity_roulette.activityconf." .. activity_conf_data[self._id].roulette)

	var_24_0.width = var_24_0.width or {
		value = 5
	}
	var_24_0.height = var_24_0.height or {
		value = 5
	}

	return var_24_0.width.value, var_24_0.height.value
end

function ACTIVITY_OBJ_NEW:canBuyRouletteCurrency()
	local var_25_0 = require("data.activity_roulette.activityconf." .. activity_conf_data[self._id].roulette)

	return (var_25_0.jump_to or nil) and (var_25_0.jump_to.value or nil)
end

function ACTIVITY_OBJ_NEW:getRouletteTaskList()
	self:getActivityTaskList(nil, function(arg_27_0, arg_27_1)
		if arg_27_0 ~= 1 then
			return
		end

		self.rouletteTaskList = {}

		for iter_27_0, iter_27_1 in pairs(arg_27_1.list) do
			iter_27_1.name = task_data[iter_27_1.taskid].name
			iter_27_1.task_des = task_data[iter_27_1.taskid].task_des
			iter_27_1.image = task_data[iter_27_1.taskid].image
			iter_27_1.drop = task_data[iter_27_1.taskid].drop
			iter_27_1.jump = task_data[iter_27_1.taskid].jump
			iter_27_1.order = task_data[iter_27_1.taskid].order

			if iter_27_1.status == 1 then
				iter_27_1.percent = -1
			end

			table.insert(self.rouletteTaskList, iter_27_1)
		end

		table.sort(self.rouletteTaskList, function(arg_28_0, arg_28_1)
			if arg_28_0.percent == arg_28_1.percent then
				return arg_28_0.order < arg_28_1.order
			else
				return arg_28_0.percent > arg_28_1.percent
			end
		end)
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = self.rouletteTaskList,
			listLen = #self.rouletteTaskList
		})
		activity_manager:updateActivityAlert("totle_roulette", self._id, self:isHasRouletteCanCompleteTask())
	end, false, nil, "totle_roulette")
end

function ACTIVITY_OBJ_NEW:isHasRouletteCanCompleteTask()
	if not self.rouletteTaskList or #self.rouletteTaskList == 0 then
		return false
	end

	if self.rouletteTaskList[1].status == 0 and self.rouletteTaskList[1].percent == 100 then
		return true
	end

	return false
end

function ACTIVITY_OBJ_NEW:getRouletteTaskReward(arg_30_1)
	self:getTaskReward(arg_30_1, function(arg_31_0, arg_31_1)
		if arg_31_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_31_1)
		self:getRouletteTaskList()
	end)
end

function ACTIVITY_OBJ_NEW:ROULETTE_FOR_TEST(arg_32_1)
	var_0_12:rpc("roulette_for_test", {
		activityid = self._id,
		num = arg_32_1
	}, function(arg_33_0)
		for iter_33_0, iter_33_1 in pairs(arg_33_0.data) do
			local var_33_0 = string.format("%s       %s     %s\n", item_data[iter_33_1.itemid].name, iter_33_1.itemid, iter_33_1.num)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getCommonRouletteItemData()
	local var_34_0 = require("data.activity_roulette.activityconf." .. activity_conf_data[self._id].roulette)
	local var_34_1 = {}
	local var_34_2 = {}
	local var_34_3, var_34_4 = self:getRouletteSize()
	local var_34_5 = {
		1,
		var_34_3,
		var_34_3 + var_34_4 - 1,
		(var_34_3 - 1) * 2 + var_34_4
	}

	for iter_34_0, iter_34_1 in ipairs(self:getCommonRouletteSpecailDrop()) do
		local var_34_6 = drop_manager:getAllDropsNotMerge((self:getCommonDropById(iter_34_1)))[1]

		var_34_6.quality = var_0_16

		table.insert(var_34_2, var_34_6)
	end

	if #var_34_2 == 0 then
		var_34_2 = {
			{},
			{},
			{},
			{}
		}
	end

	for iter_34_2, iter_34_3 in pairs((drop_manager:getAllDropsNotMerge(activity_roulette_data[self._rouletteId].nomal_drop_id))) do
		iter_34_3.quality = var_0_18

		table.insert(var_34_1, iter_34_3)
	end

	for iter_34_4 = 1, #var_34_5 do
		table.insert(var_34_1, var_34_5[iter_34_4], var_34_2[iter_34_4])
	end

	return var_34_1
end

function ACTIVITY_OBJ_NEW:get_commonroulette_special_drop(arg_35_1)
	var_0_12:rpc("get_commonroulette_special_drop", {
		activityid = self._id
	}, function(arg_36_0)
		if arg_36_0.result == 1 then
			self:setCommonRouletteSpecailDrop(arg_36_0.ids)
		elseif arg_36_0.result == 2 then
			global_ShowBlockWords(L_COMMONROULETTE_TEXT[6])

			if arg_35_1 then
				arg_35_1()
			end
		else
			global_ShowBlockWords("error!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:set_commonroulette_special_drop(arg_37_1, arg_37_2)
	var_0_12:rpc("set_commonroulette_special_drop", {
		activityid = self._id,
		ids = arg_37_1
	}, function(arg_38_0)
		if arg_38_0.result == 1 then
			global_ShowBlockWords(L_COMMONROULETTE_TEXT[7])
			self:setCommonRouletteSpecailDrop(arg_38_0.ids)
			activity_manager:fireEvent(activity_manager.activityEventId.ROULETTE_INFO_UPDATE)

			if arg_37_2 then
				arg_37_2()
			end

			local var_38_0 = {}
			local var_38_1 = self:getCommonSpecialDropids()

			for iter_38_0, iter_38_1 in ipairs(arg_37_1) do
				table.insert(var_38_0, var_38_1[iter_38_1])
			end

			AnalyticManager.activityroulette_choose({
				activityid = self._id,
				choose_list = var_38_0
			})
		else
			global_ShowBlockWords("error!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:getCommonDropById(arg_39_1)
	return common_roulette_data[self._rouletteId]["drop_id" .. arg_39_1]
end

function ACTIVITY_OBJ_NEW.setCommonRouletteSpecailDrop(arg_40_0, arg_40_1)
	arg_40_0.specailIds = arg_40_1 or {}
end

function ACTIVITY_OBJ_NEW:getCommonRouletteSpecailDrop()
	return self.specailIds
end

function ACTIVITY_OBJ_NEW:getCommonSpecialDropids()
	local var_42_0 = {}

	for iter_42_0 = 1, common_roulette_data[self._rouletteId].drop_Num do
		table.insert(var_42_0, common_roulette_data[self._rouletteId]["drop_id" .. iter_42_0])
	end

	return var_42_0
end

function ACTIVITY_OBJ_NEW:isCommonRoulette()
	return activity_conf_data[self._id].commonRoulette
end

function ACTIVITY_OBJ_NEW:getRouletteShopJump()
	if not common_roulette_data[self._rouletteId] then
		return
	end

	return common_roulette_data[self._rouletteId].RouletteShop
end
