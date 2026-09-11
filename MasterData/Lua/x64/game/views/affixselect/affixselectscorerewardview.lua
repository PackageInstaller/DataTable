local AffixSelectScoreRewardView = class("AffixSelectScoreRewardView", ReduxView)

function AffixSelectScoreRewardView:UIName()
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillRewardUI"
end

function AffixSelectScoreRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function AffixSelectScoreRewardView:OnCtor()
	return
end

function AffixSelectScoreRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectScoreRewardView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, AffixSelectRewardItemView)
	self.btnController_ = self.btnCon_:GetController("state")
end

function AffixSelectScoreRewardView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.rewardIdList_[arg_6_1], self.activityId, false)
end

function AffixSelectScoreRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnReceiveAll_, nil, function()
		ActivityAction.ReceivePointReward(self.canReceiveRewards)
	end)
end

function AffixSelectScoreRewardView:OnReceivePointReward(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if table.indexof(self.rewardIdList_, iter_10_1) then
			self:UpdateList()

			break
		end
	end
end

function AffixSelectScoreRewardView:AddEventListeners()
	return
end

function AffixSelectScoreRewardView:OnTop()
	self:UpdateBar()
end

function AffixSelectScoreRewardView:OnBehind()
	manager.windowBar:HideBar()
end

function AffixSelectScoreRewardView:UpdateBar()
	manager.windowBar:HideBar()
end

function AffixSelectScoreRewardView:OnEnter()
	self.activityId = self.params_.affixActivityId

	self:AddEventListeners()
	self:UpdateList()
end

function AffixSelectScoreRewardView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AffixSelectScoreRewardView:UpdateList()
	self.scoreLabel_.text = ActivityAffixSelectData:GetTotalScore(self.activityId)
	self.rewardIdList_ = deepClone(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityId])
	self.haveGetLabel_.text = ActivityAffixSelectData:ScoreRewardGetCount(self.activityId) .. "/" .. #self.rewardIdList_

	table.sort(self.rewardIdList_, function(arg_18_0, arg_18_1)
		local var_18_0 = ActivityAffixSelectData:GetRewardStatus(self.activityId, arg_18_0)
		local var_18_1 = ActivityAffixSelectData:GetRewardStatus(self.activityId, arg_18_1)

		if var_18_0 ~= var_18_1 then
			return var_18_1 < var_18_0
		end

		return arg_18_0 < arg_18_1
	end)

	local var_17_0

	self.canReceiveRewards = {}

	for iter_17_0, iter_17_1 in ipairs(self.rewardIdList_) do
		local var_17_1 = ActivityAffixSelectData:GetRewardStatus(self.activityId, iter_17_1)

		if var_17_0 == nil and var_17_1 ~= 3 then
			var_17_0 = iter_17_0
		end

		if var_17_1 == 2 then
			table.insert(self.canReceiveRewards, iter_17_1)
		elseif var_17_1 == 1 then
			break
		end
	end

	var_17_0 = var_17_0 or 1

	self.uiList_:StartScroll(#self.rewardIdList_, var_17_0)
	self.btnController_:SetSelectedState(#self.canReceiveRewards <= 0 and "hide" or "show")
end

function AffixSelectScoreRewardView:OnMainHomeViewTop()
	return
end

function AffixSelectScoreRewardView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	AffixSelectScoreRewardView.super.Dispose(self)
end

return AffixSelectScoreRewardView
