local var_0_0 = class("DrawNormalSelectPool", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.poolId = arg_1_2
	arg_1_0.showId = arg_1_3
	arg_1_0.detailBtnList_ = {}
	arg_1_0.btnNameList_ = {}

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:AdaptScreen()
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.poolItems_ = {}

	for iter_3_0 = 1, 7 do
		local var_3_0 = arg_3_0["poolGo_" .. iter_3_0]

		if var_3_0 then
			local var_3_1 = NewBieHeroPoolItem.New(var_3_0)
			local var_3_2 = DrawPoolCfg[arg_3_0.poolId].optional_detail[iter_3_0] or 0

			var_3_1:SetData(iter_3_0, var_3_2)
			table.insert(arg_3_0.poolItems_, var_3_1)
		end
	end

	arg_3_0.roleController_ = arg_3_0.controller_:GetController("role")
	arg_3_0.bgController_ = arg_3_0.controller_:GetController("bg")
	arg_3_0.firstController = arg_3_0.controller_:GetController("first")
end

function var_0_0.AddUIListener(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.detailBtnList_) do
		arg_4_0:AddBtnListener(iter_4_1, nil, function()
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				isDraw = true,
				hid = arg_4_0.btnNameList_[iter_4_0]
			})
		end)
	end

	if arg_4_0.m_changeBtn then
		arg_4_0:AddBtnListener(arg_4_0.m_changeBtn, nil, function()
			local var_6_0 = DrawPoolCfg[arg_4_0.poolId]
			local var_6_1 = table.indexof(var_6_0.optional_lists_poolId, arg_4_0.showId)
			local var_6_2 = var_6_0.optional_detail[var_6_1]

			arg_4_0:Go("/newbieDrawHeroSelect", {
				poolId = arg_4_0.poolId,
				heroIdList = var_6_0.optional_detail,
				heroId = var_6_2
			})
		end)
	end
end

function var_0_0.Refresh(arg_7_0, arg_7_1)
	local var_7_0 = DrawData:GetPollUpID(arg_7_0.poolId)

	arg_7_0.roleController_:SetSelectedState(tostring(var_7_0))
	arg_7_0.bgController_:SetSelectedState(var_7_0 == 0 and "no_role" or "role")

	if DrawData:GetIsFirstSSR() then
		local var_7_1 = DrawData:GetPoolDrawTimes(arg_7_0.poolId)
		local var_7_2 = GameSetting.draw_ssr_lucky_num_first_time.value[1]

		arg_7_0.drawTime_.text = string.format("%d/%d", var_7_1, var_7_2)

		arg_7_0.firstController:SetSelectedIndex(1)
	else
		arg_7_0.firstController:SetSelectedIndex(0)
	end
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)

	if arg_8_1 then
		arg_8_0:UpdateView()
	end
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = DrawPoolCfg[arg_9_0.poolId]

	if var_9_0.pool_type == 1 and arg_9_0.countGo_ then
		SetActive(arg_9_0.countGo_, DrawData:GetIsFirstSSR())
	end

	local var_9_1 = DrawData:GetPollUpID(arg_9_0.poolId)

	arg_9_0.animator_:Play(var_9_1 == 0 and "NewbiePoolSelect01UI_New" or "NewbiePoolSelect02UI_New")

	if arg_9_0.detailBtnPanelTrans_S_ == nil then
		return
	end

	local var_9_2 = var_9_0.unoption_up_items[1][1]
	local var_9_3 = arg_9_0.detailBtnPanelTrans_S_.transform:Find(tostring(var_9_2))

	if var_9_3 == nil then
		return
	end

	local var_9_4 = {}
	local var_9_5 = HeroCfg[var_9_2]

	arg_9_0:BindCfgUI(var_9_3, var_9_4)

	var_9_4.suffixText_.text = GetI18NText(var_9_5.name)
	var_9_4.nameText_.text = GetI18NText(var_9_5.suffix)
	var_9_4.campIcon_.sprite = HeroTools.GetHeroRaceIcon(var_9_2)
end

function var_0_0.ShowCountDownText(arg_10_0, arg_10_1)
	if arg_10_0.countdownText_ then
		SetActive(arg_10_0.countdownText_.gameObject, arg_10_1)
	end
end

function var_0_0.SetCountDownText(arg_11_0, arg_11_1)
	if arg_11_0.countdownText_ then
		arg_11_0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_14"), manager.time:GetLostTimeStrWith3Unit(arg_11_1))
	end
end

function var_0_0.GetPoolId(arg_12_0)
	return arg_12_0.poolId
end

function var_0_0.GetShowId(arg_13_0)
	return arg_13_0.showId
end

function var_0_0.ShowRightPanel(arg_14_0)
	return true
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.poolItems_ then
		for iter_15_0, iter_15_1 in pairs(arg_15_0.poolItems_) do
			iter_15_1:Dispose()
		end

		arg_15_0.poolItems_ = nil
	end

	Object.Destroy(arg_15_0.gameObject_)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
