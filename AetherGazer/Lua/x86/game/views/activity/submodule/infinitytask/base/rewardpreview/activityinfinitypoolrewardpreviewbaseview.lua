local var_0_0 = class("ActivityInfinityPoolRewardPreviewBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisRewardUI"
end

function var_0_0.GetRewardPreviewItem(arg_2_0)
	return ActivityInfinityPoolRewardPreviewBaseItem
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()

	arg_4_0.mainRewardList_ = {}
	arg_4_0.normalRewardList_ = {}
end

function var_0_0.OnEnter(arg_5_0)
	local var_5_0 = arg_5_0.params_.poolID
	local var_5_1 = OsirisInfinityPoolData:GetPoolData(var_5_0)

	if var_5_1.coreItem == nil then
		SetActive(arg_5_0.goMainItem_, false)
	else
		SetActive(arg_5_0.goMainItem_, true)

		for iter_5_0 = 1, 1 do
			local var_5_2 = var_5_1.coreItem

			if arg_5_0.mainRewardList_[iter_5_0] == nil then
				arg_5_0.mainRewardList_[iter_5_0] = arg_5_0:GetRewardPreviewItem().New(arg_5_0.goItem_, arg_5_0.goMainParent_, var_5_2, var_5_1.isOpenCoreItem and 1 or 0, 1)
			else
				arg_5_0.mainRewardList_[iter_5_0]:SetData(var_5_2, var_5_1.isOpenCoreItem and 1 or 0, 1)
			end
		end
	end

	for iter_5_1 = 1, #var_5_1.resultItemList do
		local var_5_3 = var_5_1.resultItemList[iter_5_1]
		local var_5_4 = var_5_3.reward

		if arg_5_0.normalRewardList_[iter_5_1] == nil then
			arg_5_0.normalRewardList_[iter_5_1] = arg_5_0:GetRewardPreviewItem().New(arg_5_0.goItem_, arg_5_0.goNormalParent_, var_5_4, var_5_3.cnt, var_5_3.maxCnt)
		else
			arg_5_0.normalRewardList_[iter_5_1]:SetData(var_5_4, var_5_3.cnt, var_5_3.maxCnt)
		end
	end

	for iter_5_2 = #var_5_1.resultItemList + 1, #arg_5_0.normalRewardList_ do
		arg_5_0.normalRewardList_[iter_5_2]:Show(false)
	end

	arg_5_0.scrollView_.verticalNormalizedPosition = 1
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.mainRewardList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.mainRewardList_ = nil

	for iter_7_2, iter_7_3 in pairs(arg_7_0.normalRewardList_) do
		iter_7_3:Dispose()
	end

	arg_7_0.normalRewardList_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btnClose_, nil, function()
		arg_8_0:Back()
	end)
end

return var_0_0
