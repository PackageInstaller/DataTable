local ChallengeRogueTeamIllustratedRelicPanelItem = class("ChallengeRogueTeamIllustratedRelicPanelItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ChallengeRogueTeamIllustratedRelicPanelItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.relicItemList_ = {}
end

function ChallengeRogueTeamIllustratedRelicPanelItem:AddListeners()
	return
end

function ChallengeRogueTeamIllustratedRelicPanelItem:SetData(arg_3_1, arg_3_2)
	self:Show(true)

	self.index_ = arg_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if self.relicItemList_[iter_3_0] == nil then
			self.relicItemList_[iter_3_0] = ChallengeRogueTeamIllustratedRelicItem.New(self.itemGo_, self.gameObject_)
		end

		self.relicItemList_[iter_3_0]:SetData(iter_3_1)
		self.relicItemList_[iter_3_0]:SetSelectID(self.selectID_)
	end

	for iter_3_2 = #arg_3_1 + 1, #self.relicItemList_ do
		self.relicItemList_[iter_3_2]:Show(false)
	end
end

function ChallengeRogueTeamIllustratedRelicPanelItem:GetItemHeight()
	return 0
end

function ChallengeRogueTeamIllustratedRelicPanelItem:SetSelectID(arg_5_1)
	self.selectID_ = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(self.relicItemList_) do
		iter_5_1:SetSelectID(arg_5_1)
	end
end

function ChallengeRogueTeamIllustratedRelicPanelItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function ChallengeRogueTeamIllustratedRelicPanelItem:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.relicItemList_) do
		iter_7_1:Dispose()
	end

	self.relicItemList_ = nil

	ChallengeRogueTeamIllustratedRelicPanelItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChallengeRogueTeamIllustratedRelicPanelItem
