local var_0_0 = {}

var_0_0.__name = "EquipmentTransformUtil"

function var_0_0:SameDrop(arg_1_1)
	if self.type ~= arg_1_1.type then
		return false
	end

	if self.type == DROP_TYPE_EQUIP then
		return EquipmentProxy.SameEquip(self.template, arg_1_1.template)
	else
		return self.id == arg_1_1.id
	end

	return
end

function var_0_0.CheckEquipmentFormulasSucceed(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(PlayerProxy)
	local var_2_1 = getProxy(BagProxy)
	local var_2_2 = {}
	local var_2_3 = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		local var_2_4 = pg.equip_upgrade_data[iter_2_1]
		local var_2_5 = Equipment.GetRevertRewardsStatic(var_2_3)

		assert(Equipment.CanInBag(var_2_3), "Missing equip_data_template ID: " .. (var_2_3 or "NIL"))

		local var_2_6 = Equipment.CanInBag(var_2_3) and Equipment.getConfigData(var_2_3).destory_gold or 0

		var_2_3 = Equipment.GetEquipRootStatic(var_2_3)

		assert(var_2_4 and var_2_4.upgrade_from == var_2_3, "Transform a non formula equipment, formula " .. (iter_2_1 or -1) .. " equipment " .. (var_2_3 or -1))

		for iter_2_2, iter_2_3 in ipairs(var_2_4.material_consume) do
			local var_2_7 = var_2_2[iter_2_3[1]]

			if not var_2_2[iter_2_3[1]] then
				var_2_7 = var_2_1:getItemCountById(iter_2_3[1])
				var_2_7 = var_2_7 or 0
			end

			var_2_2[iter_2_3[1]] = var_2_7 - iter_2_3[2]

			if var_2_2[iter_2_3[1]] < 0 then
				local var_2_8 = Item.getConfigData(iter_2_3[1])

				return false, var_2_8 and var_2_8.name
			end
		end

		local var_2_9 = var_2_2.gold

		if not var_2_2.gold then
			var_2_9 = var_2_0:getRawData().gold
			var_2_9 = var_2_9 or 0
		end

		var_2_2.gold = var_2_9 - var_2_4.coin_consume

		if var_2_2.gold < 0 then
			local var_2_11 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGold
			}):getName()

			return
		end

		for iter_2_4, iter_2_5 in pairs(var_2_5) do
			if iter_2_4 ~= "gold" then
				var_2_2[iter_2_4] = (var_2_2[iter_2_4] or 0) + iter_2_5
			end
		end

		var_2_2.gold = (var_2_2.gold or 0) + var_2_6
		var_2_3 = var_2_4.target_id
	end

	return true
end

function var_0_0.CheckTransformFormulasSucceed(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(BagProxy)
	local var_3_1 = {}

	var_3_1.gold = getProxy(PlayerProxy):getRawData().gold or 0

	local var_3_2

	if arg_3_1.type == DROP_TYPE_EQUIP then
		var_3_2 = arg_3_1.id

		if not arg_3_1.template.shipId then
			local var_3_3 = getProxy(EquipmentProxy):getEquipmentById(var_3_2)

			if not var_3_3 or var_3_3.count <= 0 then
				return false, Equipment.getConfigData(var_3_2).name
			end
		end
	elseif arg_3_1.type == DROP_TYPE_ITEM then
		if var_3_1.gold < arg_3_1.composeCfg.gold_num then
			local var_3_5 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGold
			}):getName()

			return
		elseif (var_3_0:getItemCountById(arg_3_1.composeCfg.material_id) or 0) < arg_3_1.composeCfg.material_num then
			return false, Item.getConfigData(arg_3_1.composeCfg.material_id).name
		end

		var_3_1.gold = var_3_1.gold - arg_3_1.composeCfg.gold_num
		var_3_2 = arg_3_1.composeCfg.equip_id
	end

	assert(var_3_2)

	local var_3_6 = var_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		local var_3_7 = pg.equip_upgrade_data[iter_3_1]
		local var_3_8 = Equipment.GetRevertRewardsStatic(var_3_6)

		assert(Equipment.CanInBag(var_3_6), "Missing equip_data_template ID: " .. (var_3_6 or "NIL"))

		local var_3_9 = Equipment.CanInBag(var_3_6) and Equipment.getConfigData(var_3_6).destory_gold or 0

		var_3_6 = Equipment.GetEquipRootStatic(var_3_6)

		assert(var_3_7 and var_3_7.upgrade_from == var_3_6, "Transform a non formula equipment, formula " .. (iter_3_1 or -1) .. " equipment " .. (var_3_6 or -1))

		for iter_3_2, iter_3_3 in ipairs(var_3_7.material_consume) do
			local var_3_10 = var_3_1[iter_3_3[1]]

			if not var_3_1[iter_3_3[1]] then
				var_3_10 = var_3_0:getItemCountById(iter_3_3[1])
				var_3_10 = var_3_10 or 0
			end

			var_3_1[iter_3_3[1]] = var_3_10 - iter_3_3[2]

			if var_3_1[iter_3_3[1]] < 0 then
				local var_3_11 = Item.getConfigData(iter_3_3[1])

				return false, var_3_11 and var_3_11.name
			end
		end

		var_3_1.gold = var_3_1.gold - var_3_7.coin_consume

		if var_3_1.gold < 0 then
			local var_3_13 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGold
			}):getName()

			return
		end

		for iter_3_4, iter_3_5 in pairs(var_3_8) do
			if iter_3_4 ~= "gold" then
				var_3_1[iter_3_4] = (var_3_1[iter_3_4] or var_3_0:getItemCountById(iter_3_4)) + iter_3_5
			end
		end

		var_3_1.gold = (var_3_1.gold or 0) + var_3_9
		var_3_6 = var_3_7.target_id
	end

	return true
end

function var_0_0.CheckTransformEnoughGold(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(BagProxy)
	local var_4_1 = getProxy(PlayerProxy):getRawData().gold or 0
	local var_4_2 = 0
	local var_4_3 = 0
	local var_4_4 = true
	local var_4_5

	if arg_4_1.type == DROP_TYPE_EQUIP then
		var_4_5 = arg_4_1.id
	elseif arg_4_1.type == DROP_TYPE_ITEM then
		var_4_1 = var_4_1 - arg_4_1.composeCfg.gold_num
		var_4_3 = var_4_3 + arg_4_1.composeCfg.gold_num
		var_4_4 = var_4_4 and var_4_1 >= 0
		var_4_5 = arg_4_1.composeCfg.equip_id
	end

	assert(var_4_5)

	local var_4_6 = var_4_5

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		local var_4_7 = pg.equip_upgrade_data[iter_4_1]
		local var_4_8 = Equipment.GetRevertRewardsStatic(var_4_6)

		assert(Equipment.CanInBag(var_4_6), "Missing equip_data_template ID: " .. (var_4_6 or "NIL"))

		local var_4_9 = Equipment.CanInBag(var_4_6) and Equipment.getConfigData(var_4_6).destory_gold or 0

		var_4_6 = Equipment.GetEquipRootStatic(var_4_6)

		assert(var_4_7 and var_4_7.upgrade_from == var_4_6, "Transform a non formula equipment, formula " .. (iter_4_1 or -1) .. " equipment " .. (var_4_6 or -1))

		var_4_1 = var_4_1 - var_4_7.coin_consume
		var_4_2 = var_4_2 + var_4_7.coin_consume
		var_4_4 = var_4_4 and var_4_1 >= 0

		for iter_4_2, iter_4_3 in pairs(var_4_8) do
			if iter_4_2 ~= "gold" then
				var_4_1 = var_4_1 + iter_4_3
			end
		end

		var_4_1 = var_4_1 + var_4_9
		var_4_6 = var_4_7.target_id
	end

	return var_4_4, var_4_2, var_4_3
end

return var_0_0
