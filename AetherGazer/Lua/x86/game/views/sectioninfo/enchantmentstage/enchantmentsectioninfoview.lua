local var_0_0 = class("EnchantmentSectionInfoView", import("..SectionInfoMultipleBaseView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	arg_1_0.hideDropPanelController_:SetSelectedState("false")
	arg_1_0.hideBattleAffixController_:SetSelectedState("false")
end

function var_0_0.OnClickBtn(arg_2_0)
	arg_2_0:Go("/sectionSelectHero", {
		section = arg_2_0.stageID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT,
		multiple = arg_2_0.multiple_
	})
end

function var_0_0.RefreshData(arg_3_0)
	local var_3_0 = BattleEnchantmentStageCfg[arg_3_0.stageID_]

	arg_3_0.lock_ = false
	arg_3_0.lockTips_ = ""
	arg_3_0.cost_ = var_3_0.cost
	arg_3_0.dropLibID_ = var_3_0.drop_lib_id
	arg_3_0.isFirstClear_ = true

	var_0_0.super.RefreshData(arg_3_0)
end

function var_0_0.RefreshUI(arg_4_0)
	var_0_0.super.RefreshUI(arg_4_0)
	arg_4_0:RefreshBattleAffix()
	SetActive(arg_4_0.affixInfoTrs_.gameObject, false)
end

function var_0_0.AddListeners(arg_5_0)
	var_0_0.super.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.buffAffixBtn_, nil, function()
		arg_5_0:ShowAffixInfo(arg_5_0.buffAffixBtn_.transform, arg_5_0.buff_[1])
	end)
	arg_5_0:AddBtnListener(arg_5_0.debuffAffixBtn_, nil, function()
		arg_5_0:ShowAffixInfo(arg_5_0.debuffAffixBtn_.transform, arg_5_0.debuff_[1])
	end)
end

function var_0_0.RemoveListeners(arg_8_0)
	var_0_0.super.RemoveListeners(arg_8_0)
	arg_8_0.buffAffixBtn_.onClick:RemoveAllListeners()
	arg_8_0.debuffAffixBtn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshRewardItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.rewardList_[arg_9_1]
	local var_9_1

	if var_9_0 then
		var_9_1 = rewardToItemTemplate(var_9_0)
		var_9_1.number = nil

		function var_9_1.clickFun(arg_10_0)
			ShowPopItem(POP_ITEM, arg_10_0)
		end
	end

	arg_9_2:SetData(var_9_1)
end

function var_0_0.RefreshStageInfo(arg_11_0)
	local var_11_0 = BattleEnchantmentStageCfg[arg_11_0.stageID_]

	arg_11_0.sectionName_.text = GetI18NText(var_11_0.name)
	arg_11_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_11_0.background_1))
end

function var_0_0.RefreshBattleAffix(arg_12_0)
	arg_12_0.buff_ = getHeroAffixs(BattleEnchantmentStageCfg[arg_12_0.stageID_].affix_type)
	arg_12_0.debuff_ = BattleEnchantmentStageCfg[arg_12_0.stageID_].affix_type_in_map == "" and getMosterAffix(BattleEnchantmentStageCfg[arg_12_0.stageID_].affix_type) or BattleEnchantmentStageCfg[arg_12_0.stageID_].affix_type_in_map

	if arg_12_0.buff_ and arg_12_0.buff_ ~= "" and arg_12_0.buff_[1] then
		arg_12_0.buffAffixText_.text = GetI18NText(getAffixName(arg_12_0.buff_[1]))
		arg_12_0.buffAffixImg_.sprite = getAffixSprite(arg_12_0.buff_[1])
	else
		arg_12_0.buffAffixText_.text = ""
		arg_12_0.buffAffixImg_.sprite = nil
	end

	if arg_12_0.debuff_ and arg_12_0.debuff_ ~= "" and arg_12_0.debuff_[1] then
		arg_12_0.debuffAffixText_.text = GetI18NText(getAffixName(arg_12_0.debuff_[1]))
		arg_12_0.debuffAffixImg_.sprite = getAffixSprite(arg_12_0.debuff_[1])
	else
		arg_12_0.debuffAffixText_.text = ""
		arg_12_0.debuffAffixImg_.sprite = nil
	end
end

function var_0_0.ShowAffixInfo(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.affixInfoTrs_:SetParent(arg_13_1)

	arg_13_0.affixInfoTrs_.localPosition = Vector3(0, 0, 0)

	SetActive(arg_13_0.affixInfoTrs_.gameObject, true)

	if arg_13_2 and arg_13_2 ~= "" then
		arg_13_0.affixContentText_.text = GetI18NText(getAffixDesc(arg_13_2))
		arg_13_0.affixTitleText_.text = GetI18NText(getAffixName(arg_13_2))
	else
		arg_13_0.affixContentText_.text = ""
		arg_13_0.affixTitleText_.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.affixInfoTrs_)

	if arg_13_0.countdownTimer_ then
		arg_13_0.countdownTimer_:Stop()

		arg_13_0.countdownTimer_ = nil
	end

	arg_13_0.countdownTimer_ = Timer.New(function()
		if arg_13_0.affixInfoTrs_ and arg_13_0.affixInfoTrs_.gameObject then
			SetActive(arg_13_0.affixInfoTrs_.gameObject, false)
		end
	end, 2, 1)

	arg_13_0.countdownTimer_:Start()
end

function var_0_0.OnExit(arg_15_0)
	var_0_0.super.OnExit(arg_15_0)

	if arg_15_0.countdownTimer_ then
		arg_15_0.countdownTimer_:Stop()

		arg_15_0.countdownTimer_ = nil
	end
end

return var_0_0
