local ChallengeRogueTeamEnterPopView = class("ChallengeRogueTeamEnterPopView", ReduxView)

function ChallengeRogueTeamEnterPopView:UIName()
	return "Widget/System/Activity_Roulike/RogueRewardPopUI"
end

function ChallengeRogueTeamEnterPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamEnterPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function ChallengeRogueTeamEnterPopView:InitUI()
	self:BindCfgUI()

	self.rewardItemList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CommonItemView)
end

function ChallengeRogueTeamEnterPopView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.rewardList_[arg_5_1].id
	var_5_0.number = self.rewardList_[arg_5_1].num

	arg_5_2:SetData(var_5_0)
end

function ChallengeRogueTeamEnterPopView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function ChallengeRogueTeamEnterPopView:OnEnter()
	self.activityId_ = self.params_.activityId
	self.templateId_ = ChallengeRogueTeamData:GetCacheTemplateID()
	self.level_ = ChallengeRogueTeamTools.GetCurrentSurveyLevel(self.templateId_)

	local var_8_0 = ChallengeRogueTeamData:GetScoreIDListByActivityID(self.activityId_)
	local var_8_1 = ChallengeRogueTeamData:GetRewardedScoreList(self.templateId_)

	self.rewardList_ = {}

	for iter_8_0 = 1, #var_8_0 do
		if iter_8_0 <= self.level_ then
			if not table.indexof(var_8_1, var_8_0[iter_8_0]) then
				local var_8_2 = {
					id = ActivityPointRewardCfg[var_8_0[iter_8_0]].reward_item_list[1][1]
				}

				var_8_2.num = ActivityPointRewardCfg[var_8_0[iter_8_0]].reward_item_list[1][2]

				table.insert(self.rewardList_, var_8_2)
			end
		end
	end

	self.rewardList_ = mergeReward(self.rewardList_)
	self.rewardList_ = sortReward(self.rewardList_)

	self.rewardItemList_:StartScroll(#self.rewardList_)
end

function ChallengeRogueTeamEnterPopView:OnExit()
	ChallengeRogueTeamEnterPopView.super.OnExit(self)
end

function ChallengeRogueTeamEnterPopView:Dispose()
	if self.rewardItemList_ then
		self.rewardItemList_:Dispose()

		self.rewardItemList_ = nil
	end

	self.super.Dispose(self)
end

return ChallengeRogueTeamEnterPopView
