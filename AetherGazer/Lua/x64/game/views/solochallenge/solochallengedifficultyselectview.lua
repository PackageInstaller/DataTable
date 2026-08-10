local var_0_0 = class("SoloChallengeDifficultySelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeChoosedifficult"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectItemHandler_ = handler(arg_3_0, arg_3_0.OnSelectItem)
	arg_3_0.difficultyItemList_ = {}

	local var_3_0 = arg_3_0.panelTrans_.childCount

	for iter_3_0 = 1, var_3_0 do
		arg_3_0.difficultyItemList_[iter_3_0] = SoloChallengeDifficultyItem.New(arg_3_0.panelTrans_:GetChild(iter_3_0 - 1))

		arg_3_0.difficultyItemList_[iter_3_0]:SetSelectCallBack(arg_3_0.selectItemHandler_)
	end
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_4_0.difficultyIndex_ == nil then
			ShowTips("SELECT_CURRENT")

			return
		end

		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeAction.SaveDifficulty(arg_4_0.activityID_, arg_4_0.difficultyIndex_, handler(arg_4_0, arg_4_0.OnStart))
	end)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnStart(arg_7_0)
	SoloChallengeData:SetSelectedDifficultyIndex(arg_7_0.activityID_, arg_7_0.difficultyIndex_)
	arg_7_0:Go("/factorySoloChallengeSelect", {
		activityID = arg_7_0.activityID_,
		difficultyIndex = arg_7_0.difficultyIndex_
	})
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:HideBar()

	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.difficultyIndex_ = SoloChallengeData:GetSelectedDifficultyIndex(arg_8_0.activityID_) or 1

	SoloChallengeData:SetSelectedDifficultyIndex(arg_8_0.activityID_, arg_8_0.difficultyIndex_)
	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0.difficultyIndex_ = nil
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.selectItemHandler_ = nil

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.difficultyItemList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.difficultyItemList_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.OnSelectItem(arg_11_0, arg_11_1)
	arg_11_0.difficultyIndex_ = arg_11_1

	SoloChallengeData:SetSelectedDifficultyIndex(arg_11_0.activityID_, arg_11_0.difficultyIndex_)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.difficultyItemList_) do
		iter_11_1:SetSelect(arg_11_1)
	end
end

function var_0_0.RefreshUI(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.difficultyItemList_) do
		iter_12_1:SetData(arg_12_0.activityID_, iter_12_0)
		iter_12_1:SetSelect(arg_12_0.difficultyIndex_)
	end
end

return var_0_0
