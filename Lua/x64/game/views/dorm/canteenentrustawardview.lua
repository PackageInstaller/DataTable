local var_0_0 = class("CanteenEntrustAwardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamTaskToCompletePop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.awardListScroll_ = LuaList.New(handler(arg_5_0, arg_5_0.indexAwardItem), arg_5_0.awardviewuilistUilist_, CanteenEntrustAwardItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0.awardListScroll_:SetPageChangeHandler(handler(arg_6_0, arg_6_0.UpdataButton))
	arg_6_0:AddBtnListener(arg_6_0.leftbtnBtn_, nil, function()
		arg_6_0.index = arg_6_0.index - 1

		arg_6_0:UpdataButton(arg_6_0.index)
		arg_6_0.awardListScroll_:ScrollToIndex(arg_6_0.index, true, false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.rightbtnBtn_, nil, function()
		arg_6_0.index = arg_6_0.index + 1

		arg_6_0:UpdataButton(arg_6_0.index)
		arg_6_0.awardListScroll_:ScrollToIndex(arg_6_0.index, true, false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.okbtnBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.flag = arg_10_0.params_.flag
	arg_10_0.index = 1

	arg_10_0:UpdataView()
end

function var_0_0.UpdataButton(arg_11_0, arg_11_1)
	arg_11_0.index = arg_11_1

	if arg_11_1 == 1 then
		SetActive(arg_11_0.leftbtnGo_, false)
	else
		SetActive(arg_11_0.leftbtnGo_, true)
	end

	if arg_11_1 == #arg_11_0.awardList then
		SetActive(arg_11_0.rightbtnGo_, false)
	else
		SetActive(arg_11_0.rightbtnGo_, true)
	end
end

function var_0_0.UpdataView(arg_12_0)
	arg_12_0.awardList = CanteenEntrustData:GetEntrustFinishAwardList()

	arg_12_0.awardListScroll_:StartScroll(#arg_12_0.awardList)
	arg_12_0:UpdataButton(arg_12_0.index)
end

function var_0_0.indexAwardItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_0.awardList[arg_13_1], arg_13_0.flag)
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.awardListScroll_ then
		arg_14_0.awardListScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
