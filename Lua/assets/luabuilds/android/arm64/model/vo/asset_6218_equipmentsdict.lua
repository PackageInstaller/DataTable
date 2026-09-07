local EquipmentsDict = class("EquipmentsDict")

function EquipmentsDict:Ctor()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs((getProxy(EquipmentProxy):GetEquipmentsRaw())) do
		var_1_0[iter_1_1.id] = var_1_0[iter_1_1.id] or {}

		table.insert(var_1_0[iter_1_1.id], CreateShell(iter_1_1))
	end

	for iter_1_2, iter_1_3 in pairs(getProxy(BayProxy):GetEquipsInShipsRaw()) do
		var_1_0[iter_1_3.id] = var_1_0[iter_1_3.id] or {}

		table.insert(var_1_0[iter_1_3.id], iter_1_3)
	end

	self.data = var_1_0

	return
end

function EquipmentsDict:GetSameTypeInEquips(arg_2_1)
	local var_2_0 = {}
	local var_2_1 = Equipment.getConfigData(arg_2_1)

	while var_2_1 do
		if self.data[var_2_1.id] then
			table.insertto(var_2_0, self.data[var_2_1.id])
		end

		var_2_1 = var_2_1.next and Equipment.getConfigData(var_2_1.next)
	end

	return var_2_0
end

function EquipmentsDict:GetEquipmentTransformCandicates(arg_3_1)
	local var_3_0 = _.map(self:GetSameTypeInEquips(arg_3_1), function(arg_4_0)
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

function EquipmentsDict:GetEquipTraceBack(arg_5_1, arg_5_2, arg_5_3)
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

		local var_5_4 = self:GetEquipmentTransformCandicates(var_5_2)

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
			self:GetEquipTraceBack(var_5_2, var_5_3, arg_5_3)
		end
	end

	return arg_5_3
end

function EquipmentsDict:GetSortedEquipTraceBack(...)
	local var_7_0 = self:GetEquipTraceBack(...)

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

function EquipmentsDict:FindTheEquip(arg_9_1)
	if not arg_9_1 or not self.data[arg_9_1.id] then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(self.data[arg_9_1.id]) do
		if EquipmentProxy.SameEquip(arg_9_1, iter_9_1) then
			return iter_9_0, iter_9_1
		end
	end

	return
end

function EquipmentsDict:AddEquipment(arg_10_1)
	self.data[arg_10_1.id] = self.data[arg_10_1.id] or {}
	self.data[arg_10_1.id][self:FindTheEquip(arg_10_1) or #self.data[arg_10_1.id] + 1] = arg_10_1

	return
end

function EquipmentsDict:RemoveEquipment(arg_11_1)
	if not arg_11_1 or not self.data[arg_11_1.id] then
		return
	end

	local var_11_0 = self:FindTheEquip(arg_11_1)

	if not var_11_0 then
		return
	end

	table.remove(self.data[arg_11_1.id], var_11_0)

	return
end

function EquipmentsDict:UpdateEquipment(arg_12_1)
	if arg_12_1.count == 0 then
		self:RemoveEquipment(arg_12_1)
	else
		self:AddEquipment(arg_12_1)
	end

	return
end

return EquipmentsDict
