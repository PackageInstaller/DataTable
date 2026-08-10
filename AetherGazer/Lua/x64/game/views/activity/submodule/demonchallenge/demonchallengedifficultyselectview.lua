local var_0_0 = class("DemonChallengeDifficultySelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return nil
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.InitGo(arg_3_0, arg_3_1)
	if arg_3_0.gameObject_ then
		arg_3_0:Dispose()
		Object.Destroy(arg_3_0.gameObject_)
	end

	local var_3_0 = Asset.Load(arg_3_1)

	arg_3_0.gameObject_ = Object.Instantiate(var_3_0, arg_3_0:UIParent())
	arg_3_0.transform_ = arg_3_0.gameObject_.transform

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

local var_0_1 = 3

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectController_ = ControllerUtil.GetController(arg_4_0.transform_, "selectDifficulty")
	arg_4_0.completedUIControllerS_ = {}

	for iter_4_0 = 1, var_0_1 do
		arg_4_0.completedUIControllerS_[iter_4_0] = ControllerUtil.GetController(arg_4_0[string.format("Level%dBtn_", iter_4_0)].transform, "completed")
	end

	arg_4_0.startImg_ = arg_4_0.startBtn_.gameObject:GetComponent(typeof(Image))
	arg_4_0.affixItemList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.difficultyIndex_ == nil then
			ShowTips("SELECT_CURRENT")

			return
		end

		local var_6_0 = DemonChallengeTools.GetChildId(arg_5_0.activityId_, arg_5_0.difficultyIndex_)
		local var_6_1 = DemonChallengeTools.GetStageId(arg_5_0.activityId_, arg_5_0.difficultyIndex_)

		arg_5_0:Go("/sectionSelectHero", {
			section = var_6_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON,
			activityID = var_6_0
		})
	end)

	for iter_5_0 = 1, var_0_1 do
		arg_5_0:AddBtnListener(arg_5_0[string.format("Level%dBtn_", iter_5_0)], nil, function()
			if not ActivityData:GetActivityIsOpen(arg_5_0.activityId_) then
				ShowTips("TIME_OVER")

				return
			end

			arg_5_0:RefreshDifficult(iter_5_0)
		end)
	end
end

function var_0_0.OnEnter(arg_8_0)
	if not arg_8_0.activityId_ or arg_8_0.params_.selectId ~= arg_8_0.activityId_ then
		if arg_8_0.activityId_ ~= arg_8_0.params_.selectId then
			arg_8_0.difficultyIndex_ = nil
		end

		arg_8_0.activityId_ = arg_8_0.params_.selectId

		if not arg_8_0.mainActivityId_ or arg_8_0.params_.activityId ~= arg_8_0.mainActivityId_ then
			arg_8_0.mainActivityId_ = arg_8_0.params_.activityId

			arg_8_0:InitGo(DemonChallengeTools.GetDifficultyUIName(arg_8_0.params_.activityId))
		end
	end

	arg_8_0:RefreshCompletedUI()
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshSelectedUI()
	arg_9_0:RefreshDesc()
	arg_9_0:RefreshAffix()
end

function var_0_0.RefreshCompletedUI(arg_10_0)
	local var_10_0 = SubDemonChallengeData:GetChallengeInfo(arg_10_0.activityId_)

	for iter_10_0 = 1, var_0_1 do
		if var_10_0.challengeInfo and var_10_0.challengeInfo[iter_10_0].challenge_state ~= ActivityConst.DEMON_CHALLENGE_STATE.FINISHED then
			arg_10_0.completedUIControllerS_[iter_10_0]:SetSelectedState("false")
		else
			arg_10_0.completedUIControllerS_[iter_10_0]:SetSelectedState("true")
		end
	end
end

function var_0_0.RefreshDesc(arg_11_0)
	local var_11_0 = ""

	if arg_11_0.difficultyIndex_ ~= nil then
		local var_11_1 = DemonChallengeTools.GetChildId(arg_11_0.activityId_, arg_11_0.difficultyIndex_)

		if var_11_1 then
			var_11_0 = DemonChallengeCfg[var_11_1].difficulty_desc
		end
	end

	if arg_11_0.descText_ then
		arg_11_0.descText_.text = GetI18NText(var_11_0)
	end
end

function var_0_0.RefreshSelectedUI(arg_12_0)
	if not arg_12_0.difficultyIndex_ then
		arg_12_0:RefreshDefalutDifficult()
	else
		arg_12_0.selectController_:SetSelectedState(tostring(arg_12_0.difficultyIndex_))

		if arg_12_0.startImg_ then
			manager.effect:SetGrey(arg_12_0.startImg_, false)
		end
	end
end

function var_0_0.RefreshDifficult(arg_13_0, arg_13_1)
	arg_13_0.difficultyIndex_ = arg_13_1

	arg_13_0:RefreshUI()
end

function var_0_0.RefreshDefalutDifficult(arg_14_0)
	if arg_14_0.difficultyIndex_ == nil then
		arg_14_0.difficultyIndex_ = 1

		arg_14_0.selectController_:SetSelectedState(1)

		for iter_14_0 = 1, var_0_1 - 1 do
			local var_14_0 = SubDemonChallengeData:GetChallengeInfo(arg_14_0.activityId_)

			if var_14_0.challengeInfo and var_14_0.challengeInfo[iter_14_0].challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED then
				arg_14_0.selectController_:SetSelectedState(iter_14_0 + 1)

				arg_14_0.difficultyIndex_ = iter_14_0 + 1
			else
				break
			end
		end
	end
end

function var_0_0.RefreshAffix(arg_15_0)
	local var_15_0 = {}

	if arg_15_0.difficultyIndex_ ~= nil then
		local var_15_1 = DemonChallengeTools.GetStageId(arg_15_0.activityId_, arg_15_0.difficultyIndex_)
		local var_15_2 = BattleHeartDemonStageCfg[var_15_1].affix_type

		if type(var_15_2) == "table" then
			var_15_0 = getMosterAffix(var_15_2)
		end
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if arg_15_0.affixItemList_[iter_15_0] then
			arg_15_0.affixItemList_[iter_15_0]:SetData(iter_15_1)
		else
			arg_15_0.affixItemList_[iter_15_0] = AffixItemView.New(arg_15_0.affixItem_, arg_15_0.affixPanel_, iter_15_1)
		end
	end

	for iter_15_2 = #arg_15_0.affixItemList_, #var_15_0 + 1, -1 do
		arg_15_0.affixItemList_[iter_15_2]:Show(false)
	end
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.affixItemList_) do
		iter_17_1:Dispose()
	end

	arg_17_0.affixItemList_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
