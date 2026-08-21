local var_0_0 = class("PushBoxResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/BoxGameResultPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, CommonItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshData(formatReward(arg_5_0.list_[arg_5_1]))
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
			activityID = arg_6_0.params_.activityID
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.list_ = arg_8_0.params_.rewardList

	arg_8_0.scrollHelper_:StartScroll(#arg_8_0.list_)
	SetActive(arg_8_0.rewardPanel_, #arg_8_0.list_ > 0)
end

function var_0_0.OnExit(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.scrollHelper_:GetItemList()) do
		iter_9_1:OnExit()
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.scrollHelper_:GetItemList()) do
		iter_10_1:Dispose()
	end

	arg_10_0.scrollHelper_:Dispose()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
