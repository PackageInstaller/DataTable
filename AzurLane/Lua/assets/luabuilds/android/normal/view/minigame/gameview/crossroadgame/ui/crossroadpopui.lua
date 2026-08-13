class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadPopUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initSettlementUI()

	return
end

function var_0_0.initCountUI(arg_2_0)
	findTF = var_1_10001
	arg_2_0.countUI = var_1_10001(arg_2_0._tf, "pop/CountUI")
	GetComponent = var_1

	local var_2_0 = arg_2_0.countUI

	typeof = var_3
	Animator = var_1_10004
	arg_2_0.countAnimator = var_1(var_2_0, var_3(var_1_10004))
	GetOrAddComponent = var_1

	local var_2_1 = arg_2_0.countUI

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.countDft = var_1(var_2_1, var_3(var_1_10004))

	local var_2_2 = arg_2_0.countDft

	var_1.SetTriggerEvent(var_2_2, function()
		return
	end)

	local var_2_3 = arg_2_0.countDft

	var_1.SetEndEvent(var_2_3, function()
		local var_4_0 = arg_2_0._event
		local var_4_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_4_1(var_4_0, var_2_10002.COUNT_DOWN)

		return
	end)

	return
end

function var_0_0.initLeavelUI(arg_5_0)
	findTF = var_1_10001
	arg_5_0.leaveUI = var_1_10001(arg_5_0._tf, "pop/LeaveUI")
	setText = var_1
	findTF = var_2

	local var_5_0 = var_2(arg_5_0.leaveUI, "ad/desc")

	i18n = var_3

	var_1(var_5_0, var_3("mini_game_leave"))

	setActive = var_1

	var_1(arg_5_0.leaveUI, false)

	onButton = var_1

	local var_5_1 = arg_5_0._event

	findTF = var_3

	local var_5_2 = var_3(arg_5_0.leaveUI, "ad/btnConfirm")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.ResumeGame(var_6_0)

		local var_6_1 = arg_5_0._event
		local var_6_2 = var_0.emit

		CrossRoadGameView = var_2_10002

		var_6_2(var_6_1, var_2_10002.LEAVEL_GAME, true)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_5_1, var_5_2, var_5_3, var_5)

	onButton = var_1

	local var_5_4 = arg_5_0._event

	findTF = var_5_2

	local var_5_5 = var_5_2(arg_5_0.leaveUI, "ad/btnCancel")

	local function var_5_6()
		local var_7_0 = arg_5_0

		var_0.ResumeGame(var_7_0)

		local var_7_1 = arg_5_0._event
		local var_7_2 = var_0.emit

		CrossRoadGameView = var_2_10002

		var_7_2(var_7_1, var_2_10002.LEAVEL_GAME, false)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_5_4, var_5_5, var_5_6, var_5)

	return
end

function var_0_0.initSettlementUI(arg_8_0)
	findTF = var_1_10001
	arg_8_0.settlementUI = var_1_10001(arg_8_0._tf, "pop/SettleMentUI")
	findTF = var_1
	arg_8_0.curRoleText = var_1(arg_8_0.settlementUI, "ad/1/layout2/curRoleText")
	findTF = var_1
	arg_8_0.curRoleTextCnt = var_1(arg_8_0.settlementUI, "ad/1/layout2/curRoleText_Cnt")
	findTF = var_1
	arg_8_0.curScoreText = var_1(arg_8_0.settlementUI, "ad/1/layout1/currentText")
	findTF = var_1
	arg_8_0.curScoreTextCnt = var_1(arg_8_0.settlementUI, "ad/1/layout1/currentText_Cnt")
	setActive = var_1

	var_1(arg_8_0.settlementUI, false)

	onButton = var_1

	local var_8_0 = arg_8_0._event

	findTF = var_3

	local var_8_1 = var_3(arg_8_0.settlementUI, "ad/btnOver")

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.ClearUI(var_9_0)

		local var_9_1 = arg_8_0._event
		local var_9_2 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_9_2(var_9_1, var_2_10002.BACK_MENU)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_8_0, var_8_1, var_8_2, var_5)

	onButton = var_1

	local var_8_3 = arg_8_0._event

	findTF = var_8_1

	local var_8_4 = var_8_1(arg_8_0.settlementUI, "ad/btnAgain")

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.ClearUI(var_10_0)

		local var_10_1 = arg_8_0._event
		local var_10_2 = var_0.emit

		CrossRoadGameView = var_2_10002

		var_10_2(var_10_1, var_2_10002.AGAIN)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_8_3, var_8_4, var_8_5, var_5)

	return
end

function var_0_0.setChildVisible(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = 1, arg_11_1.childCount do
		local var_11_0 = arg_11_1
		local var_11_1 = arg_11_1.GetChild(var_11_0, iter_11_0 - 1)

		setActive = var_11_0

		var_11_0(var_11_1, arg_11_2)
	end

	return
end

function var_0_0.PopPauseUI(arg_12_0)
	isActive = var_1_10001

	if var_1_10001(arg_12_0.leaveUI) then
		setActive = var_1

		var_1(arg_12_0.leaveUI, false)
	end

	return
end

function var_0_0.PopCountUI(arg_13_0, arg_13_1)
	setActive = var_1_10002

	var_1_10002(arg_13_0.countUI, arg_13_1)

	return
end

function var_0_0.PopSettlementUI(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.settlementUI, arg_14_1)

	return
end

function var_0_0.PopLeaveUI(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.leaveUI, true)

	return
end

function var_0_0.UpdateSettlementUI(arg_16_0)
	GetComponent = var_1_10001
	findTF = var_1_10002

	local var_16_0 = var_1_10002(arg_16_0.settlementUI, "ad")

	typeof = var_3
	Animator = var_4

	local var_16_1 = var_1_10001(var_16_0, var_3(var_4))

	var_1.Play(var_16_1, "settlement", -1, 0)

	local var_16_2 = arg_16_0._gameVo
	local var_16_3 = var_2.GetScore(var_16_2)
	local var_16_4 = arg_16_0._gameVo
	local var_16_5 = var_3.GetRoleCnt(var_16_4)

	setText = var_16_4

	local var_16_6 = arg_16_0.curScoreText

	i18n = var_6

	var_16_4(var_16_6, var_6("mini_game_crossroad_score"))

	setText = var_16_4

	var_16_4(arg_16_0.curScoreTextCnt, var_16_3)

	setText = var_16_4

	local var_16_7 = arg_16_0.curRoleText

	i18n = var_6

	var_16_4(var_16_7, var_6("mini_game_crossroad_cnt"))

	setText = var_16_4

	var_16_4(arg_16_0.curRoleTextCnt, var_16_5)

	local var_16_8 = arg_16_0._event
	local var_16_9 = var_4.emit

	SimpleMGEvent = var_6

	var_16_9(var_16_8, var_6.SUBMIT_GAME_SUCCESS, {
		num = var_16_3,
		cnt = var_16_5
	})

	return
end

function var_0_0.BackPressed(arg_17_0)
	isActive = var_1_10001

	local var_17_1

	if var_1_10001(arg_17_0.leaveUI) then
		arg_17_0:ResumeGame()

		local var_17_0 = arg_17_0._event

		var_17_1 = var_17_1.emit
		CrossRoadGameView = var_1_10003

		var_17_1(var_17_0, var_1_10003.LEAVEL_GAME, false)
	else
		setActive = var_17_1

		var_17_1(arg_17_0.leaveUI, true)

		local var_17_2 = arg_17_0._event
		local var_17_3 = var_1.emit

		SimpleMGEvent = var_3

		var_17_3(var_17_2, var_3.PAUSE_GAME, true)
	end

	return
end

function var_0_0.ResumeGame(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0.leaveUI, false)

	return
end

function var_0_0.UpdateGameUI(arg_19_0, arg_19_1)
	setText = var_1_10002

	var_1_10002(arg_19_0.scoreTf, arg_19_1.scoreNum)

	setText = var_1_10002

	local var_19_0 = arg_19_0.gameTimeS

	math = var_4

	var_1_10002(var_19_0, var_4.ceil(arg_19_1.gameTime))

	return
end

function var_0_0.ReadyStart(arg_20_0)
	arg_20_0:PopCountUI(true)

	local var_20_0 = arg_20_0.countAnimator

	var_1.Play(var_20_0, "cross_count")

	pg = var_1

	local var_20_1 = var_1.CriMgr.GetInstance()
	local var_20_2 = var_1.PlaySoundEffect_V3

	WatermelonGameConst = var_3

	var_20_2(var_20_1, var_3.SFX_COUNT_DOWN)

	return
end

function var_0_0.ClearUI(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_21_0.countUI, false)

	return
end

return var_0_0
