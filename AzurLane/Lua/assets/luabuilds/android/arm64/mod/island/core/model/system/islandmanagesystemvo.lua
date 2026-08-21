local var_0_0 = class("IslandManageSystemVO", import(".IslandSystemVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.name = "_system_manage_" .. arg_1_0.id
	arg_1_0.restaurant = arg_1_2

	return
end

function var_0_0.GetType(arg_2_0)
	return IslandConst.SYSTEM_TYPE_MANAGE
end

function var_0_0.GetBehaviourTree(arg_3_0)
	return "island/nodecanvas/system/system_manage_place"
end

function var_0_0.GetUnits(arg_4_0, arg_4_1)
	arg_4_0.assistants = {}
	arg_4_0.assistants = arg_4_1 and arg_4_1 or arg_4_0.restaurant:GetAssistants()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.assistants) do
		local var_4_0 = iter_4_1.id or iter_4_1.post_id
		local var_4_1 = iter_4_1.shipId or iter_4_1.ship_id

		if var_4_1 ~= 0 then
			local var_4_2 = var_4_1 == 1 and IslandUnitVO.New({
				behaviourTree = "island/nodecanvas/system/system_manage_assistant_chicken",
				id = var_4_1,
				modelId = pg.island_chara_template[var_4_1].unit_id,
				type = IslandConst.UNIT_TYPE_MANAGE_CHARA,
				name = "system_unit" .. var_4_1,
				position = pg.island_world_objects[pg.island_manage_assistant[var_4_0].birthplace].param.position,
				rotation = pg.island_world_objects[pg.island_manage_assistant[var_4_0].birthplace].param.rotation,
				scale = Vector3.one
			}) or IslandUnitVO.New({
				behaviourTree = "island/nodecanvas/system/system_manage_assistant",
				id = var_4_1,
				modelId = pg.island_chara_template[var_4_1].unit_id,
				type = IslandConst.UNIT_TYPE_MANAGE_CHARA,
				name = "system_unit" .. var_4_1,
				position = pg.island_world_objects[pg.island_manage_assistant[var_4_0].birthplace].param.position,
				rotation = pg.island_world_objects[pg.island_manage_assistant[var_4_0].birthplace].param.rotation,
				scale = Vector3.one
			})

			table.insert({}, var_4_2)
		end
	end

	local var_4_3 = Clone(pg.island_set.island_manage_customer_list.key_value_varchar)

	for iter_4_2, iter_4_3 in ipairs((arg_4_0.restaurant:getConfig("customer_slot"))) do
		local var_4_4 = var_4_3[math.random(#var_4_3)]

		table.removebyvalue(var_4_3, var_4_4)
		table.insert({}, (IslandUnitVO.New({
			behaviourTree = "island/nodecanvas/system/system_manage_customer",
			id = iter_4_3[1],
			modelId = var_4_4,
			type = IslandConst.UNIT_TYPE_MANAGE_CUSTOMER,
			name = "system_unit" .. iter_4_3[1],
			position = pg.island_world_objects[iter_4_3[1]].param.position,
			rotation = pg.island_world_objects[iter_4_3[1]].param.rotation,
			scale = Vector3.one
		})))
		table.insert({}, (IslandUnitVO.New({
			behaviourTree = "",
			id = iter_4_3[2],
			modelId = pg.island_world_objects[iter_4_3[2]].unitId,
			type = IslandConst.UNIT_TYPE_MANAGE_ITEM,
			name = "system_unit" .. iter_4_3[2],
			position = pg.island_world_objects[iter_4_3[2]].param.position,
			rotation = pg.island_world_objects[iter_4_3[2]].param.rotation,
			scale = Vector3.one
		})))
	end

	return {}
end

function var_0_0.GetPostUnitNodeList(arg_5_0)
	local var_5_0 = System.Collections.Generic.List_IslandUnitNode()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.assistants) do
		local var_5_1 = iter_5_1.id or iter_5_1.post_id
		local var_5_2 = iter_5_1.shipId or iter_5_1.ship_id

		if var_5_2 ~= 0 then
			local var_5_3 = IslandUnitNode.New()

			var_5_3.unitId = pg.island_manage_assistant[var_5_1].birthplace
			var_5_3.unitType = IslandConst.UNIT_LIST_OBJ

			var_5_0:Add(var_5_3)
		end
	end

	return var_5_0
end

function var_0_0.GetAssistantUnitNodeList(arg_6_0)
	local var_6_0 = System.Collections.Generic.List_IslandUnitNode()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.assistants) do
		local var_6_1 = iter_6_1.shipId or iter_6_1.ship_id

		if var_6_1 ~= 0 then
			local var_6_2 = IslandUnitNode.New()

			var_6_2.unitId = var_6_1
			var_6_2.unitType = IslandConst.UNIT_LIST_MANAGE

			var_6_0:Add(var_6_2)
		end
	end

	return var_6_0
end

function var_0_0.GetCustomerUnitNodeList(arg_7_0)
	local var_7_0 = System.Collections.Generic.List_IslandUnitNode()

	for iter_7_0, iter_7_1 in ipairs((arg_7_0.restaurant:getConfig("customer_slot"))) do
		local var_7_1 = IslandUnitNode.New()

		var_7_1.unitId = iter_7_1[1]
		var_7_1.unitType = IslandConst.UNIT_LIST_MANAGE

		var_7_0:Add(var_7_1)
	end

	return var_7_0
end

function var_0_0.GetFoodUnitIds(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs((arg_8_0.restaurant:getConfig("customer_slot"))) do
		table.insert({}, iter_8_1[2])
	end

	return {}
end

function var_0_0.GetStatus(arg_9_0)
	return arg_9_0.restaurant:GetStatus()
end

function var_0_0.GetRestId(arg_10_0)
	return arg_10_0.restaurant.id
end

function var_0_0.GetPostList(arg_11_0)
	return arg_11_0.restaurant:GetAssistants()
end

return var_0_0
