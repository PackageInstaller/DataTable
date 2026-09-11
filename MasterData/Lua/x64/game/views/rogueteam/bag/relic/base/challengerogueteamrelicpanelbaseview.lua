local ChallengeRogueTeamRelicPanelBaseView = class("ChallengeRogueTeamRelicPanelBaseView", ReduxView)

ChallengeRogueTeamRelicPanelBaseView.OBJECT_TYPE = {
	TITLE = 1,
	NEWITEM = 3,
	ITEM = 2
}

function ChallengeRogueTeamRelicPanelBaseView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.loopScrollView_ = LoopScrollView.New(self, self.scrollRectEx_, self.gridTrs_, self.contentTf_, self.contentTf_.rect.height, self.gridTrs_:GetComponent("VerticalLayoutGroup").spacing)

	self:InitCustomUI()

	self.onSelectRelicHandler_ = handler(self, self.OnSelectRelic)
	self.titleItemPool_ = {}
	self.relicItemPool_ = {}
	self.newRelicItemPool_ = {}
end

function ChallengeRogueTeamRelicPanelBaseView:AddListeners()
	return
end

function ChallengeRogueTeamRelicPanelBaseView:OnEnter()
	self:RefreshUI()
	manager.notify:RegistListener(CHALLENGER_ROGUE_TEAM_BAG_RELIC_SELECTED, self.onSelectRelicHandler_)
end

function ChallengeRogueTeamRelicPanelBaseView:OnExit()
	manager.notify:RemoveListener(CHALLENGER_ROGUE_TEAM_BAG_RELIC_SELECTED, self.onSelectRelicHandler_)

	self.selectRelicID_ = 0
end

function ChallengeRogueTeamRelicPanelBaseView:Dispose()
	self.onSelectRelicHandler_ = nil

	for iter_5_0, iter_5_1 in ipairs(self.titleItemPool_) do
		iter_5_1.itemView:Dispose()
	end

	self.titleItemPool_ = nil

	for iter_5_2, iter_5_3 in ipairs(self.relicItemPool_) do
		iter_5_3.itemView:Dispose()
	end

	self.relicItemPool_ = nil

	for iter_5_4, iter_5_5 in ipairs(self.newRelicItemPool_) do
		iter_5_5.itemView:Dispose()
	end

	self.newRelicItemPool_ = nil

	self.loopScrollView_:Dispose()

	self.loopScrollView_ = nil

	ChallengeRogueTeamRelicPanelBaseView.super.Dispose(self)

	self.itemDataList_ = nil
end

function ChallengeRogueTeamRelicPanelBaseView:AddListeners()
	return
end

function ChallengeRogueTeamRelicPanelBaseView:InitCustomUI()
	return
end

function ChallengeRogueTeamRelicPanelBaseView:OnSelectRelic(arg_8_1)
	self.selectRelicID_ = arg_8_1

	self:ShowItemInfo(self.selectRelicID_)
end

function ChallengeRogueTeamRelicPanelBaseView:GetAllRelicData()
	return
end

function ChallengeRogueTeamRelicPanelBaseView:ShowItemInfo(arg_10_1)
	return
end

function ChallengeRogueTeamRelicPanelBaseView:RefreshUI()
	return
end

function ChallengeRogueTeamRelicPanelBaseView:LsAddItem(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.objectType == ChallengeRogueTeamRelicPanelBaseView.OBJECT_TYPE.TITLE and self:GetFreeTitleItem(self.titleItemPool_, function()
		return ChallengeRogueTeamBagRelicTitleItem.New(self.titleItem_, self.parent_)
	end) or self:GetFreeTitleItem(self.relicItemPool_, function()
		return ChallengeRogueTeamBagRelicPanelItem.New(self.relicItem_, self.parent_)
	end)

	var_12_0.itemView:SetData(arg_12_1.data, arg_12_2)

	if arg_12_1.objectType == ChallengeRogueTeamRelicPanelBaseView.OBJECT_TYPE.ITEM then
		var_12_0.itemView:SetSelectID(self.selectRelicID_)
	end

	return var_12_0
end

function ChallengeRogueTeamRelicPanelBaseView:LsRemoveItem(arg_15_1, arg_15_2)
	arg_15_1.itemView:Show(false)

	arg_15_1.isFree = true
end

function ChallengeRogueTeamRelicPanelBaseView:LsGetItemData()
	return self.uiDataList_
end

function ChallengeRogueTeamRelicPanelBaseView:LsUpdateItem(arg_17_1, arg_17_2, arg_17_3)
	arg_17_1.itemView:SetData(arg_17_2, arg_17_3)
end

function ChallengeRogueTeamRelicPanelBaseView:GetFreeTitleItem(arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if iter_18_1.isFree == true then
			iter_18_1.isFree = false

			return iter_18_1
		end
	end

	local var_18_0 = {
		isFree = false,
		itemView = arg_18_2()
	}

	table.insert(arg_18_1, var_18_0)

	return var_18_0
end

return ChallengeRogueTeamRelicPanelBaseView
