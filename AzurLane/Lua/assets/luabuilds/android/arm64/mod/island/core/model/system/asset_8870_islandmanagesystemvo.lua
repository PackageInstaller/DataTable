class = var_0_10000

local var_0_0 = "IslandManageSystemVO"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSystemVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.name = "_system_manage_" .. arg_1_0.id
	arg_1_0.restaurant = arg_1_2

	return
end

function var_0_1.GetType(arg_2_0)
	IslandConst = var_1_10001

	return var_1_10001.SYSTEM_TYPE_MANAGE
end

function var_0_1.GetBehaviourTree(arg_3_0)
	return "island/nodecanvas/system/system_manage_place"
end

function var_0_1.GetUnits(arg_4_0, arg_4_1)
	local var_4_0 = {}

	arg_4_0.assistants = {}

	if arg_4_1 then
		arg_4_0.assistants = arg_4_1
	else
		local var_4_1 = arg_4_0.restaurant

		arg_4_0.assistants = var_3.GetAssistants(var_4_1)
	end

	ipairs = var_3

	for iter_4_0, iter_4_1 in var_3(arg_4_0.assistants) do
		local var_4_2

		if not iter_4_1.id then
			var_4_2 = iter_4_1.post_id
		end

		local var_4_3

		if not iter_4_1.shipId then
			var_4_3 = iter_4_1.ship_id
		end

		if var_4_3 ~= 0 then
			pg = var_1_10010
			var_1_10010 = var_1_10010.island_manage_assistant[var_4_2].birthplace
			pg = var_1_10011
			var_1_10011 = var_1_10011.island_world_objects[var_1_10010]
			var_1_10012 = nil

			if var_4_3 == 1 then
				IslandUnitVO = var_1_10013
				var_1_10013 = var_1_10013.New
				var_1_10015 = {
					behaviourTree = "island/nodecanvas/system/system_manage_assistant_chicken",
					id = var_4_3
				}
				pg = var_1_10016
				var_1_10015.modelId = var_1_10016.island_chara_template[var_4_3].unit_id
				IslandConst = var_1_10016
				var_1_10015.type = var_1_10016.UNIT_TYPE_MANAGE_CHARA
				var_1_10015.name = "system_unit" .. var_4_3
				var_1_10015.position = var_1_10011.param.position
				var_1_10015.rotation = var_1_10011.param.rotation
				Vector3 = var_1_10016
				var_1_10015.scale = var_1_10016.one
				var_1_10012 = var_1_10013(var_1_10015)
			else
				IslandUnitVO = var_1_10013
				var_1_10013 = var_1_10013.New
				var_1_10015 = {
					behaviourTree = "island/nodecanvas/system/system_manage_assistant",
					id = var_4_3
				}
				pg = var_1_10016
				var_1_10015.modelId = var_1_10016.island_chara_template[var_4_3].unit_id
				IslandConst = var_1_10016
				var_1_10015.type = var_1_10016.UNIT_TYPE_MANAGE_CHARA
				var_1_10015.name = "system_unit" .. var_4_3
				var_1_10015.position = var_1_10011.param.position
				var_1_10015.rotation = var_1_10011.param.rotation
				Vector3 = var_1_10016
				var_1_10015.scale = var_1_10016.one
				var_1_10012 = var_1_10013(var_1_10015)
			end

			table = var_1_10013

			var_1_10013.insert(var_4_0, var_1_10012)
		end
	end

	local var_4_4 = arg_4_0.restaurant
	local var_4_5 = var_3.getConfig(var_4_4, "customer_slot")

	Clone = var_4
	pg = var_6

	local var_4_6 = var_4(var_6.island_set.island_manage_customer_list.key_value_varchar)

	ipairs = var_4_4

	for iter_4_2, iter_4_3 in var_4_4(var_4_5) do
		local var_4_7 = iter_4_3[1]
		local var_4_8 = iter_4_3[2]

		pg = var_1_10012
		var_1_10012 = var_1_10012.island_world_objects[var_4_7]
		pg = var_1_10013
		var_1_10013 = var_1_10013.island_world_objects[var_4_8]
		math = var_1_10014
		var_1_10014 = var_4_6[var_1_10014.random(#var_4_6)]
		table = var_1_10015

		var_1_10015.removebyvalue(var_4_6, var_1_10014)

		IslandUnitVO = var_1_10015
		var_1_10015 = var_1_10015.New

		local var_4_9 = {
			behaviourTree = "island/nodecanvas/system/system_manage_customer",
			id = var_4_7,
			modelId = var_1_10014
		}

		IslandConst = var_18
		var_4_9.type = var_18.UNIT_TYPE_MANAGE_CUSTOMER
		var_4_9.name = "system_unit" .. var_4_7
		var_4_9.position = var_1_10012.param.position
		var_4_9.rotation = var_1_10012.param.rotation
		Vector3 = var_18
		var_4_9.scale = var_18.one
		var_1_10015 = var_1_10015(var_4_9)
		table = var_16

		var_16.insert(var_4_0, var_1_10015)

		IslandUnitVO = var_16

		local var_4_10 = var_16.New
		local var_4_11 = {
			behaviourTree = "",
			id = var_4_8,
			modelId = var_1_10013.unitId
		}

		IslandConst = var_19
		var_4_11.type = var_19.UNIT_TYPE_MANAGE_ITEM
		var_4_11.name = "system_unit" .. var_4_8
		var_4_11.position = var_1_10013.param.position
		var_4_11.rotation = var_1_10013.param.rotation
		Vector3 = var_19
		var_4_11.scale = var_19.one

		local var_4_12 = var_4_10(var_4_11)

		table = var_4_9

		var_4_9.insert(var_4_0, var_4_12)
	end

	return var_4_0
end

function var_0_1.GetPostUnitNodeList(arg_5_0)
	System = var_1_10001

	local var_5_0 = var_1_10001.Collections.Generic.List_IslandUnitNode()

	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.assistants) do
		local var_5_1

		if not iter_5_1.id then
			var_5_1 = iter_5_1.post_id
		end

		local var_5_2

		if not iter_5_1.shipId then
			var_5_2 = iter_5_1.ship_id
		end

		if var_5_2 ~= 0 then
			pg = var_1_10009
			var_1_10009 = var_1_10009.island_manage_assistant[var_5_1].birthplace
			IslandUnitNode = var_1_10010
			var_1_10010 = var_1_10010.New()
			var_1_10010.unitId = var_1_10009
			IslandConst = var_1_10011
			var_1_10010.unitType = var_1_10011.UNIT_LIST_OBJ

			var_5_0:Add(var_1_10010)
		end
	end

	return var_5_0
end

function var_0_1.GetAssistantUnitNodeList(arg_6_0)
	System = var_1_10001

	local var_6_0 = var_1_10001.Collections.Generic.List_IslandUnitNode()

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.assistants) do
		local var_6_1

		if not iter_6_1.shipId then
			var_6_1 = iter_6_1.ship_id
		end

		if var_6_1 ~= 0 then
			IslandUnitNode = var_1_10008
			var_1_10008 = var_1_10008.New()
			var_1_10008.unitId = var_6_1
			IslandConst = var_1_10009
			var_1_10008.unitType = var_1_10009.UNIT_LIST_MANAGE

			var_6_0:Add(var_1_10008)
		end
	end

	return var_6_0
end

function var_0_1.GetCustomerUnitNodeList(arg_7_0)
	System = var_1_10001

	local var_7_0 = var_1_10001.Collections.Generic.List_IslandUnitNode()
	local var_7_1 = arg_7_0.restaurant
	local var_7_2 = var_2.getConfig(var_7_1, "customer_slot")

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(var_7_2) do
		local var_7_3 = iter_7_1[1]

		IslandUnitNode = var_1_10009
		var_1_10009 = var_1_10009.New()
		var_1_10009.unitId = var_7_3
		IslandConst = var_1_10010
		var_1_10009.unitType = var_1_10010.UNIT_LIST_MANAGE

		var_7_0:Add(var_1_10009)
	end

	return var_7_0
end

function var_0_1.GetFoodUnitIds(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = arg_8_0.restaurant
	local var_8_2 = var_2.getConfig(var_8_1, "customer_slot")

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(var_8_2) do
		local var_8_3 = iter_8_1[2]

		table = var_1_10009

		var_1_10009.insert(var_8_0, var_8_3)
	end

	return var_8_0
end

function var_0_1.GetStatus(arg_9_0)
	local var_9_0 = arg_9_0.restaurant

	return var_1.GetStatus(var_9_0)
end

function var_0_1.GetRestId(arg_10_0)
	return arg_10_0.restaurant.id
end

function var_0_1.GetPostList(arg_11_0)
	local var_11_0 = arg_11_0.restaurant

	return var_1.GetAssistants(var_11_0)
end

return var_0_1
