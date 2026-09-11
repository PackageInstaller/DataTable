local ChallengeRogueTeamBagRelicPanelItem = class("ChallengeRogueTeamBagRelicPanelItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ChallengeRogueTeamBagRelicPanelItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.relicItemList_ = {}
end

function ChallengeRogueTeamBagRelicPanelItem:AddListeners()
	return
end

function ChallengeRogueTeamBagRelicPanelItem:SetData(arg_3_1, arg_3_2)
	self:Show(true)

	self.index_ = arg_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if self.relicItemList_[iter_3_0] == nil then
			self.relicItemList_[iter_3_0] = ChallengeRogueTeamBagRelicItem.New(self.itemGo_, self.gameObject_)
		end

		self.relicItemList_[iter_3_0]:SetData(iter_3_1)
		self.relicItemList_[iter_3_0]:SetSelectID(self.selectID_)
	end

	for iter_3_2 = #arg_3_1 + 1, #self.relicItemList_ do
		self.relicItemList_[iter_3_2]:Show(false)
	end
end

function ChallengeRogueTeamBagRelicPanelItem:SetSelectID(arg_4_1)
	self.selectID_ = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(self.relicItemList_) do
		iter_4_1:SetSelectID(arg_4_1)
	end
end

function ChallengeRogueTeamBagRelicPanelItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function ChallengeRogueTeamBagRelicPanelItem:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.relicItemList_) do
		iter_6_1:Dispose()
	end

	self.relicItemList_ = nil

	ChallengeRogueTeamBagRelicPanelItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChallengeRogueTeamBagRelicPanelItem
