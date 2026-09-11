local RogueTeamItemInfoSettingOptionalAffixView = class("RogueTeamItemInfoSettingOptionalAffixView", ReduxView)

function RogueTeamItemInfoSettingOptionalAffixView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.affixList_ = LuaList.New(handler(self, self.IndexAffixItem), self.affixListGo_, ChallengeRogueTeamBagOptionalAffixItem)
end

function RogueTeamItemInfoSettingOptionalAffixView:Dispose()
	self.affixList_:Dispose()

	self.affixList_ = nil

	RogueTeamItemInfoSettingOptionalAffixView.super.Dispose(self)
end

function RogueTeamItemInfoSettingOptionalAffixView:IndexAffixItem(arg_3_1, arg_3_2)
	arg_3_2:SetData(arg_3_1, self.affixDataList_[arg_3_1])
end

function RogueTeamItemInfoSettingOptionalAffixView:RefreshUI()
	self.levelNum_, self.affixDataList_ = ChallengeRogueTeamData:GetOptionalAffix()
	self.numText_.text = self.levelNum_

	self.affixList_:StartScroll(#self.affixDataList_)
end

return RogueTeamItemInfoSettingOptionalAffixView
