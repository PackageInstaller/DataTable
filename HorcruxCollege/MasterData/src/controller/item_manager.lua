local var_0_0 = {}
local component_manager = require("controller.component_manager")
local playermodel = require("model.playermodel")

ITEMDATA = require("data.item_data")

local var_0_3 = ITEMDATA
local major_factor_data = require("data.major_factor_data")
local network = require("network.network")
local var_0_6 = setmetatable({
	[kITEM_WEAPON] = 1,
	[kITEM_HORCRUX] = 2,
	[kITEM_COMPONENT] = 3,
	[kITEM_COMPONENT_CHIP] = 3,
	[kITEM_COMPONENT_BOX] = 3,
	[kITEM_FURNITURE] = 4,
	[kITEM_SKIN] = 4,
	[kITEM_GIFT_FOR_FRIEND] = 4,
	[kITEM_BASIC_MATRIAL] = 5,
	[kITEM_MATRIAL] = 5,
	[kITEM_DRAWING] = 5,
	[kITEM_HORCRUX_CHIP] = 5
}, {
	__index = function(arg_1_0, arg_1_1)
		return 6
	end
})

function var_0_0.init(arg_2_0)
	setmetatable(ITEMDATA, {
		__index = function(self, arg_3_1)
			if arg_3_1 then
				print("itemid is nil: " .. arg_3_1)
			end

			return self[100]
		end
	})
end

var_0_0:init()

local var_0_7 = {}

function var_0_0.registerPutItemCallback(arg_4_0, arg_4_1, arg_4_2)
	assert(var_0_7[arg_4_2] == nil, "该id已被注册")

	var_0_7[arg_4_2] = arg_4_1
end

function var_0_0.UnRegisterPutItemCallback(arg_5_0, arg_5_1)
	var_0_7[arg_5_1] = nil
end

function var_0_0.putItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	error("cant put item in client, use setItemByServerItem")
end

function var_0_0.can_stack(arg_7_0, arg_7_1)
	return arg_7_1 ~= kITEM_COMPONENT and arg_7_1 ~= kITEM_EATABLES and arg_7_1 ~= kITEM_HORCRUX and arg_7_1 ~= kITEM_WEAPON
end

function var_0_0.have_limit(arg_8_0, arg_8_1)
	return true
end

function var_0_0.get_bag_weight_id(arg_9_0, arg_9_1)
	return var_0_6[arg_9_1]
end

function var_0_0.is_full(arg_10_0, arg_10_1)
	return playermodel.bagweight[var_0_6[arg_10_1]].weight >= playermodel.bagweight[var_0_6[arg_10_1]].limit
end

function var_0_0.checkBagFullAlert(arg_11_0)
	local alert_manager = require("controller.alert_manager")

	if playermodel.bagweight and type(playermodel.bagweight) == "table" then
		for iter_11_0, iter_11_1 in pairs(playermodel.bagweight) do
			if iter_11_0 ~= 2 and iter_11_1.weight >= iter_11_1.limit and alert_manager:check_new_horcrux() == false then
				alert_manager:register_alert(ALERT_BAG)

				return
			end
		end

		alert_manager:unregister_alert(ALERT_BAG)
	end
end

function var_0_0:add_bag_weight(arg_12_1, arg_12_2)
	playermodel.bagweight[var_0_6[var_0_3[arg_12_1].bag_item_type]].weight = playermodel.bagweight[var_0_6[var_0_3[arg_12_1].bag_item_type]].weight + arg_12_2 * (var_0_3[arg_12_1].bagweight or 0)

	self:checkBagFullAlert()
end

function var_0_0:remove_bag_weight(arg_13_1, arg_13_2)
	playermodel.bagweight[var_0_6[var_0_3[arg_13_1].bag_item_type]].weight = playermodel.bagweight[var_0_6[var_0_3[arg_13_1].bag_item_type]].weight - arg_13_2 * (var_0_3[arg_13_1].bagweight or 0)

	self:checkBagFullAlert()
end

function var_0_0.getBagWeightStatus(arg_14_0, arg_14_1, arg_14_2)
	network:rpc("get_bag_content_status", {
		id = arg_14_1
	}, function(arg_15_0)
		if arg_14_2 then
			arg_14_2(arg_15_0.result, arg_15_0.content)
		end
	end)
end

function var_0_0.addMaxBagWeight(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1 = arg_16_1 or 1
	arg_16_2 = arg_16_2 or 1

	network:rpc("add_bag_content", {
		id = arg_16_1,
		buy_count = arg_16_2
	}, function(arg_17_0)
		if arg_17_0.result == 1 then
			playermodel.diamond = playermodel.diamond - arg_17_0.diamond

			global_update_gold_stone_diamond(nil, nil, arg_17_0.diamond)

			playermodel.bagweight[arg_16_1].limit = playermodel.bagweight[arg_16_1].limit + BAG_ADD_WEIGHT * arg_16_2

			AnalyticManager.buyBagWeightSuccess(arg_17_0.diamond)
			arg_16_0:checkBagFullAlert()

			if arg_16_3 then
				arg_16_3(1)
			end
		elseif arg_16_3 then
			arg_16_3(arg_17_0.result)
		end
	end)
end

function var_0_0:getItemNumber(arg_18_1)
	if self:can_stack(var_0_3[arg_18_1].bag_item_type) then
		if playermodel.items[arg_18_1] then
			return playermodel.items[arg_18_1].number
		else
			return 0
		end
	else
		local var_18_0 = 0

		for iter_18_0, iter_18_1 in pairs(playermodel.items) do
			if iter_18_1.itemid == arg_18_1 then
				var_18_0 = var_18_0 + 1
			end
		end

		return var_18_0
	end
end

function var_0_0.getItemNumberByEntityId(arg_19_0, arg_19_1)
	if playermodel.items[arg_19_1] then
		return playermodel.items[arg_19_1].number
	else
		return 0
	end
end

function var_0_0.isHaveEnoughItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2 = arg_20_2 or 1

	return playermodel.items[arg_20_1] and arg_20_2 <= playermodel.items[arg_20_1].number
end

function var_0_0.haveItem(arg_21_0, arg_21_1)
	return playermodel.items[arg_21_1] and playermodel.items[arg_21_1].number > 0
end

function var_0_0:deleteItem(arg_22_1, arg_22_2)
	arg_22_2 = arg_22_2 or 1

	if arg_22_2 <= 0 then
		return
	end

	playermodel.items[arg_22_1].number = playermodel.items[arg_22_1].number - arg_22_2

	self:remove_bag_weight(playermodel.items[arg_22_1].itemid, arg_22_2)

	if playermodel.items[arg_22_1].number <= 0 then
		playermodel.items[arg_22_1] = nil
	end

	if var_0_3[playermodel.items[arg_22_1].itemid].bag_item_type == kITEM_HORCRUX then
		require("controller.array_manager"):onHorcruxDecompose(arg_22_1)
	end
end

function var_0_0.filterItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if playermodel.items == nil then
		return
	end

	local function var_23_0(arg_24_0, arg_24_1)
		if type(arg_24_0) == "table" then
			for iter_24_0, iter_24_1 in pairs(arg_24_0) do
				if iter_24_1 == arg_24_1 then
					return true
				end
			end
		else
			return arg_24_0 == arg_24_1
		end

		return false
	end

	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(playermodel.items) do
		if (arg_23_1 == nil or var_23_0(arg_23_1, iter_23_1.itemtype)) and (arg_23_2 == nil or var_23_0(arg_23_2, var_0_3[iter_23_1.itemid].equip_quality)) and iter_23_1.number > 0 then
			var_23_1[#var_23_1 + 1] = iter_23_0
		end

		if arg_23_3 and #var_23_1 == arg_23_3 then
			break
		end
	end

	return var_23_1
end

function var_0_0.getItemByItemId(arg_25_0, arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(playermodel.items) do
		if (arg_25_1 == nil or arg_25_1 == iter_25_1.itemid) and iter_25_1.number > 0 then
			var_25_0[#var_25_0 + 1] = iter_25_0
		end
	end

	return var_25_0
end

function var_0_0.getItemByEquality(arg_26_0, arg_26_1)
	if playermodel.items == nil then
		return
	end

	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(playermodel.items) do
		if iter_26_1.itemtype == arg_26_1 and iter_26_1.number > 0 then
			table.insert(var_26_0, {
				id = iter_26_1.itemid,
				quality = var_0_3[iter_26_1.itemid].equip_quality
			})
		end
	end

	table.sort(var_26_0, function(arg_27_0, arg_27_1)
		if arg_27_0.quality == arg_27_1.quality then
			return arg_27_0.id > arg_27_1.id
		else
			return arg_27_0.quality > arg_27_1.quality
		end
	end)

	return var_26_0
end

function var_0_0.isHaveItemByType(arg_28_0, arg_28_1)
	if playermodel.items == nil then
		return
	end

	local var_28_0 = false

	for iter_28_0, iter_28_1 in pairs(playermodel.items) do
		if iter_28_1.itemtype == arg_28_1 and iter_28_1.number > 0 then
			var_28_0 = true

			break
		end
	end

	return var_28_0
end

function var_0_0.sortItemsByAttributes(arg_29_0, arg_29_1, ...)
	if arg_29_1 == nil then
		return
	end

	if playermodel.items == nil then
		return
	end

	local var_29_0 = {
		...
	}
	local var_29_1 = {}
	local var_29_2 = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_1) do
		var_29_2[#var_29_2 + 1] = {}
		var_29_2[#var_29_2 + 1].itemID = iter_29_1

		for iter_29_2 = 1, #var_29_0, 2 do
			var_29_2[#var_29_2 + 1][var_29_0[iter_29_2]] = var_0_3[playermodel.items[iter_29_1].itemid][var_29_0[iter_29_2]]
		end
	end

	table.sort(var_29_2, function(arg_30_0, arg_30_1)
		for iter_30_0 = 1, #var_29_0, 2 do
			if arg_30_0[var_29_0[iter_30_0]] ~= arg_30_1[var_29_0[iter_30_0]] then
				if var_29_0[iter_30_0 + 1] then
					return arg_30_0[var_29_0[iter_30_0]] < arg_30_1[var_29_0[iter_30_0]]
				else
					return arg_30_0[var_29_0[iter_30_0]] > arg_30_1[var_29_0[iter_30_0]]
				end
			end
		end

		return false
	end)

	for iter_29_3, iter_29_4 in pairs(var_29_2) do
		var_29_1[iter_29_3] = iter_29_4.itemID
	end

	return var_29_1
end

function var_0_0.topEquiped(arg_31_0, arg_31_1)
	local var_31_0 = {}
	local var_31_1 = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		if playermodel.items[iter_31_1].equiped then
			var_31_0[#var_31_0 + 1] = iter_31_1
		else
			var_31_1[#var_31_1 + 1] = iter_31_1
		end
	end

	for iter_31_2, iter_31_3 in pairs(var_31_1) do
		var_31_0[#var_31_0 + 1] = iter_31_3
	end

	return var_31_0
end

function var_0_0.findItem(arg_32_0, arg_32_1)
	return playermodel.items[arg_32_1]
end

function var_0_0:setItemByServerItem(arg_33_1)
	if arg_33_1.itemtype and arg_33_1.itemtype == 120 then
		return arg_33_1.itemcount
	end

	local var_33_0 = 0
	local var_33_1 = playermodel.items[arg_33_1.entityid]

	if playermodel.items[arg_33_1.entityid] then
		var_33_0 = arg_33_1.itemcount - var_33_1.number
	else
		var_33_1 = {}
		var_33_0 = arg_33_1.itemcount
	end

	var_33_1.entityid = arg_33_1.entityid
	var_33_1.itemid = arg_33_1.itemid
	var_33_1.itemtype = var_0_3[arg_33_1.itemid].bag_item_type
	var_33_1.number = arg_33_1.itemcount
	var_33_1.new = arg_33_1.new
	var_33_1.component_attr = arg_33_1.component_attr
	var_33_1.eatable_attr = arg_33_1.eatable_attr
	var_33_1.horcrux_attr = arg_33_1.horcrux_attr
	var_33_1.weapon_attr = arg_33_1.weapon_attr

	if var_33_1.itemtype == kITEM_MEDAL then
		self:addMedal(var_33_1.itemid)

		return 1
	end

	playermodel.items[arg_33_1.entityid] = var_33_1

	if var_33_1.itemtype == kITEM_HERO then
		playermodel:unlockSoul(var_0_3[var_33_1.itemid].servant, var_33_0)
		GlobalUpdateContractAttr()
		require("controller.alert_manager"):check_new_servant()
	end

	if var_33_1.itemtype == kITEM_WEAPON then
		require("controller.alert_manager"):check_weapon_update(true)
	end

	if var_33_1.itemtype == kITEM_COMPONENT then
		require("controller.alert_manager"):check_component_update(true)
	end

	if var_33_1.itemtype == kITEM_HORCRUX then
		require("controller.alert_manager"):check_new_horcrux()
	end

	require("controller.alert_manager"):check_servant_breakout(true)

	if var_33_1.itemid == 1749901 then
		require("controller.explore_manager"):unlockAirship(var_33_1.number)
	end

	if var_33_1.itemtype == kITEM_SKIN and var_33_1.number - var_33_0 == 0 then
		AnalyticManager.getNewDress({
			skin = var_33_1.itemid
		})
	end

	if var_33_1.itemtype == 207 then
		AnalyticManager.getspringfestivalword()
	end

	if var_33_1.itemid == BLACK_CARD then
		playermodel.haveblackcard = true
	end

	if var_33_1.itemid == kITEM_WEAPON_EXP then
		AlertManager:check_horcrux_strenghth()
	end

	if var_33_1.itemid == 6800101 and var_33_1.number >= 10 and var_33_1.number - var_33_0 < 10 then
		require("controller.alert_manager"):register_alert(ALERT_TWIST_TEN)
		RoleDefault:getInstance():setBoolForKey("TWIST_IS_TEN", true)
	end

	self:add_bag_weight(var_33_1.itemid, var_33_0)

	if var_33_1.itemtype ~= kITEM_HORCRUX and var_0_3[var_33_1.itemid].bagweight and var_0_3[var_33_1.itemid].bagweight > 0 and self:is_full(var_33_1.itemtype) then
		global_ShowBlockWords(L_BAG_SET_ITEM_OVER_WEIGHT)
	end

	GuideListener.triggerGuide(TRIGGER_GETITEM, var_33_1.itemtype)
	GuideListener.triggerGuide(TRIGGER_GETITEM_BY_ID, var_33_1.itemid)

	return var_33_0
end

function var_0_0.sell_item_batch(arg_34_0, arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in pairs(arg_34_1) do
		if playermodel.items[iter_34_1.entityid].component_attr and playermodel.items[iter_34_1.entityid].component_attr.lock then
			global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.Lock)

			return
		elseif playermodel.items[iter_34_1.entityid].component_attr and playermodel.items[iter_34_1.entityid].component_attr.use then
			global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.Using)

			return
		end
	end

	network:rpc("sell_item_batch", {
		entityids = arg_34_1
	}, function(arg_35_0)
		if arg_35_0.result == 1 then
			if arg_34_2 then
				for iter_35_0, iter_35_1 in pairs(arg_35_0.successes) do
					arg_34_0:deleteItem(iter_35_1.entityid, iter_35_1.number)
				end

				if arg_35_0.gold then
					playermodel.gold = playermodel.gold + arg_35_0.gold
				end

				global_update_gold_stone_diamond(arg_35_0.gold, nil, nil, true)
				arg_34_2(arg_35_0.gold)
			end

			local alert_manager = require("controller.alert_manager")

			alert_manager:check_servant_breakout(false)
			alert_manager:check_horcrux_strenghth(false)
			AnalyticManager.sellItemInBag(arg_35_0.gold)
		else
			global_ShowBlockWords(L_SOLD_FAIL)
		end
	end)
end

function var_0_0.sell_item(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	network:rpc("sell_item", {
		entityid = arg_36_1,
		num = arg_36_2
	}, function(arg_37_0)
		if arg_37_0.result == 0 then
			cclog("???, NO entityid")
		elseif arg_37_0.result == 2 then
			cclog("没有此物品")
		elseif arg_37_0.result == 3 then
			cclog("数量没有那么多")
		elseif arg_37_0.result == 3 then
			cclog("此物品没有出售价格")
		elseif arg_37_0.result == 1 then
			if arg_36_3 then
				arg_36_0:deleteItem(arg_36_1, arg_37_0.costnum)

				if arg_37_0.gold then
					playermodel.gold = playermodel.gold + arg_37_0.gold
				end

				global_update_gold_stone_diamond(arg_37_0.gold, nil, nil, true)
				arg_36_3(arg_37_0.gold)
			end

			AnalyticManager.sellItemInBag(arg_37_0.gold)
		end
	end)
end

function var_0_0.filterSortItems(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {
		[kITEM_COMPONENT] = function(arg_39_0)
			return (arg_38_0:sortComponentsByType(component_manager:filterComponent(arg_39_0), arg_39_0.sortType, arg_39_0.orderType))
		end,
		[kITEM_WEAPON] = function(arg_40_0)
			return require("controller.weapon_manager"):filterSortWeapons(arg_40_0)
		end,
		[kITEM_MEDAL] = function()
			local var_41_0 = {}
			local var_41_1 = arg_38_2.pos == 1 and {
				2,
				3
			} or arg_38_2.pos == 2 and {
				1,
				3
			} or arg_38_2.pos == 3 and {
				1,
				2
			}

			for iter_41_0, iter_41_1 in pairs(playermodel.items) do
				if var_0_3[iter_41_1.itemid].bag_item_type == arg_38_1 and playermodel.cur_medal[var_41_1[1]] ~= iter_41_1.itemid and playermodel.cur_medal[var_41_1[2]] ~= iter_41_1.itemid and (not choose_quality or choose_quality[var_0_3[iter_41_1.itemid].equip_quality]) then
					table.insert(var_41_0, iter_41_1.entityid)
				end
			end

			table.sort(var_41_0, function(arg_42_0, arg_42_1)
				return arg_42_0 < arg_42_1
			end)

			return var_41_0
		end,
		[kITEM_FURNITURE] = function(arg_43_0)
			return require("controller.dormitory_manager"):filterSortFurniture(arg_43_0)
		end
	}

	if var_38_0[arg_38_1] then
		return var_38_0[arg_38_1](arg_38_2)
	else
		return (function(arg_44_0, arg_44_1)
			local var_44_0
			local var_44_1

			if arg_44_1.quality and next(arg_44_1.quality) ~= nil then
				var_44_0 = {}

				for iter_44_0, iter_44_1 in pairs(arg_44_1.quality) do
					var_44_0[iter_44_1] = true
				end
			end

			if arg_44_1.hurtType and next(arg_44_1.hurtType) ~= nil then
				var_44_1 = {}

				for iter_44_2, iter_44_3 in pairs(arg_44_1.hurtType) do
					var_44_1[iter_44_3] = true
				end
			end

			local var_44_2 = {}

			for iter_44_4, iter_44_5 in pairs(playermodel.items) do
				if var_0_3[iter_44_5.itemid].bag_item_type == arg_44_0 and (not var_44_0 or var_44_0[var_0_3[iter_44_5.itemid].equip_quality]) and (not var_44_1 or var_44_1[var_0_3[iter_44_5.itemid].mechanical_or_energy]) then
					table.insert(var_44_2, iter_44_5.itemid)
				end
			end

			local var_44_3 = {
				{
					str = "quality",
					weight = 2,
					func = function(arg_45_0, arg_45_1)
						if var_0_3[arg_45_0].equip_quality == var_0_3[arg_45_1].equip_quality then
							return "=="
						end

						if arg_44_1.orderType == 0 then
							return var_0_3[arg_45_0].equip_quality < var_0_3[arg_45_1].equip_quality
						elseif arg_44_1.orderType == 1 then
							return var_0_3[arg_45_0].equip_quality > var_0_3[arg_45_1].equip_quality
						end
					end
				},
				{
					str = "number",
					weight = 2,
					func = function(arg_46_0, arg_46_1)
						if playermodel.items[arg_46_0].number == playermodel.items[arg_46_1].number then
							return "=="
						end

						if arg_44_1.orderType == 0 then
							return playermodel.items[arg_46_0].number < playermodel.items[arg_46_1].number
						elseif arg_44_1.orderType == 1 then
							return playermodel.items[arg_46_0].number > playermodel.items[arg_46_1].number
						end
					end
				}
			}

			for iter_44_6, iter_44_7 in pairs(var_44_3) do
				if iter_44_7.str == arg_44_1.sortType then
					var_44_3[iter_44_6].weight = var_44_3[iter_44_6].weight + 1
				end
			end

			table.sort(var_44_3, function(arg_47_0, arg_47_1)
				return arg_47_0.weight > arg_47_1.weight
			end)
			table.sort(var_44_2, function(arg_48_0, arg_48_1)
				for iter_48_0 = 1, 2 do
					if var_44_3[iter_48_0].func(arg_48_0, arg_48_1) ~= "==" then
						return var_44_3[iter_48_0].func(arg_48_0, arg_48_1)
					end

					if iter_48_0 == #var_44_3 then
						return false
					end
				end
			end)

			return var_44_2
		end)(arg_38_1, arg_38_2)
	end
end

function var_0_0:setShowMedal(arg_49_1, arg_49_2)
	if arg_49_1.medal and not self:haveMedal(arg_49_1.medal) then
		if arg_49_2 then
			arg_49_2(2)
		end

		return
	end

	for iter_49_0, iter_49_1 in pairs(playermodel.cur_medal) do
		if iter_49_1 and iter_49_1 == arg_49_1.medal then
			if arg_49_2 then
				arg_49_2(3)
			end

			return
		end
	end

	network:rpc("set_show_medal", arg_49_1, function(arg_50_0)
		playermodel.cur_medal[arg_49_1.pos] = arg_49_1.medal

		AnalyticManager.setShowMedal(arg_49_1.medal)

		if arg_49_2 then
			arg_49_2(arg_50_0.result)
		end
	end)
end

function var_0_0.addMedal(arg_51_0, arg_51_1)
	if not var_0_3[arg_51_1].order then
		return
	end

	local var_51_0 = math.floor((var_0_3[arg_51_1].order - 1) / 30) + 1

	for iter_51_0 = 1, var_51_0 do
		playermodel.medalsCoding[iter_51_0] = playermodel.medalsCoding[iter_51_0] or 0
	end

	playermodel.medalsCoding[var_51_0] = require("bit").bor(playermodel.medalsCoding[var_51_0], 2^((var_0_3[arg_51_1].order - 1) % 30 + 1 - 1))
end

function var_0_0.haveMedal(arg_52_0, arg_52_1)
	local bit = require("bit")

	if not var_0_3[arg_52_1].order then
		return
	end

	local var_52_1 = math.floor((var_0_3[arg_52_1].order - 1) / 30) + 1
	local var_52_2 = 2^((var_0_3[arg_52_1].order - 1) % 30 + 1 - 1)

	for iter_52_0 = 1, var_52_1 do
		playermodel.medalsCoding[iter_52_0] = playermodel.medalsCoding[iter_52_0] or 0
	end

	return bit.band(playermodel.medalsCoding[var_52_1], var_52_2) > 0
end

function var_0_0:getAllHavedMedals()
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs((require("data.medal_index_data"))) do
		if self:haveMedal(iter_53_1.medalid) then
			table.insert(var_53_0, iter_53_1.medalid)
		end
	end

	table.sort(var_53_0, function(arg_54_0, arg_54_1)
		if var_0_3[arg_54_0].equip_quality == var_0_3[arg_54_1].equip_quality then
			return var_0_3[arg_54_0].id > var_0_3[arg_54_1].id
		else
			return var_0_3[arg_54_0].equip_quality > var_0_3[arg_54_1].equip_quality
		end
	end)

	return var_53_0
end

function var_0_0.filterSoulFightDress(arg_55_0, arg_55_1)
	local var_55_0 = {}

	while major_factor_data[arg_55_1]["fight_model" .. 1] do
		var_55_0[1] = major_factor_data[arg_55_1]["fight_model" .. 1]
	end

	return var_55_0
end

function var_0_0.filterFoodByType(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in pairs(arg_56_1) do
		for iter_56_2, iter_56_3 in pairs(arg_56_2) do
			if var_0_3[playermodel.items[iter_56_1].itemid].m_type and var_0_3[playermodel.items[iter_56_1].itemid].m_type == iter_56_3 then
				table.insert(var_56_0, iter_56_1)

				break
			end
		end
	end

	return var_56_0
end

function var_0_0.getEatableScore(arg_57_0, arg_57_1)
	if not playermodel.items[arg_57_1] then
		return 100
	end

	local var_57_0 = playermodel.items[arg_57_1]

	if not playermodel.items[arg_57_1].eatable_attr then
		return 100
	end

	return math.floor((var_57_0.eatable_attr.color + var_57_0.eatable_attr.smell + var_57_0.eatable_attr.taste) / (var_0_3[var_57_0.itemid].max_color + var_0_3[var_57_0.itemid].max_taste + var_0_3[var_57_0.itemid].max_smell) * 1000 + 0.5) / 10
end

function var_0_0.sortFoodByType(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	local var_58_0 = {
		[4] = {
			weight = 1,
			func = function(arg_59_0, arg_59_1)
				if arg_58_3 == 0 then
					return arg_59_0 < arg_59_1
				else
					return arg_59_1 < arg_59_0
				end
			end
		},
		[2] = {
			weight = 3,
			func = function(arg_60_0, arg_60_1)
				local dormitory_manager = require("controller.dormitory_manager")
				local var_60_1 = playermodel.items[arg_60_1].itemid
				local var_60_2

				if var_0_3[playermodel.items[arg_60_0].itemid].bag_item_type == kITEM_FURNITURE then
					var_60_2 = dormitory_manager:getLeftoverFurniture(playermodel.items[arg_60_0].itemid) or arg_58_0:getItemNumber(playermodel.items[arg_60_0].itemid)

					local var_60_3

					if var_0_3[var_60_1].bag_item_type == kITEM_FURNITURE then
						var_60_3 = dormitory_manager:getLeftoverFurniture(var_60_1) or arg_58_0:getItemNumber(var_60_1)

						if var_60_2 == var_60_3 then
							return "=="
						elseif arg_58_3 == 0 then
							return var_60_2 < var_60_3
						end
					end
				end

				return var_60_3 < var_60_2
			end
		},
		{
			weight = 4,
			func = function(arg_61_0, arg_61_1)
				local var_61_0 = playermodel.items[arg_61_0].itemid
				local var_61_1 = playermodel.items[arg_61_1].itemid

				if var_0_3[playermodel.items[arg_61_0].itemid].equip_quality == var_0_3[playermodel.items[arg_61_1].itemid].equip_quality then
					return "=="
				elseif arg_58_3 == 0 then
					return var_0_3[var_61_0].equip_quality < var_0_3[var_61_1].equip_quality
				else
					return var_0_3[var_61_0].equip_quality > var_0_3[var_61_1].equip_quality
				end
			end
		},
		[3] = {
			weight = 2,
			func = function(arg_62_0, arg_62_1)
				local var_62_0 = playermodel.items[arg_62_0].itemid
				local var_62_1 = playermodel.items[arg_62_1].itemid

				if var_0_3[playermodel.items[arg_62_0].itemid].sale_price == var_0_3[playermodel.items[arg_62_1].itemid].sale_price then
					return "=="
				elseif arg_58_3 == 0 then
					return var_0_3[var_62_0].sale_price < var_0_3[var_62_1].sale_price
				else
					return var_0_3[var_62_0].sale_price > var_0_3[var_62_1].sale_price
				end
			end
		}
	}

	var_58_0[arg_58_2].weight = var_58_0[arg_58_2].weight + 10

	table.sort(var_58_0, function(arg_63_0, arg_63_1)
		return arg_63_0.weight > arg_63_1.weight
	end)
	table.sort(arg_58_1, function(arg_64_0, arg_64_1)
		for iter_64_0 = 1, 4 do
			if var_58_0[iter_64_0].func(arg_64_0, arg_64_1) ~= "==" then
				return var_58_0[iter_64_0].func(arg_64_0, arg_64_1)
			end
		end
	end)

	return arg_58_1
end

function var_0_0.filterComponent(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = {}

	for iter_65_0, iter_65_1 in pairs(arg_65_1) do
		for iter_65_2, iter_65_3 in pairs(arg_65_2) do
			if iter_65_3 == var_0_3[playermodel.items[iter_65_1].itemid].equip_condition then
				table.insert(var_65_0, iter_65_1)

				break
			end
		end
	end

	return var_65_0
end

function var_0_0.filterLock(arg_66_0, arg_66_1)
	local var_66_0 = {}

	for iter_66_0, iter_66_1 in pairs(arg_66_1) do
		if playermodel.items[iter_66_1] and not playermodel.items[iter_66_1].component_attr.use then
			table.insert(var_66_0, iter_66_1)
		end
	end

	return var_66_0
end

function var_0_0.filterComponentBySuit(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0 = {}

	for iter_67_0, iter_67_1 in pairs(arg_67_1) do
		for iter_67_2, iter_67_3 in pairs(arg_67_2) do
			if iter_67_3 == playermodel.items[iter_67_1].component_attr.effect then
				table.insert(var_67_0, iter_67_1)
			end
		end
	end

	return var_67_0
end

function var_0_0.sortComponentsByType(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = {
		[6] = {
			weight = 1,
			func = function(arg_69_0, arg_69_1)
				if arg_68_3 == 0 then
					return arg_69_0 < arg_69_1
				else
					return arg_69_1 < arg_69_0
				end
			end
		},
		[5] = {
			weight = 2,
			func = function(arg_74_0, arg_74_1)
				local var_74_0 = playermodel.items[arg_74_0].itemid
				local var_74_1 = playermodel.items[arg_74_1].itemid

				if var_0_3[playermodel.items[arg_74_0].itemid].equip_condition == var_0_3[playermodel.items[arg_74_1].itemid].equip_condition then
					return "=="
				elseif arg_68_3 == 0 then
					return var_0_3[var_74_0].equip_condition < var_0_3[var_74_1].equip_condition
				else
					return var_0_3[var_74_0].equip_condition > var_0_3[var_74_1].equip_condition
				end
			end
		},
		[4] = {
			weight = 3,
			func = function(arg_73_0, arg_73_1)
				local var_73_0 = playermodel.items[arg_73_0].itemid
				local var_73_1 = playermodel.items[arg_73_1].itemid

				if var_0_3[playermodel.items[arg_73_0].itemid].pos == var_0_3[playermodel.items[arg_73_1].itemid].pos then
					return "=="
				elseif arg_68_3 == 0 then
					return var_0_3[var_73_0].pos < var_0_3[var_73_1].pos
				else
					return var_0_3[var_73_0].pos > var_0_3[var_73_1].pos
				end
			end
		},
		[3] = {
			weight = 4,
			func = function(arg_70_0, arg_70_1)
				local var_70_0 = playermodel.items[arg_70_0].entityid
				local var_70_1 = playermodel.items[arg_70_1].entityid

				if component_manager:getExtraPoint(playermodel.items[arg_70_0].entityid) == component_manager:getExtraPoint(playermodel.items[arg_70_1].entityid) then
					return "=="
				elseif arg_68_3 == 0 then
					return component_manager:getExtraPoint(var_70_0) < component_manager:getExtraPoint(var_70_1)
				else
					return component_manager:getExtraPoint(var_70_0) > component_manager:getExtraPoint(var_70_1)
				end
			end
		},
		[2] = {
			weight = 5,
			func = function(arg_71_0, arg_71_1)
				local var_71_0 = playermodel.items[arg_71_0].itemid
				local var_71_1 = playermodel.items[arg_71_1].itemid

				if var_0_3[playermodel.items[arg_71_0].itemid].equip_quality == var_0_3[playermodel.items[arg_71_1].itemid].equip_quality then
					return "=="
				elseif arg_68_3 == 0 then
					return var_0_3[var_71_0].equip_quality < var_0_3[var_71_1].equip_quality
				else
					return var_0_3[var_71_0].equip_quality > var_0_3[var_71_1].equip_quality
				end
			end
		},
		{
			weight = 6,
			func = function(arg_72_0, arg_72_1)
				local var_72_0 = playermodel.items[arg_72_0].itemid
				local var_72_1 = playermodel.items[arg_72_1].itemid

				if var_0_3[playermodel.items[arg_72_0].itemid].rank == var_0_3[playermodel.items[arg_72_1].itemid].rank then
					return "=="
				elseif arg_68_3 == 0 then
					return var_0_3[var_72_0].rank < var_0_3[var_72_1].rank
				else
					return var_0_3[var_72_0].rank > var_0_3[var_72_1].rank
				end
			end
		}
	}

	var_68_0[arg_68_2].weight = var_68_0[arg_68_2].weight + 10

	table.sort(var_68_0, function(arg_75_0, arg_75_1)
		return arg_75_0.weight > arg_75_1.weight
	end)
	table.sort(arg_68_1, function(arg_76_0, arg_76_1)
		for iter_76_0 = 1, 6 do
			if var_68_0[iter_76_0].func(arg_76_0, arg_76_1) ~= "==" then
				return var_68_0[iter_76_0].func(arg_76_0, arg_76_1)
			end
		end
	end)

	return arg_68_1
end

function var_0_0.sortResourceByType(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	local var_77_0 = {
		[3] = {
			weight = 1,
			func = function(arg_78_0, arg_78_1)
				if arg_77_3 == 0 then
					return arg_78_0 < arg_78_1
				else
					return arg_78_1 < arg_78_0
				end
			end
		},
		[2] = {
			weight = 2,
			func = function(arg_79_0, arg_79_1)
				local var_79_0 = playermodel.items[arg_79_0].itemid
				local var_79_1 = playermodel.items[arg_79_1].itemid

				if arg_77_0:getItemNumber(playermodel.items[arg_79_0].itemid) == arg_77_0:getItemNumber(playermodel.items[arg_79_1].itemid) then
					return "=="
				elseif arg_77_3 == 0 then
					return arg_77_0:getItemNumber(var_79_0) < arg_77_0:getItemNumber(var_79_1)
				else
					return arg_77_0:getItemNumber(var_79_0) > arg_77_0:getItemNumber(var_79_1)
				end
			end
		},
		{
			weight = 3,
			func = function(arg_80_0, arg_80_1)
				local var_80_0 = playermodel.items[arg_80_0].itemid
				local var_80_1 = playermodel.items[arg_80_1].itemid

				if var_0_3[playermodel.items[arg_80_0].itemid].equip_quality == var_0_3[playermodel.items[arg_80_1].itemid].equip_quality then
					return "=="
				elseif arg_77_3 == 0 then
					return var_0_3[var_80_0].equip_quality < var_0_3[var_80_1].equip_quality
				else
					return var_0_3[var_80_0].equip_quality > var_0_3[var_80_1].equip_quality
				end
			end
		}
	}

	var_77_0[arg_77_2].weight = var_77_0[arg_77_2].weight + 10

	table.sort(var_77_0, function(arg_81_0, arg_81_1)
		return arg_81_0.weight > arg_81_1.weight
	end)
	table.sort(arg_77_1, function(arg_82_0, arg_82_1)
		for iter_82_0 = 1, 3 do
			if var_77_0[iter_82_0].func(arg_82_0, arg_82_1) ~= "==" then
				return var_77_0[iter_82_0].func(arg_82_0, arg_82_1)
			end
		end
	end)

	return arg_77_1
end

function var_0_0.playerOpenNewItem(arg_83_0, arg_83_1)
	if not playermodel.items[arg_83_1] then
		return
	end

	if not playermodel.items[arg_83_1].new then
		return
	end

	playermodel.items[arg_83_1].new = nil

	network:rpc("player_open_new_item", {
		entityid = arg_83_1
	})
end

local function var_0_8(arg_84_0)
	return ({
		[KITEM_BARRAGE_GIFT] = true,
		[KITEM_COUPONS] = true,
		[kITEM_ACTIVITY] = true,
		[kITEM_AWARD_TICKET] = true
	})[arg_84_0]
end

function var_0_0.trans_overdue_item(arg_85_0, arg_85_1)
	local time_check_manager = require("controller.time_check_manager")
	local var_85_1 = false

	for iter_85_0, iter_85_1 in pairs(playermodel.items) do
		if var_0_3[iter_85_1.itemid].overdue_trans_itemid and var_0_3[iter_85_1.itemid].overdue_time and var_0_8(var_0_3[iter_85_1.itemid].bag_item_type) and time_check_manager:getCurTime() > os.time(parse_time(var_0_3[iter_85_1.itemid].overdue_time)) then
			var_85_1 = true

			break
		end
	end

	if not var_85_1 and arg_85_1 then
		arg_85_1({
			result = 3
		})
	end

	network:rpc("trans_overdue_item", {}, function(arg_86_0)
		if arg_86_0.result == 1 then
			local var_86_0 = {
				result = 1
			}

			if arg_86_0.consumes then
				for iter_86_0, iter_86_1 in ipairs(arg_86_0.consumes) do
					var_0_0:deleteItem(iter_86_1.entityid, iter_86_1.num)
				end

				var_86_0.consumes = arg_86_0.consumes
			end

			if arg_86_0.items then
				local var_86_1, var_86_2, var_86_3, var_86_4, var_86_5 = global_get({
					items = arg_86_0.items
				})

				var_86_0.items = var_86_5
			end

			if arg_85_1 then
				arg_85_1(var_86_0)
			end
		end
	end)
end

function var_0_0.open_choosegift(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4)
	if arg_87_3 > var_0_0:getItemNumber(arg_87_1) then
		global_ShowBlockWords(L_MARKET_MSG.Item_Lack)

		if arg_87_4 then
			arg_87_4({
				result = 2
			})
		end
	end

	network:rpc("open_choosegift", {
		entityid = arg_87_1,
		select = arg_87_2,
		num = arg_87_3
	}, function(arg_88_0)
		if arg_88_0.result == 1 then
			if arg_88_0.consumes then
				for iter_88_0, iter_88_1 in ipairs(arg_88_0.consumes) do
					var_0_0:deleteItem(iter_88_1.entityid, iter_88_1.num)
				end
			end

			global_gain(arg_88_0)
		elseif arg_88_0.result == 2 then
			global_ShowBlockWords(L_MARKET_MSG.Item_Lack)
		elseif arg_88_0.result == 3 then
			global_ShowBlockWords("服务端物品表没有:" .. arg_87_1)
		elseif arg_88_0.result == 4 then
			global_ShowBlockWords("服务端物品类型不对,应该为33")
		elseif arg_88_0.result == 5 then
			global_ShowBlockWords("物品:" .. arg_87_1 .. "没填choosegift_group")
		elseif arg_88_0.result == 6 then
			global_ShowBlockWords("物品:" .. arg_87_1 .. "的choosegift_group在choosegift_data找不到")
		elseif arg_88_0.result == 7 then
			global_ShowBlockWords("choosegift_data中找不到dropid_" .. arg_87_2)
		elseif arg_88_0.result == 8 then
			global_ShowBlockWords("choosegift_data的dropid_" .. arg_87_2 .. "在掉落表里找不到")
		end

		if arg_87_4 then
			arg_87_4(arg_88_0)
		end
	end)
end

function var_0_0:compound_item(arg_89_1, arg_89_2, arg_89_3)
	if not var_0_3[arg_89_1].compound_consume or not var_0_3[arg_89_1].mode_id then
		if arg_89_3 then
			arg_89_3(4)
		end

		return
	end

	if not self:isHaveEnoughItem(arg_89_1, arg_89_2) then
		if arg_89_3 then
			arg_89_3(3)
		end

		return
	end

	network:rpc("compound_item", {
		itemid = arg_89_1,
		num = arg_89_2
	}, function(arg_90_0)
		if arg_90_0.result == 1 then
			self:deleteItem(arg_89_1, arg_90_0.consume)

			if arg_89_3 then
				arg_89_3(1, arg_90_0.items, arg_90_0.consume)
			end
		elseif arg_89_3 then
			arg_89_3(arg_90_0.result)
		end
	end)
end

function var_0_0.getServantChipInfo(arg_91_0, arg_91_1)
	if var_0_3[arg_91_1].bag_item_type ~= kITEM_SERVANT_CHIP then
		return ""
	end

	return (string.format(L_SERVANT_COMPOSE, var_0_3[arg_91_1].compound_consume))
end

return var_0_0
