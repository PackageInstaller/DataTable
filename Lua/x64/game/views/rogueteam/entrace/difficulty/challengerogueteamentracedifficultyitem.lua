local var_0_0 = class("ChallengeRogueTeamEntraceDifficultyItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
	arg_1_0.lockController_ = arg_1_0.controllerEx_:GetController("lock")
	arg_1_0.difficultyStateController_ = arg_1_0.controllerEx_:GetController("icondifficult")
	arg_1_0.hasAffixController_ = arg_1_0.controllerEx_:GetController("hasAffix")
	arg_1_0.isSelectAffixController_ = arg_1_0.controllerEx_:GetController("selectaffix")
	arg_1_0.tempVector3_ = Vector3(0, 0, 0)
	arg_1_0.affixItemList_ = {}
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.affixItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.affixItemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_DIFFICULTY_SELECT, arg_3_0.difficultyID_)
	end)
	arg_3_0:AddBtnListener(arg_3_0.affixBtn_, nil, function()
		if arg_3_0.isSelected_ and arg_3_0.isUnlock_ then
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_DIFFICULTY_AFFIX_CLICK)
		end
	end)
end

function var_0_0.SetDifficulty(arg_6_0, arg_6_1)
	arg_6_0.difficultyID_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = RogueTeamDifficultyCfg[arg_7_0.difficultyID_]

	arg_7_0.rateText_.text = string.format("x%s%%", var_7_0.score)

	local var_7_1 = RogueTeamDifficultyCfg.get_id_list_by_template_id[var_7_0.template_id]
	local var_7_2 = table.keyof(var_7_1, arg_7_0.difficultyID_)

	arg_7_0.difficultyIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Common/com_icondifficulty_%02d", var_7_2))

	local var_7_3 = IsConditionAchieved(var_7_0.unlock_condition)

	arg_7_0.isUnlock_ = var_7_3

	if not var_7_3 then
		arg_7_0.lockText_.text = arg_7_0:GetLockText()
	end

	arg_7_0.lockController_:SetSelectedState(tostring(not var_7_3))

	if #var_7_0.affix_pool > 0 then
		arg_7_0.isSelectAffixController_:SetSelectedState("true")

		arg_7_0.selectAffixText_.text = GetTips("ROUGE_TEAM_OPTIONAL_HARD")
	else
		arg_7_0.isSelectAffixController_:SetSelectedState("false")
	end

	arg_7_0:RefreshSelectState(false)
	arg_7_0:RefreshAffixList()
	SetActive(arg_7_0.gameObject_, true)
end

function var_0_0.SetSelectDifficulty(arg_8_0, arg_8_1)
	arg_8_0:RefreshSelectState(arg_8_0.difficultyID_ == arg_8_1)
end

function var_0_0.RefreshSelectState(arg_9_0, arg_9_1)
	arg_9_0.isSelected_ = arg_9_1

	arg_9_0.selectController_:SetSelectedState(tostring(arg_9_1))
	arg_9_0:RefreshDifficultyState(arg_9_1)
end

function var_0_0.RefreshDifficultyState(arg_10_0, arg_10_1)
	if not arg_10_0.isUnlock_ then
		arg_10_0.difficultyStateController_:SetSelectedState("lock")
	elseif arg_10_1 then
		arg_10_0.difficultyStateController_:SetSelectedState("select01")
	else
		arg_10_0.difficultyStateController_:SetSelectedState("select02")
	end
end

function var_0_0.RefreshAffixList(arg_11_0)
	local var_11_0 = RogueTeamDifficultyCfg[arg_11_0.difficultyID_]

	if #var_11_0.affix > 0 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0.affix) do
			arg_11_0.affixItemList_[iter_11_0] = arg_11_0.affixItemList_[iter_11_0] or ChallengeRogueTeamEntranceAffixItem.New(arg_11_0.affixItem_, arg_11_0.affixParent_)

			arg_11_0.affixItemList_[iter_11_0]:SetData(iter_11_1)
		end

		arg_11_0.hasAffixController_:SetSelectedState("true")
	else
		arg_11_0.hasAffixController_:SetSelectedState("false")
	end
end

function var_0_0.GetDifficultyID(arg_12_0)
	return arg_12_0.difficultyID_
end

function var_0_0.GetLocalPosition(arg_13_0)
	return arg_13_0.transform_.localPosition
end

function var_0_0.GetAffixPool(arg_14_0)
	return RogueTeamDifficultyCfg[arg_14_0.difficultyID_].affix_pool
end

function var_0_0.SetChildrenTransform(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0.childrenTf_.localPosition

	var_15_0.x = arg_15_1
	arg_15_0.childrenTf_.localPosition = var_15_0

	local var_15_1 = arg_15_0.childrenTf_.localEulerAngles

	var_15_1.x = arg_15_3
	arg_15_0.childrenTf_.localEulerAngles = var_15_1

	local var_15_2 = arg_15_0.childrenTf_.localScale

	var_15_2.x = arg_15_2
	var_15_2.y = arg_15_2
	arg_15_0.childrenTf_.localScale = var_15_2
end

function var_0_0.GetIsUnlock(arg_16_0)
	return arg_16_0.isUnlock_
end

function var_0_0.GetLockText(arg_17_0)
	local var_17_0 = RogueTeamDifficultyCfg[arg_17_0.difficultyID_]

	return ConditionCfg[var_17_0.unlock_condition].desc
end

return var_0_0
