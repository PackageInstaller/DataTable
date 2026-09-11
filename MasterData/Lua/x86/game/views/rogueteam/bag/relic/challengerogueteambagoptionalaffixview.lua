local ChallengeRogueTeamBagOptionalAffixView = class("ChallengeRogueTeamBagOptionalAffixView", ReduxView)

function ChallengeRogueTeamBagOptionalAffixView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChallengeRogueTeamBagOptionalAffixView:Init()
	self:BindCfgUI()

	self.affixList_ = LuaList.New(handler(self, self.IndexAffixItem), self.affixListGo_, ChallengeRogueTeamBagOptionalAffixItem)
end

function ChallengeRogueTeamBagOptionalAffixView:OnEnter(arg_3_1)
	return
end

function ChallengeRogueTeamBagOptionalAffixView:IndexAffixItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.affixDataList_[arg_4_1])
end

function ChallengeRogueTeamBagOptionalAffixView:RefreshUI()
	self.levelNum_, self.affixDataList_ = ChallengeRogueTeamData:GetOptionalAffix()
	self.numText_.text = self.levelNum_

	self.affixList_:StartScroll(#self.affixDataList_)
end

function ChallengeRogueTeamBagOptionalAffixView:OnExit()
	return
end

function ChallengeRogueTeamBagOptionalAffixView:Dispose()
	ChallengeRogueTeamBagOptionalAffixView.super.Dispose(self)

	if self.affixList_ then
		self.affixList_:Dispose()

		self.affixList_ = nil
	end
end

return ChallengeRogueTeamBagOptionalAffixView
