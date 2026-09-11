local ChallengeRogueTeamMapSwitchEffectView = class("ChallengeRogueTeamMapSwitchEffectView", ReduxView)

function ChallengeRogueTeamMapSwitchEffectView:UIName()
	return "Widget/System/Activity_Roulike/item/BackGroundCutScenesUI"
end

function ChallengeRogueTeamMapSwitchEffectView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamMapSwitchEffectView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamMapSwitchEffectView:OnEnter()
	self:AddTimer()
end

function ChallengeRogueTeamMapSwitchEffectView:OnExit()
	self:StopTimer()
end

function ChallengeRogueTeamMapSwitchEffectView:Dispose()
	ChallengeRogueTeamMapSwitchEffectView.super.Dispose(self)
end

function ChallengeRogueTeamMapSwitchEffectView:AddListeners()
	return
end

function ChallengeRogueTeamMapSwitchEffectView:AddTimer()
	self:StopTimer()

	local var_8_0 = false

	self.timer_ = FrameTimer.New(function()
		local var_9_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if var_9_0.normalizedTime >= 0.7 and var_8_0 == false then
			var_8_0 = true

			ChallengeRogueTeamAction.RequestNextMapData(function(arg_10_0)
				if not isSuccess(arg_10_0.result) then
					var_8_0 = false
				end
			end)
		end

		if var_9_0.normalizedTime >= 1 then
			self:StopTimer()
			ChallengeRogueTeamData:RemoveServerTriggerQueue()
			self:Back()
			ChallengeRogueTeamAction.RemovePopWindowCnt()
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
		end
	end, 1, -1)

	self.timer_:Start()
end

function ChallengeRogueTeamMapSwitchEffectView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ChallengeRogueTeamMapSwitchEffectView
