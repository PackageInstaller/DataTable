local ChallengeRogueTeamRewardView = class("ChallengeRogueTeamRewardView", ReduxView)

function ChallengeRogueTeamRewardView:UIName()
	return "Widget/System/Activity_Roulike/RoulikestatuspopUI"
end

function ChallengeRogueTeamRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamRewardView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
	self.stateController_ = self.controllerEx_:GetController("status")
end

function ChallengeRogueTeamRewardView:OnEnter()
	local var_4_0 = self.params_.triggerValue
	local var_4_1 = self.params_.triggerValue.itemList

	for iter_4_0, iter_4_1 in ipairs(self.params_.triggerValue.itemList) do
		if self.itemList_[iter_4_0] == nil then
			self.itemList_[iter_4_0] = ChallengeRogueTeamTreasureItem.New(self.itemParent_, iter_4_0)
		end

		iter_4_1.descRaycastFlag = true
		iter_4_1.needShowCampFlag = true

		self.itemList_[iter_4_0]:SetData(iter_4_1)
	end

	for iter_4_2 = #self.itemList_, #var_4_1 + 1, -1 do
		self.itemList_[iter_4_2]:Dispose()

		self.itemList_[iter_4_2] = nil
	end

	local var_4_2 = var_4_1[1].operate

	if var_4_1[1].operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		self.stateController_:SetSelectedState("discard")
	else
		self.stateController_:SetSelectedState("obtained")
	end

	self.titleText_.text = ChallengeRogueTeamTools.GetItemPopText(var_4_0.sourceType, var_4_0.sourceItemID, var_4_2, RogueTeamItemCfg[var_4_1[1].id].type)
end

function ChallengeRogueTeamRewardView:OnExit()
	for iter_5_0, iter_5_1 in ipairs(self.itemList_) do
		iter_5_1:OnExit()
	end
end

function ChallengeRogueTeamRewardView:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.itemList_ = nil

	ChallengeRogueTeamRewardView.super.Dispose(self)
end

function ChallengeRogueTeamRewardView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		ChallengeRogueTeamData:ClearObtainData()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		self:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end)
end

return ChallengeRogueTeamRewardView
