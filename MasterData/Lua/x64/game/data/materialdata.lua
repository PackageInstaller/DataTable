local var_0_0 = singletonClass("MaterialData")

function var_0_0.Init(arg_1_0)
	arg_1_0.materialList_ = {}
	arg_1_0.expiredMaterialList_ = {}
end

function var_0_0:InitExpiredMaterialList(arg_2_1)
	self.expiredMaterialList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_1.num > 0 then
			table.insert(self.expiredMaterialList_, {
				id = iter_2_1.id,
				num = iter_2_1.num,
				timeValid = iter_2_1.time_valid
			})
		end
	end

	manager.notify:Invoke(MATERIAL_EXPIRED)
end

function var_0_0:InitMaterialList(arg_3_1)
	self.materialList_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self.materialList_[iter_3_1.id] = self.materialList_[iter_3_1.id] or {}
		self.materialList_[iter_3_1.id][iter_3_1.time_valid or 0] = iter_3_1.num
	end

	manager.notify:Invoke(MATERIAL_INIT)
end

function var_0_0:SetMaterialValue(arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = arg_4_3 or 0
	self.materialList_[arg_4_1] = self.materialList_[arg_4_1] or {}

	local var_4_0 = self.materialList_[arg_4_1][arg_4_3] == nil or arg_4_2 == 0

	if arg_4_2 == 0 then
		self.materialList_[arg_4_1][arg_4_3] = nil
	else
		self.materialList_[arg_4_1][arg_4_3] = arg_4_2
	end

	manager.notify:Invoke(MATERIAL_MODIFY, arg_4_1, arg_4_3, arg_4_2)

	if var_4_0 then
		manager.notify:Invoke(MATERIAL_LIST_UPDATE, arg_4_1)
	end
end

function var_0_0:GetMaterialNum(arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or 0

	if self.materialList_[arg_5_1] == nil then
		return 0
	else
		return self.materialList_[arg_5_1][arg_5_2] or 0
	end
end

function var_0_0:GetTotalMaterialNum(arg_6_1)
	local var_6_0 = 0

	if self.materialList_[arg_6_1] then
		for iter_6_0, iter_6_1 in pairs(self.materialList_[arg_6_1]) do
			var_6_0 = var_6_0 + iter_6_1
		end
	end

	return var_6_0
end

function var_0_0:MaterialList()
	return self.materialList_
end

function var_0_0:GetMaterialListById(arg_8_1)
	return self.materialList_[arg_8_1] or {}
end

function var_0_0:CheckExpiredMaterialList()
	return self.expiredMaterialList_
end

function var_0_0.ClearExpiredMaterialList(arg_10_0)
	arg_10_0.expiredMaterialList_ = {}
end

function var_0_0:IsItemInExpiredMaterialList(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self.expiredMaterialList_) do
		if iter_11_1.id == arg_11_1.id then
			return true
		end
	end

	return false
end

function var_0_0:IsItemHaveServeTick(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(self.materialList_[arg_12_1] or {}) do
		if iter_12_0 > 0 then
			return true
		end
	end

	return false
end

return var_0_0
