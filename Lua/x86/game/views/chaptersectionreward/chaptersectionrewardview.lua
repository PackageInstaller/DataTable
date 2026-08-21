local var_0_0 = class("ChapterSectionRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/ChapterSectionRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rewardPanelItems_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.chapterID_ = tonumber(arg_4_0.params_.chapterID)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.rewardPanelItems_) do
		iter_4_1:SetData(arg_4_0.chapterID_)
	end
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.rewardPanelItems_) do
		iter_5_1:Dispose()
	end

	arg_5_0.rewardPanelItems_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	for iter_6_0 = 1, 3 do
		arg_6_0.rewardPanelItems_[iter_6_0] = ChapterSectionRewardItemPanel.New(arg_6_0[string.format("rewardPanelItem%s_", iter_6_0)], iter_6_0)
	end
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
end

return var_0_0
