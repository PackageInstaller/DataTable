local var_0_0 = class("SpringFestivalShopView", NewActivityShopView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Shop/SandPlay_3_10_ShopUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list = LuaList.New(handler(arg_3_0, arg_3_0.SetItem), arg_3_0.listGo_, ExchangeItemView)
	arg_3_0.tipsController_ = arg_3_0.transCon_:GetController("tips")
	arg_3_0.titleTogList = {
		RechargeSpringFestivalTitleItem.New(arg_3_0.tag01_),
		(RechargeSpringFestivalTitleItem.New(arg_3_0.tag02_))
	}

	local var_3_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[SpringFestivalShopData:GetPointActivityId()]

	arg_3_0.pointRewardList_ = {}
	arg_3_0.pointDataList_ = {}

	for iter_3_0 = 1, 8 do
		local var_3_1 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_1, arg_3_0["point_" .. iter_3_0])

		var_3_1.achieveController_ = var_3_1.achieveCon_:GetController("achieve")
		var_3_1.rewardItem = CommonItemView.New(var_3_1.rewrdItemGo_, true)

		local var_3_2 = ActivityPointRewardCfg[var_3_0[iter_3_0]]

		var_3_1.numTxt_.text = var_3_2.need / GameSetting.activity_item_point_conversion.value[1][4]

		local var_3_3 = clone(ItemTemplateData)

		var_3_3.id = var_3_2.reward_item_list[1][1]
		var_3_3.number = var_3_2.reward_item_list[1][2]
		var_3_3.pointRewardData = var_3_2
		var_3_3.clickFun = handler(arg_3_0, arg_3_0.OnClickPointReward)

		var_3_1.rewardItem:SetData(var_3_3)

		arg_3_0.pointRewardList_[iter_3_0] = var_3_1
		arg_3_0.pointDataList_[iter_3_0] = var_3_2
	end
end

function var_0_0.SetItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.shopDataList[arg_4_1]

	var_4_0.checkShopOpen = true
	var_4_0.defaultNumColor = true

	arg_4_2:SetData(arg_4_0.shopDataList[arg_4_1])
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.tipBtn_, nil, function()
		arg_5_0.tipsShow_ = true

		arg_5_0.tipsController_:SetSelectedState(tostring(arg_5_0.tipsShow_))

		arg_5_0.pointTipText_.text = GetTips("SANDPLAY_SHOP_TIP_1")

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.pointTipGo_.transform)
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0.tipsShow_ = false

		arg_5_0.tipsController_:SetSelectedState(tostring(arg_5_0.tipsShow_))
	end)
end

function var_0_0.GoHome(arg_8_0)
	QWorldUIShow()
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.super.OnEnter(arg_9_0)
	arg_9_0:RefreshPoint()
	arg_9_0:RegistEventListener(SPRING_FESTIVAL_SHOP_UPDATE, handler(arg_9_0, arg_9_0.RefreshPoint))

	arg_9_0.tipsShow_ = false

	arg_9_0.tipsController_:SetSelectedState(tostring(arg_9_0.tipsShow_))
end

function var_0_0.UpdateTitle(arg_10_0)
	local var_10_0 = arg_10_0.groupIndexes[1]

	arg_10_0.groupInfo = arg_10_0.groups[var_10_0]

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.titleTogList) do
		local var_10_1 = arg_10_0.params_.showShops[iter_10_0]

		iter_10_1:SetData(ShopListCfg[var_10_1], iter_10_0, handler(arg_10_0, arg_10_0.ClickTitle), var_10_1)

		if not ShopTools.IsShopOpen(var_10_1) then
			iter_10_1.lockController_:SetSelectedState("true")
		end
	end

	arg_10_0:ClickTitle(1)
end

function var_0_0.ClickTitle(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.params_.showShops[arg_11_1]
	local var_11_1 = ShopListCfg[var_11_0]

	if not ShopTools.IsShopOpen(var_11_0) then
		SetActive(arg_11_0.lockGo_, true)

		local var_11_2 = ActivityData:GetActivityData(var_11_1.activity_id).startTime

		arg_11_0.lockDescTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_2))

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.concitionTrs_)
	else
		SetActive(arg_11_0.lockGo_, false)
	end

	arg_11_0.currentItemIndex_ = arg_11_1

	local var_11_3 = ActivityCfg[var_11_1.activity_id]

	arg_11_0.titleTxt_.text = var_11_3.remark

	if arg_11_0.selectTitleItem_ then
		arg_11_0.selectTitleItem_:ShowSelect(false)
	end

	arg_11_0.selectTitleItem_ = arg_11_0.titleTogList[arg_11_1]

	arg_11_0.selectTitleItem_:ShowSelect(true)
	arg_11_0:UpdateBarByShopId(var_11_0)

	arg_11_0.params_.shopId = var_11_0
	arg_11_0.enterTimer = TimeTools.StartAfterSeconds(0.05, function()
		if arg_11_0.enterTimer == nil then
			return
		end

		arg_11_0:UpdateShopList(var_11_0)

		arg_11_0.enterTimer = nil
	end, {})
end

function var_0_0.OnClickPointReward(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.pointRewardData

	if SpringFestivalShopData:GetTotalPoint() >= var_13_0.need and not SpringFestivalShopData:GetIsReceivedReward(var_13_0.id) then
		local var_13_1 = var_13_0.reward_item_list[1]
		local var_13_2 = var_13_1[1]
		local var_13_3 = var_13_1[2]
		local var_13_4 = ItemCfg[var_13_2]
		local var_13_5 = ItemTools.GetItemExpiredTimeByID(var_13_2)

		if var_13_4 and var_13_4.type == 5 and var_13_4.sub_type == 517 then
			JumpTools.OpenPageByJump("springFestivalItemSelectView", {
				popItemInfo = {
					var_13_2,
					ItemTools.getItemNum(var_13_2, var_13_5),
					0,
					var_13_5
				},
				selectNum = var_13_3,
				cfgID = var_13_0.id
			})
		else
			SpringFestivalShopAciton.ReceivePointReward(var_13_0.id, 0, var_13_3)
		end
	else
		ShowPopItem(POP_ITEM, {
			arg_13_1.id,
			arg_13_1.number
		})
	end
end

function var_0_0.RefreshPoint(arg_14_0)
	local var_14_0 = SpringFestivalShopData:GetTotalPoint()

	arg_14_0.totalPointTxt_.text = math.floor(var_14_0 / GameSetting.activity_item_point_conversion.value[1][4])
	arg_14_0.firstSlider_.value = var_14_0 >= arg_14_0.pointDataList_[1].need and 1 or var_14_0 / arg_14_0.pointDataList_[1].need

	for iter_14_0 = 1, #arg_14_0.pointRewardList_ do
		local var_14_1 = arg_14_0.pointRewardList_[iter_14_0]
		local var_14_2 = arg_14_0.pointDataList_[iter_14_0].need
		local var_14_3 = arg_14_0.pointDataList_[iter_14_0 + 1] and arg_14_0.pointDataList_[iter_14_0 + 1].need or 0

		var_14_1.achieveController_:SetSelectedState(var_14_2 <= var_14_0 and "on" or "off")

		var_14_1.slider_.value = var_14_3 <= var_14_0 and 1 or (var_14_0 - var_14_2) / (var_14_3 - var_14_2)

		local var_14_4 = SpringFestivalShopData:GetIsReceivedReward(arg_14_0.pointDataList_[iter_14_0].id)

		if var_14_2 <= var_14_0 then
			var_14_1.rewardItem:RefreshCompleted(var_14_4)
			var_14_1.rewardItem:RefreshHighLight(not var_14_4)
		end
	end
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0.super.OnExit(arg_15_0)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.super.Dispose(arg_16_0)
end

return var_0_0
