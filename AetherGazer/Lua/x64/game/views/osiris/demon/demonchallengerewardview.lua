local var_0_0 = class("DemonChallengerewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisChallengerewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, TaskDemonChallengeItemView)
	arg_4_0.refreshHandler_ = handler(arg_4_0, arg_4_0.RefreshScroll)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()

	arg_7_0:RefreshUI()
	manager.notify:RegistListener(DEMON_CHALLENGE_RECEIVE_REWARD, arg_7_0.refreshHandler_)
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshLevelName()
	arg_8_0:RefreshScroll()
end

function var_0_0.RefreshLevelName(arg_9_0)
	arg_9_0.levelNameText_.text = DemonChallengeData:GetLevelName(arg_9_0.levelIndex_)
end

function var_0_0.RefreshScroll(arg_10_0)
	arg_10_0:UpdateData()
	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.sortedRewardList_)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = DemonChallengeData:GetDropId(arg_11_0.levelIndex_, arg_11_0.sortedRewardList_[arg_11_1])

	arg_11_2:SetData(var_11_0, arg_11_0.sortedRewardList_[arg_11_1], arg_11_0.levelIndex_)
end

function var_0_0.OnExit(arg_12_0)
	manager.notify:RemoveListener(DEMON_CHALLENGE_RECEIVE_REWARD, arg_12_0.refreshHandler_)
end

function var_0_0.UpdateData(arg_13_0)
	arg_13_0.sortedRewardList_ = DemonChallengeData:GetSortedRewardIndexList(arg_13_0.levelIndex_)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
