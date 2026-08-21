local var_0_0 = class("NewbieDrawSelectPool", DrawBasePool)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Asset.Load("Widget/System/Pool/NewbiePoolSelectUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.poolId = arg_1_2
	arg_1_0.showId = arg_1_3
	arg_1_0.detailBtnList_ = {}
	arg_1_0.btnNameList_ = {}

	arg_1_0:Init()
end

function var_0_0.InitUI(arg_2_0)
	var_0_0.super.InitUI(arg_2_0)

	arg_2_0.roleController_ = arg_2_0.controller_:GetController("role")
	arg_2_0.bgController_ = arg_2_0.controller_:GetController("bg")
	arg_2_0.poolItems_ = {}

	for iter_2_0 = 1, 7 do
		local var_2_0 = arg_2_0["poolGo_" .. iter_2_0]

		if var_2_0 == nil then
			return
		end

		local var_2_1 = NewBieHeroPoolItem.New(var_2_0)
		local var_2_2 = DrawPoolCfg[arg_2_0.poolId].optional_detail[iter_2_0]

		var_2_1:SetData(iter_2_0, var_2_2)
		table.insert(arg_2_0.poolItems_, var_2_1)
	end
end

function var_0_0.AddUIListener(arg_3_0)
	var_0_0.super.AddUIListener(arg_3_0)

	if arg_3_0.m_changeBtn then
		arg_3_0:AddBtnListener(arg_3_0.m_changeBtn, nil, function()
			local var_4_0 = DrawPoolCfg[arg_3_0.poolId].pool_change
			local var_4_1 = DrawData:GetPoolUpTimes(arg_3_0.poolId)

			if var_4_0 == 0 or var_4_1 < var_4_0 then
				local var_4_2 = DrawPoolCfg[arg_3_0.poolId]
				local var_4_3 = table.indexof(var_4_2.optional_lists_poolId, arg_3_0.showId)
				local var_4_4 = var_4_2.optional_detail[var_4_3]

				arg_3_0:Go("/newbieDrawHeroSelect", {
					poolId = arg_3_0.poolId,
					heroIdList = var_4_2.optional_detail,
					heroId = var_4_4
				})
			else
				ShowTips("DRAW_LACK_UP_TIMES")
			end
		end)
	end
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	var_0_0.super.Refresh(arg_5_0, arg_5_1)

	local var_5_0 = DrawPoolCfg[arg_5_0.poolId]
	local var_5_1 = DrawData:GetPollUpID(arg_5_0.poolId)
	local var_5_2 = table.indexof(var_5_0.optional_lists_poolId, var_5_1)
	local var_5_3 = var_5_0.optional_detail[var_5_2]

	arg_5_0.roleController_:SetSelectedState(var_5_3)
	arg_5_0.bgController_:SetSelectedState(var_5_1 == 0 and "no_role" or "role")

	if arg_5_0.m_changeCount then
		local var_5_4 = DrawPoolCfg[arg_5_0.poolId].pool_change

		if var_5_4 == 0 then
			arg_5_0.m_changeCount.text = ""
		else
			local var_5_5 = var_5_4 - DrawData:GetPoolUpTimes(arg_5_0.poolId)

			arg_5_0.m_changeCount.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_5_5))
		end
	end
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.poolItems_ then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.poolItems_) do
			iter_6_1:Dispose()
		end

		arg_6_0.poolItems_ = nil
	end

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
