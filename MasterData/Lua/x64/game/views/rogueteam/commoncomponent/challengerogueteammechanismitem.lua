local ChallengeRogueTeamMechanismItem = class("ChallengeRogueTeamMechanismItem", ReduxView)

function ChallengeRogueTeamMechanismItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddUIListener()

	self.progressBar_ = self.progressGo_:GetComponent("SplineProgressBar")
	self.animator_.enabled = false
	self.atmosphereController_ = self.atmosphereCon_:GetController("atmosphere")
	self.refreshAtmosphereHandler_ = handler(self, self.RefreshAtmosphere)

	manager.notify:RegistListener(CHALLENGE_SPECIAL_ENDING, self.refreshAtmosphereHandler_)
end

function ChallengeRogueTeamMechanismItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamBag")
	end)
end

function ChallengeRogueTeamMechanismItem:RefreshUI()
	self:SetValue(ChallengeRogueTeamData:UIGetMechanismValue(), (ChallengeRogueTeamTools.GetMaxMechanismValue()))
	SetActive(self.effectGo_, false)
	self:RefreshAtmosphere()
end

function ChallengeRogueTeamMechanismItem:SetValue(arg_5_1, arg_5_2)
	local var_5_0 = 0

	if arg_5_2 > 0 then
		var_5_0 = math.floor(arg_5_1 / arg_5_2 * 100)
	end

	if var_5_0 >= 100 then
		var_5_0 = 100
	end

	local var_5_1 = var_5_0 / 100

	self.progressBar_:SetValue(var_5_0 / 100)

	self.numText_.text = var_5_1 * 100

	self:PlayEffectAnimator(var_5_1)
end

function ChallengeRogueTeamMechanismItem:PlayEffectAnimator(arg_6_1)
	arg_6_1 = (GameSetting.rogue_team_mechanism_offset_value.value[1] + (100 - GameSetting.rogue_team_mechanism_offset_value.value[1]) * arg_6_1) / 100

	self.animator_:Play("Schedule", 0, arg_6_1)
	self.animator_:Update(arg_6_1)
end

function ChallengeRogueTeamMechanismItem:PlayAnimator(arg_7_1)
	local var_7_0 = ChallengeRogueTeamData:UIGetMechanismValue()
	local var_7_1 = ChallengeRogueTeamTools.GetMaxMechanismValue()
	local var_7_2 = arg_7_1.value.attributeValue

	self:RemoveTween()
	manager.ui:UIEventEnabled(false)

	if arg_7_1.value.attributeValue == var_7_0 then
		self:PlayAnimatorOver()
	elseif arg_7_1.value.attributeValue < var_7_1 then
		SetActive(self.effectGo_, true)

		if var_7_1 <= var_7_0 then
			var_7_0 = 0
		end

		self.tween_ = LeanTween.value(self.gameObject_, var_7_0, arg_7_1.value.attributeValue, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
			self:SetValue(arg_8_0, var_7_1)
		end)):setOnComplete(System.Action(function()
			self:RemoveTween()
			ChallengeRogueTeamData:UISetMechanismValue(var_7_2)
			ChallengeRogueTeamData:AttributeMechanismSetValue(var_7_2)
			self:PlayAnimatorOver()
		end))
	else
		SetActive(self.effectGo_, true)

		self.tween_ = LeanTween.value(self.gameObject_, var_7_0, var_7_1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
			self:SetValue(arg_10_0, var_7_1)
		end)):setOnComplete(System.Action(function()
			self:RemoveTween()
			ChallengeRogueTeamData:UISetMechanismValue(var_7_1)
			ChallengeRogueTeamData:AttributeMechanismSetValue(var_7_2 - var_7_1)
			self:SetValue(var_7_1, var_7_1)
			self:PlayAnimatorOver()
		end))
	end
end

function ChallengeRogueTeamMechanismItem:PlayAnimatorOver()
	ChallengeRogueTeamData:RemoveServerTriggerQueue()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	manager.ui:UIEventEnabled(true)
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
end

function ChallengeRogueTeamMechanismItem:RemoveTween()
	SetActive(self.effectGo_, false)

	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function ChallengeRogueTeamMechanismItem:RefreshAtmosphere()
	self.atmosphereController_:SetSelectedState(ChallengeRogueTeamData:GetPlotID() == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID and "red" or "normal")
end

function ChallengeRogueTeamMechanismItem:Dispose()
	manager.notify:RemoveListener(CHALLENGE_SPECIAL_ENDING, self.refreshAtmosphereHandler_)
	ChallengeRogueTeamMechanismItem.super.Dispose(self)

	if self.createFlag_ then
		self:RemoveTween()

		self.progressBar_ = nil
	end
end

return ChallengeRogueTeamMechanismItem
