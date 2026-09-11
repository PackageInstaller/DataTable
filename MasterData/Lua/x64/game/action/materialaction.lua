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
	manager.net:SendWithLoadingNew(17018, {
		nothing = 0
	}, 17019, var_0_0.OnReadExpiredMaterialCallback)
end

function var_0_0:OnReadExpiredMaterialCallback(arg_5_1)
	if isSuccess(self.result) then
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs((MaterialData:CheckExpiredMaterialList())) do
			if ItemCfg[iter_5_1.id].time_exchange_item then
				var_5_0[ItemCfg[iter_5_1.id].time_exchange_item[1]] = not var_5_0[ItemCfg[iter_5_1.id].time_exchange_item[1]] and ItemCfg[iter_5_1.id].time_exchange_item[2] * iter_5_1.num or var_5_0[ItemCfg[iter_5_1.id].time_exchange_item[1]] + ItemCfg[iter_5_1.id].time_exchange_item[2] * iter_5_1.num
			end
		end

		MaterialData:ClearExpiredMaterialList()
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.SetMaterialValue(arg_6_0, arg_6_1, arg_6_2)
	MaterialData:SetMaterialValue(arg_6_0, arg_6_1, arg_6_2)
end

return var_0_0
