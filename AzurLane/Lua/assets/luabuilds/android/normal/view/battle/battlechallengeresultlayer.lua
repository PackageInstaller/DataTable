class = var_0_10000

local var_0_0 = "BattleChallengeResultLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BattleResultLayer"))

var_0_1.DURATION_WIN_FADE_IN = 0.5
var_0_1.DURATION_LOSE_FADE_IN = 1.5
var_0_1.DURATION_GRADE_LAST = 1.5
var_0_1.DURATION_MOVE = 0.7
var_0_1.DURATION_WIN_SCALE = 0.7
var_0_1.STATE_DEFEAT = "state_defeat"
var_0_1.STATE_CLEAR = "state_clear"
var_0_1.STATE_CONTINUE = "state_continue"
var_0_1.STATE_QUIT = "state_quit"

function var_0_1.getUIName(arg_1_0)
	return "BattleResultUI"
end

function var_0_1.setChallengeInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.challenge = arg_2_1
	arg_2_0.challengeExpire = arg_2_2

	return
end

function var_0_1.setShips(arg_3_0, arg_3_1)
	arg_3_0.shipVOs = arg_3_1

	return
end

function var_0_1.isTotalClear(arg_4_0)
	local var_4_0 = arg_4_0.challenge
	local var_4_1 = var_1.getMode(var_4_0)

	ChallengeProxy = var_4_0

	local var_4_3

	if var_4_1 == var_4_0.MODE_CASUAL then
		local var_4_2 = arg_4_0.challenge

		var_4_3 = var_1.IsFinish(var_4_2)
	else
		var_4_3 = false
	end

	if false then
		var_4_3 = true
	end

	return var_4_3 or arg_4_0:isFail()
end

function var_0_1.isFail(arg_5_0)
	local var_5_0 = arg_5_0.contextData.score

	ys = var_1_10002

	return var_5_0 < var_1_10002.Battle.BattleConst.BattleScore.S
end

function var_0_1.init(arg_6_0)
	var_0_1.super.init(arg_6_0)

	local var_6_0 = arg_6_0._blurConatiner

	arg_6_0._challengeBottomPanel = var_1.Find(var_6_0, "challenge_confirm")
	setText = var_1
	findTF = var_6_0

	local var_6_1 = var_6_0(arg_6_0._challengeBottomPanel, "continue_btn/text")

	i18n = var_3

	var_1(var_6_1, var_3("battle_result_continue_battle"))

	setText = var_1
	findTF = var_6_1

	local var_6_2 = var_6_1(arg_6_0._challengeBottomPanel, "quit_btn/text")

	i18n = var_3

	var_1(var_6_2, var_3("battle_result_quit_battle"))

	setText = var_1
	findTF = var_6_2

	local var_6_3 = var_6_2(arg_6_0._challengeBottomPanel, "share_btn/text")

	i18n = var_3

	var_1(var_6_3, var_3("battle_result_share_battle"))

	local var_6_4 = arg_6_0._challengeBottomPanel

	arg_6_0._shareBtn = var_1.Find(var_6_4, "share_btn")

	local var_6_5 = arg_6_0._challengeBottomPanel

	arg_6_0._continueBtn = var_1.Find(var_6_5, "continue_btn")

	local var_6_6 = arg_6_0._challengeBottomPanel

	arg_6_0._quitBtn = var_1.Find(var_6_6, "quit_btn")

	local var_6_7 = arg_6_0._main

	arg_6_0._expire = var_1.Find(var_6_7, "challenge_expire")

	local var_6_8 = arg_6_0._expire

	arg_6_0._expireTxt = var_1.Find(var_6_8, "text")

	return
end

function var_0_1.didEnter(arg_7_0)
	var_0_1.super.didEnter(arg_7_0)

	onButton = var_1

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0._skipBtn

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.skip(var_8_0)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_7_0, var_7_1, var_7_2, var_1_10005)

	return
end

function var_0_1.setStageName(arg_9_0)
	if arg_9_0.contextData.system then
		local var_9_0 = arg_9_0.contextData.system

		SYSTEM_DUEL = var_1_10002

		if var_9_0 == var_1_10002 then
			setText = var_9_0

			var_9_0(arg_9_0._levelText, arg_9_0.rivalVO.name)

			goto label_9_0
		end
	end

	do
		local var_9_1 = arg_9_0.contextData.stageId

		pg = var_1_10002

		local var_9_2 = var_1_10002.expedition_data_template[var_9_1]
	end

	::label_9_0::

	local var_9_3 = arg_9_0.challenge
	local var_9_4 = var_1.getMode(var_9_3)

	ChallengeProxy = var_9_3

	if var_9_4 == var_9_3.MODE_INFINITE then
		local var_9_5 = arg_9_0.contextData.stageId

		pg = var_2

		local var_9_6 = var_2.expedition_data_template[var_9_5].name
		local var_9_7 = " - ROUND "
		local var_9_8 = arg_9_0.challenge
		local var_9_9 = var_9_6 .. var_9_7 .. var_5.getLevel(var_9_8)

		setText = var_9_7

		var_9_7(arg_9_0._levelText, var_9_9)
	else
		var_0_1.super.setStageName(arg_9_0)
	end

	return
end

function var_0_1.rankAnimaFinish(arg_10_0)
	local var_10_0 = arg_10_0._tf
	local var_10_1 = var_1.Find(var_10_0, "main/conditions")
	local var_10_2 = arg_10_0.challenge
	local var_10_3 = var_2.getMode(var_10_2)

	ChallengeProxy = var_10_2

	if var_10_3 == var_10_2.MODE_INFINITE then
		SetActive = var_10_3

		var_10_3(var_10_1, false)

		arg_10_0._stateFlag = var_0_1.STATE_REPORTED
	else
		SetActive = var_10_3

		var_10_3(var_10_1, true)

		local var_10_4 = arg_10_0
		local var_10_5 = arg_10_0.setCondition

		i18n = var_4

		local var_10_6 = "challenge_combat_score"
		local var_10_7 = arg_10_0.challenge

		var_10_5(var_10_4, var_4(var_10_6, var_6.getLastScore(var_10_7)), true)

		local var_10_8 = arg_10_0
		local var_10_9 = arg_10_0.setCondition

		i18n = var_4

		local var_10_10 = "challenge_current_score"
		local var_10_11 = arg_10_0.challenge

		var_10_9(var_10_8, var_4(var_10_10, var_6.getScore(var_10_11)), true)

		LeanTween = var_10_9

		local var_10_12 = var_10_9.delayedCall
		local var_10_13 = 1

		System = var_4

		local var_10_14 = var_10_12(var_10_13, var_4.Action(function()
			local var_11_0 = arg_10_0

			var_11_0._stateFlag = var_0_1.STATE_REPORTED
			SetActive = var_11_0

			local var_11_1 = arg_10_0._bg

			var_11_0(var_1.Find(var_11_1, "jieuan01/tips"), true)

			return
		end))

		table = var_10_13

		var_10_13.insert(arg_10_0._delayLeanList, var_10_14.id)

		arg_10_0._stateFlag = var_0_1.STATE_REPORT
	end

	return
end

function var_0_1.displayDefeat(arg_12_0)
	local function var_12_0()
		local var_13_0 = arg_12_0

		var_0.skip(var_13_0)

		return
	end

	if arg_12_0:isFail() then
		arg_12_0._stateFlag = var_0_1.STATE_QUIT

		var_12_0()
	else
		local var_12_1 = arg_12_0
		local var_12_2 = arg_12_0.emit

		BattleResultMediator = var_1_10004

		var_12_2(var_12_1, var_1_10004.ON_CHALLENGE_DEFEAT_SCENE, {
			callback = var_12_0
		})
	end

	return
end

function var_0_1.showRightBottomPanel(arg_14_0)
	SetActive = var_1_10001

	var_1_10001(arg_14_0._expire, arg_14_0.challengeExpire)

	setText = var_1_10001

	local var_14_0 = arg_14_0._expireTxt

	i18n = var_3

	var_1_10001(var_14_0, var_3("challenge_expire_warn"))

	SetActive = var_1_10001

	var_1_10001(arg_14_0._skipBtn, false)

	if not arg_14_0:isTotalClear() then
		SetActive = var_1

		local var_14_1 = arg_14_0._bg

		var_1(var_2.Find(var_14_1, "jieuan01/tips"), false)
	end

	SetActive = var_1

	var_1(arg_14_0._challengeBottomPanel, true)

	if arg_14_0:isTotalClear() then
		SetActive = var_1

		var_1(arg_14_0._continueBtn, false)

		SetActive = var_1

		var_1(arg_14_0._quitBtn, false)

		SetActive = var_1

		var_1(arg_14_0._shareBtn, true)

		onButton = var_1

		local var_14_2 = arg_14_0
		local var_14_3 = arg_14_0._shareBtn

		local function var_14_4()
			local var_15_0 = arg_14_0
			local var_15_1 = var_0.emit

			BattleResultMediator = var_2_10002

			var_15_1(var_15_0, var_2_10002.ON_CHALLENGE_SHARE)

			return
		end

		SFX_CONFIRM = var_1_10005

		var_1(var_14_2, var_14_3, var_14_4, var_1_10005)

		onButton = var_1

		var_1(arg_14_0, arg_14_0._bg, function()
			local var_16_0 = arg_14_0

			var_0.skip(var_16_0)

			arg_14_0._stateFlag = var_0_1.STATE_CLEAR

			return
		end)
	else
		SetActive = var_1

		var_1(arg_14_0._continueBtn, true)

		SetActive = var_1

		var_1(arg_14_0._quitBtn, true)

		SetActive = var_1

		var_1(arg_14_0._shareBtn, false)

		onButton = var_1

		local var_14_5 = arg_14_0
		local var_14_6 = arg_14_0._continueBtn

		local function var_14_7()
			local var_17_0 = arg_14_0

			var_0.skip(var_17_0)

			arg_14_0._stateFlag = var_0_1.STATE_CONTINUE

			return
		end

		SFX_CONFIRM = var_1_10005

		var_1(var_14_5, var_14_6, var_14_7, var_1_10005)

		onButton = var_1

		local var_14_8 = arg_14_0
		local var_14_9 = arg_14_0._quitBtn

		local function var_14_10()
			local var_18_0 = arg_14_0

			var_0.skip(var_18_0)

			arg_14_0._stateFlag = var_0_1.STATE_QUIT

			return
		end

		SFX_CONFIRM = var_1_10005

		var_1(var_14_8, var_14_9, var_14_10, var_1_10005)
	end

	arg_14_0._stateFlag = var_0_1.STATE_DEFEAT

	return
end

function var_0_1.onBackPressed(arg_19_0)
	arg_19_0:skip()

	return
end

function var_0_1.skip(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0._delayLeanList) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_20_1)
	end

	if arg_20_0._stateFlag == var_0_1.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_20_0._stateFlag == var_0_1.STATE_REPORT then
		local var_20_0 = arg_20_0._conditionContainer.childCount

		while 0 < var_20_0 do
			SetActive = var_2

			local var_20_1 = arg_20_0._conditionContainer

			var_2(var_3.GetChild(var_20_1, var_20_0 - 1), true)

			var_20_0 = var_20_0 - 1
		end

		SetActive = var_2

		local var_20_2 = arg_20_0._bg

		var_2(var_3.Find(var_20_2, "jieuan01/tips"), true)

		arg_20_0._stateFlag = var_0_1.STATE_REPORTED
	elseif arg_20_0._stateFlag == var_0_1.STATE_REPORTED then
		arg_20_0:showRightBottomPanel()
	elseif arg_20_0._stateFlag == var_0_1.STATE_DEFEAT then
		if arg_20_0:isTotalClear() then
			local var_20_3 = arg_20_0
			local var_20_4 = arg_20_0.emit

			BattleResultMediator = var_3

			var_20_4(var_20_3, var_3.ON_BACK_TO_LEVEL_SCENE, {
				goToNext = false
			})
		else
			arg_20_0:displayDefeat()
		end
	elseif arg_20_0._stateFlag == var_0_1.STATE_CONTINUE then
		local var_20_5 = arg_20_0
		local var_20_6 = arg_20_0.emit

		BattleResultMediator = var_3

		var_20_6(var_20_5, var_3.ON_BACK_TO_LEVEL_SCENE, {
			goToNext = true
		})
	elseif arg_20_0._stateFlag == var_0_1.STATE_QUIT or arg_20_0._stateFlag == var_0_1.STATE_CLEAR then
		local var_20_7 = arg_20_0
		local var_20_8 = arg_20_0.emit

		BattleResultMediator = var_3

		var_20_8(var_20_7, var_3.ON_BACK_TO_LEVEL_SCENE, {
			goToNext = false
		})
	end

	return
end

function var_0_1.willExit(arg_21_0)
	var_0_1.super.willExit(arg_21_0)

	LeanTween = var_1

	local var_21_0 = var_1.cancel

	go = var_2

	var_21_0(var_2(arg_21_0._tf))

	pg = var_21_0

	local var_21_1 = var_21_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_1, arg_21_0._tf)

	return
end

return var_0_1
