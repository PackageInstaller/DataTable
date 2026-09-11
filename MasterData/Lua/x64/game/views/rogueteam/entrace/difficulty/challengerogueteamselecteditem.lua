local ChallengeRogueTeamSelectedItem = class("ChallengeRogueTeamSelectedItem", ReduxView)

function ChallengeRogueTeamSelectedItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.statusController_ = self.itemCon_:GetController("status")
end

function ChallengeRogueTeamSelectedItem:AddListeners()
	return
end

function ChallengeRogueTeamSelectedItem:RefreshData(arg_3_1)
	local var_3_0 = ActivityAffixPoolCfg[arg_3_1]

	self.iconImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_3_1].affix)
	self.numText_.text = var_3_0.point

	self.statusController_:SetSelectedState(var_3_0.point > 0 and "red" or blue)
end

return ChallengeRogueTeamSelectedItem
