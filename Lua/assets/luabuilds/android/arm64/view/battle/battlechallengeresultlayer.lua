local var_0_0 = class("BattleChallengeResultLayer", import(".BattleResultLayer"))

var_0_0.DURATION_WIN_FADE_IN = 0.5
var_0_0.DURATION_LOSE_FADE_IN = 1.5
var_0_0.DURATION_GRADE_LAST = 1.5
var_0_0.DURATION_MOVE = 0.7
var_0_0.DURATION_WIN_SCALE = 0.7
var_0_0.STATE_DEFEAT = "state_defeat"
var_0_0.STATE_CLEAR = "state_clear"
var_0_0.STATE_CONTINUE = "state_continue"
var_0_0.STATE_QUIT = "state_quit"

function var_0_0.getUIName(arg_1_0)
	return "BattleResultUI"
end

function var_0_0.setChallengeInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.challenge = arg_2_1
	arg_2_0.challengeExpire = arg_2_2

	return
end

function var_0_0.setShips(arg_3_0, arg_3_1)
	arg_3_0.shipVOs = arg_3_1

	return
end

function var_0_0.isTotalClear(arg_4_0)
	return arg_4_0.challenge:getMode() == ChallengeProxy.MODE_CASUAL and arg_4_0.challenge:IsFinish() or arg_4_0:isFail()
end

function var_0_0.isFail(arg_5_0)
	return arg_5_0.contextData.score < ys.Battle.BattleConst.BattleScore.S
end

function var_0_0.init(arg_6_0)
	var_0_0.super.init(arg_6_0)

	arg_6_0._challengeBottomPanel = arg_6_0._blurConatiner:Find("challenge_confirm")

	setText(findTF(arg_6_0._challengeBottomPanel, "continue_btn/text"), i18n("battle_result_continue_battle"))
	setText(findTF(arg_6_0._challengeBottomPanel, "quit_btn/text"), i18n("battle_result_quit_battle"))
	setText(findTF(arg_6_0._challengeBottomPanel, "share_btn/text"), i18n("battle_result_share_battle"))

	arg_6_0._shareBtn = arg_6_0._challengeBottomPanel:Find("share_btn")
	arg_6_0._continueBtn = arg_6_0._challengeBottomPanel:Find("continue_btn")
	arg_6_0._quitBtn = arg_6_0._challengeBottomPanel:Find("quit_btn")
	arg_6_0._expire = arg_6_0._main:Find("challenge_expire")
	arg_6_0._expireTxt = arg_6_0._expire:Find("text")

	return
end

function var_0_0.didEnter(arg_7_0)
	var_0_0.super.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0._skipBtn, function()
		arg_7_0:skip()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.setStageName(arg_9_0)
	if arg_9_0.contextData.system and arg_9_0.contextData.system == SYSTEM_DUEL then
		setText(arg_9_0._levelText, arg_9_0.rivalVO.name)
	else
		-- block empty
	end

	if arg_9_0.challenge:getMode() == ChallengeProxy.MODE_INFINITE then
		setText(arg_9_0._levelText, pg.expedition_data_template[arg_9_0.contextData.stageId].name .. " - ROUND " .. arg_9_0.challenge:getLevel())
	else
		var_0_0.super.setStageName(arg_9_0)
	end

	return
end

function var_0_0.rankAnimaFinish(arg_10_0)
	local var_10_0 = arg_10_0._tf:Find("main/conditions")

	if arg_10_0.challenge:getMode() == ChallengeProxy.MODE_INFINITE then
		SetActive(var_10_0, false)

		arg_10_0._stateFlag = var_0_0.STATE_REPORTED
	else
		SetActive(var_10_0, true)
		arg_10_0:setCondition(i18n("challenge_combat_score", arg_10_0.challenge:getLastScore()), true)
		arg_10_0:setCondition(i18n("challenge_current_score", arg_10_0.challenge:getScore()), true)
		table.insert(arg_10_0._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
			arg_10_0._stateFlag = var_0_0.STATE_REPORTED

			SetActive(arg_10_0._bg:Find("jieuan01/tips"), true)

			return
		end)).id)

		arg_10_0._stateFlag = var_0_0.STATE_REPORT
	end

	return
end

function var_0_0.displayDefeat(arg_12_0)
	if arg_12_0:isFail() then
		arg_12_0._stateFlag = var_0_0.STATE_QUIT

		;(function()
			arg_12_0:skip()

			return
		end)()
	else
		arg_12_0:emit(BattleResultMediator.ON_CHALLENGE_DEFEAT_SCENE, {
			callback = function()
				arg_12_0:skip()

				return
			end
		})
	end

	return
end

function var_0_0.showRightBottomPanel(arg_14_0)
	SetActive(arg_14_0._expire, arg_14_0.challengeExpire)
	setText(arg_14_0._expireTxt, i18n("challenge_expire_warn"))
	SetActive(arg_14_0._skipBtn, false)

	if not arg_14_0:isTotalClear() then
		SetActive(arg_14_0._bg:Find("jieuan01/tips"), false)
	end

	SetActive(arg_14_0._challengeBottomPanel, true)

	if arg_14_0:isTotalClear() then
		SetActive(arg_14_0._continueBtn, false)
		SetActive(arg_14_0._quitBtn, false)
		SetActive(arg_14_0._shareBtn, true)
		onButton(arg_14_0, arg_14_0._shareBtn, function()
			arg_14_0:emit(BattleResultMediator.ON_CHALLENGE_SHARE)

			return
		end, SFX_CONFIRM)
		onButton(arg_14_0, arg_14_0._bg, function()
			arg_14_0:skip()

			arg_14_0._stateFlag = var_0_0.STATE_CLEAR

			return
		end)
	else
		SetActive(arg_14_0._continueBtn, true)
		SetActive(arg_14_0._quitBtn, true)
		SetActive(arg_14_0._shareBtn, false)
		onButton(arg_14_0, arg_14_0._continueBtn, function()
			arg_14_0:skip()

			arg_14_0._stateFlag = var_0_0.STATE_CONTINUE

			return
		end, SFX_CONFIRM)
		onButton(arg_14_0, arg_14_0._quitBtn, function()
			arg_14_0:skip()

			arg_14_0._stateFlag = var_0_0.STATE_QUIT

			return
		end, SFX_CONFIRM)
	end

	arg_14_0._stateFlag = var_0_0.STATE_DEFEAT

	return
end

function var_0_0.onBackPressed(arg_19_0)
	arg_19_0:skip()

	return
end

function var_0_0.skip(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._delayLeanList) do
		LeanTween.cancel(iter_20_1)
	end

	if arg_20_0._stateFlag == var_0_0.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_20_0._stateFlag == var_0_0.STATE_REPORT then
		while arg_20_0._conditionContainer.childCount > 0 do
			SetActive(arg_20_0._conditionContainer:GetChild(arg_20_0._conditionContainer.childCount - 1), true)
		end

		SetActive(arg_20_0._bg:Find("jieuan01/tips"), true)

		arg_20_0._stateFlag = var_0_0.STATE_REPORTED
	elseif arg_20_0._stateFlag == var_0_0.STATE_REPORTED then
		arg_20_0:showRightBottomPanel()
	elseif arg_20_0._stateFlag == var_0_0.STATE_DEFEAT then
		if arg_20_0:isTotalClear() then
			arg_20_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE, {
				goToNext = false
			})
		else
			arg_20_0:displayDefeat()
		end
	elseif arg_20_0._stateFlag == var_0_0.STATE_CONTINUE then
		arg_20_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE, {
			goToNext = true
		})
	elseif arg_20_0._stateFlag == var_0_0.STATE_QUIT or arg_20_0._stateFlag == var_0_0.STATE_CLEAR then
		arg_20_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE, {
			goToNext = false
		})
	end

	return
end

function var_0_0.willExit(arg_21_0)
	var_0_0.super.willExit(arg_21_0)
	LeanTween.cancel(go(arg_21_0._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf)

	return
end

return var_0_0
