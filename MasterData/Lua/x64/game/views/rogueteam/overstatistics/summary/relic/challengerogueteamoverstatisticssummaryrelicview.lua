local ChallengeRogueTeamOverStatisticsSummaryRelicView = class("ChallengeRogueTeamOverStatisticsSummaryRelicView", ReduxView)

function ChallengeRogueTeamOverStatisticsSummaryRelicView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.emptyController_ = self.controllerEx_:GetController("empty")
	self.relicItemList_ = {}
	self.relicDataList_ = ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC)

	self:RefreshUI()
end

function ChallengeRogueTeamOverStatisticsSummaryRelicView:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.relicItemList_) do
		iter_2_1:Dispose()
	end

	self.relicItemList_ = nil

	ChallengeRogueTeamOverStatisticsSummaryRelicView.super.Dispose(self)
end

function ChallengeRogueTeamOverStatisticsSummaryRelicView:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsSummaryRelicView:RefreshUI()
	for iter_4_0, iter_4_1 in ipairs(self.relicDataList_) do
		if self.relicItemList_[iter_4_0] == nil then
			self.relicItemList_[iter_4_0] = ChallengeRogueTeamOverStatisticsSummaryRelicItem.New(self.item_, self.parent_)
		end

		self.relicItemList_[iter_4_0]:SetData(iter_4_1)
	end

	for iter_4_2 = #self.relicDataList_ + 1, #self.relicItemList_ do
		self.relicItemList_[iter_4_2]:Show(false)
	end

	if #self.relicDataList_ <= 0 then
		self.emptyController_:SetSelectedState("off")
	else
		self.emptyController_:SetSelectedState("on")
	end
end

function ChallengeRogueTeamOverStatisticsSummaryRelicView:GetHeight()
	return self.rectTransform_.rect.height
end

function ChallengeRogueTeamOverStatisticsSummaryRelicView:Show(arg_6_1)
	self.animator_.enabled = arg_6_1

	if arg_6_1 == false then
		self.canvasGroup_.alpha = 0
	end
end

return ChallengeRogueTeamOverStatisticsSummaryRelicView
