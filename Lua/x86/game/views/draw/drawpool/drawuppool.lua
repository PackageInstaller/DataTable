local var_0_0 = class("DrawUpPool", DrawBasePool)

function var_0_0.AddUIListener(arg_1_0)
	var_0_0.super.AddUIListener(arg_1_0)

	if arg_1_0.m_changeBtn then
		arg_1_0:AddBtnListener(arg_1_0.m_changeBtn, nil, function()
			local var_2_0 = DrawPoolCfg[arg_1_0.poolId].pool_change
			local var_2_1 = DrawData:GetPoolUpTimes(arg_1_0.poolId)

			if var_2_0 == 0 or var_2_1 < var_2_0 then
				arg_1_0:Go("/drawHeroSelect", {
					poolId = arg_1_0.poolId
				})
			else
				ShowTips("DRAW_LACK_UP_TIMES")
			end
		end)
	end
end

function var_0_0.Refresh(arg_3_0)
	var_0_0.super.Refresh(arg_3_0)

	if arg_3_0.m_changeCount then
		local var_3_0 = DrawPoolCfg[arg_3_0.poolId].pool_change

		if var_3_0 == 0 then
			arg_3_0.m_changeCount.text = ""
		else
			local var_3_1 = var_3_0 - DrawData:GetPoolUpTimes(arg_3_0.poolId)

			arg_3_0.m_changeCount.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_3_1))
		end
	end
end

return var_0_0
