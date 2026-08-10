local var_0_0 = class("AshPointView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_Com_RewardTrustUI"
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

	arg_4_0.trustItem_ = AshSystemTrustItem.New(arg_4_0.trustGo_)
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.levelUilist_, AshSystemTrustViewItem)
	arg_4_0.itemID_ = CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id
	arg_4_0.updateHandler_ = handler(arg_4_0, arg_4_0.OnReceivePointReward)
	arg_4_0.oneKeyController_ = arg_4_0.mainControllerEx_:GetController("onekey")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.rewardIDList_[arg_5_1], arg_5_1)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		local var_7_0 = false
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(arg_6_0.rewardIDList_) do
			if AshSystemData:GetHomologyRate() >= ActivityPointRewardCfg[iter_7_1].need and not AshSystemData:GetPointRewardIsGet(iter_7_1) then
				local var_7_2 = true

				table.insert(var_7_1, iter_7_1)
			end
		end

		ActivityPointAction.ReceivePointReward(var_7_1)
		AshSystemData:UpdateTaskRedPoint()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0:RefreshUI()

	arg_8_0.list_:StartScroll(#arg_8_0.rewardIDList_, var_8_0)
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, arg_8_0.updateHandler_)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.trustItem_:RefreshUI()

	arg_10_0.rewardIDList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_MAIN] or {}

	local var_10_0 = false

	for iter_10_0, iter_10_1 in pairs(arg_10_0.rewardIDList_) do
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id) >= ActivityPointRewardCfg[iter_10_1].need and not AshSystemData:GetPointRewardIsGet(iter_10_1) then
			var_10_0 = true

			break
		end
	end

	local var_10_1 = 1

	for iter_10_2, iter_10_3 in pairs(arg_10_0.rewardIDList_) do
		if not AshSystemData:GetPointRewardIsGet(iter_10_3) then
			var_10_1 = iter_10_2

			break
		end
	end

	if var_10_0 then
		arg_10_0.oneKeyController_:SetSelectedState("true")
	else
		arg_10_0.oneKeyController_:SetSelectedState("false")
	end

	return var_10_1
end

function var_0_0.OnReceivePointReward(arg_11_0, arg_11_1)
	AshSystemData:UpdatePointRed()

	local var_11_0 = arg_11_0:RefreshUI()

	arg_11_0.list_:StartScroll(#arg_11_0.rewardIDList_, var_11_0)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(RECEIVE_POINT_REWARD, arg_12_0.updateHandler_)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.super.Dispose(arg_13_0)
	arg_13_0.trustItem_:Dispose()

	if arg_13_0.list_ then
		arg_13_0.list_:Dispose()

		arg_13_0.list_ = nil
	end

	arg_13_0.updateHandler_ = nil
end

return var_0_0
