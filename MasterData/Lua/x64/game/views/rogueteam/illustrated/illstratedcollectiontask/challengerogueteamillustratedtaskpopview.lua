local ChallengeRogueTeamIllustratedTaskPopView = class("ChallengeRogueTeamIllustratedTaskPopView", ReduxView)

function ChallengeRogueTeamIllustratedTaskPopView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeCollectRewardsPopUI"
end

function ChallengeRogueTeamIllustratedTaskPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamIllustratedTaskPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChallengeRogueTeamIllustratedTaskPopView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, ChallengeRogueTeamIllustratedTaskPopItem)
	self.onClickController_ = self.controller_:GetController("oneclick")
end

function ChallengeRogueTeamIllustratedTaskPopView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.activityIds_[arg_5_1])
end

function ChallengeRogueTeamIllustratedTaskPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.onClickBtn_, nil, function()
		TaskAction:SubmitTaskList((self:GetCanRewardTask()))
	end)
end

function ChallengeRogueTeamIllustratedTaskPopView:OnEnter()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, handler(self, self.RefreshUI))

	self.activityIds_ = self.params_.activityIDList
	self.type_ = self.params_.type
	self.campID_ = self.params_.campID

	self:RefreshUI()
end

function ChallengeRogueTeamIllustratedTaskPopView:RefreshUI()
	table.sort(self.activityIds_, function(arg_11_0, arg_11_1)
		local var_11_0 = TaskData2:GetTaskComplete(arg_11_1)
		local var_11_1 = TaskData2:GetTaskProgress(arg_11_0) >= AssignmentCfg[arg_11_0].need
		local var_11_2 = TaskData2:GetTaskProgress(arg_11_1) >= AssignmentCfg[arg_11_1].need

		if TaskData2:GetTaskComplete(arg_11_0) ~= var_11_0 then
			return var_11_0
		end

		if var_11_1 ~= var_11_2 then
			return var_11_1
		end

		return arg_11_0 < arg_11_1
	end)
	self.uiList_:StartScroll(#self.activityIds_)

	local var_10_0, var_10_1 = self:GetCanRewardTask()

	self.onClickController_:SetSelectedState(tostring(not table.isEmpty(canReward)))

	self.collectCountText.text = string.format(GetTips("ROGUE_TEAM_ILLUSTRADED_TASK_COUNT"), var_10_1)
end

function ChallengeRogueTeamIllustratedTaskPopView:OnExit()
	self:RemoveAllEventListener()
end

function ChallengeRogueTeamIllustratedTaskPopView:GetCanRewardTask()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self.activityIds_) do
		if iter_13_1 then
			if TaskData2:GetTaskProgress(iter_13_1) >= AssignmentCfg[iter_13_1].need and not TaskData2:GetTaskComplete(iter_13_1) then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	return var_13_0, self.type_ == ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP and #ChallengeRogueTeamData:GetUnlockIllustratedTreasureDataByCamp(ChallengeRogueTeamData:GetCacheTemplateID(), self.campID_) or #ChallengeRogueTeamData:GetIllustratedDataByType(ChallengeRogueTeamData:GetCacheTemplateID(), self.type_)
end

function ChallengeRogueTeamIllustratedTaskPopView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	ChallengeRogueTeamIllustratedTaskPopView.super.Dispose(self)
end

return ChallengeRogueTeamIllustratedTaskPopView
