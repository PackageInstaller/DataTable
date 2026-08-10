return {
	GetEquipHaveNum = function(arg_1_0)
		local var_1_0 = IllustratedData:GetEquipInfo()[arg_1_0]

		if var_1_0 then
			local var_1_1 = 0

			for iter_1_0, iter_1_1 in pairs(var_1_0.pos_list) do
				if iter_1_1 == 1 then
					var_1_1 = var_1_1 + 1
				end
			end

			return var_1_1
		end

		return 0
	end,
	GetEquipAll = function()
		local var_2_0 = IllustratedData:GetEquipInfo()
		local var_2_1 = 0

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			for iter_2_2, iter_2_3 in pairs(iter_2_1.pos_list) do
				if iter_2_3 == 1 then
					var_2_1 = var_2_1 + 1
				end
			end
		end

		return var_2_1
	end,
	GetIllustrationNotRewardList = function()
		local var_3_0 = IllustratedData:GetIllustrationInfo()
		local var_3_1 = {}

		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if iter_3_1.is_receive == 0 then
				table.insert(var_3_1, iter_3_0)
			end
		end

		return var_3_1
	end
}
