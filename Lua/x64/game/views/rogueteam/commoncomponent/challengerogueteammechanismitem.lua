local var_0_0 = class("ChallengeRogueTeamMechanismItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddUIListener()

	arg_1_0.progressBar_ = arg_1_0.progressGo_:GetComponent("SplineProgressBar")
	arg_1_0.animator_.enabled = false
	arg_1_0.atmosphereController_ = arg_1_0.atmosphereCon_:GetController("atmosphere")
	arg_1_0.refreshAtmosphereHandler_ = handler(arg_1_0, arg_1_0.RefreshAtmosphere)

	manager.notify:RegistListener(CHALLENGE_SPECIAL_ENDING, arg_1_0.refreshAtmosphereHandler_)
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamBag")
	end)
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ChallengeRogueTeamData:UIGetMechanismValue()
	local var_4_1 = ChallengeRogueTeamTools.GetMaxMechanismValue()

	arg_4_0:SetValue(var_4_0, var_4_1)
	SetActive(arg_4_0.effectGo_, false)
	arg_4_0:RefreshAtmosphere()
end

function var_0_0.SetValue(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = 0

	if arg_5_2 > 0 then
		var_5_0 = math.floor(arg_5_1 / arg_5_2 * 100)
	end

	if var_5_0 >= 100 then
		var_5_0 = 100
	end

	local var_5_1 = var_5_0 / 100

	arg_5_0.progressBar_:SetValue(var_5_1)

	arg_5_0.numText_.text = var_5_1 * 100

	arg_5_0:PlayEffectAnimator(var_5_1)
end

function var_0_0.PlayEffectAnimator(arg_6_0, arg_6_1)
	local var_6_0 = GameSetting.rogue_team_mechanism_offset_value.value[1]

	arg_6_1 = (var_6_0 + (100 - var_6_0) * arg_6_1) / 100

	arg_6_0.animator_:Play("Schedule", 0, arg_6_1)
	arg_6_0.animator_:Update(arg_6_1)
end

function var_0_0.PlayAnimator(arg_7_0, arg_7_1)
	local var_7_0 = ChallengeRogueTeamData:UIGetMechanismValue()
	local var_7_1 = ChallengeRogueTeamTools.GetMaxMechanismValue()
	local var_7_2 = arg_7_1.value.attributeValue

	arg_7_0:RemoveTween()
	manager.ui:UIEventEnabled(false)

	if var_7_2 == var_7_0 then
		arg_7_0:PlayAnimatorOver()
	elseif var_7_2 < var_7_1 then
		SetActive(arg_7_0.effectGo_, true)

		if var_7_1 <= var_7_0 then
			var_7_0 = 0
		end

		arg_7_0.tween_ = LeanTween.value(arg_7_0.gameObject_, var_7_0, var_7_2, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
			arg_7_0:SetValue(arg_8_0, var_7_1)
		end)):setOnComplete(System.Action(function()
			arg_7_0:RemoveTween()
			ChallengeRogueTeamData:UISetMechanismValue(var_7_2)
			ChallengeRogueTeamData:AttributeMechanismSetValue(var_7_2)
			arg_7_0:PlayAnimatorOver()
		end))
	else
		SetActive(arg_7_0.effectGo_, true)

		arg_7_0.tween_ = LeanTween.value(arg_7_0.gameObject_, var_7_0, var_7_1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
			arg_7_0:SetValue(arg_10_0, var_7_1)
		end)):setOnComplete(System.Action(function()
			arg_7_0:RemoveTween()
			ChallengeRogueTeamData:UISetMechanismValue(var_7_1)
			ChallengeRogueTeamData:AttributeMechanismSetValue(var_7_2 - var_7_1)
			arg_7_0:SetValue(var_7_1, var_7_1)
			arg_7_0:PlayAnimatorOver()
		end))
	end
end

function var_0_0.PlayAnimatorOver(arg_12_0)
	ChallengeRogueTeamData:RemoveServerTriggerQueue()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	manager.ui:UIEventEnabled(true)
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
end

function var_0_0.RemoveTween(arg_13_0)
	SetActive(arg_13_0.effectGo_, false)

	if arg_13_0.tween_ then
		arg_13_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_13_0.tween_.id)

		arg_13_0.tween_ = nil
	end
end

function var_0_0.RefreshAtmosphere(arg_14_0)
	local var_14_0 = ChallengeRogueTeamData:GetPlotID()

	arg_14_0.atmosphereController_:SetSelectedState(var_14_0 == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID and "red" or "normal")
end

function var_0_0.Dispose(arg_15_0)
	manager.notify:RemoveListener(CHALLENGE_SPECIAL_ENDING, arg_15_0.refreshAtmosphereHandler_)
	var_0_0.super.Dispose(arg_15_0)

	if arg_15_0.createFlag_ then
		arg_15_0:RemoveTween()

		arg_15_0.progressBar_ = nil
	end
end

return var_0_0
