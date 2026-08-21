local var_0_0 = class("ChallengeRogueTeamPathHero", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.hasHeroController_ = arg_1_0.hasHeroCon_:GetController("hasHero")
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:Init()
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.heroID_ = arg_3_2 or 0
	arg_3_0.trialID_ = arg_3_3 or 0
	arg_3_0.index_ = arg_3_1

	arg_3_0:Refresh()
end

function var_0_0.Refresh(arg_4_0)
	if arg_4_0.heroID_ ~= 0 then
		local var_4_0 = ChallengeRogueTeamData:GetHeroData(arg_4_0.heroID_, nil, true)
		local var_4_1 = var_4_0.id

		if var_4_0.using_skin ~= 0 then
			var_4_1 = var_4_0.using_skin
		end

		arg_4_0.icon_.spriteSync = "TextureConfig/Character/Itemshead/" .. var_4_1
	end

	arg_4_0.hasHeroController_:SetSelectedState(tostring(arg_4_0.heroID_ ~= 0))
	arg_4_0:RefreshHP()
end

function var_0_0.PlayEffect(arg_5_0, arg_5_1)
	if arg_5_0.trialID_ ~= 0 then
		local var_5_0 = ChallengeRogueTeamData:UIGetTeamHPData(arg_5_0.heroID_, arg_5_0.trialID_)
		local var_5_1 = ChallengeRogueTeamData:GetUnlockTrailHeroList()[arg_5_0.trialID_].hpPercent

		arg_5_0:PlayHPAnimator(var_5_0, var_5_1)
	elseif arg_5_0.heroID_ ~= 0 then
		local var_5_2 = ChallengeRogueTeamData:UIGetTeamHPData(arg_5_0.heroID_, arg_5_0.trialID_)
		local var_5_3 = ChallengeRogueTeamData:GetHeroList()[arg_5_0.heroID_].hpPercent

		arg_5_0:PlayHPAnimator(var_5_2, var_5_3)
	end
end

function var_0_0.RefreshHP(arg_6_0)
	if arg_6_0.trialID_ ~= 0 then
		local var_6_0 = ChallengeRogueTeamData:UIGetTeamHPData(arg_6_0.heroID_, arg_6_0.trialID_)

		arg_6_0.hpSlider_.value = var_6_0 / 10000
	elseif arg_6_0.heroID_ ~= 0 then
		local var_6_1 = ChallengeRogueTeamData:UIGetTeamHPData(arg_6_0.heroID_, arg_6_0.trialID_)

		arg_6_0.hpSlider_.value = var_6_1 / 10000
	else
		arg_6_0.hpSlider_.value = 0
	end
end

function var_0_0.PlayHPAnimator(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.tween_ = LeanTween.value(arg_7_0.gameObject_, arg_7_1, arg_7_2, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
		arg_7_0.hpSlider_.value = arg_8_0 / 10000
	end)):setOnComplete(System.Action(function()
		arg_7_0:RemoveTween()
		ChallengeRogueTeamData:UISetTeamHPData(arg_7_0.heroID_, arg_7_0.trialID_, arg_7_2)

		arg_7_0.hpSlider_.value = arg_7_2 / 10000
	end))
end

function var_0_0.RemoveTween(arg_10_0)
	if arg_10_0.tween_ then
		arg_10_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_10_0.tween_.id)

		arg_10_0.tween_ = nil
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	arg_11_0:RemoveTween()

	arg_11_0.gameObject_ = nil
end

return var_0_0
