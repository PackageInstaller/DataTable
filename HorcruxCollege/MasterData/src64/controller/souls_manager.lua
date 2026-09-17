local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local servant_data = require("data.servant_data")
local servant_advance_data = require("data.servant.servant_advance_data")

L_SERVANT_ADVANCE_LOG = {
	nil,
	"共振未满级",
	"稀有度已满级",
	"进阶表中没填数据",
	"材料不足"
}

function var_0_0.servant_advance(arg_1_0, arg_1_1, arg_1_2)
	network:rpc("servant_advance", {
		servantid = arg_1_1
	}, function(arg_2_0)
		if arg_2_0.result ~= 1 then
			cclog(L_SERVANT_ADVANCE_LOG[arg_2_0.result])
			global_ShowBlockWords(L_SERVANT_ADVANCE_ERROR[arg_2_0.result])

			if arg_1_2 then
				arg_1_2(arg_2_0)
			end

			return
		end

		if arg_2_0.consumes then
			for iter_2_0, iter_2_1 in pairs(arg_2_0.consumes) do
				item_manager:deleteItem(iter_2_1.entityid, iter_2_1.num)
			end
		end

		playermodel.addRollRarity[arg_1_1] = playermodel.addRollRarity[arg_1_1] + 1
		playermodel.soulContract[arg_1_1] = 0

		if arg_1_2 then
			arg_1_2(arg_2_0)
		end

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
	end)
end

function var_0_0:get_total_contract(arg_3_1)
	return (self:get_servant_cur_roll_rarity(arg_3_1) - self:get_servant_initial_roll_rarity(arg_3_1)) * 5 + playermodel.soulContract[arg_3_1]
end

function var_0_0.get_servant_initial_roll_rarity(arg_4_0, arg_4_1)
	return servant_data[arg_4_1].roll_rarity
end

function var_0_0:get_servant_cur_roll_rarity(arg_5_1, arg_5_2)
	local var_5_0 = self:get_servant_initial_roll_rarity(arg_5_1)
	local var_5_1

	if arg_5_2 then
		var_5_1 = var_5_0 + arg_5_2 or var_5_0 + playermodel.addRollRarity[arg_5_1]

		if var_5_1 > 5 then
			var_5_1 = 5

			assert(not config._DEBUG, "BUG BUG BUG:怎么有角色稀有度大于5了??????")
		end
	end

	return var_5_1
end

function var_0_0:get_roll_rarity_str(arg_6_1, arg_6_2)
	local var_6_0 = self:get_servant_initial_roll_rarity(arg_6_1)
	local var_6_1

	if arg_6_2 then
		var_6_1 = arg_6_2 + var_6_0 or self:get_servant_cur_roll_rarity(arg_6_1)

		if var_6_1 > 5 then
			var_6_1 = 5

			assert(not config._DEBUG, "BUG BUG BUG:怎么有角色稀有度大于5了??????")
		end

		if var_6_0 == var_6_1 then
			return ""
		end
	end

	return "_" .. tostring(RARITY_STR_TBL[var_6_1])
end

function var_0_0:get_add_damage_factor(arg_7_1)
	if playermodel.soulContract[arg_7_1] == 0 then
		local var_7_0 = self:get_servant_cur_roll_rarity(arg_7_1) - 1

		return servant_data[arg_7_1]["damageFactorPlus" .. 5 .. (self:get_servant_initial_roll_rarity(arg_7_1) == var_7_0 and "" or "_" .. RARITY_STR_TBL[var_7_0])] or 0
	else
		local var_7_2 = servant_data[arg_7_1]["damageFactorPlus" .. playermodel.soulContract[arg_7_1] .. self:get_roll_rarity_str(arg_7_1)]

		var_7_2 = var_7_2 or 0

		return var_7_2
	end
end

function var_0_0:get_add_damage_factor_for_pvp(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 == 0 then
		arg_8_3 = arg_8_3 or 0

		local var_8_0 = self:get_servant_initial_roll_rarity(arg_8_1)
		local var_8_1 = var_8_0 + arg_8_3 - 1

		return servant_data[arg_8_1]["damageFactorPlus" .. 5 .. (var_8_0 == var_8_1 and "" or "_" .. RARITY_STR_TBL[var_8_1])] or 0
	else
		local var_8_3 = servant_data[arg_8_1]["damageFactorPlus" .. arg_8_2 .. self:get_roll_rarity_str(arg_8_1, arg_8_3)]

		var_8_3 = var_8_3 or 0

		return var_8_3
	end
end

function var_0_0:get_add_hp_factor(arg_9_1)
	if playermodel.soulContract[arg_9_1] == 0 then
		local var_9_0 = self:get_servant_cur_roll_rarity(arg_9_1) - 1

		return servant_data[arg_9_1]["hpFactorPlus" .. 5 .. (self:get_servant_initial_roll_rarity(arg_9_1) == var_9_0 and "" or "_" .. RARITY_STR_TBL[var_9_0])] or 0
	else
		local var_9_2 = servant_data[arg_9_1]["hpFactorPlus" .. playermodel.soulContract[arg_9_1] .. self:get_roll_rarity_str(arg_9_1)]

		var_9_2 = var_9_2 or 0

		return var_9_2
	end
end

function var_0_0:get_add_hp_factor_for_pvp(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == 0 then
		arg_10_3 = arg_10_3 or 0

		local var_10_0 = self:get_servant_initial_roll_rarity(arg_10_1)
		local var_10_1 = var_10_0 + arg_10_3 - 1

		return servant_data[arg_10_1]["hpFactorPlus" .. 5 .. (var_10_0 == var_10_1 and "" or "_" .. RARITY_STR_TBL[var_10_1])] or 0
	else
		local var_10_3 = servant_data[arg_10_1]["hpFactorPlus" .. arg_10_2 .. self:get_roll_rarity_str(arg_10_1, arg_10_3)]

		var_10_3 = var_10_3 or 0

		return var_10_3
	end
end

function var_0_0:get_next_roll_rarity_damage_factor(arg_11_1)
	local var_11_0 = self:get_roll_rarity_str(arg_11_1)

	if not self:is_can_advance(arg_11_1) then
		return
	end

	return servant_data[arg_11_1]["damageFactorPlus" .. 5 .. var_11_0] or 0
end

function var_0_0:get_next_roll_rarity_hp_factor(arg_12_1)
	local var_12_0 = self:get_roll_rarity_str(arg_12_1)

	if not self:is_can_advance(arg_12_1) then
		return
	end

	return servant_data[arg_12_1]["hpFactorPlus" .. 5 .. var_12_0] or 0
end

function var_0_0:is_can_advance(arg_13_1)
	local var_13_0 = self:get_servant_cur_roll_rarity(arg_13_1)

	if not servant_advance_data[arg_13_1] then
		return false
	end

	return servant_advance_data[arg_13_1]["advance" .. var_13_0 + 1 .. "_flag"] == 1
end

function var_0_0:check_is_can_avance(arg_14_1)
	local var_14_0 = self:get_total_contract(arg_14_1)

	if not playermodel.soulOverClock[arg_14_1] then
		-- block empty
	end

	return self:is_can_advance(arg_14_1) and playermodel.soulContract[arg_14_1] >= 5
end

function var_0_0.check_is_can_upgrade(arg_15_0, arg_15_1)
	return not not require("controller.core_manager"):getUpgradeCostRoleCardNum(arg_15_1, playermodel.soulContract[arg_15_1] + 1)
end

function var_0_0:check_is_can_OC(arg_16_1)
	return servant_data[arg_16_1]["oc_isopen" .. (playermodel.soulOverClock[arg_16_1] or 0) + 1] and self:get_total_contract(arg_16_1) >= 5 and not playermodel:isServantOverclockLockByTime(arg_16_1)
end

function var_0_0:check_is_can_OC_with_material(arg_17_1)
	local core_manager = require("controller.core_manager")

	if self:check_is_can_OC(arg_17_1) then
		local var_17_1 = playermodel.soulOverClock[arg_17_1]
		local var_17_5
		local var_17_4
		local var_17_3
		local var_17_2

		if not playermodel.soulOverClock[arg_17_1] then
			var_17_1 = 0
			var_17_2 = core_manager:getServantRarityCard(arg_17_1)
			var_17_3 = core_manager:getOcCostCardNum(arg_17_1, var_17_1 + 1) or 0
			var_17_4 = core_manager:getOcCpuId(arg_17_1, var_17_1 + 1)
			var_17_5 = core_manager:getOcCostCpuNum(arg_17_1, var_17_1 + 1) or 0
		end

		if var_17_3 > item_manager:getItemNumber(servant_data[arg_17_1].itemid) + (var_17_2 and item_manager:getItemNumber(var_17_2) or 0) then
			return false
		end

		if var_17_5 > item_manager:getItemNumber(var_17_4) then
			return false
		end

		return true
	end

	return false
end

function var_0_0:check_is_can_avance_with_material(arg_18_1)
	if self:check_is_can_avance(arg_18_1) then
		local var_18_0 = self:get_servant_cur_roll_rarity(arg_18_1) + 1

		while servant_advance_data[arg_18_1]["advance" .. var_18_0 .. "_cost_itemid" .. 1] do
			if servant_advance_data[arg_18_1]["advance" .. var_18_0 .. "_cost_itemnum" .. 1] > item_manager:getItemNumber(servant_advance_data[arg_18_1]["advance" .. var_18_0 .. "_cost_itemid" .. 1]) then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0:get_soul_contract_strength_science(arg_19_1, arg_19_2)
	if servant_data[arg_19_1] and servant_data[arg_19_1].linkage and servant_data[arg_19_1].linkage == 1 then
		return 0
	end

	local var_19_1 = 0
	local var_19_2 = (require("data.contract_attr_data")[RARITY_STR_TBL[self:get_servant_initial_roll_rarity(arg_19_1)] .. "_" .. (playermodel.addRollRarity[arg_19_1] or 0)] or {})["contract_" .. (arg_19_2 or playermodel.soulContract[arg_19_1])]

	return var_19_1 + ((not (require("data.contract_attr_data")[RARITY_STR_TBL[self:get_servant_initial_roll_rarity(arg_19_1)] .. "_" .. (playermodel.addRollRarity[arg_19_1] or 0)] or {})["contract_" .. (arg_19_2 or playermodel.soulContract[arg_19_1])] or nil) and 0)
end

function var_0_0:get_all_servant_contract_strength()
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(playermodel.haveServant) do
		var_20_0 = var_20_0 + self:get_soul_contract_strength_science(iter_20_0)
	end

	return var_20_0
end

function var_0_0:get_total_contract_attr()
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(playermodel.cores) do
		var_21_0 = var_21_0 + self:get_contract_attr(iter_21_0)
	end

	return var_21_0
end

function var_0_0.get_contract_attr(arg_22_0, arg_22_1)
	local var_22_0 = 0

	if servant_data[arg_22_1] and not servant_data[arg_22_1].linkage then
		if servant_data[arg_22_1].roll_rarity + (playermodel.addRollRarity[arg_22_1] or 0) >= 4 then
			var_22_0 = 1 + (playermodel.soulContract[arg_22_1] or 0) + (playermodel.soulOverClock[arg_22_1] or 0) * 2
		end
	end

	return var_22_0
end

function var_0_0:get_can_up_level()
	local var_23_0 = self:get_total_contract_attr()
	local servant_up_star_limit_data = require("data.servant_up_star_limit_data")

	if var_23_0 < servant_up_star_limit_data[1].star then
		return servant_up_star_limit_data[1].lv
	end

	for iter_23_0, iter_23_1 in ipairs(servant_up_star_limit_data) do
		if var_23_0 < iter_23_1.star then
			return servant_up_star_limit_data[iter_23_0 - 1].lv
		end
	end

	return servant_up_star_limit_data[#servant_up_star_limit_data].lv
end

function var_0_0:get_contract_attr_add(arg_24_1, arg_24_2)
	if not servant_data[arg_24_1] or servant_data[arg_24_1].linkage then
		return 0
	end

	local var_24_0 = playermodel.addRollRarity[arg_24_1] or 0

	if arg_24_2 == 2 then
		return 2
	elseif servant_data[arg_24_1].roll_rarity + var_24_0 >= 4 then
		return 1
	elseif arg_24_2 == 1 and self:check_is_can_avance(arg_24_1) and servant_data[arg_24_1].roll_rarity + var_24_0 >= 3 then
		if playermodel.soulOverClock[arg_24_1] > 0 then
			return 2
		else
			return 1
		end
	end

	return 0
end

function var_0_0:get_next_up_level_limit(...)
	local var_25_0 = self:get_total_contract_attr()
	local servant_up_star_limit_data = require("data.servant_up_star_limit_data")

	if var_25_0 < servant_up_star_limit_data[1].star then
		return servant_up_star_limit_data[1].star
	end

	for iter_25_0, iter_25_1 in ipairs(servant_up_star_limit_data) do
		if var_25_0 < iter_25_1.star then
			return iter_25_1.star
		end
	end

	return servant_up_star_limit_data[#servant_up_star_limit_data].star
end

function var_0_0.get_breakout_star_rank(arg_26_0, arg_26_1)
	network:rpc("get_breakout_star_rank", {
		count = 50,
		start = 1
	}, function(arg_27_0)
		if arg_26_1 then
			arg_26_1(arg_27_0)
		end
	end)
end

return var_0_0
