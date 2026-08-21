local var_0_0 = class("EquipmentsDict")

function var_0_0.Ctor(arg_1_0)
	for iter_1_0, iter_1_1 in pairs((getProxy(EquipmentProxy):GetEquipmentsRaw())) do
		local var_1_0 = ({})[iter_1_1.id]

		if not ({})[iter_1_1.id] then
			var_1_0 = {}
		end

		;({})[iter_1_1.id] = var_1_0

		table.insert(({})[iter_1_1.id], CreateShell(iter_1_1))
	end

	for iter_1_2, iter_1_3 in pairs(getProxy(BayProxy):GetEquipsInShipsRaw()) do
		local var_1_1 = ({})[iter_1_3.id]

		if not ({})[iter_1_3.id] then
			var_1_1 = {}
		end

		;({})[iter_1_3.id] = var_1_1

		table.insert(({})[iter_1_3.id], iter_1_3)
	end

	arg_1_0.data = {}

	return
end

function var_0_0.GetSameTypeInEquips(arg_2_0, arg_2_1)
	local var_2_0 = Equipment.getConfigData(arg_2_1)

	while var_2_0 do
		if arg_2_0.data[var_2_0.id] then
			table.insertto({}, arg_2_0.data[var_2_0.id])
		end

		var_2_0 = var_2_0.next and Equipment.getConfigData(var_2_0.next)
	end

	return {}
end

function var_0_0.GetEquipmentTransformCandicates(arg_3_0, arg_3_1)
	local var_3_0 = _.map(arg_3_0:GetSameTypeInEquips(arg_3_1), function(arg_4_0)
		return {
			type = DROP_TYPE_EQUIP,
			id = arg_4_0.id,
			template = arg_4_0
		}
	end)
	local var_3_1 = Equipment.GetEquipComposeCfgStatic({
		equip_id = arg_3_1
	})

	if var_3_1 then
		local var_3_2 = getProxy(BagProxy):getItemById(var_3_1.material_id)

		var_3_2 = var_3_2 or Item.New({
			count = 0,
			id = var_3_1.material_id
		})

		table.insert(var_3_0, 1, {
			type = DROP_TYPE_ITEM,
			id = var_3_1.material_id,
			template = var_3_2,
			composeCfg = var_3_1
		})
	end

	return var_3_0
end

function var_0_0.GetEquipTraceBack(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_2 = arg_5_2 or {
		arg_5_1
	}
	arg_5_3 = arg_5_3 or {}

	local var_5_1 = EquipmentProxy.GetTransformSources(arg_5_1)

	if #var_5_1 == 0 then
		table.insert(arg_5_3, arg_5_2)
	end

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = pg.equip_upgrade_data[iter_5_1].upgrade_from
		local var_5_3 = iter_5_0 == #var_5_1 and arg_5_2 or Clone(arg_5_2)

		table.insert(var_5_3, pg.equip_upgrade_data[iter_5_1].upgrade_from)

		var_5_3.formulas = var_5_3.formulas or {}

		table.insert(var_5_3.formulas, 1, iter_5_1)

		local var_5_4 = arg_5_0:GetEquipmentTransformCandicates(var_5_2)

		if _.any(var_5_4, function(arg_6_0)
			if arg_6_0.type == DROP_TYPE_ITEM then
				return arg_6_0.template.count >= arg_6_0.composeCfg.material_num
			elseif arg_6_0.type == DROP_TYPE_EQUIP then
				return arg_6_0.template.count > 0
			end

			return
		end) then
			var_5_3.candicates = var_5_4

			table.insert(arg_5_3, var_5_3)
		elseif var_5_2 == 0 then
			assert(false, "ERROR Source Equip ID 0")

			var_5_3.candicates = {
				setmetatable({
					id = 0
				}, Equipment)
			}

			table.insert(arg_5_3, var_5_3)
		else
			arg_5_0:GetEquipTraceBack(var_5_2, var_5_3, arg_5_3)
		end
	end

	return arg_5_3
end

function var_0_0.GetSortedEquipTraceBack(arg_7_0, ...)
	local var_7_0 = arg_7_0:GetEquipTraceBack(...)

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		if #arg_8_0 ~= #arg_8_1 then
			return #arg_8_0 < #arg_8_1
		else
			for iter_8_0 = 1, #arg_8_0 do
				if arg_8_0[iter_8_0] ~= arg_8_1[iter_8_0] then
					return arg_8_0[iter_8_0] < arg_8_1[iter_8_0]
				end
			end

			return false
		end

		return
	end)

	return var_7_0
end

function var_0_0.FindTheEquip(arg_9_0, arg_9_1)
	if not arg_9_1 or not arg_9_0.data[arg_9_1.id] then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.data[arg_9_1.id]) do
		if EquipmentProxy.SameEquip(arg_9_1, iter_9_1) then
			return iter_9_0, iter_9_1
		end
	end

	return
end

function var_0_0.AddEquipment(arg_10_0, arg_10_1)
	arg_10_0.data[arg_10_1.id] = arg_10_0.data[arg_10_1.id] or {}

	local var_10_0 = arg_10_0:FindTheEquip(arg_10_1) or #arg_10_0.data[arg_10_1.id] + 1

	arg_10_0.data[arg_10_1.id][var_10_0] = arg_10_1

	return
end

function var_0_0.RemoveEquipment(arg_11_0, arg_11_1)
	if not arg_11_1 or not arg_11_0.data[arg_11_1.id] then
		return
	end

	local var_11_0 = arg_11_0:FindTheEquip(arg_11_1)

	if not var_11_0 then
		return
	end

	table.remove(arg_11_0.data[arg_11_1.id], var_11_0)

	return
end

function var_0_0.UpdateEquipment(arg_12_0, arg_12_1)
	if arg_12_1.count == 0 then
		arg_12_0:RemoveEquipment(arg_12_1)
	else
		arg_12_0:AddEquipment(arg_12_1)
	end

	return
end

return var_0_0
