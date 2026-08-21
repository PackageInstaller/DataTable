return {
	CalHeroEquipAttribute = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = {
			0,
			0,
			0,
			0,
			0
		}
		local var_1_1 = arg_1_0:GetEquipDataList(arg_1_1)
		local var_1_2 = {}

		if arg_1_2 then
			var_1_1 = arg_1_2
			var_1_2 = EquipData:GetEquipList()
		end

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_3 = {}

			if arg_1_2 then
				var_1_3 = var_1_2[iter_1_1.equip_id]
			else
				var_1_3 = iter_1_1
			end

			if var_1_3 and var_1_3.prefab_id ~= 0 then
				for iter_1_2, iter_1_3 in pairs(EquipTools.CountEquipAttribute(var_1_3, nil, arg_1_1)) do
					if var_1_0[iter_1_2] == nil then
						var_1_0[iter_1_2] = 0
					end

					var_1_0[iter_1_2] = var_1_0[iter_1_2] + iter_1_3
				end
			end
		end

		return var_1_0
	end
}
