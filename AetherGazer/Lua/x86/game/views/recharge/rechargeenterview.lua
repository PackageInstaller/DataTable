local var_0_0 = class("RechargeEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeEnterUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.bgList_ = {}
	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiListGo_, RechargeEnterListItemView)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.recommendIdList_[arg_5_1])

	if arg_5_2:GetIndex() == arg_5_0.pageIndex_ then
		arg_5_2:SetSelect(true)
	else
		arg_5_2:SetSelect(false)
	end

	arg_5_2:RegisterClickListener(function(arg_6_0)
		OperationRecorder.RecordButtonTouch("shop_recommend_left_" .. arg_5_0.recommendIdList_[arg_6_0])

		if arg_5_0.pageIndex_ ~= arg_6_0 then
			arg_5_0.uiList_:SwitchToPage(arg_6_0)
			arg_5_0:OnPageChange(arg_6_0)
		end

		ShopAction.ReadRedPoint(arg_5_0.recommendIdList_[arg_6_0])
		arg_5_0.timer_:Reset()
	end)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DAILY_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_7_0:AddBtnListener(arg_7_0.rechargeBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("shop_recharge")
		JumpTools.GoToSystem("/rechargeMain", {
			page = 1
		}, ViewConst.SYSTEM_ID.RECHARGE)
	end)
end

function var_0_0.OnPageChange(arg_10_0, arg_10_1)
	if arg_10_0.pageIndex_ == arg_10_1 then
		return
	end

	CustomLog.Log(debug.traceback(string.format("OnPageChange, index = %s", tostring(arg_10_1))))

	local var_10_0 = arg_10_0.recommendIdList_[arg_10_0.pageIndex_]

	if arg_10_0.bgList_[var_10_0] then
		arg_10_0.bgList_[var_10_0]:Hide()
	end

	arg_10_0.pageIndex_ = arg_10_1

	arg_10_0.uiList_:Refresh()
	arg_10_0:UpdatePageView()
end

function var_0_0.UpdatePageView(arg_11_0)
	local var_11_0 = arg_11_0.recommendIdList_[arg_11_0.pageIndex_]

	arg_11_0.cfg_ = RechargeRecommendCfg[var_11_0]

	if not arg_11_0.bgList_[var_11_0] then
		arg_11_0.bgList_[var_11_0] = arg_11_0:CreatedRecommendBgItem(var_11_0)
	else
		arg_11_0.bgList_[var_11_0]:Show()
	end

	arg_11_0.bgList_[var_11_0]:SetData(arg_11_0.pageIndex_, arg_11_0.cfg_)

	if arg_11_0.cfg_.free_dlc_icon ~= "" then
		arg_11_0.image_.sprite = ItemTools.getItemSprite(arg_11_0.cfg_.free_dlc_icon[1])

		SetActive(arg_11_0.littleItemGo_, true)
	else
		SetActive(arg_11_0.littleItemGo_, false)
	end
end

function var_0_0.CreatedRecommendBgItem(arg_12_0, arg_12_1)
	local var_12_0 = RechargeRecommendCfg[arg_12_1]
	local var_12_1 = Asset.Load("Widget/System/Shop/RechargeShopRecommend/" .. var_12_0.prefab)
	local var_12_2 = Object.Instantiate(var_12_1, arg_12_0.bgContainer_)

	if var_12_0.show_type == 1 then
		return RechargeRecommendFukubukuroItemView.New(var_12_2)
	else
		return RechargeRecommendBgItemView.New(var_12_2)
	end
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.recommendIdList_ = {}

	for iter_14_0, iter_14_1 in ipairs(RechargeRecommendCfg.all) do
		local var_14_0 = RechargeRecommendCfg[iter_14_1]
		local var_14_1 = var_14_0.time[1]
		local var_14_2 = false

		if not var_14_1 or #var_14_1[1] < 3 or #var_14_1[2] < 3 then
			var_14_2 = true
		end

		local var_14_3 = var_14_0.time[2]

		if not var_14_3 or #var_14_3[1] < 3 or #var_14_3[2] < 3 then
			var_14_2 = true
		end

		if not var_14_2 then
			local var_14_4 = TimeMgr.GetInstance():parseTimeFromConfig(var_14_0.time[1])
			local var_14_5 = TimeMgr.GetInstance():parseTimeFromConfig(var_14_0.time[2])
			local var_14_6 = TimeMgr.GetInstance():GetServerTime()

			var_14_2 = var_14_6 < var_14_5 and var_14_4 <= var_14_6 and true or false
		end

		if var_14_2 then
			table.insert(arg_14_0.recommendIdList_, iter_14_1)
		end
	end

	table.sort(arg_14_0.recommendIdList_, function(arg_15_0, arg_15_1)
		local var_15_0 = RechargeRecommendCfg[arg_15_0]
		local var_15_1 = RechargeRecommendCfg[arg_15_1]

		return var_15_0.order < var_15_1.order
	end)
	arg_14_0.uiList_:StartScroll(#arg_14_0.recommendIdList_)
	manager.redPoint:bindUIandKey(arg_14_0.rechargeBtn_.transform, RedPointConst.RECHARGE)
	manager.redPoint:bindUIandKey(arg_14_0.shopBtn_.transform, RedPointConst.SHOP)
	arg_14_0:OnPageChange(1)
	arg_14_0:StartTimer()
	arg_14_0:RefreshRechargeBtnTag()
end

function var_0_0.OnExit(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.rechargeBtn_.transform, RedPointConst.RECHARGE)
	manager.redPoint:unbindUIandKey(arg_16_0.shopBtn_.transform, RedPointConst.SHOP)
	manager.windowBar:HideBar()
	arg_16_0:StopTimer()

	local var_16_0 = arg_16_0.recommendIdList_[arg_16_0.pageIndex_]

	if arg_16_0.bgList_[var_16_0] then
		arg_16_0.bgList_[var_16_0]:Hide()
	end

	arg_16_0.pageIndex_ = 0
end

function var_0_0.StartTimer(arg_17_0)
	if arg_17_0.timer_ == nil then
		arg_17_0.timer_ = Timer.New(function()
			arg_17_0:ScrollToNextPage()
		end, 10, -1)
	end

	arg_17_0.timer_:Start()
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.ScrollToNextPage(arg_20_0)
	if #arg_20_0.recommendIdList_ <= 1 then
		return
	end

	local var_20_0 = arg_20_0.pageIndex_ % #arg_20_0.recommendIdList_ + 1

	arg_20_0.uiList_:SwitchToPage(var_20_0)
	arg_20_0:OnPageChange(var_20_0)
	CustomLog.Log(debug.traceback(string.format("ScrollToNextPage, newIndex = %s", tostring(var_20_0))))
end

function var_0_0.OnTop(arg_21_0)
	arg_21_0:UpdateBar()
	arg_21_0:UpdatePageView()
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.uiList_ then
		arg_22_0.uiList_:Dispose()

		arg_22_0.uiList_ = nil
	end

	if arg_22_0.bgList_ then
		for iter_22_0, iter_22_1 in pairs(arg_22_0.bgList_) do
			iter_22_1:Dispose()
		end

		arg_22_0.bgList_ = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.RefreshRechargeBtnTag(arg_23_0)
	if ActivityNoobData:IsFirstRechargeNewTag() then
		SetActive(arg_23_0.rechargeBtnTagGo_, true)

		arg_23_0.rechargeBtnTagText_.text = GetTips("RECHARGE_WELFARE")
	else
		SetActive(arg_23_0.rechargeBtnTagGo_, false)
	end
end

return var_0_0
