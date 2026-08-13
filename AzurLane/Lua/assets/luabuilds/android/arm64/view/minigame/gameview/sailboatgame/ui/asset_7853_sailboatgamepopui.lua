class = var_0_10000

local var_0_0 = var_0_10000("SailBoatGamePopUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initPauseUI()
	arg_1_0:initSettlementUI()

	return
end

function var_0_0.initCountUI(arg_2_0)
	findTF = var_1_10001
	arg_2_0.countUI = var_1_10001(arg_2_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_2_0 = var_3(arg_2_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_2_0.countAnimator = var_1(var_2_0, var_4(var_6))
	GetOrAddComponent = var_1
	findTF = var_2_0

	local var_2_1 = var_2_0(arg_2_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_2_0.countDft = var_1(var_2_1, var_4(var_6))

	local var_2_2 = arg_2_0.countDft

	var_1.SetTriggerEvent(var_2_2, function()
		return
	end)

	local var_2_3 = arg_2_0.countDft

	var_1.SetEndEvent(var_2_3, function()
		local var_4_0 = arg_2_0._event
		local var_4_1 = var_0.emit

		SailBoatGameView = var_2_10003

		var_4_1(var_4_0, var_2_10003.COUNT_DOWN)

		return
	end)

	return
end

function var_0_0.initLeavelUI(arg_5_0)
	findTF = var_1_10001
	arg_5_0.leaveUI = var_1_10001(arg_5_0._tf, "pop/LeaveUI")
	setActive = var_1

	var_1(arg_5_0.leaveUI, false)

	onButton = var_1

	local var_5_0 = arg_5_0._event

	findTF = var_4

	local var_5_1 = var_4(arg_5_0.leaveUI, "ad/btnOk")

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.resumeGame(var_6_0)

		local var_6_1 = arg_5_0._event
		local var_6_2 = var_0.emit

		SailBoatGameView = var_2_10003

		var_6_2(var_6_1, var_2_10003.LEVEL_GAME, true)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_0, var_5_1, var_5_2, var_6)

	onButton = var_1

	local var_5_3 = arg_5_0._event

	findTF = var_5_1

	local var_5_4 = var_5_1(arg_5_0.leaveUI, "ad/btnCancel")

	local function var_5_5()
		local var_7_0 = arg_5_0

		var_0.resumeGame(var_7_0)

		local var_7_1 = arg_5_0._event
		local var_7_2 = var_0.emit

		SailBoatGameView = var_2_10003

		var_7_2(var_7_1, var_2_10003.LEVEL_GAME, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_3, var_5_4, var_5_5, var_6)

	return
end

function var_0_0.initPauseUI(arg_8_0)
	findTF = var_1_10001
	arg_8_0.pauseUI = var_1_10001(arg_8_0._tf, "pop/pauseUI")
	setActive = var_1

	var_1(arg_8_0.pauseUI, false)

	onButton = var_1

	local var_8_0 = arg_8_0._event

	findTF = var_4

	local var_8_1 = var_4(arg_8_0.pauseUI, "ad/btnOk")

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.resumeGame(var_9_0)

		local var_9_1 = arg_8_0._event
		local var_9_2 = var_0.emit

		SailBoatGameView = var_2_10003

		var_9_2(var_9_1, var_2_10003.PAUSE_GAME, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_8_0, var_8_1, var_8_2, var_6)

	return
end

function var_0_0.initSettlementUI(arg_10_0)
	findTF = var_1_10001
	arg_10_0.settlementUI = var_1_10001(arg_10_0._tf, "pop/SettleMentUI")
	setActive = var_1

	var_1(arg_10_0.settlementUI, false)

	onButton = var_1

	local var_10_0 = arg_10_0._event

	findTF = var_4

	local var_10_1 = var_4(arg_10_0.settlementUI, "ad/btnOver")

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.clearUI(var_11_0)

		local var_11_1 = arg_10_0._event
		local var_11_2 = var_0.emit

		SailBoatGameView = var_2_10003

		var_11_2(var_11_1, var_2_10003.BACK_MENU)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_10_0, var_10_1, var_10_2, var_6)

	return
end

function var_0_0.updateSettlementUI(arg_12_0)
	GetComponent = var_1_10001
	findTF = var_1_10003

	local var_12_0 = var_1_10003(arg_12_0.settlementUI, "ad")

	typeof = var_1_10004
	Animator = var_6

	local var_12_1 = var_1_10001(var_12_0, var_1_10004(var_6))

	var_1.Play(var_12_1, "settlement", -1, 0)

	local var_12_2 = var_0_1.GetMiniGameData()
	local var_12_3 = var_2.GetRuntimeData(var_12_2, "elements")
	local var_12_4 = var_0_1.scoreNum

	if var_12_3 then
		local var_12_5 = #var_12_3
		local var_12_6

		if not (0 < var_12_5) or not var_12_3[1] then
			var_12_6 = 0
		end

		setActive = var_12_8
		findTF = var_7

		var_12_8(var_7(arg_12_0.settlementUI, "ad/new"), var_12_6 < var_12_4)

		local var_12_8

		if var_12_6 < var_12_4 then
			var_12_6 = var_12_4

			local var_12_7 = arg_12_0._event

			var_12_8 = var_12_8.emit
			SailBoatGameView = var_8

			var_12_8(var_12_7, var_8.STORE_SERVER, var_12_6)
		end

		findTF = var_12_8

		local var_12_9 = var_12_8(arg_12_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_12_10 = var_6(arg_12_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_12_9, var_12_6)

		setText = var_7

		var_7(var_12_10, var_12_4)

		local var_12_11 = arg_12_0._event
		local var_12_12 = var_7.emit

		SailBoatGameView = var_10

		var_12_12(var_12_11, var_10.SUBMIT_GAME_SUCCESS)

		return
	end
end

function var_0_0.backPressed(arg_13_0)
	isActive = var_1_10001

	local var_13_1

	if var_1_10001(arg_13_0.pauseUI) then
		arg_13_0:resumeGame()

		local var_13_0 = arg_13_0._event

		var_13_1 = var_13_1.emit
		SailBoatGameView = var_1_10004

		var_13_1(var_13_0, var_1_10004.PAUSE_GAME, false)
	else
		isActive = var_13_1

		local var_13_3

		if var_13_1(arg_13_0.leaveUI) then
			arg_13_0:resumeGame()

			local var_13_2 = arg_13_0._event

			var_13_3 = var_13_3.emit
			SailBoatGameView = var_1_10004

			var_13_3(var_13_2, var_1_10004.LEVEL_GAME, false)
		else
			isActive = var_13_3

			if not var_13_3(arg_13_0.pauseUI) then
				isActive = var_1

				if not var_1(arg_13_0.pauseUI) then
					arg_13_0:popPauseUI()

					local var_13_4 = arg_13_0._event
					local var_13_5 = var_1.emit

					SailBoatGameView = var_1_10004

					var_13_5(var_13_4, var_1_10004.PAUSE_GAME, true)

					goto label_13_0
				end
			end

			arg_13_0:resumeGame()
		end
	end

	::label_13_0::

	return
end

function var_0_0.resumeGame(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.leaveUI, false)

	setActive = var_1_10001

	var_1_10001(arg_14_0.pauseUI, false)

	return
end

function var_0_0.popLeaveUI(arg_15_0)
	isActive = var_1_10001

	if var_1_10001(arg_15_0.pauseUI) then
		setActive = var_1

		var_1(arg_15_0.pauseUI, false)
	end

	setActive = var_1

	var_1(arg_15_0.leaveUI, true)

	return
end

function var_0_0.popPauseUI(arg_16_0)
	isActive = var_1_10001

	if var_1_10001(arg_16_0.leaveUI) then
		setActive = var_1

		var_1(arg_16_0.leaveUI, false)
	end

	setActive = var_1

	var_1(arg_16_0.pauseUI, true)

	return
end

function var_0_0.updateGameUI(arg_17_0, arg_17_1)
	setText = var_1_10002

	var_1_10002(arg_17_0.scoreTf, arg_17_1.scoreNum)

	setText = var_1_10002

	local var_17_0 = arg_17_0.gameTimeS

	math = var_5

	var_1_10002(var_17_0, var_5.ceil(arg_17_1.gameTime))

	return
end

function var_0_0.readyStart(arg_18_0)
	arg_18_0:popCountUI(true)

	local var_18_0 = arg_18_0.countAnimator

	var_1.Play(var_18_0, "count")

	pg = var_1

	local var_18_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_18_1, var_0_1.SFX_COUNT_DOWN)

	return
end

function var_0_0.popCountUI(arg_19_0, arg_19_1)
	setActive = var_1_10002

	var_1_10002(arg_19_0.countUI, arg_19_1)

	return
end

function var_0_0.popSettlementUI(arg_20_0, arg_20_1)
	setActive = var_1_10002

	var_1_10002(arg_20_0.settlementUI, arg_20_1)

	return
end

function var_0_0.clearUI(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_21_0.countUI, false)

	return
end

return var_0_0
