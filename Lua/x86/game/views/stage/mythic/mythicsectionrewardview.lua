local var_0_0 = class("MythicSectionRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicSectionRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.rewardPanelItems_ = {}

	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.difficulty_ = tonumber(arg_5_0.params_.difficulty)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.rewardPanelItems_) do
		iter_5_1:SetData(arg_5_0.difficulty_)
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:RemoveListeners()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.rewardPanelItems_) do
		iter_6_1:Dispose()
	end

	arg_6_0.rewardPanelItems_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	for iter_7_0 = 1, 3 do
		arg_7_0.rewardPanelItems_[iter_7_0] = MythicSectionRewardItem.New(arg_7_0[string.format("rewardPanelItem%s_", iter_7_0)], iter_7_0)
	end
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.RemoveListeners(arg_10_0)
	return
end

function var_0_0.OnMythicStarRewardUpdate(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.rewardPanelItems_) do
		iter_11_1:SetData(arg_11_0.difficulty_)
	end
end

return var_0_0
