local var_0_0 = class("SkuldSystemTrustView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_RewardTrustUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.trustItem_ = SkuldSystemTrustItem.New(arg_4_0.trustGo_)
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, SkuldSystemTrustViewItem)
	arg_4_0.itemID_ = CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id
	arg_4_0.updateHandler_ = handler(arg_4_0, arg_4_0.OnReceivePointReward)
	arg_4_0.oneKeyController_ = arg_4_0.controllerEx_:GetController("onekey")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.rewardIDList_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		local var_7_0 = false
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(arg_6_0.rewardIDList_) do
			if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= ActivityPointRewardCfg[iter_7_1].need and not SkuldSystemData:GetPointRewardIsGet(iter_7_1) then
				local var_7_2 = true

				table.insert(var_7_1, iter_7_1)
			end
		end

		ActivityAction.ReceivePointReward(var_7_1)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.trustItem_:RefreshUI()

	arg_8_0.rewardIDList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_MAIN]

	local var_8_0 = false

	for iter_8_0, iter_8_1 in pairs(arg_8_0.rewardIDList_) do
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= ActivityPointRewardCfg[iter_8_1].need and not SkuldSystemData:GetPointRewardIsGet(iter_8_1) then
			var_8_0 = true

			break
		end
	end

	local var_8_1 = 0

	for iter_8_2, iter_8_3 in pairs(arg_8_0.rewardIDList_) do
		if not SkuldSystemData:GetPointRewardIsGet(iter_8_3) then
			var_8_1 = iter_8_2 == 1 and iter_8_2 or iter_8_2

			break
		end
	end

	if var_8_0 then
		arg_8_0.oneKeyController_:SetSelectedState("true")
	else
		arg_8_0.oneKeyController_:SetSelectedState("false")
	end

	arg_8_0.list_:StartScroll(#arg_8_0.rewardIDList_, var_8_1)
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, arg_8_0.updateHandler_)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SkuldSystemData:UpdateSkuldPointRewardRedPoint()
end

function var_0_0.OnReceivePointReward(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		SkuldSystemData:GetPointReward(iter_10_1)
	end

	arg_10_0.list_:Refresh()

	local var_10_0 = false

	for iter_10_2, iter_10_3 in pairs(arg_10_0.rewardIDList_) do
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= ActivityPointRewardCfg[iter_10_3].need and not SkuldSystemData:GetPointRewardIsGet(iter_10_3) then
			var_10_0 = true

			break
		end
	end

	if var_10_0 then
		arg_10_0.oneKeyController_:SetSelectedState("true")
	else
		arg_10_0.oneKeyController_:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(RECEIVE_POINT_REWARD, arg_11_0.updateHandler_)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.super.Dispose(arg_12_0)
	arg_12_0.trustItem_:Dispose()

	if arg_12_0.list_ then
		arg_12_0.list_:Dispose()

		arg_12_0.list_ = nil
	end

	arg_12_0.updateHandler_ = nil
end

return var_0_0
