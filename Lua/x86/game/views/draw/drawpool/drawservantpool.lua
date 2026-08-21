local var_0_0 = class("DrawServantPool", DrawBasePool)

function var_0_0.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.replacebtnBtn_, nil, function()
		arg_1_0:Go("/drawSelect")
	end)
	arg_1_0:AddBtnListener(arg_1_0.btnlook1Btn_, nil, function()
		local var_3_0 = DrawPoolCfg[arg_1_0.poolId]
		local var_3_1 = table.indexof(var_3_0.optional_lists_poolId, arg_1_0.showId)

		if var_3_1 and var_3_0.optional_detail[var_3_1] then
			local var_3_2 = var_3_0.optional_detail[var_3_1]

			arg_1_0:Go("/showServantView", {
				state = "onlydetail",
				id = var_3_2
			})
		end
	end)
	arg_1_0:AddBtnListener(arg_1_0.btnshow_, nil, function()
		DrawData:SetServantRedPoint(arg_1_0.poolId, 0)
		arg_1_0:Go("/weaponServantList", {
			race = arg_1_0.showId - 200000
		})
	end)
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	var_0_0.super.SetActive(arg_5_0, arg_5_1)
	manager.redPoint:unbindUIandKey(arg_5_0.btnshow_.transform)

	local var_5_0 = string.format("%s_%d_%d", RedPointConst.WEAPON_SERVANT_POOL, arg_5_0.poolId, DrawData:GetPollUpID(arg_5_0.poolId))

	if arg_5_1 == true then
		manager.redPoint:bindUIandKey(arg_5_0.btnshow_.transform, var_5_0)
	end
end

return var_0_0
