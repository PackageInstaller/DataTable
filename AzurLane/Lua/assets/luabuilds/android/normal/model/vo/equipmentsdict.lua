class = var_0_10000

local var_0_0 = var_0_10000("EquipmentsDict")

function var_0_0.Ctor(arg_1_0)
	local var_1_0 = {}

	getProxy = var_1_10002
	EquipmentProxy = var_1_10003

	local var_1_1 = var_1_10002(var_1_10003)
	local var_1_2 = var_2.GetEquipmentsRaw(var_1_1)

	pairs = var_1_1

	for iter_1_0, iter_1_1 in var_1_1(var_1_2) do
		local var_1_3 = iter_1_1.id
		local var_1_4

		if not var_1_0[iter_1_1.id] then
			var_1_4 = {}
		end

		var_1_0[var_1_3] = var_1_4
		table = var_1_3

		local var_1_5 = var_1_3.insert
		local var_1_6 = var_1_0[iter_1_1.id]

		CreateShell = var_1_10010

		var_1_5(var_1_6, var_1_10010(iter_1_1))
	end

	pairs = var_3
	getProxy = var_4
	BayProxy = var_5

	local var_1_7 = var_4(var_5)

	for iter_1_2, iter_1_3 in var_3(var_4.GetEquipsInShipsRaw(var_1_7)) do
		local var_1_8 = iter_1_3.id
		local var_1_9

		if not var_1_0[iter_1_3.id] then
			var_1_9 = {}
		end

		var_1_0[var_1_8] = var_1_9
		table = var_1_8

		var_1_8.insert(var_1_0[iter_1_3.id], iter_1_3)
	end

	arg_1_0.data = var_1_0

	return
end

function var_0_0.GetSameTypeInEquips(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = arg_2_0.data

	Equipment = var_1_10004

	local var_2_2 = var_1_10004.getConfigData(arg_2_1)

	while var_2_2 do
		if var_2_1[var_2_2.id] then
			table = var_5

			var_5.insertto(var_2_0, var_2_1[var_2_2.id])
		end

		if var_2_2.next then
			::label_2_0::

			Equipment = var_5
			var_2_2 = var_5.getConfigData(var_2_2.next)
		end
	end

	return var_2_0
end

function var_0_0.GetEquipmentTransformCandicates(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GetSameTypeInEquips(var_3_0, arg_3_1)

	_ = var_3_0

	local var_3_2 = var_3_0.map(var_3_1, function(arg_4_0)
		local var_4_0 = {}

		DROP_TYPE_EQUIP = var_2_10002
		var_4_0.type = var_2_10002
		var_4_0.id = arg_4_0.id
		var_4_0.template = arg_4_0

		return var_4_0
	end)

	Equipment = var_3

	if var_3.GetEquipComposeCfgStatic({
		equip_id = arg_3_1
	}) then
		getProxy = var_4
		BagProxy = var_5

		local var_3_3 = var_4(var_5)
		local var_3_4

		if not var_4.getItemById(var_3_3, var_3.material_id) then
			Item = var_3_4
			var_3_4 = var_3_4.New({
				count = 0,
				id = var_3.material_id
			})
		end

		table = var_3_3

		local var_3_5 = var_3_3.insert
		local var_3_6 = var_3_2
		local var_3_7 = 1
		local var_3_8 = {}

		DROP_TYPE_ITEM = var_1_10009
		var_3_8.type = var_1_10009
		var_3_8.id = var_3.material_id
		var_3_8.template = var_3_4
		var_3_8.composeCfg = var_3

		var_3_5(var_3_6, var_3_7, var_3_8)
	end

	return var_3_2
end

function var_0_0.GetEquipTraceBack(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0.data

	arg_5_2 = arg_5_2 or {
		arg_5_1
	}
	arg_5_3 = arg_5_3 or {}
	EquipmentProxy = var_1_10005

	if #var_1_10005.GetTransformSources(arg_5_1) == 0 then
		table = var_6

		var_6.insert(arg_5_3, arg_5_2)
	end

	ipairs = var_6

	for iter_5_0, iter_5_1 in var_6(var_5) do
		pg = var_1_10011
		var_1_10011 = var_1_10011.equip_upgrade_data[iter_5_1].upgrade_from

		local var_5_1

		if iter_5_0 ~= #var_5 or not arg_5_2 then
			::label_5_0::

			Clone = var_5_1
			var_5_1 = var_5_1(arg_5_2)
		end

		table = var_1_10013

		var_1_10013.insert(var_5_1, var_1_10011)

		if not var_5_1.formulas then
			var_1_10013 = {}
		end

		var_5_1.formulas = var_1_10013
		table = var_1_10013

		var_1_10013.insert(var_5_1.formulas, 1, iter_5_1)

		local var_5_2 = arg_5_0

		var_1_10013 = arg_5_0.GetEquipmentTransformCandicates(var_5_2, var_1_10011)
		_ = var_5_2

		if var_5_2.any(var_1_10013, function(arg_6_0)
			local var_6_0 = arg_6_0.type

			DROP_TYPE_ITEM = var_2_10002

			if var_6_0 == var_2_10002 then
				local var_6_1 = arg_6_0.template.count

				return arg_6_0.composeCfg.material_num <= var_6_1
			else
				local var_6_2 = arg_6_0.type

				DROP_TYPE_EQUIP = var_2_10002

				if var_6_2 == var_2_10002 then
					return arg_6_0.template.count > 0
				end
			end

			return
		end) then
			var_5_1.candicates = var_1_10013
			table = var_14

			var_14.insert(arg_5_3, var_5_1)
		elseif var_1_10011 == 0 then
			assert = var_14

			var_14(false, "ERROR Source Equip ID 0")

			local var_5_3 = {}

			setmetatable = var_15

			local var_5_4 = {
				id = 0
			}

			Equipment = var_1_10017
			var_5_3[1] = var_15(var_5_4, var_1_10017)
			var_5_1.candicates = var_5_3
			table = var_5_3

			var_5_3.insert(arg_5_3, var_5_1)
		else
			arg_5_0:GetEquipTraceBack(var_1_10011, var_5_1, arg_5_3)
		end
	end

	return arg_5_3
end

function var_0_0.GetSortedEquipTraceBack(arg_7_0, ...)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.GetEquipTraceBack(var_7_0, ...)

	table = var_7_0

	var_7_0.sort(var_7_1, function(arg_8_0, arg_8_1)
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

	return var_7_1
end

function var_0_0.FindTheEquip(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.data

	if not arg_9_1 or not var_9_0[arg_9_1.id] then
		return
	end

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(var_9_0[arg_9_1.id]) do
		EquipmentProxy = var_1_10008

		if var_1_10008.SameEquip(arg_9_1, iter_9_1) then
			return iter_9_0, iter_9_1
		end
	end

	return
end

function var_0_0.AddEquipment(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.data
	local var_10_1 = arg_10_1.id
	local var_10_2

	if not var_10_0[arg_10_1.id] then
		var_10_2 = {}
	end

	var_10_0[var_10_1] = var_10_2

	local var_10_3

	if not arg_10_0:FindTheEquip(arg_10_1) then
		var_10_3 = #var_10_0[arg_10_1.id] + 1
	end

	var_10_0[arg_10_1.id][var_10_3] = arg_10_1

	return
end

function var_0_0.RemoveEquipment(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.data

	if not arg_11_1 or not var_11_0[arg_11_1.id] then
		return
	end

	local var_11_1 = arg_11_0

	if not arg_11_0.FindTheEquip(var_11_1, arg_11_1) then
		return
	end

	table = var_11_1

	var_11_1.remove(var_11_0[arg_11_1.id], var_3)

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
