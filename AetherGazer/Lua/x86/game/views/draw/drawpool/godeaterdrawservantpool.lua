local var_0_0 = class("GodEaterDrawServantPool", DrawBasePool)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0
	local var_1_1 = Asset.Load("Widget/System/Pool/pool_" .. arg_1_3)

	arg_1_0.gameObject_ = Object.Instantiate(var_1_1, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.poolId = arg_1_2
	arg_1_0.showId = arg_1_3
	arg_1_0.detailBtnList_ = {}
	arg_1_0.btnNameList_ = {}

	arg_1_0:Init()
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.replacebtnBtn_, nil, function()
		arg_2_0:Go("/drawGodEaterSelect", {
			poolID = arg_2_0.poolId
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.btnlook1Btn_, nil, function()
		local var_4_0 = DrawPoolCfg[arg_2_0.poolId]
		local var_4_1 = table.indexof(var_4_0.optional_lists_poolId, arg_2_0.showId)

		if var_4_1 and var_4_0.optional_detail[var_4_1] then
			local var_4_2 = var_4_0.optional_detail[var_4_1]

			arg_2_0:Go("/showServantView", {
				state = "onlydetail",
				id = var_4_2
			})
		end
	end)
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	var_0_0.super.SetActive(arg_5_0, arg_5_1)
end

return var_0_0
