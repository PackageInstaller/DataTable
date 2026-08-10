local var_0_0 = class("MoonCakeDispatchDelegateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonDelegateDispatchUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.transform_, "status")
	arg_4_0.clickCakeHandler_ = handler(arg_4_0, arg_4_0.OnClickCake)
	arg_4_0.cakeItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, MoonCakeItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.dispatchBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not arg_5_0.targetCakeID_ then
			return
		end

		MoonCakeAction.DispatchDelegate(arg_5_0.activityID_, arg_5_0.targetCakeID_, function()
			arg_5_0:Back()
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.cakeItemList_:Dispose()

	arg_9_0.cakeItemList_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.targetCakeID_ = nil

	arg_10_0:RefreshUI()
	arg_10_0:RefreshStatus()
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.cakeIdList_ = MoonCakeCfg.get_id_list_by_activity[arg_11_0.activityID_]

	arg_11_0.cakeItemList_:StartScroll(#arg_11_0.cakeIdList_)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.cakeIdList_[arg_12_1]
	local var_12_1 = MoonCakeCfg[var_12_0].moon_cakes

	arg_12_2:SetData(var_12_1, var_12_0)
	arg_12_2:SetClickHandler(arg_12_0.clickCakeHandler_)
	arg_12_2:SetSelect(arg_12_0.targetCakeID_)
end

function var_0_0.RefreshStatus(arg_13_0)
	if not arg_13_0.targetCakeID_ then
		arg_13_0.statusController_:SetSelectedState("off")
	else
		arg_13_0.statusController_:SetSelectedState("on")

		local var_13_0 = MoonCakeCfg[arg_13_0.targetCakeID_].moon_cakes

		arg_13_0.dispatchCakeName_.text = ItemTools.getItemName(var_13_0)
		arg_13_0.dispatchCakeIcon_.sprite = ItemTools.getItemSprite(var_13_0)
	end
end

function var_0_0.OnClickCake(arg_14_0, arg_14_1)
	arg_14_0.targetCakeID_ = arg_14_1

	local var_14_0 = arg_14_0.cakeItemList_:GetItemList()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		iter_14_1:SetSelect(arg_14_1)
	end

	arg_14_0:RefreshStatus()
end

return var_0_0
