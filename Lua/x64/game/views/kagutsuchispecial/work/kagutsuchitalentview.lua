local var_0_0 = class("KagutsuchiAffixMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkTalentUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.talentIdList_ = KagutsuchiTalentData:GetTalentIdList()

	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.upBtnController_ = ControllerUtil.GetController(arg_3_0.upgradeTrs_, "button")
	arg_3_0.upTxtController_ = ControllerUtil.GetController(arg_3_0.upgradeTrs_, "text")

	for iter_3_0 = 1, #arg_3_0.talentIdList_ do
		local var_3_0 = arg_3_0[string.format("talent%dBtn_", iter_3_0)]

		if var_3_0 then
			arg_3_0[string.format("lock%dController_", iter_3_0)] = ControllerUtil.GetController(var_3_0.transform, "lock")
		end
	end

	arg_3_0.rightLockController_ = ControllerUtil.GetController(arg_3_0.rightIconTrs_, "lock")
end

function var_0_0.AddUIListener(arg_4_0)
	for iter_4_0 = 1, #arg_4_0.talentIdList_ do
		local var_4_0 = arg_4_0[string.format("talent%dBtn_", iter_4_0)]

		if var_4_0 then
			arg_4_0:AddBtnListener(var_4_0, nil, function()
				arg_4_0:SelectItem(iter_4_0)
			end)
		end
	end

	arg_4_0:AddBtnListener(arg_4_0.upBtn_, nil, function()
		arg_4_0:UpgradeTalent()
	end)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.currentIndex_ = -1

	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	AnimatorTools.Stop()
end

function var_0_0.RefreshUI(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.talentIdList_) do
		arg_10_0:RefreshItem(iter_10_0, iter_10_1)

		local var_10_0 = arg_10_0[string.format("select%dGo_", iter_10_0)]

		if var_10_0 then
			SetActive(var_10_0, false)
		end
	end

	arg_10_0:SelectItem(1)
	SetActive(arg_10_0.upEffectGo_, false)
end

function var_0_0.RefreshItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = TalentTreeCfg[arg_11_2]
	local var_11_1 = KagutsuchiTalentData:GetTalentLevel(arg_11_2)
	local var_11_2 = var_11_1 == KagutsuchiTalentData:GetTalentMaxLevel(arg_11_2)
	local var_11_3 = KagutsuchiTalentData:IsTalentLocked(arg_11_2)
	local var_11_4 = arg_11_0[string.format("lock%dGo_", arg_11_1)]

	if var_11_4 then
		SetActive(var_11_4, var_11_3)
	end

	local var_11_5 = arg_11_0[string.format("select%dGo_", arg_11_1)]

	if var_11_5 then
		SetActive(var_11_5, true)
	end

	local var_11_6 = arg_11_0[string.format("max%dGo_", arg_11_1)]

	if var_11_6 then
		SetActive(var_11_6, var_11_2)
	end

	local var_11_7 = arg_11_0[string.format("level%dText_", arg_11_1)]

	if var_11_7 then
		if var_11_2 or var_11_3 then
			var_11_7.text = ""
		else
			var_11_7.text = string.format("LV.%d", var_11_1)
		end
	end

	local var_11_8 = arg_11_0[string.format("name%dText_", arg_11_1)]

	if var_11_8 then
		var_11_8.text = getAffixName({
			var_11_0.affix_id,
			1
		})
	end

	arg_11_0[string.format("lock%dController_", arg_11_1)]:SetSelectedState(var_11_3 and "yes" or "no")

	if arg_11_0[string.format("talent%dIcon_", arg_11_1)] then
		-- block empty
	end

	arg_11_0:RefreshRightPanel(arg_11_2, arg_11_1)
end

function var_0_0.RefreshRightPanel(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = TalentTreeCfg[arg_12_1]

	arg_12_0.rightNameText_.text = getAffixName({
		var_12_0.affix_id,
		1
	})

	local var_12_1 = KagutsuchiTalentData:IsTalentMaxLevel(arg_12_1)
	local var_12_2 = KagutsuchiTalentData:CanUpgrade(arg_12_1)
	local var_12_3 = KagutsuchiTalentData:IsTalentLocked(arg_12_1)
	local var_12_4 = KagutsuchiTalentData:GetTalentLevel(arg_12_1)

	if var_12_3 then
		var_12_4 = 1
	end

	arg_12_0.rightLockController_:SetSelectedState(var_12_3 and "yes" or "no")

	local var_12_5 = arg_12_0[string.format("talent%dIcon_", arg_12_2)]

	if var_12_5 then
		arg_12_0.rightIcon_.sprite = var_12_5.sprite
	end

	SetActive(arg_12_0.rightLockGo_, var_12_3)
	SetActive(arg_12_0.rightLevelGo_, not var_12_3)
	SetActive(arg_12_0.rightMaxGo_, var_12_1)

	if var_12_1 then
		SetActive(arg_12_0.rightLevelGo_, false)
	else
		arg_12_0.rightLevelText_.text = string.format("LV.%d", var_12_4)
	end

	arg_12_0.rightDescText_.text = getAffixDesc({
		var_12_0.affix_id,
		var_12_4
	})

	if var_12_1 or var_12_3 then
		SetActive(arg_12_0.rightNextGo_, false)
	else
		arg_12_0.rightNextDescText_.text = getAffixDesc({
			var_12_0.affix_id,
			var_12_4 + 1
		})

		SetActive(arg_12_0.rightNextGo_, true)
	end

	arg_12_0:RefreshCondition(arg_12_1, var_12_3 and var_12_4 or var_12_4 + 1)

	if var_12_2 then
		arg_12_0.upBtnController_:SetSelectedState("yellow")
		arg_12_0.upTxtController_:SetSelectedState(var_12_3 and "unlock" or "upgrade")
	elseif var_12_3 then
		arg_12_0.upBtnController_:SetSelectedState("gray")
		arg_12_0.upTxtController_:SetSelectedState("unlock")
	elseif var_12_1 then
		arg_12_0.upBtnController_:SetSelectedState("black")
		arg_12_0.upTxtController_:SetSelectedState("max")
	else
		arg_12_0.upBtnController_:SetSelectedState("gray")
		arg_12_0.upTxtController_:SetSelectedState(var_12_3 and "unlock" or "upgrade")
	end
end

function var_0_0.RefreshCondition(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = KagutsuchiTalentData:IsTalentMaxLevel(arg_13_1)
	local var_13_1 = KagutsuchiTalentData:CanUpgrade(arg_13_1)

	if var_13_0 then
		SetActive(arg_13_0.unlockGo_, false)

		return
	end

	SetActive(arg_13_0.unlockGo_, true)

	local var_13_2 = KagutsuchiTalentData:GetTalentConditionId(arg_13_1, arg_13_2)
	local var_13_3 = ConditionCfg[var_13_2]
	local var_13_4 = var_13_3.type
	local var_13_5 = var_13_3.params

	if var_13_4 == 1020 then
		local var_13_6 = HeroConst.Hero_Star
		local var_13_7 = HeroData:GetHeroData(var_13_5[1])
		local var_13_8 = var_13_7.unlock == 0 and "-" or var_13_6[math.floor(var_13_7.star / 100)]

		arg_13_0.rightConditionText_.text = var_13_3.desc
		arg_13_0.rightProgressText_.text = string.format("(%s/%s)", var_13_8, var_13_6[var_13_5[2]])
	elseif var_13_4 == 2510 then
		local var_13_9 = KagutsuchiWorkData:GetTotalCoins()

		arg_13_0.rightConditionText_.text = string.format(var_13_3.desc, var_13_5[1])
		arg_13_0.rightProgressText_.text = string.format("(%d/%d)", var_13_9, var_13_5[1])
	end

	SetActive(arg_13_0.rightCanUpGo_, var_13_1)
end

function var_0_0.SelectItem(arg_14_0, arg_14_1)
	if arg_14_0.currentIndex_ == arg_14_1 then
		return
	end

	local var_14_0 = arg_14_0.talentIdList_[arg_14_1]

	if arg_14_0.currentIndex_ then
		local var_14_1 = arg_14_0[string.format("select%dGo_", arg_14_0.currentIndex_)]

		if var_14_1 then
			SetActive(var_14_1, false)
		end
	end

	arg_14_0.currentIndex_ = arg_14_1

	arg_14_0:RefreshItem(arg_14_1, var_14_0)
end

function var_0_0.UpgradeTalent(arg_15_0)
	local var_15_0 = arg_15_0.talentIdList_[arg_15_0.currentIndex_]

	if not KagutsuchiTalentData:CanUpgrade(var_15_0) then
		if KagutsuchiTalentData:IsTalentLocked(var_15_0) then
			ShowTips(string.format(GetTips("NO_REACH_UNLOCK")))
		else
			ShowTips(string.format(GetTips("DORM_CANTEEN_CANT_LEVEL_UP")))
		end

		return
	end

	KagutsuchiTalentAction:UpgradeTalent(var_15_0, handler(arg_15_0, arg_15_0.OnUpgradeTalent))
end

function var_0_0.OnUpgradeTalent(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:RefreshItem(arg_16_0.currentIndex_, arg_16_2.talent_id)
	SetActive(arg_16_0.upEffectGo_, true)
	AnimatorTools.PlayAnimationWithCallback(arg_16_0.upgradeAni_, "JapanRegionWorkTalentUI_saoguang", function()
		SetActive(arg_16_0.upEffectGo_, false)
	end)
end

return var_0_0
