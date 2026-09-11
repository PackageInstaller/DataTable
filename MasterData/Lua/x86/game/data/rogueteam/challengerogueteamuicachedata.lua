local ChallengeRogueTeamUICacheData = class("ChallengeRogueTeamUICacheData")

function ChallengeRogueTeamUICacheData:ExportMethod()
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

function ChallengeRogueTeamUICacheData:Init()
	self:UICacheResetData()
end

function ChallengeRogueTeamUICacheData:UICacheResetData()
	self.playStartAnimatorFlag_ = false
	self.treasureCampMaxCnt_ = nil
	self.treasureIDList_ = nil
	self.relicIDList_ = nil
	self.isPlaySuitSkillAnimationFlag_ = false
	self.mechanismValue_ = nil
	self.hpInitFlag_ = true
	self.heroHPList_ = {}
	self.trailHeroHPList_ = {}
	self.uiOperateType_ = nil
	self.uiSelectEventID_ = nil
	self.uiSelectEventOptionID_ = nil
	self.uiEventIDAnimator_ = nil
	self.uiEventOptionIDAnimator_ = nil
	self.palyAnimatorEventID_ = nil
	self.nodeEffectID_ = nil
	self.uiSelectNodeID_ = nil
	self.eventPauseState_ = false
	self.playAnimatorNodeIDList_ = {}
	self.attributeList_ = {}
end

function ChallengeRogueTeamUICacheData:UISetNeedPlayStartAnimator(arg_4_1)
	self.playStartAnimatorFlag_ = arg_4_1
end

function ChallengeRogueTeamUICacheData:UIGetNeedPlayStartAnimator()
	return self.playStartAnimatorFlag_
end

function ChallengeRogueTeamUICacheData:UIGetTreasureCampMaxCnt()
	if self.treasureCampMaxCnt_ == nil then
		self.treasureCampMaxCnt_ = ChallengeRogueTeamTools.GetTreasureCmapMaxCnt()
	end

	return self.treasureCampMaxCnt_
end

function ChallengeRogueTeamUICacheData:UISetTreasureCampMaxCnt(arg_7_1)
	self.treasureCampMaxCnt_ = arg_7_1
end

function ChallengeRogueTeamUICacheData:UIGetTreasureIDList()
	if self.treasureIDList_ == nil then
		self.treasureIDList_ = ChallengeRogueTeamTools.GetCurTreasureIDList()
	end

	return self.treasureIDList_
end

function ChallengeRogueTeamUICacheData:UIAddTreasureID(arg_9_1)
	if self.treasureIDList_ == nil then
		self:UIGetTreasureIDList()
	end

	if table.keyof(self.treasureIDList_, arg_9_1) == nil then
		table.insert(self.treasureIDList_, arg_9_1)
	end
end

function ChallengeRogueTeamUICacheData:UIRemoveTreasureID(arg_10_1)
	if self.treasureIDList_ == nil then
		self:UIGetTreasureIDList()
	end

	table.removebyvalue(self.treasureIDList_, arg_10_1)
end

function ChallengeRogueTeamUICacheData:UIGetRelicIDList()
	if self.relicIDList_ == nil then
		self.relicIDList_ = ChallengeRogueTeamTools.GetCurRelicIDList()
	end

	return self.relicIDList_
end

function ChallengeRogueTeamUICacheData:UIAddRelicID(arg_12_1)
	if table.keyof(self.relicIDList_, arg_12_1) == nil then
		table.insert(self.relicIDList_, arg_12_1)
	end
end

function ChallengeRogueTeamUICacheData:UIRemoveRelicID(arg_13_1)
	table.removebyvalue(self.relicIDList_, arg_13_1)
end

function ChallengeRogueTeamUICacheData:UIGetIsPlaySuitSkillAnimationFlag()
	return self.isPlaySuitSkillAnimationFlag_
end

function ChallengeRogueTeamUICacheData:UISetIsPlaySuitSkillAnimationFlag(arg_15_1)
	self.isPlaySuitSkillAnimationFlag_ = arg_15_1
end

function ChallengeRogueTeamUICacheData:UIGetMechanismValue()
	if self.mechanismValue_ == nil then
		self.mechanismValue_ = ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_VALUE)
	end

	return self.mechanismValue_
end

function ChallengeRogueTeamUICacheData:UISetMechanismValue(arg_17_1)
	self.mechanismValue_ = arg_17_1
end

function ChallengeRogueTeamUICacheData:UIGetTeamHPInitFlag()
	return self.hpInitFlag_
end

function ChallengeRogueTeamUICacheData:UISetTeamHPInitFlag(arg_19_1)
	self.hpInitFlag_ = arg_19_1
end

function ChallengeRogueTeamUICacheData:UIGetTeamHPData(arg_20_1, arg_20_2)
	if arg_20_2 ~= 0 then
		if self.trailHeroHPList_[arg_20_2] == nil then
			self.trailHeroHPList_[arg_20_2] = ChallengeRogueTeamTools.GetHeroHp(arg_20_1, arg_20_2)
		end

		return self.trailHeroHPList_[arg_20_2]
	else
		if self.heroHPList_[arg_20_1] == nil then
			self.heroHPList_[arg_20_1] = ChallengeRogueTeamTools.GetHeroHp(arg_20_1, arg_20_2)
		end

		return self.heroHPList_[arg_20_1]
	end
end

function ChallengeRogueTeamUICacheData:UISetTeamHPData(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_2 ~= 0 then
		self.trailHeroHPList_[arg_21_2] = arg_21_3
	else
		self.heroHPList_[arg_21_1] = arg_21_3
	end
end

function ChallengeRogueTeamUICacheData:UIGetOperatePopType()
	return self.uiOperateType_
end

function ChallengeRogueTeamUICacheData:UISetOperatePopType(arg_23_1)
	self.uiOperateType_ = arg_23_1
end

function ChallengeRogueTeamUICacheData:UISetSelectEventOption(arg_24_1, arg_24_2)
	self.uiSelectEventID_ = arg_24_1
	self.uiSelectEventOptionID_ = arg_24_2
end

function ChallengeRogueTeamUICacheData:UIGetSelectEventOption()
	return self.uiSelectEventID_, self.uiSelectEventOptionID_
end

function ChallengeRogueTeamUICacheData:UISetEventIDAnimator(arg_26_1, arg_26_2)
	self.uiEventIDAnimator_ = arg_26_1
	self.uiEventOptionIDAnimator_ = arg_26_2
end

function ChallengeRogueTeamUICacheData:UIGetEventIDAnimator()
	return self.uiEventIDAnimator_ or 0, self.uiEventOptionIDAnimator_ or 0
end

function ChallengeRogueTeamUICacheData:UISetPlayEventAnimator(arg_28_1)
	self.palyAnimatorEventID_ = arg_28_1
end

function ChallengeRogueTeamUICacheData:UIGetPlayEventAnimator()
	return self.palyAnimatorEventID_
end

function ChallengeRogueTeamUICacheData:UISetEventPause(arg_30_1)
	self.eventPauseState_ = arg_30_1
end

function ChallengeRogueTeamUICacheData:UIGetEventPause()
	return self.eventPauseState_
end

function ChallengeRogueTeamUICacheData:UIGetSelectNodeID()
	return self.uiSelectNodeID_
end

function ChallengeRogueTeamUICacheData:UISetSelectNodeID(arg_33_1)
	self.uiSelectNodeID_ = arg_33_1
end

function ChallengeRogueTeamUICacheData:UIGetPlayAnimatorNodeIDList()
	return self.playAnimatorNodeIDList_
end

function ChallengeRogueTeamUICacheData:UIClearPlayAnimatorNodeIDList()
	self.playAnimatorNodeIDList_ = {}
end

function ChallengeRogueTeamUICacheData:UIInsertPlayAnimatorNodeIDList(arg_36_1)
	table.insert(self.playAnimatorNodeIDList_, arg_36_1)
end

function ChallengeRogueTeamUICacheData:UISetNodeEffectID(arg_37_1)
	self.nodeEffectID_ = arg_37_1
end

function ChallengeRogueTeamUICacheData:UIGetNodeEffectID()
	return self.nodeEffectID_
end

function ChallengeRogueTeamUICacheData:UIGetAttributeValue(arg_39_1)
	if self.attributeList_[arg_39_1] == nil then
		self.attributeList_[arg_39_1] = ChallengeRogueTeamData:AttributeGetValue(arg_39_1)
	end

	return self.attributeList_[arg_39_1]
end

function ChallengeRogueTeamUICacheData:UISetAttributeValue(arg_40_1, arg_40_2)
	self.attributeList_[arg_40_1] = arg_40_2
end

return ChallengeRogueTeamUICacheData
