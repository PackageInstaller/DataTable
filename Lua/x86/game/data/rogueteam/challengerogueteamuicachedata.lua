local var_0_0 = class("ChallengeRogueTeamUICacheData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"UISetNeedPlayStartAnimator",
		"UIGetNeedPlayStartAnimator",
		"UICacheResetData",
		"UIGetTreasureCampMaxCnt",
		"UISetTreasureCampMaxCnt",
		"UIGetTreasureIDList",
		"UIAddTreasureID",
		"UIRemoveTreasureID",
		"UIGetRelicIDList",
		"UIAddRelicID",
		"UIRemoveRelicID",
		"UIGetIsPlaySuitSkillAnimationFlag",
		"UISetIsPlaySuitSkillAnimationFlag",
		"UIGetMechanismValue",
		"UISetMechanismValue",
		"UIGetTeamHPInitFlag",
		"UISetTeamHPInitFlag",
		"UIGetTeamHPData",
		"UISetTeamHPData",
		"UIGetOperatePopType",
		"UISetOperatePopType",
		"UISetSelectEventOption",
		"UIGetSelectEventOption",
		"UISetEventIDAnimator",
		"UIGetEventIDAnimator",
		"UISetPlayEventAnimator",
		"UIGetPlayEventAnimator",
		"UISetEventPause",
		"UIGetEventPause",
		"UISetSelectNodeID",
		"UIGetSelectNodeID",
		"UIGetPlayAnimatorNodeIDList",
		"UIClearPlayAnimatorNodeIDList",
		"UIInsertPlayAnimatorNodeIDList",
		"UISetNodeEffectID",
		"UIGetNodeEffectID",
		"UISetAttributeValue",
		"UIGetAttributeValue"
	}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:UICacheResetData()
end

function var_0_0.UICacheResetData(arg_3_0)
	arg_3_0.playStartAnimatorFlag_ = false
	arg_3_0.treasureCampMaxCnt_ = nil
	arg_3_0.treasureIDList_ = nil
	arg_3_0.relicIDList_ = nil
	arg_3_0.isPlaySuitSkillAnimationFlag_ = false
	arg_3_0.mechanismValue_ = nil
	arg_3_0.hpInitFlag_ = true
	arg_3_0.heroHPList_ = {}
	arg_3_0.trailHeroHPList_ = {}
	arg_3_0.uiOperateType_ = nil
	arg_3_0.uiSelectEventID_ = nil
	arg_3_0.uiSelectEventOptionID_ = nil
	arg_3_0.uiEventIDAnimator_ = nil
	arg_3_0.uiEventOptionIDAnimator_ = nil
	arg_3_0.palyAnimatorEventID_ = nil
	arg_3_0.nodeEffectID_ = nil
	arg_3_0.uiSelectNodeID_ = nil
	arg_3_0.eventPauseState_ = false
	arg_3_0.playAnimatorNodeIDList_ = {}
	arg_3_0.attributeList_ = {}
end

function var_0_0.UISetNeedPlayStartAnimator(arg_4_0, arg_4_1)
	arg_4_0.playStartAnimatorFlag_ = arg_4_1
end

function var_0_0.UIGetNeedPlayStartAnimator(arg_5_0)
	return arg_5_0.playStartAnimatorFlag_
end

function var_0_0.UIGetTreasureCampMaxCnt(arg_6_0)
	if arg_6_0.treasureCampMaxCnt_ == nil then
		arg_6_0.treasureCampMaxCnt_ = ChallengeRogueTeamTools.GetTreasureCmapMaxCnt()
	end

	return arg_6_0.treasureCampMaxCnt_
end

function var_0_0.UISetTreasureCampMaxCnt(arg_7_0, arg_7_1)
	arg_7_0.treasureCampMaxCnt_ = arg_7_1
end

function var_0_0.UIGetTreasureIDList(arg_8_0)
	if arg_8_0.treasureIDList_ == nil then
		arg_8_0.treasureIDList_ = ChallengeRogueTeamTools.GetCurTreasureIDList()
	end

	return arg_8_0.treasureIDList_
end

function var_0_0.UIAddTreasureID(arg_9_0, arg_9_1)
	if arg_9_0.treasureIDList_ == nil then
		arg_9_0:UIGetTreasureIDList()
	end

	if table.keyof(arg_9_0.treasureIDList_, arg_9_1) == nil then
		table.insert(arg_9_0.treasureIDList_, arg_9_1)
	end
end

function var_0_0.UIRemoveTreasureID(arg_10_0, arg_10_1)
	if arg_10_0.treasureIDList_ == nil then
		arg_10_0:UIGetTreasureIDList()
	end

	table.removebyvalue(arg_10_0.treasureIDList_, arg_10_1)
end

function var_0_0.UIGetRelicIDList(arg_11_0)
	if arg_11_0.relicIDList_ == nil then
		arg_11_0.relicIDList_ = ChallengeRogueTeamTools.GetCurRelicIDList()
	end

	return arg_11_0.relicIDList_
end

function var_0_0.UIAddRelicID(arg_12_0, arg_12_1)
	if table.keyof(arg_12_0.relicIDList_, arg_12_1) == nil then
		table.insert(arg_12_0.relicIDList_, arg_12_1)
	end
end

function var_0_0.UIRemoveRelicID(arg_13_0, arg_13_1)
	table.removebyvalue(arg_13_0.relicIDList_, arg_13_1)
end

function var_0_0.UIGetIsPlaySuitSkillAnimationFlag(arg_14_0)
	return arg_14_0.isPlaySuitSkillAnimationFlag_
end

function var_0_0.UISetIsPlaySuitSkillAnimationFlag(arg_15_0, arg_15_1)
	arg_15_0.isPlaySuitSkillAnimationFlag_ = arg_15_1
end

function var_0_0.UIGetMechanismValue(arg_16_0)
	if arg_16_0.mechanismValue_ == nil then
		arg_16_0.mechanismValue_ = ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_VALUE)
	end

	return arg_16_0.mechanismValue_
end

function var_0_0.UISetMechanismValue(arg_17_0, arg_17_1)
	arg_17_0.mechanismValue_ = arg_17_1
end

function var_0_0.UIGetTeamHPInitFlag(arg_18_0)
	return arg_18_0.hpInitFlag_
end

function var_0_0.UISetTeamHPInitFlag(arg_19_0, arg_19_1)
	arg_19_0.hpInitFlag_ = arg_19_1
end

function var_0_0.UIGetTeamHPData(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 ~= 0 then
		if arg_20_0.trailHeroHPList_[arg_20_2] == nil then
			arg_20_0.trailHeroHPList_[arg_20_2] = ChallengeRogueTeamTools.GetHeroHp(arg_20_1, arg_20_2)
		end

		return arg_20_0.trailHeroHPList_[arg_20_2]
	else
		if arg_20_0.heroHPList_[arg_20_1] == nil then
			arg_20_0.heroHPList_[arg_20_1] = ChallengeRogueTeamTools.GetHeroHp(arg_20_1, arg_20_2)
		end

		return arg_20_0.heroHPList_[arg_20_1]
	end
end

function var_0_0.UISetTeamHPData(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_2 ~= 0 then
		arg_21_0.trailHeroHPList_[arg_21_2] = arg_21_3
	else
		arg_21_0.heroHPList_[arg_21_1] = arg_21_3
	end
end

function var_0_0.UIGetOperatePopType(arg_22_0)
	return arg_22_0.uiOperateType_
end

function var_0_0.UISetOperatePopType(arg_23_0, arg_23_1)
	arg_23_0.uiOperateType_ = arg_23_1
end

function var_0_0.UISetSelectEventOption(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.uiSelectEventID_ = arg_24_1
	arg_24_0.uiSelectEventOptionID_ = arg_24_2
end

function var_0_0.UIGetSelectEventOption(arg_25_0)
	return arg_25_0.uiSelectEventID_, arg_25_0.uiSelectEventOptionID_
end

function var_0_0.UISetEventIDAnimator(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.uiEventIDAnimator_ = arg_26_1
	arg_26_0.uiEventOptionIDAnimator_ = arg_26_2
end

function var_0_0.UIGetEventIDAnimator(arg_27_0)
	return arg_27_0.uiEventIDAnimator_ or 0, arg_27_0.uiEventOptionIDAnimator_ or 0
end

function var_0_0.UISetPlayEventAnimator(arg_28_0, arg_28_1)
	arg_28_0.palyAnimatorEventID_ = arg_28_1
end

function var_0_0.UIGetPlayEventAnimator(arg_29_0)
	return arg_29_0.palyAnimatorEventID_
end

function var_0_0.UISetEventPause(arg_30_0, arg_30_1)
	arg_30_0.eventPauseState_ = arg_30_1
end

function var_0_0.UIGetEventPause(arg_31_0)
	return arg_31_0.eventPauseState_
end

function var_0_0.UIGetSelectNodeID(arg_32_0)
	return arg_32_0.uiSelectNodeID_
end

function var_0_0.UISetSelectNodeID(arg_33_0, arg_33_1)
	arg_33_0.uiSelectNodeID_ = arg_33_1
end

function var_0_0.UIGetPlayAnimatorNodeIDList(arg_34_0)
	return arg_34_0.playAnimatorNodeIDList_
end

function var_0_0.UIClearPlayAnimatorNodeIDList(arg_35_0)
	arg_35_0.playAnimatorNodeIDList_ = {}
end

function var_0_0.UIInsertPlayAnimatorNodeIDList(arg_36_0, arg_36_1)
	table.insert(arg_36_0.playAnimatorNodeIDList_, arg_36_1)
end

function var_0_0.UISetNodeEffectID(arg_37_0, arg_37_1)
	arg_37_0.nodeEffectID_ = arg_37_1
end

function var_0_0.UIGetNodeEffectID(arg_38_0)
	return arg_38_0.nodeEffectID_
end

function var_0_0.UIGetAttributeValue(arg_39_0, arg_39_1)
	if arg_39_0.attributeList_[arg_39_1] == nil then
		arg_39_0.attributeList_[arg_39_1] = ChallengeRogueTeamData:AttributeGetValue(arg_39_1)
	end

	return arg_39_0.attributeList_[arg_39_1]
end

function var_0_0.UISetAttributeValue(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0.attributeList_[arg_40_1] = arg_40_2
end

return var_0_0
