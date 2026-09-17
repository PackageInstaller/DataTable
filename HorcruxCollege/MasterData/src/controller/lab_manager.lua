local var_0_0 = {}
local network = require("network.network")
local bit = require("bit")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local lab_research_data = require("data.lab_research_data")
local lab_recipe_data = require("data.lab_recipe_data")
local item_data = require("data.item_data")

var_0_0.rdlist = {
	{
		status = 0,
		slot = 1
	},
	{
		status = 0,
		slot = 2
	},
	{
		status = 0,
		slot = 3
	}
}
var_0_0.rdscheduler = nil
var_0_0.attachedRef = {}

local var_0_8 = false

function var_0_0.get_lab_production_list(arg_1_0, arg_1_1)
	network:rpc("get_lab_production_list", nil, function(arg_2_0)
		if arg_1_1 then
			arg_1_1(arg_2_0.list)
		end
	end)
end

function var_0_0.start_lab_production(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	network:rpc("start_lab_production", {
		slot = arg_3_1,
		product = arg_3_2
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			item_manager:deleteItem(arg_3_2, 1)

			if arg_3_3 then
				arg_3_3(1, arg_4_0.time)
			end
		elseif arg_3_3 then
			arg_3_3(arg_4_0.result)
		end
	end)
end

function var_0_0.complete_lab_production(arg_5_0, arg_5_1, arg_5_2)
	network:rpc("complete_lab_production", {
		slot = arg_5_1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			local var_6_0 = {
				gold = arg_6_0.gold,
				sp = arg_6_0.sp,
				items = arg_6_0.items
			}

			for iter_6_0, iter_6_1 in ipairs(var_6_0.items) do
				var_6_0.items[iter_6_0].addCount = item_manager:setItemByServerItem(iter_6_1)
			end

			if arg_5_2 then
				arg_5_2(1, var_6_0)
			end
		elseif arg_6_0.result == 2 then
			if arg_5_2 then
				arg_5_2(2, arg_6_0.production)
			end
		elseif arg_5_2 then
			arg_5_2(arg_6_0.result)
		end
	end)
end

function var_0_0.quick_complete_lab_production(arg_7_0, arg_7_1, arg_7_2)
	network:rpc("quick_complete_lab_production", {
		slot = arg_7_1
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			playermodel.diamond = playermodel.diamond - arg_8_0.cost

			global_update_gold_stone_diamond(nil, nil, arg_8_0.cost)

			local var_8_0 = {
				gold = arg_8_0.gold,
				sp = arg_8_0.sp,
				items = arg_8_0.items
			}

			for iter_8_0, iter_8_1 in ipairs(var_8_0.items) do
				var_8_0.items[iter_8_0].addCount = item_manager:setItemByServerItem(iter_8_1)
			end

			if arg_7_2 then
				arg_7_2(1, var_8_0)
			end
		elseif arg_8_0.result == 2 then
			if arg_7_2 then
				arg_7_2(2, arg_8_0.production)
			end
		elseif arg_7_2 then
			arg_7_2(arg_8_0.result)
		end
	end)
end

function var_0_0.unlock_new_production_slot(arg_9_0, arg_9_1)
	network:rpc("unlock_new_production_slot", nil, function(arg_10_0)
		if arg_10_0.result == 1 then
			playermodel.diamond = playermodel.diamond - arg_10_0.cost

			global_update_gold_stone_diamond(nil, nil, arg_10_0.cost)

			if arg_9_1 then
				arg_9_1(1, arg_10_0.production)
			end
		elseif arg_9_1 then
			arg_9_1(arg_10_0.result)
		end
	end)
end

local var_0_9 = 0
local var_0_10 = 1
local var_0_11 = 2

function var_0_0:onEnter(arg_11_1)
	var_0_8 = true

	self:get_player_lab_rd_list(function()
		self:start_lab_rd_scheduler()

		if arg_11_1 then
			arg_11_1()
		end
	end)
end

function var_0_0:onExit()
	var_0_8 = false
	self.attachedRef = {}

	self:end_lab_rd_scheduler()
end

local function var_0_12(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(var_0_0.rdlist) do
		if iter_14_1.status == var_0_10 then
			iter_14_1.time = iter_14_1.time - 1

			if iter_14_1.time <= 0 then
				iter_14_1.status = var_0_11
				iter_14_1.time = 0
			end

			if var_0_0.attachedRef[iter_14_1.slot] then
				var_0_0.attachedRef[iter_14_1.slot]:updateStatus(iter_14_1.status, iter_14_1.time, iter_14_1.id)
			end
		end
	end
end

function var_0_0:start_lab_rd_scheduler()
	if not var_0_8 then
		print("global_lab_showing == false")

		return
	end

	self.rdscheduler = self.rdscheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_12, 1, false)
end

function var_0_0:end_lab_rd_scheduler()
	if self.rdscheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.rdscheduler)

		self.rdscheduler = nil
	end
end

function var_0_0:attach_rd(arg_17_1, arg_17_2)
	self.attachedRef[arg_17_2] = arg_17_1

	local var_17_0 = self:get_lab_rd_workstatus(arg_17_2)

	arg_17_1:updateStatus(var_17_0.status, var_17_0.time, var_17_0.id)
end

function var_0_0:dettach_rd(arg_18_1)
	self.attachedRef[arg_18_1] = nil
end

function var_0_0.get_player_lab_rd_list(arg_19_0, arg_19_1)
	arg_19_0.rdlist = {
		{
			status = 0,
			slot = 1
		},
		{
			status = 0,
			slot = 2
		},
		{
			status = 0,
			slot = 3
		}
	}

	network:rpc("get_lab_rd_list", nil, function(arg_20_0)
		if arg_20_0.list and next(arg_20_0.list) ~= nil then
			for iter_20_0, iter_20_1 in ipairs(arg_20_0.list) do
				if iter_20_1 and next(iter_20_1) ~= nil then
					arg_19_0.rdlist[iter_20_1.slot] = iter_20_1
				end
			end
		end

		if arg_19_1 then
			arg_19_1(arg_20_0.list)
		end
	end)
end

function var_0_0:get_lab_rd_workstatus(arg_21_1)
	return self.rdlist[arg_21_1]
end

function var_0_0.is_lab_rd_valid(arg_22_0, arg_22_1)
	if not lab_research_data[arg_22_1] then
		return false
	end

	if not lab_research_data[arg_22_1].valid then
		return false
	end

	if lab_research_data[arg_22_1].blueprint then
		return item_manager:haveItem(lab_research_data[arg_22_1].blueprint)
	else
		return true
	end
end

function var_0_0.start_lab_rd(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if not lab_research_data[arg_23_2] or not lab_research_data[arg_23_2].valid then
		if arg_23_3 then
			arg_23_3(3)
		end

		return
	end

	if lab_research_data[arg_23_2].blueprint and not item_manager:haveItem(lab_research_data[arg_23_2].blueprint) then
		if arg_23_3 then
			arg_23_3(2)
		end

		return
	end

	local var_23_0 = {}

	while lab_research_data[arg_23_2]["material" .. 1] do
		if not item_manager:isHaveEnoughItem(lab_research_data[arg_23_2]["material" .. 1], lab_research_data[arg_23_2]["material" .. 1 .. "_num"]) then
			if arg_23_3 then
				arg_23_3(6)
			end

			return
		else
			table.insert(var_23_0, {
				id = lab_research_data[arg_23_2]["material" .. 1],
				count = lab_research_data[arg_23_2]["material" .. 1 .. "_num"]
			})
		end
	end

	network:rpc("start_lab_rd", {
		slot = arg_23_1,
		id = arg_23_2
	}, function(arg_24_0)
		if arg_24_0.result == 1 then
			for iter_24_0, iter_24_1 in ipairs(var_23_0) do
				item_manager:deleteItem(iter_24_1.id, iter_24_1.count)
			end

			arg_23_0.rdlist[arg_23_1].status = var_0_10
			arg_23_0.rdlist[arg_23_1].time = arg_24_0.time
			arg_23_0.rdlist[arg_23_1].id = arg_23_2

			if arg_23_0.attachedRef[arg_23_1] then
				arg_23_0.attachedRef[arg_23_1]:updateStatus(var_0_10, arg_24_0.time, arg_23_2)
			end

			if arg_23_3 then
				arg_23_3(1)
			end
		elseif arg_23_3 then
			arg_23_3(arg_24_0.result)
		end
	end)
end

function var_0_0.complete_lab_rd(arg_25_0, arg_25_1, arg_25_2)
	network:rpc("complete_lab_rd", {
		slot = arg_25_1
	}, function(arg_26_0)
		if arg_26_0.result == 1 then
			for iter_26_0, iter_26_1 in ipairs(arg_26_0.items) do
				arg_26_0.items[iter_26_0].addCount = item_manager:setItemByServerItem(iter_26_1)
			end

			arg_25_0.rdlist[arg_25_1].status = var_0_9
			arg_25_0.rdlist[arg_25_1].time = nil
			arg_25_0.rdlist[arg_25_1].id = nil

			if arg_25_0.attachedRef[arg_25_1] then
				arg_25_0.attachedRef[arg_25_1]:updateStatus(var_0_9)
			end

			if arg_25_2 then
				arg_25_2(1, arg_26_0.items)
			end
		elseif arg_26_0.result == 2 then
			if arg_26_0.rd then
				arg_25_0.rdlist[arg_25_1].status = arg_26_0.rd.status
				arg_25_0.rdlist[arg_25_1].time = arg_26_0.rd.time
				arg_25_0.rdlist[arg_25_1].id = arg_26_0.rd.id

				if arg_25_0.attachedRef[arg_25_1] then
					arg_25_0.attachedRef[arg_25_1]:updateStatus(arg_26_0.rd.status, arg_26_0.rd.time, arg_26_0.rd.id)
				end
			end

			if arg_25_2 then
				arg_25_2(2, arg_26_0.rd)
			end
		elseif arg_25_2 then
			arg_25_2(arg_26_0.result)
		end
	end)
end

function var_0_0.giveup_lab_rd(arg_27_0, arg_27_1, arg_27_2)
	network:rpc("giveup_lab_rd", {
		slot = arg_27_1
	}, function(arg_28_0)
		if arg_28_0.result == 1 then
			if arg_28_0.items then
				for iter_28_0, iter_28_1 in ipairs(arg_28_0.items) do
					local var_28_0 = item_manager:setItemByServerItem(iter_28_1)
				end
			end

			arg_27_0.rdlist[arg_27_1].status = var_0_9
			arg_27_0.rdlist[arg_27_1].time = nil
			arg_27_0.rdlist[arg_27_1].id = nil

			if arg_27_0.attachedRef[arg_27_1] then
				arg_27_0.attachedRef[arg_27_1]:updateStatus(var_0_9)
			end

			if arg_27_2 then
				arg_27_2(1)
			end
		elseif arg_28_0.result == 2 then
			if arg_28_0.rd then
				arg_27_0.rdlist[arg_27_1].status = arg_28_0.rd.status
				arg_27_0.rdlist[arg_27_1].time = arg_28_0.rd.time
				arg_27_0.rdlist[arg_27_1].id = arg_28_0.rd.id

				if arg_27_0.attachedRef[arg_27_1] then
					arg_27_0.attachedRef[arg_27_1]:updateStatus(arg_28_0.rd.status, arg_28_0.rd.time, arg_28_0.rd.id)
				end
			end

			if arg_27_2 then
				arg_27_2(2)
			end
		elseif arg_27_2 then
			arg_27_2(arg_28_0.result)
		end
	end)
end

function var_0_0.quick_complete_lab_rd(arg_29_0, arg_29_1, arg_29_2)
	network:rpc("quick_complete_lab_rd", {
		slot = arg_29_1
	}, function(arg_30_0)
		if arg_30_0.result == 1 then
			playermodel.diamond = playermodel.diamond - arg_30_0.cost

			global_update_gold_stone_diamond(nil, nil, arg_30_0.cost)

			for iter_30_0, iter_30_1 in pairs(arg_30_0.items) do
				arg_30_0.items[iter_30_0].addCount = item_manager:setItemByServerItem(iter_30_1)
			end

			arg_29_0.rdlist[arg_29_1].status = var_0_9
			arg_29_0.rdlist[arg_29_1].time = nil
			arg_29_0.rdlist[arg_29_1].id = nil

			if arg_29_0.attachedRef[arg_29_1] then
				arg_29_0.attachedRef[arg_29_1]:updateStatus(var_0_9)
			end

			if arg_29_2 then
				arg_29_2(1, arg_30_0.items)
			end
		elseif arg_30_0.result == 2 then
			if arg_30_0.rd then
				arg_29_0.rdlist[arg_29_1].status = arg_30_0.rd.status
				arg_29_0.rdlist[arg_29_1].time = arg_30_0.rd.time
				arg_29_0.rdlist[arg_29_1].id = arg_30_0.rd.id

				if arg_29_0.attachedRef[arg_29_1] then
					arg_29_0.attachedRef[arg_29_1]:updateStatus(arg_30_0.rd.status, arg_30_0.rd.time, arg_30_0.rd.id)
				end
			end

			if arg_29_2 then
				arg_29_2(2)
			end
		elseif arg_29_2 then
			arg_29_2(arg_30_0.result)
		end
	end)
end

function var_0_0.make_lab_research(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_2 = arg_31_2 or 2

	network:rpc("make_lab_research", {
		researchid = arg_31_1,
		num = arg_31_2
	}, function(arg_32_0)
		if arg_32_0.result == 1 then
			for iter_32_0, iter_32_1 in pairs(arg_32_0.cost_items) do
				item_manager:deleteItem(iter_32_1.entityid, iter_32_1.num)
			end

			if arg_32_0.gold and arg_32_0.gold > 0 then
				playermodel.gold = playermodel.gold - arg_32_0.gold

				global_update_gold_stone_diamond(playermodel.gold)
			end

			local var_32_0 = {
				result = 1,
				items = arg_32_0.items
			}

			for iter_32_2, iter_32_3 in ipairs(var_32_0.items) do
				var_32_0.items[iter_32_2].dropNum = item_manager:setItemByServerItem(iter_32_3)
			end

			if arg_31_3 then
				arg_31_3(var_32_0)
			end
		elseif arg_32_0.result == 2 then
			global_ShowBlockWords(L_LAB_RESEARCH_WARNING[2])
		elseif arg_32_0.result == 3 then
			global_ShowBlockWords(L_LAB_RESEARCH_WARNING[3])
		elseif arg_32_0.result == 4 then
			global_ShowBlockWords(L_LAB_RESEARCH_WARNING[4])
		elseif arg_32_0.result == 5 then
			global_ShowBlockWords(L_LAB_RESEARCH_WARNING[5])
		elseif arg_32_0.result == 0 then
			global_ShowBlockWords(L_LAB_RESEARCH_WARNING[0])
		elseif arg_32_0.result == 6 and arg_31_3 then
			arg_31_3({
				result = arg_32_0.result
			})
		end
	end)
end

function var_0_0.getResearchDataByType(arg_33_0)
	local drop_manager = require("controller.drop_manager")
	local drop_data = require("data.drop_data")
	local var_33_2 = {}

	for iter_33_0, iter_33_1 in pairs(lab_research_data) do
		if not iter_33_1.valid or iter_33_1.valid == 1 then
			var_33_2[iter_33_1.type] = var_33_2[iter_33_1.type] or {}
			var_33_2[iter_33_1.type][#var_33_2[iter_33_1.type] + 1] = {}
			var_33_2[iter_33_1.type][#var_33_2[iter_33_1.type]].id = iter_33_1.id
			var_33_2[iter_33_1.type][#var_33_2[iter_33_1.type]].drop_items = drop_data[iter_33_1.dropid].rd_drop_id1 and drop_manager:getEquipAllDrops(iter_33_1.dropid) or drop_manager:getEquipDrops(iter_33_1.dropid)
		end
	end

	for iter_33_2, iter_33_3 in pairs(var_33_2) do
		table.sort(var_33_2[iter_33_2], function(arg_34_0, arg_34_1)
			return arg_34_0.id < arg_34_1.id
		end)
	end

	return var_33_2
end

function var_0_0:isSatisfyDemand(arg_35_1)
	local var_35_0 = {}
	local var_35_1 = true
	local var_35_2 = false
	local var_35_3 = true

	if lab_research_data[arg_35_1] then
		local var_35_4 = {}
		local var_35_5 = 1

		while lab_research_data[arg_35_1]["material" .. var_35_5] do
			local var_35_6 = item_manager:getItemNumber(lab_research_data[arg_35_1]["material" .. var_35_5])

			if var_35_6 < lab_research_data[arg_35_1]["material" .. var_35_5 .. "_num"] then
				var_35_3 = false
			end

			table.insert(var_35_0, {
				itemid = lab_research_data[arg_35_1]["material" .. var_35_5],
				needNum = lab_research_data[arg_35_1]["material" .. var_35_5 .. "_num"],
				haveNum = var_35_6,
				pretask = lab_research_data[arg_35_1]["material" .. var_35_5 .. "_pretask"]
			})

			var_35_5 = var_35_5 + 1
		end

		local var_35_7 = self:getMaterialWeapon(arg_35_1)

		while lab_research_data[arg_35_1]["material_weapon" .. 1] do
			if lab_research_data[arg_35_1]["material_weapon" .. 1 .. "_num"] > #var_35_7[1] then
				var_35_1 = false
			end
		end

		if not var_35_1 and self:getMaterialWeapon(arg_35_1, 0) then
			var_35_7 = self:getMaterialWeapon(arg_35_1, 0)
			var_35_2 = true
		end

		local var_35_10 = 1

		while lab_research_data[arg_35_1]["material_weapon" .. var_35_10] do
			if #var_35_7[var_35_10] < lab_research_data[arg_35_1]["material_weapon" .. var_35_10 .. "_num"] then
				var_35_2 = false
			end

			table.sort(var_35_7[var_35_10], function(arg_36_0, arg_36_1)
				return (arg_36_0.weapon_attr.lock and 1 or 0) < (arg_36_1.weapon_attr.lock and 1 or 0)
			end)

			local var_35_11 = {}

			for iter_35_0, iter_35_1 in pairs(var_35_7[var_35_10]) do
				if iter_35_0 <= lab_research_data[arg_35_1]["material_weapon" .. var_35_10 .. "_num"] then
					table.insert(var_35_11, iter_35_1.entityid)
				end
			end

			table.insert(var_35_4, {
				itemid = lab_research_data[arg_35_1]["material_weapon" .. var_35_10],
				needNum = lab_research_data[arg_35_1]["material_weapon" .. var_35_10 .. "_num"],
				haveNum = #var_35_7[var_35_10],
				weapons = var_35_11,
				pretask = lab_research_data[arg_35_1]["material_weapon" .. var_35_10 .. "_pretask"],
				needLevel = lab_research_data[arg_35_1]["material_weapon" .. var_35_10 .. "_level"]
			})

			var_35_10 = var_35_10 + 1
		end

		for iter_35_2, iter_35_3 in pairs(var_35_4) do
			table.insert(var_35_0, #var_35_0 > 1 and 2 or 1, var_35_4[iter_35_2])
		end
	end

	if not var_35_3 then
		var_35_1 = false
		var_35_2 = false
	end

	local var_35_12, var_35_13 = self:getOnceStrengWeaponLevelCostWeapon(arg_35_1)

	return var_35_1, var_35_0, (not var_35_13 or nil) and false
end

function var_0_0.getMaterialWeapon(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = {}

	while lab_research_data[arg_37_1]["material_weapon" .. 1] do
		var_37_0[lab_research_data[arg_37_1]["material_weapon" .. 1]] = {}
	end

	for iter_37_0, iter_37_1 in pairs(playermodel.items) do
		if var_37_0[iter_37_1.itemid] then
			var_37_0[iter_37_1.itemid][iter_37_0] = global_deepCopy(iter_37_1)
		end
	end

	local var_37_2 = {}

	while lab_research_data[arg_37_1]["material_weapon" .. 1] do
		var_37_2[1] = var_37_2[1] or {}

		for iter_37_2, iter_37_3 in pairs(var_37_0[lab_research_data[arg_37_1]["material_weapon" .. 1]]) do
			if iter_37_3.weapon_attr.level >= (arg_37_2 or lab_research_data[arg_37_1]["material_weapon" .. 1 .. "_level"]) and iter_37_3.weapon_attr.nowStars >= lab_research_data[arg_37_1]["material_weapon" .. 1 .. "_star"] and not iter_37_3.weapon_attr.use then
				table.insert(var_37_2[1], global_deepCopy(iter_37_3))
			end
		end
	end

	for iter_37_4, iter_37_5 in pairs(var_37_2) do
		table.sort(var_37_2[iter_37_4], function(arg_38_0, arg_38_1)
			if (arg_38_0.weapon_attr.lock and 1 or 0) == (arg_38_1.weapon_attr.lock and 1 or 0) then
				return arg_38_0.weapon_attr.level > arg_38_1.weapon_attr.level
			else
				return (arg_38_0.weapon_attr.lock and 1 or 0) < (arg_38_1.weapon_attr.lock and 1 or 0)
			end
		end)
	end

	return var_37_2
end

function var_0_0:getOnceStrengWeaponLevelCostWeapon(arg_39_1)
	local weapon_manager = require("controller.weapon_manager")
	local var_39_1 = self:getMaterialWeapon(arg_39_1, 0)
	local var_39_2 = {
		gold = 0,
		item = {}
	}
	local var_39_3 = {}

	while lab_research_data[arg_39_1]["material_weapon" .. 1] do
		local var_39_6 = 0

		for iter_39_0, iter_39_1 in pairs(var_39_1[1]) do
			if lab_research_data[arg_39_1]["material_weapon" .. 1 .. "_num"] <= var_39_6 then
				break
			end

			if lab_research_data[arg_39_1]["material_weapon" .. 1 .. "_level"] > weapon_manager:getWeaponMaxLevel(iter_39_1.entityid) then
				return false
			end

			local var_39_7 = weapon_manager:getWeaponUpToLevelCost(iter_39_1.entityid, lab_research_data[arg_39_1]["material_weapon" .. 1 .. "_level"])

			var_39_2.gold = var_39_2.gold + var_39_7.gold

			for iter_39_2, iter_39_3 in pairs(var_39_7.item) do
				var_39_2.item[iter_39_2] = var_39_2.item[iter_39_2] or 0
				var_39_2.item[iter_39_2] = var_39_2.item[iter_39_2] + iter_39_3
			end

			var_39_6 = var_39_6 + 1

			table.insert(var_39_3, {
				entityid = iter_39_1.entityid,
				target_lv = lab_research_data[arg_39_1]["material_weapon" .. 1 .. "_level"]
			})
		end

		if var_39_6 < lab_research_data[arg_39_1]["material_weapon" .. 1 .. "_num"] then
			return false
		end
	end

	if playermodel.gold < var_39_2.gold then
		return false
	end

	for iter_39_4, iter_39_5 in pairs(var_39_2.item) do
		if iter_39_5 > item_manager:getItemNumber(iter_39_4) then
			return false
		end
	end

	return var_39_3, var_39_2
end

function var_0_0.get_recipe_list(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1 = arg_40_1 or false

	network:rpc("get_recipe_list", {
		collect = arg_40_1
	}, function(arg_41_0)
		global_gain({
			items = arg_41_0.items
		})

		if arg_40_2 then
			arg_40_2(arg_41_0)
		end
	end)
end

function var_0_0.start_lab_recipe(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	network:rpc("start_lab_recipe", {
		slot = arg_42_1,
		recipeid = arg_42_2,
		recipeNum = arg_42_3
	}, function(arg_43_0)
		if arg_43_0.result == 1 then
			if arg_43_0.cost_items then
				for iter_43_0, iter_43_1 in pairs(arg_43_0.cost_items) do
					item_manager:deleteItem(iter_43_1.entityid, iter_43_1.num)
				end
			end

			if arg_43_0.items and next(arg_43_0.items) then
				global_gain({
					items = arg_43_0.items
				})
			end

			if arg_43_0.cancel_res and next(arg_43_0.cancel_res) then
				for iter_43_2, iter_43_3 in pairs(arg_43_0.cancel_res) do
					item_manager:setItemByServerItem(iter_43_3)
				end
			end

			AnalyticManager.start_lab_recipe({
				recipeid = arg_42_2,
				recipeNum = arg_42_3
			})

			if arg_42_4 then
				arg_42_4(arg_43_0)
			end
		elseif arg_43_0.result == 2 then
			global_ShowBlockWords(L_LAB_RECIPE_WARNING[2])
		elseif arg_43_0.result == 3 then
			global_ShowBlockWords(L_LAB_RECIPE_WARNING[3])
		elseif arg_43_0.result == 4 then
			global_ShowBlockWords(L_LAB_RECIPE_WARNING[4])
		end
	end)
end

function var_0_0.stop_lab_recipe(arg_44_0, arg_44_1, arg_44_2)
	network:rpc("stop_lab_recipe", {
		slot = arg_44_1
	}, function(arg_45_0)
		if arg_45_0.result == 1 then
			if arg_45_0.items and next(arg_45_0.items) then
				global_gain({
					items = arg_45_0.items
				})
			end

			if arg_45_0.cancel_res and next(arg_45_0.cancel_res) then
				for iter_45_0, iter_45_1 in pairs(arg_45_0.cancel_res) do
					item_manager:setItemByServerItem(iter_45_1)
				end
			end

			if arg_44_2 then
				arg_44_2(arg_45_0)
			end
		elseif arg_45_0.result == 2 then
			global_ShowBlockWords(L_LAB_STOP_RECIPE[2])
		end
	end)
end

function var_0_0.complete_lab_recipe(arg_46_0, arg_46_1, arg_46_2)
	network:rpc("complete_lab_recipe", {
		slot = arg_46_1
	}, function(arg_47_0)
		if arg_47_0.result == 1 then
			if arg_46_2 then
				arg_46_2(arg_47_0)
			end
		elseif arg_47_0.result == 0 then
			global_ShowBlockWords(L_LAB_COMPLETE_RECIPE[0])
		elseif arg_47_0.result == 2 then
			global_ShowBlockWords(L_LAB_COMPLETE_RECIPE[2])
		end
	end)
end

function var_0_0.quick_complete_lab_recipe(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	if arg_48_2 == "gold" then
		arg_48_2 = CURRENCY_GOLD
		arg_48_3 = arg_48_3 * 200
	elseif tiemid == "strengthpoint" then
		arg_48_2 = CURRENCY_STRENGTHPOINT
	elseif arg_48_2 == "diamond" then
		arg_48_2 = CURRENCY_DIAMOND
	end

	network:rpc("quick_complete_lab_recipe", {
		slot = arg_48_1,
		itemid = arg_48_2,
		num = arg_48_3
	}, function(arg_49_0)
		if arg_49_0.result == 1 then
			if arg_49_0.items and next(arg_49_0.items) then
				global_gain({
					items = arg_49_0.items
				})
			end

			if arg_48_2 == CURRENCY_GOLD then
				playermodel.gold = playermodel.gold - arg_48_3
			elseif tiemid == CURRENCY_STRENGTHPOINT then
				playermodel.strengthpoint = playermodel.strengthpoint - arg_48_3 * 200
			elseif arg_48_2 == CURRENCY_DIAMOND then
				playermodel.diamond = playermodel.diamond - arg_48_3
			else
				item_manager:deleteItem(arg_48_2, arg_48_3)
			end

			global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)

			if arg_48_4 then
				arg_48_4(arg_49_0)
			end
		elseif arg_49_0.result == 2 then
			global_ShowBlockWords(L_LAB_STOP_RECIPE[2])
		elseif arg_49_0.result == 3 then
			global_ShowBlockWords(L_LAB_STOP_RECIPE[3])
		end
	end)
end

function var_0_0.unlock_new_recipe_slot(arg_50_0, arg_50_1)
	network:rpc("unlock_new_recipe_slot", {
		slot = slot
	}, function(arg_51_0)
		if arg_51_0.result == 1 then
			if arg_51_0.cost_items then
				for iter_51_0, iter_51_1 in pairs(arg_51_0.cost_items) do
					item_manager:deleteItem(iter_51_1.entityid, iter_51_1.num)
				end
			end

			if arg_51_0.gold and arg_51_0.gold > 0 then
				playermodel.gold = playermodel.gold - arg_51_0.gold

				global_update_gold_stone_diamond(playermodel.gold)
			end

			if arg_51_0.cost and arg_51_0.cost > 0 then
				playermodel.diamond = playermodel.diamond - arg_51_0.cost

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
			end
		elseif arg_51_0.result == 2 then
			global_ShowBlockWords(L_LAB_UNLOCK_NEW_RECIPE_SLOT[2])
		elseif arg_51_0.result == 3 then
			global_ShowBlockWords(L_LAB_UNLOCK_NEW_RECIPE_SLOT[3])
		elseif arg_51_0.result == 4 then
			global_ShowBlockWords(L_LAB_UNLOCK_NEW_RECIPE_SLOT[4])
		elseif arg_51_0.result == 5 then
			global_ShowBlockWords(L_LAB_UNLOCK_NEW_RECIPE_SLOT[5])
		end

		if arg_50_1 then
			arg_50_1(arg_51_0)
		end
	end)
end

function var_0_0.collect_recipe_slot(arg_52_0, arg_52_1, arg_52_2)
	network:rpc("collect_recipe_slot", {
		slot = arg_52_1
	}, function(arg_53_0)
		if arg_53_0.result == 1 then
			local var_53_0 = 0

			if next(arg_53_0.items) then
				var_53_0 = item_manager:getItemNumber(arg_53_0.items[1].itemid)
			end

			if arg_53_0.items then
				global_gain({
					items = arg_53_0.items
				})
			end

			if next(arg_53_0.items) then
				AnalyticManager.collect_recipe_slot({
					itemid = arg_53_0.items[1].itemid,
					num = arg_53_0.items[1].itemcount - var_53_0
				})
			end

			if arg_52_2 then
				arg_52_2(arg_53_0)
			end
		elseif arg_53_0.result == 0 then
			global_ShowBlockWords(L_LAB_COMPLETE_RECIPE[0])
		elseif arg_53_0.result == 3 then
			global_ShowBlockWords(L_LAB_COMPLETE_RECIPE[3])
		end
	end)
end

function var_0_0.add_recipe_unlock_speed(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	if arg_54_1 == "diamond" then
		arg_54_1 = CURRENCY_DIAMOND
	end

	network:rpc("add_recipe_unlock_speed", {
		itemid = arg_54_1,
		num = arg_54_2
	}, function(arg_55_0)
		if arg_55_0.result == 1 then
			if arg_54_1 == CURRENCY_GOLD then
				playermodel.gold = playermodel.gold - arg_55_0.cost_num
			elseif arg_54_1 == CURRENCY_DIAMOND then
				playermodel.diamond = playermodel.diamond - arg_55_0.cost_num
			else
				item_manager:deleteItem(arg_54_1, arg_55_0.cost_num)
			end

			global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)
			AnalyticManager.unlock_cur_recipe_slot({
				num = arg_55_0.recipe_single.slot
			})

			if arg_54_3 then
				arg_54_3(arg_55_0)
			end
		end
	end)
end

function var_0_0.unlock_cur_recipe_slot(arg_56_0, arg_56_1)
	network:rpc("unlock_cur_recipe_slot", {}, function(arg_57_0)
		if arg_57_0.result == 1 then
			if arg_56_1 then
				arg_56_1(arg_57_0)
			end

			AnalyticManager.unlock_cur_recipe_slot({
				num = arg_57_0.recipe_single.slot
			})
		end
	end)
end

function var_0_0.use_all_battery(arg_58_0, arg_58_1)
	local var_58_0 = false

	for iter_58_0, iter_58_1 in pairs(item_data) do
		if iter_58_1.bag_item_type == 21 and playermodel.items[iter_58_1.id] then
			var_58_0 = true
		end
	end

	if var_58_0 == false then
		arg_58_1({
			result = 2
		})

		return
	end

	network:rpc("use_all_battery", {}, function(arg_59_0)
		if arg_59_0.result == 1 then
			if arg_59_0.cost_items then
				for iter_59_0, iter_59_1 in pairs(arg_59_0.cost_items) do
					item_manager:deleteItem(iter_59_1.entityid, iter_59_1.num)
				end
			end

			global_get({
				items = arg_59_0.items
			})
		end

		if arg_58_1 then
			arg_58_1(arg_59_0)
		end
	end)
end

function var_0_0.get_research_list(arg_60_0, arg_60_1)
	network:rpc("get_research_list", {}, function(arg_61_0)
		if arg_60_1 then
			arg_60_1(arg_61_0)
		end
	end)
end

function var_0_0.start_unlock_cur_research_slot(arg_62_0, arg_62_1)
	network:rpc("start_unlock_cur_research_slot", {}, function(arg_63_0)
		if arg_63_0.result == 1 then
			if arg_63_0.cost_items then
				for iter_63_0, iter_63_1 in pairs(arg_63_0.cost_items) do
					item_manager:deleteItem(iter_63_1.entityid, iter_63_1.num)
				end
			end

			if arg_63_0.gold and arg_63_0.gold > 0 then
				playermodel.gold = playermodel.gold - arg_63_0.gold

				AnalyticManager.cost_gold({
					gold = arg_63_0.gold
				})
				global_update_gold_stone_diamond(playermodel.gold)
			end

			if arg_63_0.cost and arg_63_0.cost > 0 then
				playermodel.diamond = playermodel.diamond - arg_63_0.cost

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
			end
		elseif arg_63_0.result == 2 then
			global_ShowBlockWords(L_LAB_UNLOCK_NEW_RECIPE_SLOT[2])
		elseif arg_63_0.result == 3 then
			global_ShowBlockWords(L_LAB_UNLOCK_NEW_RECIPE_SLOT[3])
		elseif arg_63_0.result == 4 then
			global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
		elseif arg_63_0.result == 5 then
			global_ShowBlockWords(L_LAB_UNLOCK_NEW_RECIPE_SLOT[2])
		end

		if arg_62_1 then
			arg_62_1(arg_63_0)
		end
	end)
end

function var_0_0.add_research_unlock_speed(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	if arg_64_1 == "diamond" then
		arg_64_1 = CURRENCY_DIAMOND
	end

	network:rpc("add_research_unlock_speed", {
		itemid = arg_64_1,
		num = arg_64_2
	}, function(arg_65_0)
		if arg_65_0.result == 1 then
			local var_65_0

			if arg_64_1 == CURRENCY_GOLD then
				playermodel.gold = playermodel.gold - arg_65_0.cost_num
			elseif arg_64_1 == CURRENCY_DIAMOND then
				playermodel.diamond = playermodel.diamond - arg_65_0.cost_num
				var_65_0 = arg_65_0.cost_num
			else
				item_manager:deleteItem(arg_64_1, arg_65_0.cost_num)
			end

			local var_65_1 = {
				room_num = arg_65_0.research_single.slot
			}

			if var_65_0 then
				var_65_1.cost_diamond = var_65_0
			end

			AnalyticManager.unlock_cur_research_slot(var_65_1)
			global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)

			if arg_64_3 then
				arg_64_3(arg_65_0)
			end
		end
	end)
end

function var_0_0.unlock_cur_research_slot(arg_66_0, arg_66_1)
	network:rpc("unlock_cur_research_slot", {}, function(arg_67_0)
		if arg_67_0.result == 1 then
			AnalyticManager.unlock_cur_research_slot({
				room_num = arg_67_0.research_single.slot
			})

			if arg_66_1 then
				arg_66_1(arg_67_0)
			end
		end
	end)
end

function var_0_0.get_research_status_list(arg_68_0, arg_68_1)
	network:rpc("get_research_status_list", {}, function(arg_69_0)
		if arg_68_1 then
			arg_68_1(arg_69_0)
		end
	end)
end

local var_0_13 = {
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

function var_0_0.is_lock_research(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = math.ceil(lab_research_data[arg_70_2].index / 32)
	local var_70_1 = (lab_research_data[arg_70_2].index - 1) % 32 + 1

	if not arg_70_1[var_70_0] then
		return false
	end

	return bit.band(arg_70_1[var_70_0], var_0_13[var_70_1]) ~= 0
end

function var_0_0.unlock_research(arg_71_0, arg_71_1, arg_71_2)
	network:rpc("unlock_research", {
		researchid = arg_71_1
	}, function(arg_72_0)
		if arg_72_0.result == 1 then
			for iter_72_0, iter_72_1 in pairs(arg_72_0.cost_items) do
				item_manager:deleteItem(iter_72_1.entityid, iter_72_1.num)
			end

			playermodel.gold = playermodel.gold - arg_72_0.cost_gold

			global_update_gold_stone_diamond(arg_72_0.cost_gold)
			AnalyticManager.unlock_research({
				researchid = arg_71_1
			})
		elseif arg_72_0.result == 0 then
			print("未传入 researchid")
		elseif arg_72_0.result == 2 then
			print("表里没有:", arg_71_1)
		elseif arg_72_0.result == 3 then
			print("条目无效:", arg_71_1)
		elseif arg_72_0.result == 4 then
			print("已解锁")
		elseif arg_72_0.result == 5 then
			global_ShowBlockWords(L_GOLD_LACK)
		elseif arg_72_0.result == 6 then
			global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
		end

		if arg_71_2 then
			arg_71_2(arg_72_0)
		end
	end)
end

function var_0_0:initComposeData()
	if self.isInitComposeData then
		return
	end

	self.isInitComposeData = true
	self.composeData = {}

	local function var_73_0(arg_74_0)
		local var_74_0 = {}

		while arg_74_0["material" .. 1] do
			var_74_0[#var_74_0 + 1] = {
				itemId = arg_74_0["material" .. 1],
				itemNum = arg_74_0["material" .. 1 .. "_num"]
			}
		end

		local var_74_2 = {
			unlock = false,
			operateId = arg_74_0.id,
			materials = var_74_0
		}

		var_74_2.gold = arg_74_0.recipe_gold or 0
		var_74_2.power = (arg_74_0.cost_power or 0) + math.ceil((arg_74_0.recipe_time or 0) / 60)
		var_74_2.slot = arg_74_0.tab
		var_74_2.limit = arg_74_0.recipe_open_limit or nil

		return var_74_2
	end

	for iter_73_0, iter_73_1 in pairs((require("data.lab_research_data"))) do
		if iter_73_1.is_valid == 1 and (not iter_73_1.is_straight_need or iter_73_1.is_straight_need ~= 1) then
			local var_73_1 = iter_73_1.target

			if not self.composeData[iter_73_1.target] then
				self.composeData[var_73_1] = {}
			end

			self.composeData[var_73_1].research = var_73_0(iter_73_1)
		end
	end

	for iter_73_2, iter_73_3 in pairs((require("data.lab_recipe_data"))) do
		self.composeData[iter_73_3.target] = self.composeData[iter_73_3.target] or {}
		self.composeData[iter_73_3.target].recipe = var_73_0(iter_73_3)
	end
end

function var_0_0:getComposeDataById(arg_75_1)
	if not self.isInitComposeData then
		self:initComposeData()
	end

	return self.composeData[arg_75_1] or nil
end

function var_0_0:initOperatorInfo()
	if self.isInitOperatorInfo then
		return
	end

	self.isInitOperatorInfo = true
	self.operatorInfos = {}

	for iter_76_0, iter_76_1 in pairs(lab_research_data) do
		if iter_76_1.is_bag_valid then
			self.operatorInfos[iter_76_1.material1] = self.operatorInfos[iter_76_1.material1] or {}

			if iter_76_1.is_bag_valid == 1 then
				self.operatorInfos[iter_76_1.material1].compose = {
					target = iter_76_1.target,
					needCount = iter_76_1.material1_num,
					cost = iter_76_1.recipe_gold,
					operateId = tonumber(iter_76_0)
				}
			elseif iter_76_1.is_bag_valid == 2 then
				self.operatorInfos[iter_76_1.material1].decompose = {
					target = iter_76_1.target,
					createCount = iter_76_1.num,
					cost = iter_76_1.recipe_gold,
					operateId = tonumber(iter_76_0)
				}
			end
		end
	end

	print("init operatorinfo end")
end

function var_0_0:getOperatorInfoById(arg_77_1)
	if not self.operatorInfos then
		self:initOperatorInfo()
	end

	return self.operatorInfos[arg_77_1] or nil
end

function var_0_0:queryComposeUnlock(arg_78_1)
	if not self.isInitComposeData then
		self:initComposeData()
	end

	local level_manager = require("controller.level_manager")
	local var_78_1 = 0

	self:get_recipe_list(false, function(arg_79_0)
		var_78_1 = var_78_1 + 1

		for iter_79_0, iter_79_1 in pairs(self.composeData) do
			if iter_79_1.recipe then
				iter_79_1.recipe.unlock = true
			end
		end

		if var_78_1 == 2 and arg_78_1 then
			arg_78_1()
		end
	end)
	self:get_research_list(function(arg_80_0)
		var_78_1 = var_78_1 + 1

		for iter_80_0, iter_80_1 in pairs(self.composeData) do
			if iter_80_1.research then
				local var_80_0 = level_manager:isPlayerPassLevel(iter_80_1.limit) and 1 or 2
				local var_80_1 = iter_80_1.research.slot

				if iter_80_1.research.slot == 3 then
					var_80_1 = 4
				elseif var_80_1 == 4 then
					var_80_1 = 3
				end

				if iter_80_1.research.slot <= #arg_80_0.reserch_list then
					iter_80_1.research.unlock = arg_80_0.reserch_list[var_80_1] and arg_80_0.reserch_list[var_80_1].status >= RECIPE_FREE
				end
			end
		end

		if var_78_1 == 2 and arg_78_1 then
			arg_78_1()
		end
	end)
end

return var_0_0
