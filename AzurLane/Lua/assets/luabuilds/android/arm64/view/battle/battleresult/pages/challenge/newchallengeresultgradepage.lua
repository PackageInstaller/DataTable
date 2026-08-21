local var_0_0 = class("NewChallengeResultGradePage", import("..NewBattleResultGradePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.challenge = getProxy(ChallengeProxy):getUserChallengeInfo(arg_1_0.contextData.mode)
	arg_1_0.challengeExpire = getProxy(ChallengeProxy):userSeaonExpire(arg_1_0.contextData.mode)

	return
end

function var_0_0.isTotalClear(arg_2_0)
	return arg_2_0.challenge:getMode() == ChallengeProxy.MODE_CASUAL and arg_2_0.challenge:IsFinish() or arg_2_0:isFail()
end

function var_0_0.isFail(arg_3_0)
	return arg_3_0.contextData.score < ys.Battle.BattleConst.BattleScore.S
end

function var_0_0.GetGetObjectives(arg_4_0)
	local var_4_0 = getProxy(ChallengeProxy):getUserChallengeInfo(arg_4_0.contextData.mode)

	if var_4_0:getMode() == ChallengeProxy.MODE_INFINITE then
		return {}
	else
		local var_4_1 = {}
		local var_4_2, var_4_3 = NewBattleResultUtil.ColorObjective(true)

		table.insert(var_4_1, {
			text = setColorStr(i18n("challenge_combat_score", var_4_0:getLastScore()), var_4_3),
			icon = var_4_2
		})
		table.insert(var_4_1, {
			text = setColorStr(i18n("challenge_current_score", var_4_0:getScore()), var_4_3),
			icon = var_4_2
		})

		return var_4_1
	end

	return
end

function var_0_0.UpdateChapterName(arg_5_0)
	if getProxy(ChallengeProxy):getUserChallengeInfo(arg_5_0.contextData.mode) == ChallengeProxy.MODE_INFINITE then
		setText(arg_5_0.gradeChapterName, pg.expedition_data_template[arg_5_0.contextData.stageId].name .. " - ROUND " .. getProxy(ChallengeProxy):getUserChallengeInfo(arg_5_0.contextData.mode):getLevel())
	else
		var_0_0.super.UpdateChapterName(arg_5_0)
	end

	return
end

function var_0_0.LoadChallengeRes(arg_6_0, arg_6_1)
	setActive(arg_6_0.bgTr:Find("ResultEffect/Tips"), false)
	LoadAnyAsync("BattleResultItems/Challenge", "", nil, function(arg_7_0)
		if arg_6_0.exited or IsNil(arg_7_0) then
			if arg_6_1 then
				arg_6_1()
			end

			return
		end

		arg_6_0:UpdateChallengeInfo(Object.Instantiate(arg_7_0, arg_6_0._tf).transform)

		if arg_6_1 then
			arg_6_1()
		end

		return
	end)

	return
end

function var_0_0.UpdateChallengeInfo(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.challengeExpire and i18n("challenge_expire_warn") or ""

	setText(arg_8_1:Find("expire"), var_8_0)
	setText(findTF(arg_8_1, "continue_btn/text"), i18n("battle_result_continue_battle"))
	setText(findTF(arg_8_1, "quit_btn/text"), i18n("battle_result_quit_battle"))
	setText(findTF(arg_8_1, "share_btn/text"), i18n("battle_result_share_battle"))

	arg_8_0.continueBtn = findTF(arg_8_1, "continue_btn")
	arg_8_0.quitBtn = findTF(arg_8_1, "quit_btn")
	arg_8_0.shareBtn = findTF(arg_8_1, "share_btn")

	local var_8_1 = arg_8_0:isTotalClear()

	SetActive(arg_8_0.continueBtn, not var_8_1)
	SetActive(arg_8_0.quitBtn, not var_8_1)
	SetActive(arg_8_0.shareBtn, var_8_1)

	return
end

function var_0_0.RegisterEvent(arg_9_0, arg_9_1)
	seriesAsync({
		function(arg_10_0)
			var_0_0.super.RegisterEvent(arg_9_0, arg_10_0)

			return
		end,
		function(arg_11_0)
			removeOnButton(arg_9_0._tf)
			arg_9_0:LoadChallengeRes(arg_11_0)

			return
		end,
		function(arg_12_0)
			arg_9_0:RegisterChallengeEvent(arg_9_1)

			return
		end
	})

	return
end

function var_0_0.RegisterChallengeEvent(arg_13_0, arg_13_1)
	if arg_13_0:isTotalClear() then
		onButton(arg_13_0, arg_13_0.shareBtn, function()
			arg_13_0:emit(NewBattleResultMediator.CHALLENGE_SHARE)

			return
		end, SFX_CONFIRM)
		onButton(arg_13_0, arg_13_0._tf, arg_13_1, SFX_CONFIRM)
	else
		onButton(arg_13_0, arg_13_0.continueBtn, function()
			arg_13_0:OnContinue(arg_13_1)

			return
		end, SFX_CONFIRM)
		onButton(arg_13_0, arg_13_0.quitBtn, function()
			arg_13_0:OnQuit(arg_13_1)

			return
		end, SFX_CONFIRM)
	end

	return
end

function var_0_0.OnContinue(arg_17_0, arg_17_1)
	if arg_17_0:isFail() then
		arg_17_1()
	else
		arg_17_0.contextData.goToNext = true

		arg_17_0:emit(NewBattleResultMediator.CHALLENGE_DEFEAT_SCENE, {
			callback = arg_17_1
		})
	end

	return
end

function var_0_0.OnQuit(arg_18_0, arg_18_1)
	if arg_18_0:isFail() then
		arg_18_1()
	else
		arg_18_0:emit(NewBattleResultMediator.CHALLENGE_DEFEAT_SCENE, {
			callback = arg_18_1
		})
	end

	return
end

return var_0_0
