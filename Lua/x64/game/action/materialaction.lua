local var_0_0 = {}

manager.net:Bind(17007, function(arg_1_0)
	MaterialData:InitExpiredMaterialList(arg_1_0.invalid_item_list)
end)
manager.net:Bind(17009, function(arg_2_0)
	MaterialData:InitMaterialList(arg_2_0.material_list)
end)

function var_0_0.MaterialModify(arg_3_0, arg_3_1, arg_3_2)
	print("TODO: 废弃接口", debug.traceback())
end

function var_0_0.ReadExpiredMaterial()
	local var_4_0 = {
		nothing = 0
	}

	manager.net:SendWithLoadingNew(17018, var_4_0, 17019, var_0_0.OnReadExpiredMaterialCallback)
end

function var_0_0.OnReadExpiredMaterialCallback(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		local var_5_0 = {}
		local var_5_1 = MaterialData:CheckExpiredMaterialList()

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_2 = iter_5_1.id
			local var_5_3 = iter_5_1.num
			local var_5_4 = ItemCfg[var_5_2]

			if var_5_4.time_exchange_item then
				if not var_5_0[var_5_4.time_exchange_item[1]] then
					var_5_0[var_5_4.time_exchange_item[1]] = var_5_4.time_exchange_item[2] * var_5_3
				else
					var_5_0[var_5_4.time_exchange_item[1]] = var_5_0[var_5_4.time_exchange_item[1]] + var_5_4.time_exchange_item[2] * var_5_3
				end
			end
		end

		MaterialData:ClearExpiredMaterialList()
	else
		ShowTips(GetTips(arg_5_0.result))
	end
end

function var_0_0.SetMaterialValue(arg_6_0, arg_6_1, arg_6_2)
	MaterialData:SetMaterialValue(arg_6_0, arg_6_1, arg_6_2)
end

return var_0_0
