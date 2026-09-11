local ChallengeRogueTeamWorldLineView = class("ChallengeRogueTeamWorldLineView", ReduxView)

function ChallengeRogueTeamWorldLineView:UIName()
	return "Widget/System/Activity_Roulike/RogueTeamStoryUI"
end

function ChallengeRogueTeamWorldLineView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamWorldLineView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.sureBtnGo_, handler(self, self.OnClickBtn))
	self.atmosphereController_ = self.atmosphereCon_:GetController("Ending")
end

function ChallengeRogueTeamWorldLineView:OnEnter()
	local var_4_0 = ChallengeRogueTeamData:PlotGetWorldLineID()

	self.contentText_.text = RogueTeamPlotPopCfg[var_4_0].pop_desc
	self.itemGo_ = Object.Instantiate(Asset.Load(RogueTeamPlotPopCfg[var_4_0].prefab_path), self.storyContentGo_.transform)

	self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)

	local var_4_1 = var_4_0 == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID

	self.atmosphereController_:SetSelectedState(var_4_0 == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID and "red" or "normal")

	if var_4_1 then
		manager.notify:Invoke("CHALLENGE_SPECIAL_ENDING")
	end
end

function ChallengeRogueTeamWorldLineView:OnExit()
	return
end

function ChallengeRogueTeamWorldLineView:Dispose()
	self.rogueTeamSureBtnView_:Dispose()

	self.rogueTeamSureBtnView_ = nil

	Object.Destroy(self.itemGo_)

	self.itemGo_ = nil

	ChallengeRogueTeamWorldLineView.super.Dispose(self)
end

function ChallengeRogueTeamWorldLineView:AddListeners()
	return
end

function ChallengeRogueTeamWorldLineView:OnClickBtn()
	ChallengeRogueTeamData:RemoveServerTriggerQueue()
	self:Back()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
end

function ChallengeRogueTeamWorldLineView:Cacheable()
	return false
end

return ChallengeRogueTeamWorldLineView
