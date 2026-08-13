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
	arg_1_0:initRankUI()

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

		WatermelonGameEvent = var_2_10003

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

		WatermelonGameEvent = var_2_10003

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

		WatermelonGameEvent = var_2_10003

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
	setActive = var_1

	var_1(arg_8_0.pauseUI, false)

	GetComponent = var_1
	findTF = var_3

	local var_8_0 = var_3(arg_8_0.pauseUI, "ad/desc")

	typeof = var_4
	Image = var_6

	local var_8_1 = var_1(var_8_0, var_4(var_6))

	var_1.SetNativeSize(var_8_1)

	onButton = var_1

	local var_8_2 = arg_8_0._event

	findTF = var_4

	local var_8_3 = var_4(arg_8_0.pauseUI, "ad/btnOk")

	local function var_8_4()
		local var_9_0 = arg_8_0

		var_0.resumeGame(var_9_0)

		local var_9_1 = arg_8_0._event
		local var_9_2 = var_0.emit

		WatermelonGameEvent = var_2_10003

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
	GetComponent = var_1
	findTF = var_3

	local var_10_0 = var_3(arg_10_0.settlementUI, "ad/HighImg")

	typeof = var_4
	Image = var_6

	local var_10_1 = var_1(var_10_0, var_4(var_6))

	var_1.SetNativeSize(var_10_1)

	GetComponent = var_1
	findTF = var_10_1

	local var_10_2 = var_10_1(arg_10_0.settlementUI, "ad/CurImg")

	typeof = var_4
	Image = var_6

	local var_10_3 = var_1(var_10_2, var_4(var_6))

	var_1.SetNativeSize(var_10_3)

	setActive = var_1

	var_1(arg_10_0.settlementUI, false)

	onButton = var_1

	local var_10_4 = arg_10_0._event

	findTF = var_4

	local var_10_5 = var_4(arg_10_0.settlementUI, "ad/btnOver")

	local function var_10_6()
		local var_11_0 = arg_10_0

		var_0.clearUI(var_11_0)

		local var_11_1 = arg_10_0._event
		local var_11_2 = var_0.emit

		WatermelonGameEvent = var_2_10003

		var_11_2(var_11_1, var_2_10003.BACK_MENU)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_10_4, var_10_5, var_10_6, var_6)

	return
end

function var_0_0.initRankUI(arg_12_0)
	findTF = var_1_10001
	arg_12_0.rankUI = var_1_10001(arg_12_0._tf, "pop/RankUI")

	local var_12_0 = arg_12_0

	arg_12_0.popRankUI(var_12_0, false)

	GetComponent = var_1
	findTF = var_12_0

	local var_12_1 = var_12_0(arg_12_0.rankUI, "ad/img/score")

	typeof = var_4
	Image = var_6

	local var_12_2 = var_1(var_12_1, var_4(var_6))

	var_1.SetNativeSize(var_12_2)

	GetComponent = var_1
	findTF = var_12_2

	local var_12_3 = var_12_2(arg_12_0.rankUI, "ad/img/time")

	typeof = var_4
	Image = var_6

	local var_12_4 = var_1(var_12_3, var_4(var_6))

	var_1.SetNativeSize(var_12_4)

	findTF = var_1
	arg_12_0._rankImg = var_1(arg_12_0.rankUI, "ad/img")
	findTF = var_1
	arg_12_0._rankBtnClose = var_1(arg_12_0.rankUI, "ad/btnClose")
	findTF = var_1
	arg_12_0._rankContent = var_1(arg_12_0.rankUI, "ad/list/content")
	findTF = var_1
	arg_12_0._rankItemTpl = var_1(arg_12_0.rankUI, "ad/list/content/itemTpl")
	findTF = var_1
	arg_12_0._rankEmpty = var_1(arg_12_0.rankUI, "ad/empty")
	findTF = var_1
	arg_12_0._rankDesc = var_1(arg_12_0.rankUI, "ad/desc")
	arg_12_0._rankItems = {}
	setActive = var_1

	var_1(arg_12_0._rankItemTpl, false)

	onButton = var_1

	local var_12_5 = arg_12_0._event

	findTF = var_4

	local var_12_6 = var_4(arg_12_0.rankUI, "ad/close")

	local function var_12_7()
		local var_13_0 = arg_12_0

		var_0.popRankUI(var_13_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_12_5, var_12_6, var_12_7, var_6)

	onButton = var_1

	local var_12_8 = arg_12_0._event
	local var_12_9 = arg_12_0._rankBtnClose

	local function var_12_10()
		local var_14_0 = arg_12_0

		var_0.popRankUI(var_14_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_12_8, var_12_9, var_12_10, var_6)

	setText = var_1

	local var_12_11 = arg_12_0._rankDesc

	i18n = var_12_9
	WatermelonGameConst = var_6

	var_1(var_12_11, var_12_9(var_6.rank_tip))

	return
end

function var_0_0.updateRankData(arg_15_0, arg_15_1)
	for iter_15_0 = 1, #arg_15_1 do
		var_1_10006 = nil

		if #arg_15_0._rankItems < iter_15_0 then
			tf = var_7
			instantiate = var_1_10009

			local var_15_0 = var_7(var_1_10009(arg_15_0._rankItemTpl))

			setActive = var_1_10008

			var_1_10008(var_15_0, false)

			setParent = var_1_10008

			var_1_10008(var_15_0, arg_15_0._rankContent)

			table = var_1_10008

			var_1_10008.insert(arg_15_0._rankItems, var_15_0)
		end

		var_1_10006 = arg_15_0._rankItems[iter_15_0]
		var_1_10009 = arg_15_0

		arg_15_0.setRankItemData(var_1_10009, var_1_10006, arg_15_1[iter_15_0], iter_15_0)

		setActive = var_7

		var_7(var_1_10006, true)
	end

	for iter_15_1 = #arg_15_1 + 1, #arg_15_0._rankItems do
		setActive = var_1_10006

		var_1_10006(arg_15_0._rankItems, false)
	end

	setActive = var_2

	var_2(arg_15_0._rankEmpty, #arg_15_1 == 0)

	setActive = var_2

	var_2(arg_15_0._rankImg, #arg_15_1 > 0)

	return
end

function var_0_0.setRankItemData(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_2.name
	local var_16_1 = arg_16_2.player_id
	local var_16_2 = arg_16_2.position
	local var_16_3 = arg_16_2.score
	local var_16_4 = arg_16_2.time_data

	getProxy = var_1_10009
	PlayerProxy = var_1_10011

	local var_16_5 = var_1_10009(var_1_10011)
	local var_16_6 = var_9.isSelf(var_16_5, var_16_1)

	setText = var_1_10010
	findTF = var_12

	var_1_10010(var_12(arg_16_1, "nameText"), var_16_0)

	local var_16_7 = arg_16_0
	local var_16_8 = arg_16_0.setChildVisible

	findTF = var_13

	var_16_8(var_16_7, var_13(arg_16_1, "bg"), false)

	local var_16_9 = arg_16_0
	local var_16_10 = arg_16_0.setChildVisible

	findTF = var_13

	var_16_10(var_16_9, var_13(arg_16_1, "rank"), false)

	if arg_16_3 <= 3 then
		setActive = var_10
		findTF = var_16_9

		var_10(var_16_9(arg_16_1, "bg/" .. arg_16_3), true)

		setActive = var_10
		findTF = var_16_9

		var_10(var_16_9(arg_16_1, "rank/" .. arg_16_3), true)
	elseif var_16_6 then
		setActive = var_10
		findTF = var_16_9

		var_10(var_16_9(arg_16_1, "bg/me"), true)

		setActive = var_10
		findTF = var_16_9

		var_10(var_16_9(arg_16_1, "rank/count"), true)
	else
		setActive = var_10
		findTF = var_16_9

		var_10(var_16_9(arg_16_1, "bg/other"), true)

		setActive = var_10
		findTF = var_16_9

		var_10(var_16_9(arg_16_1, "rank/count"), true)
	end

	setText = var_10
	findTF = var_16_9

	local var_16_11 = var_16_9(arg_16_1, "rank/count")

	tostring = var_13

	var_10(var_16_11, var_13(arg_16_3))

	setText = var_10
	findTF = var_16_11

	local var_16_12 = var_16_11(arg_16_1, "score")

	tostring = var_13

	var_10(var_16_12, var_13(var_16_3))

	setActive = var_10
	findTF = var_16_12

	var_10(var_16_12(arg_16_1, "imgMy"), var_16_6)

	return
end

function var_0_0.setChildVisible(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = 1, arg_17_1.childCount do
		local var_17_0 = arg_17_1:GetChild(iter_17_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_17_0, arg_17_2)
	end

	return
end

function var_0_0.initRankUI(arg_18_0)
	findTF = var_1_10001
	arg_18_0.rankUI = var_1_10001(arg_18_0._tf, "pop/RankUI")

	local var_18_0 = arg_18_0

	arg_18_0.showRank(var_18_0, false)

	GetComponent = var_1
	findTF = var_18_0

	local var_18_1 = var_18_0(arg_18_0.rankUI, "ad/img/score")

	typeof = var_4
	Image = var_6

	local var_18_2 = var_1(var_18_1, var_4(var_6))

	var_1.SetNativeSize(var_18_2)

	GetComponent = var_1
	findTF = var_18_2

	local var_18_3 = var_18_2(arg_18_0.rankUI, "ad/img/time")

	typeof = var_4
	Image = var_6

	local var_18_4 = var_1(var_18_3, var_4(var_6))

	var_1.SetNativeSize(var_18_4)

	findTF = var_1
	arg_18_0._rankImg = var_1(arg_18_0.rankUI, "ad/img")
	findTF = var_1
	arg_18_0._rankBtnClose = var_1(arg_18_0.rankUI, "ad/btnClose")
	findTF = var_1
	arg_18_0._rankContent = var_1(arg_18_0.rankUI, "ad/list/content")
	findTF = var_1
	arg_18_0._rankItemTpl = var_1(arg_18_0.rankUI, "ad/list/content/itemTpl")
	findTF = var_1
	arg_18_0._rankEmpty = var_1(arg_18_0.rankUI, "ad/empty")
	findTF = var_1
	arg_18_0._rankDesc = var_1(arg_18_0.rankUI, "ad/desc")
	arg_18_0._rankItems = {}
	setActive = var_1

	var_1(arg_18_0._rankItemTpl, false)

	onButton = var_1

	local var_18_5 = arg_18_0._event

	findTF = var_4

	local var_18_6 = var_4(arg_18_0.rankUI, "ad/close")

	local function var_18_7()
		local var_19_0 = arg_18_0

		var_0.showRank(var_19_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_18_5, var_18_6, var_18_7, var_6)

	onButton = var_1

	local var_18_8 = arg_18_0._event
	local var_18_9 = arg_18_0._rankBtnClose

	local function var_18_10()
		local var_20_0 = arg_18_0

		var_0.showRank(var_20_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_18_8, var_18_9, var_18_10, var_6)

	setText = var_1

	local var_18_11 = arg_18_0._rankDesc

	i18n = var_18_9
	WatermelonGameConst = var_6

	var_1(var_18_11, var_18_9(var_6.rank_tip))

	return
end

function var_0_0.showRank(arg_21_0, arg_21_1)
	setActive = var_1_10002

	var_1_10002(arg_21_0.rankUI, arg_21_1)

	return
end

function var_0_0.updateSettlementUI(arg_22_0)
	GetComponent = var_1_10001
	findTF = var_1_10003

	local var_22_0 = var_1_10003(arg_22_0.settlementUI, "ad")

	typeof = var_1_10004
	Animator = var_6

	local var_22_1 = var_1_10001(var_22_0, var_1_10004(var_6))

	var_1.Play(var_22_1, "settlement", -1, 0)

	local var_22_2 = arg_22_0._gameVo.scoreNum
	local var_22_3
	local var_22_4 = arg_22_0._gameVo.mgData
	local var_22_5 = var_4.getConfig(var_22_4, "game_room")

	if 0 < var_22_5 then
		getProxy = var_22_5
		GameRoomProxy = var_22_4
		var_22_4 = var_22_5(var_22_4)
		var_22_5 = var_22_5.getRoomScore

		local var_22_6 = arg_22_0._gameVo.mgData

		var_22_3 = var_22_5(var_22_4, var_7.getConfig(var_22_6, "game_room"))

		goto label_22_1
	end

	getProxy = var_22_5
	MiniGameProxy = var_22_4
	var_22_4 = var_22_5(var_22_4)

	if var_22_5.GetHighScore(var_22_4, arg_22_0._gameVo.gameId) then
		local var_22_7 = #var_22_5

		if not (0 < var_22_7) or not var_22_5[1] then
			::label_22_0::

			var_22_3 = 0
		end

		::label_22_1::

		setActive = var_22_5
		findTF = var_22_4

		var_22_5(var_22_4(arg_22_0.settlementUI, "ad/new"), var_22_3 < var_22_2)

		local var_22_9

		if 0 < var_22_2 and var_22_3 < var_22_2 then
			local var_22_8 = arg_22_0._event

			var_22_9 = var_22_9.emit
			WatermelonGameEvent = var_7

			var_22_9(var_22_8, var_7.STORE_SERVER, {
				var_22_2,
				1
			})
		end

		findTF = var_22_9

		local var_22_10 = var_22_9(arg_22_0.settlementUI, "ad/highText")

		findTF = var_22_7

		local var_22_11 = var_22_7(arg_22_0.settlementUI, "ad/currentText")

		setText = var_6

		var_6(var_22_11, var_22_2)

		setText = var_6

		var_6(var_22_10, var_22_3)

		local var_22_12 = arg_22_0._event
		local var_22_13 = var_6.emit

		WatermelonGameEvent = var_9

		var_22_13(var_22_12, var_9.SUBMIT_GAME_SUCCESS, var_22_2)

		return
	end
end

function var_0_0.backPressed(arg_23_0)
	isActive = var_1_10001

	local var_23_1

	if var_1_10001(arg_23_0.pauseUI) then
		arg_23_0:resumeGame()

		local var_23_0 = arg_23_0._event

		var_23_1 = var_23_1.emit
		WatermelonGameEvent = var_1_10004

		var_23_1(var_23_0, var_1_10004.PAUSE_GAME, false)
	else
		isActive = var_23_1

		local var_23_3

		if var_23_1(arg_23_0.leaveUI) then
			arg_23_0:resumeGame()

			local var_23_2 = arg_23_0._event

			var_23_3 = var_23_3.emit
			WatermelonGameEvent = var_1_10004

			var_23_3(var_23_2, var_1_10004.LEVEL_GAME, false)
		else
			isActive = var_23_3

			if not var_23_3(arg_23_0.pauseUI) then
				isActive = var_1

				if not var_1(arg_23_0.pauseUI) then
					if not arg_23_0._gameVo.startSettlement then
						arg_23_0:popPauseUI()

						local var_23_4 = arg_23_0._event
						local var_23_5 = var_1.emit

						WatermelonGameEvent = var_1_10004

						var_23_5(var_23_4, var_1_10004.PAUSE_GAME, true)
					end

					goto label_23_0
				end
			end

			arg_23_0:resumeGame()
		end
	end

	::label_23_0::

	return
end

function var_0_0.resumeGame(arg_24_0)
	setActive = var_1_10001

	var_1_10001(arg_24_0.leaveUI, false)

	setActive = var_1_10001

	var_1_10001(arg_24_0.pauseUI, false)

	return
end

function var_0_0.popLeaveUI(arg_25_0)
	isActive = var_1_10001

	if var_1_10001(arg_25_0.pauseUI) then
		setActive = var_1

		var_1(arg_25_0.pauseUI, false)
	end

	setActive = var_1

	var_1(arg_25_0.leaveUI, true)

	return
end

function var_0_0.popPauseUI(arg_26_0)
	isActive = var_1_10001

	if var_1_10001(arg_26_0.leaveUI) then
		setActive = var_1

		var_1(arg_26_0.leaveUI, false)
	end

	setActive = var_1

	var_1(arg_26_0.pauseUI, true)

	return
end

function var_0_0.updateGameUI(arg_27_0, arg_27_1)
	setText = var_1_10002

	var_1_10002(arg_27_0.scoreTf, arg_27_1.scoreNum)

	setText = var_1_10002

	local var_27_0 = arg_27_0.gameTimeS

	math = var_5

	var_1_10002(var_27_0, var_5.ceil(arg_27_1.gameTime))

	return
end

function var_0_0.readyStart(arg_28_0)
	arg_28_0:popCountUI(true)

	local var_28_0 = arg_28_0.countAnimator

	var_1.Play(var_28_0, "count")

	pg = var_1

	local var_28_1 = var_1.CriMgr.GetInstance()
	local var_28_2 = var_1.PlaySoundEffect_V3

	WatermelonGameConst = var_4

	var_28_2(var_28_1, var_4.SFX_COUNT_DOWN)

	return
end

function var_0_0.popCountUI(arg_29_0, arg_29_1)
	setActive = var_1_10002

	var_1_10002(arg_29_0.countUI, arg_29_1)

	return
end

function var_0_0.popSettlementUI(arg_30_0, arg_30_1)
	setActive = var_1_10002

	var_1_10002(arg_30_0.settlementUI, arg_30_1)

	return
end

function var_0_0.popRankUI(arg_31_0, arg_31_1)
	setActive = var_1_10002

	var_1_10002(arg_31_0.rankUI, arg_31_1)

	return
end

function var_0_0.clearUI(arg_32_0)
	setActive = var_1_10001

	var_1_10001(arg_32_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_32_0.countUI, false)

	return
end

return var_0_0
