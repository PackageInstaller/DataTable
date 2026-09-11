local ChallengeRogueTeamBagSchoolItem = class("ChallengeRogueTeamBagSchoolItem", ReduxView)

function ChallengeRogueTeamBagSchoolItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamBagSchoolItem:Dispose()
	ChallengeRogueTeamBagSchoolItem.super.Dispose(self)
end

function ChallengeRogueTeamBagSchoolItem:AddListeners()
	return
end

function ChallengeRogueTeamBagSchoolItem:SetData(arg_4_1)
	local var_4_0 = RogueTeamItemCfg[ChallengeRogueTeamData:TreasureGetList()[arg_4_1].id]

	self.nameText_.text = var_4_0.name
	self.descText_.text = var_4_0.desc
end

return ChallengeRogueTeamBagSchoolItem
