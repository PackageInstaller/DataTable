local var_0_0 = singletonClass("MaterialData")

function var_0_0.Init(arg_1_0)
	arg_1_0.materialList_ = {}
	arg_1_0.expiredMaterialList_ = {}
end

function var_0_0.InitExpiredMaterialList(arg_2_0, arg_2_1)
	arg_2_0.expiredMaterialList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_1.num > 0 then
			table.insert(arg_2_0.expiredMaterialList_, {
				id = iter_2_1.id,
				num = iter_2_1.num,
				timeValid = iter_2_1.time_valid
			})
		end
	end

	manager.notify:Invoke(MATERIAL_EXPIRED)
end

function var_0_0.InitMaterialList(arg_3_0, arg_3_1)
	arg_3_0.materialList_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = iter_3_1.id
		local var_3_1 = iter_3_1.time_valid or 0
		local var_3_2 = iter_3_1.num

		arg_3_0.materialList_[var_3_0] = arg_3_0.materialList_[var_3_0] or {}
		arg_3_0.materialList_[var_3_0][var_3_1] = var_3_2
	end

	manager.notify:Invoke(MATERIAL_INIT)
end

function var_0_0.SetMaterialValue(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = arg_4_3 or 0
	arg_4_0.materialList_[arg_4_1] = arg_4_0.materialList_[arg_4_1] or {}

	local var_4_0 = false

	if arg_4_0.materialList_[arg_4_1][arg_4_3] == nil or arg_4_2 == 0 then
		var_4_0 = true
	end

	if arg_4_2 == 0 then
		arg_4_0.materialList_[arg_4_1][arg_4_3] = nil
	else
		arg_4_0.materialList_[arg_4_1][arg_4_3] = arg_4_2
	end

	manager.notify:Invoke(MATERIAL_MODIFY, arg_4_1, arg_4_3, arg_4_2)

	if var_4_0 then
		manager.notify:Invoke(MATERIAL_LIST_UPDATE, arg_4_1)
	end
end

function var_0_0.GetMaterialNum(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or 0

	if arg_5_0.materialList_[arg_5_1] == nil then
		return 0
	else
		return arg_5_0.materialList_[arg_5_1][arg_5_2] or 0
	end
end

function var_0_0.GetTotalMaterialNum(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = arg_6_0.materialList_[arg_6_1]

	if var_6_1 then
		for iter_6_0, iter_6_1 in pairs(var_6_1) do
			var_6_0 = var_6_0 + iter_6_1
		end
	end

	return var_6_0
end

function var_0_0.MaterialList(arg_7_0)
	return arg_7_0.materialList_
end

function var_0_0.GetMaterialListById(arg_8_0, arg_8_1)
	return arg_8_0.materialList_[arg_8_1] or {}
end

function var_0_0.CheckExpiredMaterialList(arg_9_0)
	return arg_9_0.expiredMaterialList_
end

function var_0_0.ClearExpiredMaterialList(arg_10_0)
	arg_10_0.expiredMaterialList_ = {}
end

function var_0_0.IsItemInExpiredMaterialList(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.expiredMaterialList_) do
		if iter_11_1.id == arg_11_1.id then
			return true
		end
	end

	return false
end

function var_0_0.IsItemHaveServeTick(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.materialList_[arg_12_1] or {}) do
		if iter_12_0 > 0 then
			return true
		end
	end

	return false
end

return var_0_0
