local ChallengeRogueTeamBagRelicTitleItem = class("ChallengeRogueTeamBagRelicTitleItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ChallengeRogueTeamBagRelicTitleItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamBagRelicTitleItem:AddListeners()
	return
end

function ChallengeRogueTeamBagRelicTitleItem:SetData(arg_3_1, arg_3_2)
	self:Show(true)

	self.nameText_.text = GetTips(ChallengeRogueTeamConst.RELIC_SUB_TYPE_TITLE[arg_3_1])
	self.index_ = arg_3_2
end

function ChallengeRogueTeamBagRelicTitleItem:SetSelectID(arg_4_1)
	return
end

function ChallengeRogueTeamBagRelicTitleItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function ChallengeRogueTeamBagRelicTitleItem:Dispose()
	ChallengeRogueTeamBagRelicTitleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChallengeRogueTeamBagRelicTitleItem
