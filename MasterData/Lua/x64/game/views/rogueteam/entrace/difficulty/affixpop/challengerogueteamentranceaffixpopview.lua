local ChallengRogueTeamEntranceAffixPopView = class("ChallengRogueTeamEntranceAffixPopView", ReduxView)

function ChallengRogueTeamEntranceAffixPopView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
end

function ChallengRogueTeamEntranceAffixPopView:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.itemList_) do
		iter_2_1:Dispose()
	end

	self.itemList_ = nil

	ChallengRogueTeamEntranceAffixPopView.super.Dispose(self)
end

function ChallengRogueTeamEntranceAffixPopView:AddListeners()
	return
end

function ChallengRogueTeamEntranceAffixPopView:SetData(arg_4_1)
	if #RogueTeamDifficultyCfg[arg_4_1].affix > 0 then
		for iter_4_0, iter_4_1 in ipairs(RogueTeamDifficultyCfg[arg_4_1].affix) do
			self.itemList_[iter_4_0] = self.itemList_[iter_4_0] or ChallengeRogueTeamEntranceAffixPopItem.New(self.itemGo_, self.parentGo_)

			self.itemList_[iter_4_0]:SetData(iter_4_1)
		end

		for iter_4_2 = #self.itemList_, #RogueTeamDifficultyCfg[arg_4_1].affix + 1, -1 do
			self.itemList_[iter_4_2]:Show(false)
		end

		self:Show(true)
	else
		self:Show(false)
	end
end

function ChallengRogueTeamEntranceAffixPopView:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengRogueTeamEntranceAffixPopView
