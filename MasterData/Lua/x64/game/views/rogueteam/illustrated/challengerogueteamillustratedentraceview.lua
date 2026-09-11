local ChallengeRogueTeamIllustratedEntraceView = class("ChallengeRogueTeamIllustratedEntraceView", ReduxView)

function ChallengeRogueTeamIllustratedEntraceView:UIName()
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedMainUI"
end

function ChallengeRogueTeamIllustratedEntraceView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamIllustratedEntraceView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamIllustratedEntraceView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	self.templateID_ = self.params_.templateID or ChallengeRogueTeamData:GetActiveTemplateID()

	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.remainsBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))))
	manager.redPoint:bindUIandKey(self.eventBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT))))
	manager.redPoint:bindUIandKey(self.schoolBtn_.transform, (string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_CAMP, self.templateID_)))
	manager.redPoint:bindUIandKey(self.outcomeBtn_.transform, (string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_END, self.templateID_)))
end

function ChallengeRogueTeamIllustratedEntraceView:OnExit()
	manager.redPoint:unbindUIandKey(self.remainsBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))))
	manager.redPoint:unbindUIandKey(self.eventBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT))))
	manager.redPoint:unbindUIandKey(self.schoolBtn_.transform, (string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_CAMP, self.templateID_)))
	manager.redPoint:unbindUIandKey(self.outcomeBtn_.transform, (string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_END, self.templateID_)))
	manager.windowBar:HideBar()
end

function ChallengeRogueTeamIllustratedEntraceView:Dispose()
	ChallengeRogueTeamIllustratedEntraceView.super.Dispose(self)
end

function ChallengeRogueTeamIllustratedEntraceView:AddListeners()
	self:AddBtnListener(self.mechanismBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedMechanism")
	end)
	self:AddBtnListener(self.schoolBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedTreasureEntrace")
	end)
	self:AddBtnListener(self.eventBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedEvent")
	end)
	self:AddBtnListener(self.outcomeBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedEndingEntrace")
	end)
	self:AddBtnListener(self.remainsBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedRelic", {
			templateID = self.templateID_
		})
	end)
end

function ChallengeRogueTeamIllustratedEntraceView:RefreshUI()
	local var_13_0 = {}

	var_13_0[1] = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(RogueTeamCfg[self.templateID_].item_temp)
	var_13_0[3] = ChallengeRogueTeamData:GetAllItemIDByTempAndType(RogueTeamCfg[self.templateID_].item_temp, ChallengeRogueTeamConst.ITEM_TYPE.RELIC)
	var_13_0[2] = RogueTeamEventCfg.get_id_list_by_event_group[1]
	var_13_0[4] = ChallengeRogueTeamData:GetAllItemIDByTempAndType(RogueTeamCfg[self.templateID_].item_temp, ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM)
	var_13_0[5] = RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[1][1]

	for iter_13_0 = 1, 5 do
		self["progressText" .. iter_13_0 .. "_"].text = #ChallengeRogueTeamData:GetIllustratedDataByType(self.templateID_, iter_13_0) .. "/" .. #var_13_0[iter_13_0]
	end
end

function ChallengeRogueTeamIllustratedEntraceView:OnTop()
	self:RefreshUI()
end

return ChallengeRogueTeamIllustratedEntraceView
