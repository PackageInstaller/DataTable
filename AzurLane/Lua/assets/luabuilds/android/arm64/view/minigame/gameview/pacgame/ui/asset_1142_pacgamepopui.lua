class = var_0_10000

local var_0_0 = var_0_10000("WatermelonGamePopUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

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

		SimpleMGEvent = var_2_10003

		var_4_1(var_4_0, var_2_10003.COUNT_DOWN)

		return
	end)

	return
end

function var_0_0.initLeavelUI(arg_5_0)
	findTF = var_1_10001
	arg_5_0.leaveUI = var_1_10001(arg_5_0._tf, "pop/LeaveUI")
	setText = var_1
	findTF = var_3

	local var_5_0 = var_3(arg_5_0.leaveUI, "ad/desc")

	i18n = var_4

	var_1(var_5_0, var_4("mini_game_leave"))

	setText = var_1
	findTF = var_5_0

	local var_5_1 = var_5_0(arg_5_0.leaveUI, "ad/btnConfirmDesc")

	i18n = var_4

	var_1(var_5_1, var_4("ryza_task_confirm"))

	setText = var_1
	findTF = var_5_1

	local var_5_2 = var_5_1(arg_5_0.leaveUI, "ad/btnCancelDesc")

	i18n = var_4

	var_1(var_5_2, var_4("ryza_task_cancel"))

	setActive = var_1

	var_1(arg_5_0.leaveUI, false)

	onButton = var_1

	local var_5_3 = arg_5_0._event

	findTF = var_4

	local var_5_4 = var_4(arg_5_0.leaveUI, "ad/btnConfirm")

	local function var_5_5()
		local var_6_0 = arg_5_0

		var_0.ResumeGame(var_6_0)

		local var_6_1 = arg_5_0._event
		local var_6_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_6_2(var_6_1, var_2_10003.LEVEL_GAME, true)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_3, var_5_4, var_5_5, var_6)

	onButton = var_1

	local var_5_6 = arg_5_0._event

	findTF = var_5_4

	local var_5_7 = var_5_4(arg_5_0.leaveUI, "ad/btnCancel")

	local function var_5_8()
		local var_7_0 = arg_5_0

		var_0.ResumeGame(var_7_0)

		local var_7_1 = arg_5_0._event
		local var_7_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_7_2(var_7_1, var_2_10003.LEVEL_GAME, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_6, var_5_7, var_5_8, var_6)

	return
end

function var_0_0.initPauseUI(arg_8_0)
	findTF = var_1_10001
	arg_8_0.pauseUI = var_1_10001(arg_8_0._tf, "pop/pauseUI")
	setActive = var_1

	var_1(arg_8_0.pauseUI, false)

	setText = var_1
	findTF = var_3

	local var_8_0 = var_3(arg_8_0.pauseUI, "ad/desc")

	i18n = var_4

	var_1(var_8_0, var_4("mini_game_pause"))

	setText = var_1
	findTF = var_8_0

	local var_8_1 = var_8_0(arg_8_0.pauseUI, "ad/btnDesc")

	i18n = var_4

	var_1(var_8_1, var_4("mini_game_continue"))

	onButton = var_1

	local var_8_2 = arg_8_0._event

	findTF = var_4

	local var_8_3 = var_4(arg_8_0.pauseUI, "ad/btnOk")

	local function var_8_4()
		local var_9_0 = arg_8_0

		var_0.ResumeGame(var_9_0)

		local var_9_1 = arg_8_0._event
		local var_9_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_9_2(var_9_1, var_2_10003.PAUSE_GAME, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_8_2, var_8_3, var_8_4, var_6)

	return
end

function var_0_0.initSettlementUI(arg_10_0)
	findTF = var_1_10001
	arg_10_0.settlementUI = var_1_10001(arg_10_0._tf, "pop/SettleMentUI")
	setText = var_1
	findTF = var_3

	local var_10_0 = var_3(arg_10_0.settlementUI, "ad/btnOver/text")

	i18n = var_4

	var_1(var_10_0, var_4("mini_game_over_game"))

	setText = var_1
	findTF = var_10_0

	local var_10_1 = var_10_0(arg_10_0.settlementUI, "ad/HighDesc")

	i18n = var_4

	var_1(var_10_1, var_4("mini_game_high_score"))

	setText = var_1
	findTF = var_10_1

	local var_10_2 = var_10_1(arg_10_0.settlementUI, "ad/CurDesc")

	i18n = var_4

	var_1(var_10_2, var_4("mini_game_cur_score"))

	setActive = var_1

	var_1(arg_10_0.settlementUI, false)

	onButton = var_1

	local var_10_3 = arg_10_0._event

	findTF = var_4

	local var_10_4 = var_4(arg_10_0.settlementUI, "ad/btnOver")

	local function var_10_5()
		local var_11_0 = arg_10_0

		var_0.ClearUI(var_11_0)

		local var_11_1 = arg_10_0._event
		local var_11_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_11_2(var_11_1, var_2_10003.BACK_MENU)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_10_3, var_10_4, var_10_5, var_6)

	return
end

function var_0_0.setChildVisible(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		local var_12_0 = arg_12_1:GetChild(iter_12_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_12_0, arg_12_2)
	end

	return
end

function var_0_0.PopPauseUI(arg_13_0)
	isActive = var_1_10001

	if var_1_10001(arg_13_0.leaveUI) then
		setActive = var_1

		var_1(arg_13_0.leaveUI, false)
	end

	setActive = var_1

	var_1(arg_13_0.pauseUI, true)

	return
end

function var_0_0.PopCountUI(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.countUI, arg_14_1)

	return
end

function var_0_0.PopSettlementUI(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.settlementUI, arg_15_1)

	return
end

function var_0_0.PopLeaveUI(arg_16_0)
	isActive = var_1_10001

	if var_1_10001(arg_16_0.pauseUI) then
		setActive = var_1

		var_1(arg_16_0.pauseUI, false)
	end

	setActive = var_1

	var_1(arg_16_0.leaveUI, true)

	return
end

function var_0_0.UpdateSettlementUI(arg_17_0)
	GetComponent = var_1_10001
	findTF = var_1_10003

	local var_17_0 = var_1_10003(arg_17_0.settlementUI, "ad")

	typeof = var_1_10004
	Animator = var_6

	local var_17_1 = var_1_10001(var_17_0, var_1_10004(var_6))

	var_1.Play(var_17_1, "settlement", -1, 0)

	local var_17_2 = arg_17_0._gameVo
	local var_17_3 = var_2.GetScore(var_17_2)
	local var_17_4
	local var_17_5 = arg_17_0._gameVo
	local var_17_6 = var_4.GetConfig(var_17_5, "game_room")

	if 0 < var_17_6 then
		getProxy = var_17_6
		GameRoomProxy = var_17_5
		var_17_5 = var_17_6(var_17_5)
		var_17_6 = var_17_6.getRoomScore

		local var_17_7 = arg_17_0._gameVo

		var_17_4 = var_17_6(var_17_5, var_7.GetConfig(var_17_7, "game_room"))

		goto label_17_1
	end

	getProxy = var_17_6
	MiniGameProxy = var_17_5
	var_17_5 = var_17_6(var_17_5)
	var_17_6 = var_17_6.GetHighScore

	local var_17_8 = arg_17_0._gameVo

	if var_17_6(var_17_5, var_7.GetGameId(var_17_8)) then
		local var_17_9 = #var_17_6

		if not (0 < var_17_9) or not var_17_6[1] then
			::label_17_0::

			var_17_4 = 0
		end

		::label_17_1::

		setActive = var_17_6
		findTF = var_17_5

		var_17_6(var_17_5(arg_17_0.settlementUI, "ad/new"), var_17_4 < var_17_3)

		local var_17_11

		if 0 < var_17_3 and var_17_4 < var_17_3 then
			local var_17_10 = arg_17_0._event

			var_17_11 = var_17_11.emit
			SimpleMGEvent = var_7

			var_17_11(var_17_10, var_7.STORE_SERVER, {
				var_17_3,
				1
			})
		end

		findTF = var_17_11

		local var_17_12 = var_17_11(arg_17_0.settlementUI, "ad/highText")

		findTF = var_17_9

		local var_17_13 = var_17_9(arg_17_0.settlementUI, "ad/currentText")

		setText = var_6

		var_6(var_17_13, var_17_3)

		setText = var_6

		var_6(var_17_12, var_17_4)

		local var_17_14 = arg_17_0._event
		local var_17_15 = var_6.emit

		SimpleMGEvent = var_9

		var_17_15(var_17_14, var_9.SUBMIT_GAME_SUCCESS, var_17_3)

		return
	end
end

function var_0_0.BackPressed(arg_18_0)
	isActive = var_1_10001

	local var_18_1

	if var_1_10001(arg_18_0.pauseUI) then
		arg_18_0:ResumeGame()

		local var_18_0 = arg_18_0._event

		var_18_1 = var_18_1.emit
		SimpleMGEvent = var_1_10004

		var_18_1(var_18_0, var_1_10004.PAUSE_GAME, false)
	else
		isActive = var_18_1

		local var_18_3

		if var_18_1(arg_18_0.leaveUI) then
			arg_18_0:ResumeGame()

			local var_18_2 = arg_18_0._event

			var_18_3 = var_18_3.emit
			SimpleMGEvent = var_1_10004

			var_18_3(var_18_2, var_1_10004.LEVEL_GAME, false)
		else
			isActive = var_18_3

			if not var_18_3(arg_18_0.pauseUI) then
				isActive = var_1

				if not var_1(arg_18_0.pauseUI) then
					local var_18_4 = arg_18_0._gameVo

					if not var_1.IsSettlement(var_18_4) then
						arg_18_0:PopPauseUI()

						local var_18_5 = arg_18_0._event
						local var_18_6 = var_1.emit

						SimpleMGEvent = var_1_10004

						var_18_6(var_18_5, var_1_10004.PAUSE_GAME, true)
					end

					goto label_18_0
				end
			end

			arg_18_0:ResumeGame()
		end
	end

	::label_18_0::

	return
end

function var_0_0.ResumeGame(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0.leaveUI, false)

	setActive = var_1_10001

	var_1_10001(arg_19_0.pauseUI, false)

	return
end

function var_0_0.UpdateGameUI(arg_20_0, arg_20_1)
	setText = var_1_10002

	var_1_10002(arg_20_0.scoreTf, arg_20_1.scoreNum)

	setText = var_1_10002

	local var_20_0 = arg_20_0.gameTimeS

	math = var_5

	var_1_10002(var_20_0, var_5.ceil(arg_20_1.gameTime))

	return
end

function var_0_0.ReadyStart(arg_21_0)
	arg_21_0:PopCountUI(true)

	local var_21_0 = arg_21_0.countAnimator

	var_1.Play(var_21_0, "count")

	pg = var_1

	local var_21_1 = var_1.CriMgr.GetInstance()
	local var_21_2 = var_1.PlaySoundEffect_V3

	WatermelonGameConst = var_4

	var_21_2(var_21_1, var_4.SFX_COUNT_DOWN)

	return
end

function var_0_0.ClearUI(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_22_0.countUI, false)

	return
end

return var_0_0
