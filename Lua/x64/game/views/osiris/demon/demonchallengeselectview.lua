local var_0_0 = class("DemonChallengeSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisUIselectDifficultyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.levelIndex_ = arg_3_0.params_.levelIndex
	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "selectDifficulty")

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.completedUIController_1 = ControllerUtil.GetController(arg_4_0.Level1Btn_.transform, "completed")
	arg_4_0.completedUIController_2 = ControllerUtil.GetController(arg_4_0.Level2Btn_.transform, "completed")
	arg_4_0.completedUIController_3 = ControllerUtil.GetController(arg_4_0.Level3Btn_.transform, "completed")
	arg_4_0.completedUIController_ = {
		arg_4_0.completedUIController_1,
		arg_4_0.completedUIController_2,
		arg_4_0.completedUIController_3
	}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		if not ActivityData:GetActivityData(ActivityConst.OSIRIS_DEMON):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		DemonChallengeData:SetSelectDifficultyIndex(arg_5_0.levelIndex_, arg_5_0.difficultyIndex_)
		arg_5_0:GetStageId()
		arg_5_0:Go("/sectionSelectHero", {
			section = arg_5_0.curStageId_,
			sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.Level1Btn_, nil, function()
		arg_5_0:RefreshDifficult(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.Level2Btn_, nil, function()
		arg_5_0:RefreshDifficult(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.Level3Btn_, nil, function()
		arg_5_0:RefreshDifficult(3)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_10_0:UpdateData()
	arg_10_0:RefreshUI()
end

function var_0_0.UpdateData(arg_11_0)
	arg_11_0.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()
	arg_11_0.difficultyIndex_ = DemonChallengeData:GetSelectDifficultyIndex(arg_11_0.levelIndex_)

	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:RefreshCompletedUI()
	arg_12_0:RefreshSelectedUI()
	arg_12_0:RefreshDesc()
end

function var_0_0.RefreshCompletedUI(arg_13_0)
	local var_13_0 = DemonChallengeData:GetCompletedList(arg_13_0.levelIndex_)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.completedUIController_) do
		if table.keyof(var_13_0, iter_13_0) ~= nil then
			iter_13_1:SetSelectedState("true")
		else
			iter_13_1:SetSelectedState("false")
		end
	end
end

function var_0_0.RefreshDesc(arg_14_0)
	local var_14_0 = ""

	if arg_14_0.difficultyIndex_ ~= nil then
		var_14_0 = DemonChallengeData:GetDifficultyDes(arg_14_0.levelIndex_, arg_14_0.difficultyIndex_)
	end

	arg_14_0.descText_.text = GetI18NText(var_14_0)
end

function var_0_0.RefreshSelectedUI(arg_15_0)
	if arg_15_0.difficultyIndex_ == nil then
		arg_15_0.selectController_:SetSelectedState("4")

		arg_15_0.startBtn_.interactable = false
	else
		arg_15_0.selectController_:SetSelectedState(tostring(arg_15_0.difficultyIndex_))

		arg_15_0.startBtn_.interactable = true
	end
end

function var_0_0.RefreshDifficult(arg_16_0, arg_16_1)
	arg_16_0.difficultyIndex_ = arg_16_1

	DemonChallengeData:SetSelectDifficultyIndex(arg_16_0.levelIndex_, arg_16_0.difficultyIndex_)
	arg_16_0:RefreshUI()
	arg_16_0:GetStageId()
end

function var_0_0.GetStageId(arg_17_0)
	arg_17_0.curStageId_ = DemonChallengeData:GetStageId(arg_17_0.levelIndex_, arg_17_0.difficultyIndex_)
end

return var_0_0
