local var_0_0 = class("KagutsuchiGachaPreviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionJackpotRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.poolRewardItem_ = {}
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgmask_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityId_ = arg_6_0.params_.activityId
	arg_6_0.poolId_ = arg_6_0.params_.poolId

	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.poolRewardItem_) do
		arg_7_0.poolRewardItem_[iter_7_0]:OnExit()
	end
end

function var_0_0.OnTop(arg_8_0)
	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.OnBehind(arg_9_0)
	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshPoolRewardItems(arg_10_0.poolId_)
end

function var_0_0.RefreshPoolRewardItems(arg_11_0, arg_11_1)
	local var_11_0 = KagutsuchiGachaData:GetAllDrawItemIds(arg_11_1)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not arg_11_0.poolRewardItem_[iter_11_0] then
			local var_11_1 = Object.Instantiate(arg_11_0.templateItem_, arg_11_0.contentParent_)

			arg_11_0.poolRewardItem_[iter_11_0] = KagutsuchiGachaRewardItem.New(var_11_1)
		end

		arg_11_0.poolRewardItem_[iter_11_0]:SetData(arg_11_0.activityId_, arg_11_1, iter_11_1)
	end
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.poolRewardItem_) do
		arg_12_0.poolRewardItem_[iter_12_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
