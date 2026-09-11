local ChallengeRogueTeamEventPopItem = class("ChallengeRogueTeamEventPopItem", ReduxView)

function ChallengeRogueTeamEventPopItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamEventPopItem:Dispose()
	ChallengeRogueTeamEventPopItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamEventPopItem:AddListeners()
	return
end

function ChallengeRogueTeamEventPopItem:SetData(arg_4_1)
	self.nameText_.text = ChallengeRogueTeamTools.TextFormat(arg_4_1.id, arg_4_1.rare, "#ADAC9C")
	self.descText_.text = RogueTeamItemCfg[arg_4_1.id].desc

	self:Show(true)
end

function ChallengeRogueTeamEventPopItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengeRogueTeamEventPopItem
