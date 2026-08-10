local var_0_0 = class("DrawSelectPool", DrawBasePool)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Asset.Load("Widget/System/Pool/pool_" .. arg_1_2)

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

	arg_2_0.firstController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "first")
	arg_2_0.showController_ = arg_2_0.controller_:GetController("show")
end

function var_0_0.AddUIListener(arg_3_0)
	var_0_0.super.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.detailBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			isDraw = true,
			hid = arg_3_0.heroId
		})
	end)

	if arg_3_0.m_changeBtn then
		arg_3_0:AddBtnListener(arg_3_0.m_changeBtn, nil, function()
			local var_5_0 = DrawPoolCfg[arg_3_0.poolId].pool_change
			local var_5_1 = DrawData:GetPoolUpTimes(arg_3_0.poolId)

			if var_5_0 == 0 or var_5_1 < var_5_0 then
				local var_5_2 = DrawPoolCfg[arg_3_0.poolId]
				local var_5_3 = table.indexof(var_5_2.optional_lists_poolId, arg_3_0.showId)
				local var_5_4 = var_5_2.optional_detail[var_5_3]

				arg_3_0:Go("/drawAllHeroSelect", {
					poolId = arg_3_0.poolId,
					heroIdList = var_5_2.optional_detail,
					heroId = var_5_4
				})
			else
				ShowTips("DRAW_LACK_UP_TIMES")
			end
		end)
	end
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	var_0_0.super.Refresh(arg_6_0, arg_6_1)

	arg_6_0.showId = arg_6_1
	arg_6_0.upID = DrawData:GetPollUpID(arg_6_0.poolId)

	if arg_6_0.upID == 0 then
		arg_6_0.showController_:SetSelectedState("no_role")
	else
		arg_6_0.showController_:SetSelectedState("role")
	end

	local var_6_0 = DrawPoolCfg[arg_6_0.poolId]
	local var_6_1 = table.indexof(var_6_0.optional_lists_poolId, arg_6_1)

	arg_6_0.heroId = DrawData:ConvertUpId(arg_6_0.poolId, arg_6_0.upID, 0)

	local var_6_2 = HeroCfg[arg_6_0.heroId]

	if arg_6_0.m_changeCount then
		local var_6_3 = DrawPoolCfg[arg_6_0.poolId].pool_change

		if var_6_3 == 0 then
			arg_6_0.m_changeCount.text = ""
		else
			local var_6_4 = var_6_3 - DrawData:GetPoolUpTimes(arg_6_0.poolId)

			arg_6_0.m_changeCount.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_6_4))
		end
	end

	if arg_6_0.upID ~= 0 then
		arg_6_0.nameText_.text = GetI18NText(var_6_2.suffix)

		if arg_6_0.suffixText_ then
			arg_6_0.suffixText_.text = GetI18NText(var_6_2.name)
		else
			arg_6_0.nameText_.text = HeroTools.GetHeroFullName(arg_6_0.heroId)
		end

		arg_6_0.pic_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Character/Portrait/%d", arg_6_0.heroId))
		arg_6_0.campIcon_.sprite = HeroTools.GetHeroRaceIcon(arg_6_0.heroId)

		arg_6_0.pic_:SetNativeSize()
	end

	arg_6_0.countText_.text = DrawData:GetUpRemainTime(arg_6_0.poolId)
end

return var_0_0
