local var_0_0 = class("NewbieDrawSelectPool", DrawBasePool)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Asset.Load("Widget/System/Pool/ReturnPoolSelectUI")

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

	arg_2_0.bgController_ = arg_2_0.controller_:GetController("bg")
end

function var_0_0.AddUIListener(arg_3_0)
	var_0_0.super.AddUIListener(arg_3_0)

	if arg_3_0.m_changeBtn then
		arg_3_0:AddBtnListener(arg_3_0.m_changeBtn, nil, function()
			local var_4_0 = DrawPoolCfg[arg_3_0.poolId].pool_change
			local var_4_1 = DrawData:GetPoolUpTimes(arg_3_0.poolId)

			if var_4_0 == 0 or var_4_1 < var_4_0 then
				local var_4_2 = DrawPoolCfg[arg_3_0.poolId]
				local var_4_3 = DrawData:GetPollUpID(arg_3_0.poolId)
				local var_4_4 = table.indexof(var_4_2.optional_lists_poolId, var_4_3)
				local var_4_5 = var_4_2.optional_detail[var_4_4]

				arg_3_0:Go("/drawAllHeroSelect", {
					poolId = arg_3_0.poolId,
					heroIdList = var_4_2.optional_detail,
					heroId = var_4_5
				})
			else
				ShowTips("DRAW_LACK_UP_TIMES")
			end
		end)
	end

	if arg_3_0.detailBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.detailBtn_, nil, function()
			local var_5_0 = DrawPoolCfg[arg_3_0.poolId]
			local var_5_1 = DrawData:GetPollUpID(arg_3_0.poolId)
			local var_5_2 = table.indexof(var_5_0.optional_lists_poolId, var_5_1)
			local var_5_3 = var_5_0.optional_detail[var_5_2]

			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				isDraw = true,
				hid = var_5_3
			})
		end)
	end
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	var_0_0.super.Refresh(arg_6_0, arg_6_1)

	local var_6_0 = DrawPoolCfg[arg_6_0.poolId]
	local var_6_1 = DrawData:GetPollUpID(arg_6_0.poolId)
	local var_6_2 = table.indexof(var_6_0.optional_lists_poolId, var_6_1)
	local var_6_3 = var_6_0.optional_detail[var_6_2]

	arg_6_0.bgController_:SetSelectedState(var_6_1 == 0 and "no_role" or "role")

	if arg_6_0.m_changeCount then
		local var_6_4 = DrawPoolCfg[arg_6_0.poolId].pool_change

		if var_6_4 == 0 then
			arg_6_0.m_changeCount.text = ""
		else
			local var_6_5 = var_6_4 - DrawData:GetPoolUpTimes(arg_6_0.poolId)

			arg_6_0.m_changeCount.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_6_5))
		end
	end

	if var_6_1 ~= 0 then
		local var_6_6 = HeroCfg[var_6_3]

		arg_6_0.nameText_.text = HeroTools.GetHeroFullName(var_6_3)
		arg_6_0.campIcon_.sprite = HeroTools.GetHeroRaceIcon(var_6_3)
		arg_6_0.pic_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Character/Portrait/%d", var_6_3))

		arg_6_0.pic_:SetNativeSize()
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
