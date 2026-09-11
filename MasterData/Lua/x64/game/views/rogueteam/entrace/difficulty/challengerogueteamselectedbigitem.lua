local ChallengeRogueTeamSelectedBigItem = class("ChallengeRogueTeamSelectedBigItem", ReduxView)

function ChallengeRogueTeamSelectedBigItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.statusController_ = self.itemCon_:GetController("status")
end

function ChallengeRogueTeamSelectedBigItem:AddListeners()
	return
end

function ChallengeRogueTeamSelectedBigItem:RefreshData(arg_3_1, arg_3_2)
	self.groupId_ = arg_3_1
	self.affixId_ = arg_3_2

	local var_3_0 = ActivityAffixPoolCfg[arg_3_2]

	self.nameText_.text = getAffixName(ActivityAffixPoolCfg[arg_3_2].affix)
	self.descText_.text = getAffixDesc(var_3_0.affix)
	self.iconImg_.sprite = getAffixSprite(var_3_0.affix)
	self.numText_.text = var_3_0.point

	self.statusController_:SetSelectedState(var_3_0.point > 0 and "red" or blue)
end

function ChallengeRogueTeamSelectedBigItem:IsActive()
	return self.isActive_
end

function ChallengeRogueTeamSelectedBigItem:PlayAnim()
	self.anim_:Play("Affixitem", 0, 0)
end

function ChallengeRogueTeamSelectedBigItem:SetActive(arg_6_1)
	self.isActive_ = arg_6_1

	SetActive(self.gameObject_, arg_6_1)
end

return ChallengeRogueTeamSelectedBigItem
