local var_0_0 = class("SPHeroChallengeTrainView", import(".SPHeroChallengeBattleStageBaseView"))

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTrainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.lockController = arg_5_0.controller:GetController("open")
	arg_5_0.challengeTimeController_ = arg_5_0.controller:GetController("times")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RefreshBar()

	if not arg_6_0.params_.showFlag then
		arg_6_0.lockController:SetSelectedState("no")

		if arg_6_0.params_.reason then
			arg_6_0.lockdescText_.text = GetTips(arg_6_0.params_.reason)
		end
	else
		arg_6_0.lockController:SetSelectedState("open")
	end

	arg_6_0:RefreshPlayTime()
	arg_6_0:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_CHALLENGE, function()
		arg_6_0:RefreshPlayTime()
	end)
end

function var_0_0.RefreshPlayTime(arg_8_0)
	arg_8_0.totalNum, arg_8_0.curNum = SPHeroChallengeData:GetCurActivityInfo():GetChallengeTimes()

	local var_8_0 = arg_8_0.totalNum - arg_8_0.curNum
	local var_8_1

	if var_8_0 <= 0 then
		var_8_1 = string.format("<color='#FF000B'>%d</color>", tostring(var_8_0))
	else
		var_8_1 = tostring(var_8_0)
	end

	arg_8_0.challengeTime.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REMAIN_TIME"), var_8_1, tonumber(1))
end

function var_0_0.RefreshBar(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_11_0)
	for iter_11_0 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		arg_11_0:AddBtnListener(arg_11_0["trainitem" .. iter_11_0 .. "Btn_"], nil, function()
			JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
				playAnimation = true,
				trainType = iter_11_0
			})
		end)
	end

	arg_11_0:AddBtnListener(arg_11_0.timeInfoBtn, nil, function()
		if arg_11_0.challengeTimeController_:GetSelectedState() == "show" then
			arg_11_0.challengeTimeController_:SetSelectedState("showTip")

			arg_11_0.infoTipText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")
		else
			arg_11_0.challengeTimeController_:SetSelectedState("show")
		end
	end)
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
