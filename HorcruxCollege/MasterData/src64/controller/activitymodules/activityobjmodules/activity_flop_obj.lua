local activity_flop_conf_data = require("data.activity_flop_conf_data")
local activity_flop_giftbag_conf_data = require("data.activity_flop.activity_flop_giftbag_conf_data")
local item_data = require("data.item_data")
local activity_flop_condition_conf = require("data.activity_modules.activity_flop_condition_conf")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local component_manager = require("controller.component_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")

function ACTIVITY_OBJ_NEW.initFlop(arg_1_0)
	arg_1_0.FlopStat = {}
	arg_1_0.reset = false
end

function ACTIVITY_OBJ_NEW:getActivityFlopConf(arg_2_1)
	network:rpc("enter_flop_get_conf", {
		activityid = self._id
	}, function(arg_3_0)
		if arg_3_0.result == 1 then
			self:setCurFlopLevel(arg_3_0)
			self:setFlopTurns(arg_3_0.flop_turns)
			self:setResetEnable(arg_3_0.can_reset)
			self:setSkinList()

			self.flop_drop_suffix = arg_3_0.drop_suffix
			self.champion_itemid = arg_3_0.champion_itemid
			self.champion_itemnum = arg_3_0.champion_itemnum

			local var_3_0 = self:decodeFlopConf(arg_3_0)

			if arg_2_1 then
				arg_2_1(var_3_0)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLOP_CONF_UPDATE, var_3_0)
		elseif arg_3_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_EXPLORE_CLOSE)
		elseif arg_3_0.result == 3 then
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:setCurFlopLevel(arg_4_1)
	self.curFlopLevel = arg_4_1.flop_turns

	if arg_4_1.can_reset == true then
		self.curFlopLevel = self.curFlopLevel + 1
	end
end

function ACTIVITY_OBJ_NEW:getCurFlopLevel()
	return self.curFlopLevel
end

function ACTIVITY_OBJ_NEW:setActivityFlopResult(arg_6_1, arg_6_2)
	network:rpc("set_activity_flop_result", {
		activityid = self._id,
		pos = arg_6_1
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			self:deleteFlopTicket(arg_7_0.consumes)
			self:setChampionFlag(arg_7_0.droporder == self:getChampionOrder(), arg_6_1)
			self:setFlopCount(arg_7_0.flop_count)
			self:setResetEnable(arg_7_0.can_reset)

			local var_7_0 = {
				itemGain = {
					items = arg_7_0.items,
					gold = arg_7_0.gold,
					diamond = arg_7_0.diamond,
					itemformat = arg_7_0.itemformat
				},
				pos = arg_6_1,
				drawConf = self:getItemByOrder(arg_7_0.droporder),
				isChampion = arg_7_0.isChampion
			}

			if arg_7_0.isChampion == true then
				self.curFlopLevel = self.curFlopLevel + 1
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLOP_SET_RESULT, var_7_0)

			if arg_6_2 then
				arg_6_2(var_7_0)
			end
		elseif arg_7_0.result == 2 then
			global_ShowBlockWords(L_FLOP_WARNING[2])

			if arg_6_2 then
				arg_6_2()
			end
		elseif arg_7_0.result == 3 then
			global_ShowBlockWords(L_FLOP_WARNING[3])

			if arg_6_2 then
				arg_6_2()
			end
		elseif arg_7_0.result == 4 then
			global_ShowBlockWords(L_FLOP_WARNING[4])

			if arg_6_2 then
				arg_6_2()
			end
		elseif arg_7_0.result == 5 then
			global_ShowBlockWords(L_FLOP_WARNING[5])

			if arg_6_2 then
				arg_6_2()
			end
		elseif arg_7_0.result == 6 then
			global_ShowBlockWords(L_FLOP_WARNING[6])

			if arg_6_2 then
				arg_6_2()
			end
		end
	end)
end

function ACTIVITY_OBJ_NEW:decodeFlopConf(arg_8_1)
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.card_conf) do
		if iter_8_1.order == self:getChampionOrder() then
			self:setChampionFlag(true, iter_8_1.pos)
		end

		var_8_1["pos_" .. iter_8_1.pos] = self:getItemByOrder(iter_8_1.order)
	end

	self:setFlopCount(#arg_8_1.card_conf)

	return var_8_1
end

function ACTIVITY_OBJ_NEW:getChampionFlopItemAttr(arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in ipairs((drop_manager:getAllDropsNotMerge(activity_flop_conf_data[self._id .. "-1-1"]["dropid_" .. self:getChampionItem()]))) do
		if iter_9_1.dropid == arg_9_1 and iter_9_1.dropNum == arg_9_2 then
			return iter_9_1.item_attr
		end
	end
end

function ACTIVITY_OBJ_NEW:getFlopAwardAllByTurn()
	local var_10_0 = self:getMatrixConf()
	local var_10_1 = {}

	for iter_10_0 = 1, var_10_0 * var_10_0 do
		var_10_1["pos_" .. iter_10_0] = self:getItemByOrder(iter_10_0)
	end

	return var_10_1
end

function ACTIVITY_OBJ_NEW:getItemByOrder(arg_11_1)
	if arg_11_1 == self:getChampionOrder() and self.champion_itemid then
		return {
			itemNum = self.champion_itemnum,
			itemImg = item_data[self.champion_itemid].image_id,
			itemid = self.champion_itemid,
			item_attr = self:getChampionFlopItemAttr(self.champion_itemid, self.champion_itemnum)
		}
	end

	local var_11_0 = self:getFlopTurns()

	if var_11_0 > activity_flop_condition_conf[self._id].champion_special_turns then
		var_11_0 = activity_flop_condition_conf[self._id].champion_special_turns + 1
	end

	return self:getItemByDropid((self:getFlopDropid(var_11_0, arg_11_1)))
end

function ACTIVITY_OBJ_NEW:getItemByDropid(arg_12_1)
	local var_12_0, var_12_1, var_12_2, var_12_3 = self:getItemImage((drop_manager:getDropMsg(arg_12_1)))

	return {
		itemNum = var_12_0,
		itemImg = var_12_1,
		itemid = var_12_2,
		item_attr = var_12_3
	}
end

function ACTIVITY_OBJ_NEW.getItemImage(arg_13_0, arg_13_1)
	if arg_13_1.diamond and arg_13_1.diamond > 0 then
		itemid = "diamond"

		return arg_13_1.diamond, 1000000, itemid
	elseif arg_13_1.gold and arg_13_1.gold > 0 then
		itemid = "gold"

		return arg_13_1.gold, 1000001, itemid
	elseif arg_13_1.equips and next(arg_13_1.equips) then
		for iter_13_0, iter_13_1 in pairs(arg_13_1.equips) do
			local var_13_2 = iter_13_1.dropid

			return iter_13_1.dropNum, item_data[iter_13_1.dropid].bag_item_type == kITEM_COMPONENT and component_manager:getComponentImageId(var_13_2) or item_data[var_13_2].image_id, var_13_2, iter_13_1.item_attr
		end
	end
end

function ACTIVITY_OBJ_NEW:getChampionItem()
	return activity_flop_condition_conf[self._id].champion_item
end

function ACTIVITY_OBJ_NEW.canResetFlop(arg_15_0)
	return
end

function ACTIVITY_OBJ_NEW.deleteFlopTicket(arg_16_0, arg_16_1)
	if arg_16_1 then
		for iter_16_0, iter_16_1 in pairs(arg_16_1) do
			item_manager:deleteItem(iter_16_1.entityid, iter_16_1.num)
		end
	end
end

function ACTIVITY_OBJ_NEW:getFlopTicket()
	return activity_flop_condition_conf[self._id].one_time_cost, item_manager:getItemNumber(activity_flop_condition_conf[self._id].key_item), activity_flop_condition_conf[self._id].key_item, activity_flop_condition_conf[self._id].key_price, activity_flop_condition_conf[self._id].flop_buy_way
end

function ACTIVITY_OBJ_NEW:getFlopLimitBag(arg_18_1, arg_18_2)
	network:rpc("get_flop_limit_data", {
		activityid = self._id,
		activityType = arg_18_1
	}, function(arg_19_0)
		local var_19_0 = {}

		while activity_flop_giftbag_conf_data[self._id .. "-" .. arg_18_1 .. "-" .. 1] do
			table.insert(var_19_0, {
				currency = activity_flop_giftbag_conf_data[self._id .. "-" .. arg_18_1 .. "-" .. 1].currencytype,
				price = activity_flop_giftbag_conf_data[self._id .. "-" .. arg_18_1 .. "-" .. 1].price,
				itemid = activity_flop_giftbag_conf_data[self._id .. "-" .. arg_18_1 .. "-" .. 1].itemid
			})
		end

		LayerManager:pushInLayer("PopBuyPackageDirectLayer", {
			currencyData = var_19_0,
			limitData = arg_19_0.limitData,
			activityid = self._id
		})
	end)
end

function ACTIVITY_OBJ_NEW:buyFlopLimitBag(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	network:rpc("buy_flot_limit_item", {
		activityid = self._id,
		order = arg_20_1,
		buyNum = arg_20_2,
		activityType = arg_20_3
	}, function(arg_21_0)
		if arg_21_0.result == 1 then
			if arg_21_0.consumes then
				for iter_21_0, iter_21_1 in pairs(arg_21_0.consumes) do
					item_manager:deleteItem(iter_21_1.entityid, iter_21_1.num)
				end
			end

			if arg_21_0.costdiamond ~= 0 then
				playermodel.diamond = playermodel.diamond - arg_21_0.costdiamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
			end

			if arg_20_4 then
				arg_20_4(arg_21_0, arg_20_1)
			end
		elseif arg_21_0.result == 2 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[2])
		elseif arg_21_0.result == 3 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[3])
		elseif arg_21_0.result == 4 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[4])
		end
	end)
end

function ACTIVITY_OBJ_NEW:buyTicketItem(arg_22_1, arg_22_2)
	network:rpc("buy_key_item", {
		activityid = self._id,
		buyNum = arg_22_1
	}, function(arg_23_0)
		if arg_23_0.result == 1 then
			if arg_23_0.consumes then
				for iter_23_0, iter_23_1 in pairs(arg_23_0.consumes) do
					item_manager:deleteItem(iter_23_1.entityid, iter_23_1.num)
				end
			end

			if arg_23_0.diamond ~= 0 then
				item_manager:deleteItem(CURRENCY_DIAMOND, arg_23_0.diamond)
			end

			if arg_22_2 then
				arg_22_2(arg_23_0)
			end
		elseif arg_23_0.result == 2 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[2])
		elseif arg_23_0.result == 3 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[3])
		elseif arg_23_0.result == 4 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[4])
		end
	end)
end

function ACTIVITY_OBJ_NEW:goNextTurn(arg_24_1)
	local function var_24_0()
		network:rpc("go_next_turn", {
			activityid = self._id
		}, function(arg_26_0)
			if arg_26_0.result == 1 then
				self:setFlopTurns(arg_26_0.flop_turns)
				self:setResetEnable(arg_26_0.can_reset)

				self.championCardPos = nil

				local var_26_0 = self:decodeFlopConf(arg_26_0)

				var_26_0.is_reset = arg_26_0.is_reset
				self.champion_itemid = arg_26_0.champion_itemid
				self.champion_itemnum = arg_26_0.champion_itemnum

				if arg_24_1 then
					arg_24_1(var_26_0, arg_26_0.is_reset)
				end

				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLOP_CONF_UPDATE, var_26_0)
			elseif arg_26_0.result == 2 then
				global_ShowBlockWords(L_FLOP_RESET_WARNING[2])
			elseif arg_26_0.result == 3 then
				global_ShowBlockWords(L_FLOP_RESET_WARNING[3])
			elseif arg_26_0.result == 4 then
				global_ShowBlockWords(string.format(L_FLOP_RESET_WARNING[4], "$$$$$$$$$$$$$$$$$$$$"))
			end
		end)
	end

	if not self:getResetEnable() then
		global_ShowBlockWords(L_FLOP_RESET_WARNING[2])

		return
	elseif activity_flop_condition_conf[self._id].flop_limit_turns and self.flopTurns == activity_flop_condition_conf[self._id].flop_limit_turns then
		global_ShowBlockWords(L_FLOP_RESET_WARNING[3])

		return
	elseif activity_flop_condition_conf[self._id]["lock_turn_" .. self.flopTurns + 1] then
		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				title = L_FLOP_NEXT_TURN.title,
				des = L_FLOP_NEXT_TURN.des,
				button = L_FLOP_NEXT_TURN.button
			},
			surecallback = function()
				var_24_0()
			end
		})
	else
		var_24_0()
	end
end

function ACTIVITY_OBJ_NEW:goPreviousTurn(arg_28_1)
	network:rpc("go_previous_turn", {
		activityid = self._id
	}, function(arg_29_0)
		if arg_29_0.result == 1 then
			self:setFlopTurns(arg_29_0.flop_turns)
			self:setResetEnable(arg_29_0.can_reset)

			self.championCardPos = nil

			local var_29_0 = self:decodeFlopConf(arg_29_0)

			self.champion_itemid = nil
			self.champion_itemnum = nil

			if arg_28_1 then
				arg_28_1(var_29_0)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLOP_CONF_UPDATE, var_29_0)
		elseif arg_29_0.result == 2 then
			global_ShowBlockWords(L_FLOP_RESET_WARNING[2])
		elseif arg_29_0.result == 3 then
			global_ShowBlockWords(L_FLOP_RESET_WARNING[3])
		end
	end)
end

function ACTIVITY_OBJ_NEW:getFlopDropid(arg_30_1, arg_30_2)
	return (self.flop_drop_suffix or nil) and (activity_flop_conf_data[self._id .. "-" .. arg_30_1 .. "-1"]["dropid_" .. arg_30_2 .. "_" .. self.flop_drop_suffix] or activity_flop_conf_data[self._id .. "-" .. arg_30_1 .. "-1"]["dropid_" .. arg_30_2])
end

function ACTIVITY_OBJ_NEW:getDropConf()
	local var_31_0 = {}
	local var_31_1 = {}
	local var_31_3 = {}
	local var_31_4 = {}
	local var_31_5 = self:getMatrixConf()
	local var_31_6 = self:getFlopTurns()
	local var_31_7 = activity_flop_condition_conf[self._id].champion_item

	if var_31_6 > activity_flop_condition_conf[self._id].champion_special_turns then
		var_31_6 = activity_flop_condition_conf[self._id].champion_special_turns + 1
	end

	for iter_31_0 = 1, var_31_5 * var_31_5 do
		local var_31_8 = drop_manager:getDropMsg((self:getFlopDropid(var_31_6, iter_31_0)))
		local var_31_9

		if iter_31_0 ~= self:getChampionItem() then
			local var_31_10

			if var_31_8.gold ~= 0 then
				var_31_9 = "gold"
				var_31_10 = var_31_8.gold
				quality = 1
			elseif var_31_8.diamond ~= 0 then
				var_31_9 = "diamond"
				var_31_10 = var_31_8.diamond
				quality = 5
			elseif var_31_8.equips then
				for iter_31_1, iter_31_2 in pairs(var_31_8.equips) do
					var_31_9 = tostring(iter_31_2.dropid)
					var_31_10 = iter_31_2.dropNum
					quality = item_data[iter_31_2.dropid].equip_quality
				end
			end

			var_31_0[var_31_9] = (var_31_0[var_31_9] or 0) + nil
			var_31_1[var_31_9] = quality
		end
	end

	local var_31_11 = {}

	for iter_31_3, iter_31_4 in pairs(var_31_0) do
		table.insert(var_31_11, {
			itemid = (tonumber(iter_31_3) ~= nil or nil) and tonumber(iter_31_3),
			itemNum = iter_31_4,
			quality = var_31_1[iter_31_3]
		})
	end

	local var_31_13 = drop_manager:getDropMsg((self:getFlopDropid(var_31_6, self:getChampionItem())))
	local var_31_14
	local var_31_15
	local var_31_16

	if var_31_13.gold ~= 0 then
		var_31_14 = "gold"
		var_31_15 = var_31_13.gold
		var_31_16 = 1
	elseif var_31_13.diamond ~= 0 then
		var_31_14 = "diamond"
		var_31_15 = var_31_13.diamond
		var_31_16 = 5
	elseif var_31_13.equips then
		for iter_31_5, iter_31_6 in pairs(var_31_13.equips) do
			var_31_14 = tostring(iter_31_6.dropid)
			var_31_15 = iter_31_6.dropNum
			var_31_16 = item_data[iter_31_6.dropid].equip_quality
		end
	end

	if tonumber(var_31_14) ~= nil then
		var_31_14 = tonumber(var_31_14)
	end

	table.insert(var_31_11, {
		itemid = var_31_14,
		itemNum = var_31_15 or 0,
		quality = var_31_16
	})
	table.sort(var_31_11, function(arg_32_0, arg_32_1)
		return arg_32_0.quality > arg_32_1.quality
	end)

	var_31_3.attribute = 2
	var_31_3.content = var_31_11
	var_31_4.attribute = 3
	var_31_4.content = {}

	for iter_31_7 = 1, activity_flop_condition_conf[self._id].flop_limit_turns do
		local var_31_17 = iter_31_7
		local var_31_18

		if iter_31_7 > activity_flop_condition_conf[self._id].champion_special_turns + 1 then
			break
		else
			var_31_18 = var_31_17 == activity_flop_condition_conf[self._id].champion_special_turns + 1 and string.format(L_FLOP_TURNS_DOWN, iter_31_7) or string.format(L_FLOP_TURNS_IN_DETAILS, iter_31_7)
		end

		for iter_31_8, iter_31_9 in pairs((drop_manager:getAllDrops(self:getFlopDropid(var_31_17, var_31_7)))) do
			table.insert(var_31_4.content, {
				itemid = iter_31_9.dropid,
				itemNum = iter_31_9.dropNum,
				details = var_31_18,
				item_attr = iter_31_9.item_attr
			})
		end
	end

	local var_31_21 = {}

	table.insert(var_31_21, var_31_4)
	table.insert(var_31_21, var_31_3)
	print("droplist======", dump(var_31_21))

	return var_31_21
end

function ACTIVITY_OBJ_NEW.sortByQuality(arg_33_0, arg_33_1)
	if arg_33_1 and #arg_33_1 > 1 then
		table.sort(arg_33_1, function(arg_34_0, arg_34_1)
			if item_data[arg_34_0.itemid].equip_quality == item_data[arg_34_1.itemid].equip_quality then
				return arg_34_0.itemid < arg_34_1.itemid
			else
				return item_data[arg_34_0.itemid].equip_quality > item_data[arg_34_1.itemid].equip_quality
			end
		end)
	end
end

function ACTIVITY_OBJ_NEW:getFlopSkinData()
	local var_35_1 = self:getFlopTurns()
	local var_35_2 = 0
	local var_35_3 = 0
	local var_35_4 = false

	while activity_flop_condition_conf[self._id]["flop_skin_" .. var_35_3 + 1] do
		if var_35_1 <= activity_flop_condition_conf[self._id]["flop_skin_" .. var_35_3 + 1] then
			var_35_2 = activity_flop_condition_conf[self._id]["flop_skin_" .. var_35_3 + 1]
			var_35_3 = var_35_3 + 1

			break
		end

		var_35_3 = var_35_3 + 1
	end

	if var_35_2 == 0 then
		var_35_2 = activity_flop_condition_conf[self._id]["flop_skin_" .. var_35_3]
		var_35_4 = true
	end

	return self:getItemByDropid((self:getFlopDropid(var_35_2, (self:getChampionItem())))).itemid, var_35_3, var_35_4
end

function ACTIVITY_OBJ_NEW:getFlopFurniture()
	if not activity_flop_condition_conf[self._id].have_furniture then
		return
	end

	local var_36_0 = self:getFlopTurns()
	local var_36_1 = 1

	while activity_flop_condition_conf[self._id]["flop_furniture_" .. var_36_1] do
		if var_36_0 <= activity_flop_condition_conf[self._id]["flop_furniture_" .. var_36_1] then
			order = activity_flop_condition_conf[self._id]["flop_furniture_" .. var_36_1]
			var_36_1 = var_36_1 + 1

			break
		end

		var_36_1 = var_36_1 + 1
	end

	furnitureIndex = var_36_1 - 1

	if furnitureIndex - 1 > 0 then
		startTurn = activity_flop_condition_conf[self._id]["flop_furniture_" .. furnitureIndex - 1] + 1 or 1
	end

	endTurn = activity_flop_condition_conf[self._id]["flop_furniture_" .. furnitureIndex]

	return furnitureIndex, startTurn, endTurn
end

function ACTIVITY_OBJ_NEW:getMatrixConf()
	return activity_flop_condition_conf[self._id].matrix_line
end

function ACTIVITY_OBJ_NEW:getChampionOrder()
	return activity_flop_condition_conf[self._id].champion_item
end

function ACTIVITY_OBJ_NEW.setChampionFlag(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0.reset = arg_39_1

	if arg_39_1 then
		arg_39_0.championCardPos = arg_39_2
	end
end

function ACTIVITY_OBJ_NEW:getChampionCardPos()
	return self.championCardPos
end

function ACTIVITY_OBJ_NEW.setFlopCount(arg_41_0, arg_41_1)
	arg_41_0.flopCount = arg_41_1
end

function ACTIVITY_OBJ_NEW:getFlopCount()
	return self.flopCount
end

function ACTIVITY_OBJ_NEW.setFlopTurns(arg_43_0, arg_43_1)
	arg_43_0.flopTurns = arg_43_1
end

function ACTIVITY_OBJ_NEW:getFlopTurns()
	return self.flopTurns
end

function ACTIVITY_OBJ_NEW.setResetEnable(arg_45_0, arg_45_1)
	arg_45_0.is_champion = arg_45_1
end

function ACTIVITY_OBJ_NEW:getResetEnable()
	return self.is_champion
end

function ACTIVITY_OBJ_NEW:setSkinList()
	local var_47_0 = {}
	local var_47_1 = self:getFlopTurns()
	local var_47_2 = 0
	local var_47_3 = 1
	local var_47_4 = self:getChampionItem()

	while activity_flop_condition_conf[self._id]["flop_skin_" .. var_47_3] do
		table.insert(var_47_0, {
			itemid = self:getItemByDropid((self:getFlopDropid(activity_flop_condition_conf[self._id]["flop_skin_" .. var_47_3], var_47_4))).itemid
		})

		if var_47_1 < activity_flop_condition_conf[self._id]["flop_skin_" .. var_47_3] and var_47_2 ~= 0 then
			var_47_2 = var_47_3
		end

		var_47_3 = var_47_3 + 1
	end

	if var_47_2 == 0 then
		var_47_2 = var_47_3 - 1
	end

	self.skinAll = var_47_0
	self.skinShowid = var_47_2
end

function ACTIVITY_OBJ_NEW:getSkinid()
	local var_48_0 = self:getFlopTurns()
	local var_48_1 = 0

	while activity_flop_condition_conf[self._id]["flop_skin_" .. 1] do
		if var_48_0 <= activity_flop_condition_conf[self._id]["flop_skin_" .. 1] then
			var_48_1 = 1

			break
		end
	end

	if var_48_1 == 0 then
		var_48_1 = #self.skinAll
	end

	self.skinShowid = var_48_1

	return self.skinShowid
end

function ACTIVITY_OBJ_NEW:getSkinList()
	return self.skinAll
end

function ACTIVITY_OBJ_NEW:can_flop()
	if not activity_flop_condition_conf[self._id] then
		return false
	end

	local var_50_0, var_50_1, var_50_2 = self:getFlopTicket()
	local var_50_3 = self:getMatrixConf()
	local var_50_4 = self:getFlopTurns() or 1
	local var_50_5 = self:getFlopCount()

	if var_50_1 < var_50_0 then
		return false
	end

	if var_50_4 >= activity_flop_condition_conf[self._id].flop_limit_turns and var_50_5 == activity_flop_condition_conf[self._id].matrix_line * activity_flop_condition_conf[self._id].matrix_line then
		return false
	end

	return true
end

function ACTIVITY_OBJ_NEW:getFlopLimitTurns()
	return activity_flop_condition_conf[self._id].flop_limit_turns
end

function ACTIVITY_OBJ_NEW:canGoPreciouTurn()
	local var_52_0 = self:getFlopTurns()

	if var_52_0 == 1 then
		return false
	end

	if activity_flop_condition_conf[self._id]["lock_turn_" .. var_52_0] then
		return false
	end

	return true
end

return ACTIVITY_OBJ_NEW
