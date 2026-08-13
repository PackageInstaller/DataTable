class = var_0_10000

local var_0_0 = "NewChallengeResultGradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultGradePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	getProxy = var_1
	ChallengeProxy = var_2

	local var_1_0 = var_1(var_2)

	arg_1_0.challenge = var_1.getUserChallengeInfo(var_1_0, arg_1_0.contextData.mode)
	getProxy = var_1
	ChallengeProxy = var_1_0

	local var_1_1 = var_1(var_1_0)

	arg_1_0.challengeExpire = var_1.userSeaonExpire(var_1_1, arg_1_0.contextData.mode)

	return
end

function var_0_1.isTotalClear(arg_2_0)
	local var_2_0 = arg_2_0.challenge
	local var_2_1 = var_1.getMode(var_2_0)

	ChallengeProxy = var_2_0

	local var_2_3

	if var_2_1 == var_2_0.MODE_CASUAL then
		local var_2_2 = arg_2_0.challenge

		var_2_3 = var_1.IsFinish(var_2_2)
	else
		var_2_3 = false
	end

	if false then
		var_2_3 = true
	end

	return var_2_3 or arg_2_0:isFail()
end

function var_0_1.isFail(arg_3_0)
	local var_3_0 = arg_3_0.contextData.score

	ys = var_1_10002

	return var_3_0 < var_1_10002.Battle.BattleConst.BattleScore.S
end

function var_0_1.GetGetObjectives(arg_4_0)
	local var_4_0 = arg_4_0.contextData

	getProxy = var_1_10002
	ChallengeProxy = var_1_10003

	local var_4_1 = var_1_10002(var_1_10003)
	local var_4_2 = var_2.getUserChallengeInfo(var_4_1, var_4_0.mode)
	local var_4_3 = var_2.getMode(var_4_2)

	ChallengeProxy = var_4_2

	if var_4_3 == var_4_2.MODE_INFINITE then
		return {}
	else
		local var_4_4 = {}

		i18n = var_4

		local var_4_5 = "challenge_combat_score"
		local var_4_6 = var_2
		local var_4_7 = var_4(var_4_5, var_2.getLastScore(var_4_6))

		NewBattleResultUtil = var_4_5

		local var_4_8, var_4_9 = var_4_5.ColorObjective(true)

		table = var_4_6

		local var_4_10 = var_4_6.insert
		local var_4_11 = var_4_4
		local var_4_12 = {}

		setColorStr = var_1_10010
		var_4_12.text = var_1_10010(var_4_7, var_4_9)
		var_4_12.icon = var_4_8

		var_4_10(var_4_11, var_4_12)

		i18n = var_4_10

		local var_4_13 = var_4_10("challenge_current_score", var_2:getScore())

		table = var_8

		local var_4_14 = var_8.insert
		local var_4_15 = var_4_4
		local var_4_16 = {}

		setColorStr = var_11
		var_4_16.text = var_11(var_4_13, var_4_9)
		var_4_16.icon = var_4_8

		var_4_14(var_4_15, var_4_16)

		return var_4_4
	end

	return
end

function var_0_1.UpdateChapterName(arg_5_0)
	local var_5_0 = arg_5_0.contextData

	getProxy = var_1_10002
	ChallengeProxy = var_1_10003

	local var_5_1 = var_1_10002(var_1_10003)
	local var_5_2 = var_2.getUserChallengeInfo(var_5_1, var_5_0.mode)

	ChallengeProxy = var_5_1

	if var_5_2 == var_5_1.MODE_INFINITE then
		pg = var_5_2

		local var_5_3 = var_5_2.expedition_data_template[var_5_0.stageId].name
		local var_5_4 = " - ROUND "

		getProxy = var_1_10005
		ChallengeProxy = var_1_10006

		local var_5_5 = var_1_10005(var_1_10006)
		local var_5_6 = var_5.getUserChallengeInfo(var_5_5, var_5_0.mode)
		local var_5_7 = var_5_3 .. var_5_4 .. var_5.getLevel(var_5_6)

		setText = var_5_4

		var_5_4(arg_5_0.gradeChapterName, var_5_7)
	else
		var_0_1.super.UpdateChapterName(arg_5_0)
	end

	return
end

function var_0_1.LoadChallengeRes(arg_6_0, arg_6_1)
	setActive = var_1_10002

	local var_6_0 = arg_6_0.bgTr

	var_1_10002(var_3.Find(var_6_0, "ResultEffect/Tips"), false)

	LoadAnyAsync = var_1_10002

	var_1_10002("BattleResultItems/Challenge", "", nil, function(arg_7_0)
		if not arg_6_0.exited then
			IsNil = var_1

			if var_1(arg_7_0) then
				if arg_6_1 then
					arg_6_1()
				end

				return
			end

			local var_7_0 = arg_6_0
			local var_7_1 = var_1.UpdateChallengeInfo

			Object = var_2_10003

			var_7_1(var_7_0, var_2_10003.Instantiate(arg_7_0, arg_6_0._tf).transform)

			if arg_6_1 then
				arg_6_1()
			end

			return
		end
	end)

	return
end

function var_0_1.UpdateChallengeInfo(arg_8_0, arg_8_1)
	setText = var_1_10002

	local var_8_0 = arg_8_1:Find("expire")

	if arg_8_0.challengeExpire then
		i18n = var_4

		local var_8_1

		if not var_4("challenge_expire_warn") then
			var_8_1 = ""
		end

		var_1_10002(var_8_0, var_8_1)

		setText = var_1_10002
		findTF = var_8_0

		local var_8_2 = var_8_0(arg_8_1, "continue_btn/text")

		i18n = var_4

		var_1_10002(var_8_2, var_4("battle_result_continue_battle"))

		setText = var_1_10002
		findTF = var_8_2

		local var_8_3 = var_8_2(arg_8_1, "quit_btn/text")

		i18n = var_4

		var_1_10002(var_8_3, var_4("battle_result_quit_battle"))

		setText = var_1_10002
		findTF = var_8_3

		local var_8_4 = var_8_3(arg_8_1, "share_btn/text")

		i18n = var_4

		var_1_10002(var_8_4, var_4("battle_result_share_battle"))

		findTF = var_1_10002
		arg_8_0.continueBtn = var_1_10002(arg_8_1, "continue_btn")
		findTF = var_2
		arg_8_0.quitBtn = var_2(arg_8_1, "quit_btn")
		findTF = var_2
		arg_8_0.shareBtn = var_2(arg_8_1, "share_btn")

		local var_8_5 = arg_8_0
		local var_8_6 = arg_8_0.isTotalClear(var_8_5)

		SetActive = var_8_5

		var_8_5(arg_8_0.continueBtn, not var_8_6)

		SetActive = var_8_5

		var_8_5(arg_8_0.quitBtn, not var_8_6)

		SetActive = var_8_5

		var_8_5(arg_8_0.shareBtn, var_8_6)

		return
	end
end

function var_0_1.RegisterEvent(arg_9_0, arg_9_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_10_0)
			var_0_1.super.RegisterEvent(arg_9_0, arg_10_0)

			return
		end,
		function(arg_11_0)
			removeOnButton = var_2_10001

			var_2_10001(arg_9_0._tf)

			local var_11_0 = arg_9_0

			var_1.LoadChallengeRes(var_11_0, arg_11_0)

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_9_0

			var_1.RegisterChallengeEvent(var_12_0, arg_9_1)

			return
		end
	})

	return
end

function var_0_1.RegisterChallengeEvent(arg_13_0, arg_13_1)
	if arg_13_0:isTotalClear() then
		onButton = var_2

		local var_13_0 = arg_13_0
		local var_13_1 = arg_13_0.shareBtn

		local function var_13_2()
			local var_14_0 = arg_13_0
			local var_14_1 = var_0.emit

			NewBattleResultMediator = var_2_10002

			var_14_1(var_14_0, var_2_10002.CHALLENGE_SHARE)

			return
		end

		SFX_CONFIRM = var_1_10006

		var_2(var_13_0, var_13_1, var_13_2, var_1_10006)

		onButton = var_2

		local var_13_3 = arg_13_0
		local var_13_4 = arg_13_0._tf
		local var_13_5 = arg_13_1

		SFX_CONFIRM = var_1_10006

		var_2(var_13_3, var_13_4, var_13_5, var_1_10006)
	else
		onButton = var_2

		local var_13_6 = arg_13_0
		local var_13_7 = arg_13_0.continueBtn

		local function var_13_8()
			local var_15_0 = arg_13_0

			var_0.OnContinue(var_15_0, arg_13_1)

			return
		end

		SFX_CONFIRM = var_1_10006

		var_2(var_13_6, var_13_7, var_13_8, var_1_10006)

		onButton = var_2

		local var_13_9 = arg_13_0
		local var_13_10 = arg_13_0.quitBtn

		local function var_13_11()
			local var_16_0 = arg_13_0

			var_0.OnQuit(var_16_0, arg_13_1)

			return
		end

		SFX_CONFIRM = var_1_10006

		var_2(var_13_9, var_13_10, var_13_11, var_1_10006)
	end

	return
end

function var_0_1.OnContinue(arg_17_0, arg_17_1)
	if arg_17_0:isFail() then
		arg_17_1()
	else
		arg_17_0.contextData.goToNext = true

		local var_17_0 = arg_17_0
		local var_17_1 = arg_17_0.emit

		NewBattleResultMediator = var_1_10004

		var_17_1(var_17_0, var_1_10004.CHALLENGE_DEFEAT_SCENE, {
			callback = arg_17_1
		})
	end

	return
end

function var_0_1.OnQuit(arg_18_0, arg_18_1)
	if arg_18_0:isFail() then
		arg_18_1()
	else
		local var_18_0 = arg_18_0
		local var_18_1 = arg_18_0.emit

		NewBattleResultMediator = var_1_10004

		var_18_1(var_18_0, var_1_10004.CHALLENGE_DEFEAT_SCENE, {
			callback = arg_18_1
		})
	end

	return
end

return var_0_1
