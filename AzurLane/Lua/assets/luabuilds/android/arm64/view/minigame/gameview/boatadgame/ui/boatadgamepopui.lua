class = var_0_10000

local var_0_0 = var_0_10000("BoatAdGamePopUI")
local var_0_1
local var_0_2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initPauseUI()
	arg_1_0:initSettlementUI()
	arg_1_0:initAdWindow()

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
	GetComponent = var_1
	findTF = var_3

	local var_5_0 = var_3(arg_5_0.leaveUI, "ad/desc")

	typeof = var_4
	Image = var_6

	local var_5_1 = var_1(var_5_0, var_4(var_6))

	var_1.SetNativeSize(var_5_1)

	setActive = var_1

	var_1(arg_5_0.leaveUI, false)

	onButton = var_1

	local var_5_2 = arg_5_0._event

	findTF = var_4

	local var_5_3 = var_4(arg_5_0.leaveUI, "ad/btnOk")

	local function var_5_4()
		local var_6_0 = arg_5_0

		var_0.resumeGame(var_6_0)

		local var_6_1 = arg_5_0._event
		local var_6_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_6_2(var_6_1, var_2_10003.LEVEL_GAME, true)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_2, var_5_3, var_5_4, var_6)

	onButton = var_1

	local var_5_5 = arg_5_0._event

	findTF = var_5_3

	local var_5_6 = var_5_3(arg_5_0.leaveUI, "ad/btnCancel")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.resumeGame(var_7_0)

		local var_7_1 = arg_5_0._event
		local var_7_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_7_2(var_7_1, var_2_10003.LEVEL_GAME, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_5, var_5_6, var_5_7, var_6)

	return
end

function var_0_0.initPauseUI(arg_8_0)
	findTF = var_1_10001
	arg_8_0.pauseUI = var_1_10001(arg_8_0._tf, "pop/pauseUI")
	GetComponent = var_1
	findTF = var_3

	local var_8_0 = var_3(arg_8_0.pauseUI, "ad/desc")

	typeof = var_4
	Image = var_6

	local var_8_1 = var_1(var_8_0, var_4(var_6))

	var_1.SetNativeSize(var_8_1)

	setActive = var_1

	var_1(arg_8_0.pauseUI, false)

	onButton = var_1

	local var_8_2 = arg_8_0._event

	findTF = var_4

	local var_8_3 = var_4(arg_8_0.pauseUI, "ad/btnOk")

	local function var_8_4()
		local var_9_0 = arg_8_0

		var_0.resumeGame(var_9_0)

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

		SimpleMGEvent = var_2_10003

		var_11_2(var_11_1, var_2_10003.BACK_MENU)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_10_0, var_10_1, var_10_2, var_6)

	return
end

function var_0_0.initAdWindow(arg_12_0)
	findTF = var_1_10001
	arg_12_0.adUI = var_1_10001(arg_12_0._tf, "pop/AdUI")
	setActive = var_1

	var_1(arg_12_0.adUI, false)

	findTF = var_1
	arg_12_0.mvContent = var_1(arg_12_0.adUI, "ad/movie/view/content")
	findTF = var_1
	arg_12_0.btnPlay = var_1(arg_12_0.adUI, "ad/movie/btnPlay")
	findTF = var_1
	arg_12_0.btnStop = var_1(arg_12_0.adUI, "ad/movie/btnStop")
	findTF = var_1
	arg_12_0.btnRepeat = var_1(arg_12_0.adUI, "ad/movie/btnRepeat")
	setActive = var_1

	var_1(arg_12_0.btnRepeat, false)

	onButton = var_1

	local var_12_0 = arg_12_0._event

	findTF = var_4

	local var_12_1 = var_4(arg_12_0.adUI, "ad/bottom")

	local function var_12_2()
		if var_0_2 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_2 < 3 then
				return
			end
		end

		Time = var_0
		var_0_2 = var_0.realtimeSinceStartup

		if arg_12_0.isLoading then
			return
		end

		setActive = var_0

		var_0(arg_12_0.adUI, false)

		local var_13_0 = arg_12_0

		var_0.clearMovie(var_13_0)

		local var_13_1 = arg_12_0._event
		local var_13_2 = var_0.emit

		BoatAdGameEvent = var_3

		var_13_2(var_13_1, var_3.CLOSE_AD_UI)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_12_0, var_12_1, var_12_2, var_6)

	onButton = var_1

	local var_12_3 = arg_12_0._event

	findTF = var_12_1

	local var_12_4 = var_12_1(arg_12_0.adUI, "ad/bgClose")

	local function var_12_5()
		if var_0_2 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_2 < 3 then
				return
			end
		end

		Time = var_0
		var_0_2 = var_0.realtimeSinceStartup

		if arg_12_0.isLoading then
			return
		end

		setActive = var_0

		var_0(arg_12_0.adUI, false)

		local var_14_0 = arg_12_0

		var_0.clearMovie(var_14_0)

		local var_14_1 = arg_12_0._event
		local var_14_2 = var_0.emit

		BoatAdGameEvent = var_3

		var_14_2(var_14_1, var_3.CLOSE_AD_UI)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_12_3, var_12_4, var_12_5, var_6)

	onButton = var_1

	var_1(arg_12_0._event, arg_12_0.btnRepeat, function()
		if var_0_2 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_2 < 3 then
				return
			end
		end

		Time = var_0
		var_0_2 = var_0.realtimeSinceStartup

		if arg_12_0.mvManaCpkUI and arg_12_0.mvCompleteFlag then
			local var_15_0 = arg_12_0

			var_0.loadMv(var_15_0)
		end

		return
	end)

	return
end

function var_0_0.clearMovie(arg_16_0)
	if arg_16_0.mvGo then
		local var_16_0 = arg_16_0.mvManaCpkUI

		var_1.SetPlayEndHandler(var_16_0, nil)

		local var_16_1 = arg_16_0.mvManaCpkUI

		var_1.StopCpk(var_16_1)

		destroy = var_1

		var_1(arg_16_0.mvGo)

		arg_16_0.mvManaCpkUI = nil
		arg_16_0.mvGo = nil
		arg_16_0.mvName = nil
	end

	return
end

function var_0_0.loadMv(arg_17_0)
	arg_17_0:clearMovie()

	if arg_17_0.isLoading then
		return
	end

	local var_17_0 = "BoatAdMvUI"

	arg_17_0.isLoading = true
	arg_17_0.mvCompleteFlag = false
	setActive = var_2

	var_2(arg_17_0.btnPlay, false)

	setActive = var_2

	var_2(arg_17_0.btnStop, false)

	setActive = var_2

	var_2(arg_17_0.btnRepeat, false)

	PoolMgr = var_2

	local var_17_1 = var_2.GetInstance()

	var_2.GetUI(var_17_1, var_17_0, true, function(arg_18_0)
		arg_17_0.mvGo = arg_18_0
		arg_17_0.mvName = var_17_0

		local var_18_0 = arg_17_0

		GetComponent = var_2
		findTF = var_2_10004

		local var_18_1 = var_2_10004(arg_17_0.mvGo, "video/cpk")

		typeof = var_2_10005
		CriManaCpkUI = var_7
		var_18_0.mvManaCpkUI = var_2(var_18_1, var_2_10005(var_7))

		local var_18_2 = arg_17_0.mvManaCpkUI
		local var_18_3 = var_1.SetPlayEndHandler

		System = var_18_1

		var_18_3(var_18_2, var_18_1.Action(function()
			local var_19_0 = arg_17_0

			var_0.mvComplete(var_19_0)

			return
		end))

		local var_18_4 = arg_17_0.mvManaCpkUI

		var_1.PlayCpk(var_18_4)

		PlayerPrefs = var_1

		local var_18_5 = var_1.GetFloat
		local var_18_6 = "bgm_vol"

		DEFAULT_BGMVOLUME = var_4

		local var_18_7

		if not var_18_5(var_18_6, var_4) then
			var_18_7 = 1
		end

		local var_18_8 = arg_17_0.mvManaCpkUI.player

		var_2.SetVolume(var_18_8, var_18_7)

		if arg_17_0.isLoading == false then
			local var_18_9 = arg_17_0

			var_2.clearMovie(var_18_9)
		else
			local var_18_10 = arg_17_0

			var_18_10.isLoading = false
			setParent = var_18_10

			var_18_10(arg_17_0.mvGo, arg_17_0.mvContent)

			setActive = var_18_10

			var_18_10(arg_17_0.mvGo, true)
		end

		return
	end)

	return
end

function var_0_0.mvComplete(arg_20_0)
	arg_20_0.mvCompleteFlag = true

	arg_20_0:onPlayerEnd()

	return
end

function var_0_0.onPlayerEnd(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.btnPlay, false)

	setActive = var_1_10001

	var_1_10001(arg_21_0.btnStop, false)

	setActive = var_1_10001

	var_1_10001(arg_21_0.btnRepeat, true)

	return
end

function var_0_0.onPlayerStop(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.btnPlay, true)

	setActive = var_1_10001

	var_1_10001(arg_22_0.btnStop, false)

	setActive = var_1_10001

	var_1_10001(arg_22_0.btnRepeat, false)

	return
end

function var_0_0.onPlayerStart(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.btnPlay, false)

	setActive = var_1_10001

	var_1_10001(arg_23_0.btnStop, true)

	setActive = var_1_10001

	var_1_10001(arg_23_0.btnRepeat, false)

	return
end

function var_0_0.oepnAd(arg_24_0)
	setActive = var_1_10001

	var_1_10001(arg_24_0.adUI, true)

	Time = var_1_10001
	var_0_2 = var_1_10001.realtimeSinceStartup

	arg_24_0:loadMv()

	return
end

function var_0_0.updateSettlementUI(arg_25_0)
	GetComponent = var_1_10001
	findTF = var_1_10003

	local var_25_0 = var_1_10003(arg_25_0.settlementUI, "ad")

	typeof = var_1_10004
	Animator = var_6

	local var_25_1 = var_1_10001(var_25_0, var_1_10004(var_6))

	var_1.Play(var_25_1, "settlement", -1, 0)

	local var_25_2 = var_0_1.scoreNum
	local var_25_3
	local var_25_4 = var_0_1.GetMiniGameData()
	local var_25_5 = var_4.getConfig(var_25_4, "game_room")

	if 0 < var_25_5 then
		getProxy = var_25_5
		GameRoomProxy = var_25_4
		var_25_4 = var_25_5(var_25_4)
		var_25_5 = var_25_5.getRoomScore

		local var_25_6 = var_0_1.GetMiniGameData()

		var_25_3 = var_25_5(var_25_4, var_7.getConfig(var_25_6, "game_room"))

		goto label_25_1
	end

	var_25_4 = var_0_1.GetMiniGameData()

	if var_25_5.GetRuntimeData(var_25_4, "elements") then
		local var_25_7 = #var_25_5

		if not (0 < var_25_7) or not var_25_5[1] then
			::label_25_0::

			var_25_3 = 0
		end

		::label_25_1::

		setActive = var_25_5
		findTF = var_25_4

		var_25_5(var_25_4(arg_25_0.settlementUI, "ad/new"), var_25_3 < var_25_2)

		if var_25_3 < var_25_2 then
			var_25_3 = var_25_2

			local var_25_8 = arg_25_0._event

			var_25_5 = var_25_5.emit
			SimpleMGEvent = var_7

			var_25_5(var_25_8, var_7.STORE_SERVER, var_25_3)
		end

		findTF = var_25_5

		local var_25_9 = var_25_5(arg_25_0.settlementUI, "ad/highText")

		findTF = var_25_7

		local var_25_10 = var_25_7(arg_25_0.settlementUI, "ad/currentText")

		setText = var_6

		var_6(var_25_9, var_25_3)

		setText = var_6

		var_6(var_25_10, var_25_2)

		local var_25_11 = arg_25_0._event
		local var_25_12 = var_6.emit

		SimpleMGEvent = var_9

		var_25_12(var_25_11, var_9.SUBMIT_GAME_SUCCESS, var_25_2)

		return
	end
end

function var_0_0.backPressed(arg_26_0)
	isActive = var_1_10001

	local var_26_1

	if var_1_10001(arg_26_0.pauseUI) then
		arg_26_0:resumeGame()

		local var_26_0 = arg_26_0._event

		var_26_1 = var_26_1.emit
		SimpleMGEvent = var_1_10004

		var_26_1(var_26_0, var_1_10004.PAUSE_GAME, false)
	else
		isActive = var_26_1

		local var_26_3

		if var_26_1(arg_26_0.leaveUI) then
			arg_26_0:resumeGame()

			local var_26_2 = arg_26_0._event

			var_26_3 = var_26_3.emit
			SimpleMGEvent = var_1_10004

			var_26_3(var_26_2, var_1_10004.LEVEL_GAME, false)
		else
			isActive = var_26_3

			if not var_26_3(arg_26_0.pauseUI) then
				isActive = var_1

				if not var_1(arg_26_0.pauseUI) then
					arg_26_0:popPauseUI()

					local var_26_4 = arg_26_0._event
					local var_26_5 = var_1.emit

					SimpleMGEvent = var_1_10004

					var_26_5(var_26_4, var_1_10004.PAUSE_GAME, true)

					goto label_26_0
				end
			end

			arg_26_0:resumeGame()
		end
	end

	::label_26_0::

	return
end

function var_0_0.resumeGame(arg_27_0)
	setActive = var_1_10001

	var_1_10001(arg_27_0.leaveUI, false)

	setActive = var_1_10001

	var_1_10001(arg_27_0.pauseUI, false)

	return
end

function var_0_0.popLeaveUI(arg_28_0)
	isActive = var_1_10001

	if var_1_10001(arg_28_0.pauseUI) then
		setActive = var_1

		var_1(arg_28_0.pauseUI, false)
	end

	setActive = var_1

	var_1(arg_28_0.leaveUI, true)

	return
end

function var_0_0.popPauseUI(arg_29_0)
	isActive = var_1_10001

	if var_1_10001(arg_29_0.leaveUI) then
		setActive = var_1

		var_1(arg_29_0.leaveUI, false)
	end

	setActive = var_1

	var_1(arg_29_0.pauseUI, true)

	return
end

function var_0_0.updateGameUI(arg_30_0, arg_30_1)
	setText = var_1_10002

	var_1_10002(arg_30_0.scoreTf, arg_30_1.scoreNum)

	setText = var_1_10002

	local var_30_0 = arg_30_0.gameTimeS

	math = var_5

	var_1_10002(var_30_0, var_5.ceil(arg_30_1.gameTime))

	return
end

function var_0_0.readyStart(arg_31_0)
	arg_31_0:popCountUI(true)

	local var_31_0 = arg_31_0.countAnimator

	var_1.Play(var_31_0, "count")

	pg = var_1

	local var_31_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_31_1, var_0_1.SFX_COUNT_DOWN)

	return
end

function var_0_0.popCountUI(arg_32_0, arg_32_1)
	setActive = var_1_10002

	var_1_10002(arg_32_0.countUI, arg_32_1)

	return
end

function var_0_0.popSettlementUI(arg_33_0, arg_33_1)
	setActive = var_1_10002

	var_1_10002(arg_33_0.settlementUI, arg_33_1)

	return
end

function var_0_0.clearUI(arg_34_0)
	setActive = var_1_10001

	var_1_10001(arg_34_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_34_0.countUI, false)

	return
end

return var_0_0
