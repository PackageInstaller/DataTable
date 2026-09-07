local IslandManageSystemVO = class("IslandManageSystemVO", import(".IslandSystemVO"))

function IslandManageSystemVO:Ctor(arg_1_1, arg_1_2)
	IslandManageSystemVO.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.name = "_system_manage_" .. self.id
	self.restaurant = arg_1_2

	return
end

function IslandManageSystemVO:GetType()
	return IslandConst.SYSTEM_TYPE_MANAGE
end

function IslandManageSystemVO:GetBehaviourTree()
	return "island/nodecanvas/system/system_manage_place"
end

function IslandManageSystemVO:GetUnits(arg_4_1)
	local var_4_0 = {}

	self.assistants = {}
	self.assistants = arg_4_1 and arg_4_1 or self.restaurant:GetAssistants()

	for iter_4_0, iter_4_1 in ipairs(self.assistants) do
		local var_4_1 = iter_4_1.id or iter_4_1.post_id
		local var_4_2 = iter_4_1.shipId or iter_4_1.ship_id

		if var_4_2 ~= 0 then
			table.insert(var_4_0, var_4_2 == 1 and IslandUnitVO.New({
				behaviourTree = "island/nodecanvas/system/system_manage_assistant_chicken",
				id = var_4_2,
				modelId = pg.island_chara_template[var_4_2].unit_id,
				type = IslandConst.UNIT_TYPE_MANAGE_CHARA,
				name = "system_unit" .. var_4_2,
				position = pg.island_world_objects[pg.island_manage_assistant[var_4_1].birthplace].param.position,
				rotation = pg.island_world_objects[pg.island_manage_assistant[var_4_1].birthplace].param.rotation,
				scale = Vector3.one
			}) or IslandUnitVO.New({
				behaviourTree = "island/nodecanvas/system/system_manage_assistant",
				id = var_4_2,
				modelId = pg.island_chara_template[var_4_2].unit_id,
				type = IslandConst.UNIT_TYPE_MANAGE_CHARA,
				name = "system_unit" .. var_4_2,
				position = pg.island_world_objects[pg.island_manage_assistant[var_4_1].birthplace].param.position,
				rotation = pg.island_world_objects[pg.island_manage_assistant[var_4_1].birthplace].param.rotation,
				scale = Vector3.one
			}))
		end
	end

	local var_4_4 = Clone(pg.island_set.island_manage_customer_list.key_value_varchar)

	for iter_4_2, iter_4_3 in ipairs((self.restaurant:getConfig("customer_slot"))) do
		local var_4_5 = var_4_4[math.random(#var_4_4)]

		table.removebyvalue(var_4_4, var_4_5)
		table.insert(var_4_0, (IslandUnitVO.New({
			behaviourTree = "island/nodecanvas/system/system_manage_customer",
			id = iter_4_3[1],
			modelId = var_4_5,
			type = IslandConst.UNIT_TYPE_MANAGE_CUSTOMER,
			name = "system_unit" .. iter_4_3[1],
			position = pg.island_world_objects[iter_4_3[1]].param.position,
			rotation = pg.island_world_objects[iter_4_3[1]].param.rotation,
			scale = Vector3.one
		})))
		table.insert(var_4_0, (IslandUnitVO.New({
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

	return var_4_0
end

function IslandManageSystemVO:GetPostUnitNodeList()
	local var_5_0 = System.Collections.Generic.List_IslandUnitNode()

	for iter_5_0, iter_5_1 in ipairs(self.assistants) do
		if (iter_5_1.shipId or iter_5_1.ship_id) ~= 0 then
			local var_5_2 = IslandUnitNode.New()

			var_5_2.unitId = pg.island_manage_assistant[iter_5_1.id or iter_5_1.post_id].birthplace
			var_5_2.unitType = IslandConst.UNIT_LIST_OBJ

			var_5_0:Add(var_5_2)
		end
	end

	return var_5_0
end

function IslandManageSystemVO:GetAssistantUnitNodeList()
	local var_6_0 = System.Collections.Generic.List_IslandUnitNode()

	for iter_6_0, iter_6_1 in ipairs(self.assistants) do
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

function IslandManageSystemVO:GetCustomerUnitNodeList()
	local var_7_0 = System.Collections.Generic.List_IslandUnitNode()

	for iter_7_0, iter_7_1 in ipairs((self.restaurant:getConfig("customer_slot"))) do
		local var_7_1 = IslandUnitNode.New()

		var_7_1.unitId = iter_7_1[1]
		var_7_1.unitType = IslandConst.UNIT_LIST_MANAGE

		var_7_0:Add(var_7_1)
	end

	return var_7_0
end

function IslandManageSystemVO:GetFoodUnitIds()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs((self.restaurant:getConfig("customer_slot"))) do
		table.insert(var_8_0, iter_8_1[2])
	end

	return var_8_0
end

function IslandManageSystemVO:GetStatus()
	return self.restaurant:GetStatus()
end

function IslandManageSystemVO:GetRestId()
	return self.restaurant.id
end

function IslandManageSystemVO:GetPostList()
	return self.restaurant:GetAssistants()
end

return IslandManageSystemVO
