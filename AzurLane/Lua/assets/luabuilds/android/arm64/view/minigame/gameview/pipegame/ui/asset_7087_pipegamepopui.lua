class = var_0_10000

local var_0_0 = var_0_10000("PipeGamePopUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	PipeGameVo = var_1_10003
	var_0_1 = var_1_10003

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

		PipeGameEvent = var_2_10003

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

		PipeGameEvent = var_2_10003

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

		PipeGameEvent = var_2_10003

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

		PipeGameEvent = var_2_10003

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

		PipeGameEvent = var_2_10003

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

	arg_12_0.showRank(var_12_0, false)

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

		var_0.showRank(var_13_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_12_5, var_12_6, var_12_7, var_6)

	onButton = var_1

	local var_12_8 = arg_12_0._event
	local var_12_9 = arg_12_0._rankBtnClose

	local function var_12_10()
		local var_14_0 = arg_12_0

		var_0.showRank(var_14_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_12_8, var_12_9, var_12_10, var_6)

	setText = var_1

	local var_12_11 = arg_12_0._rankDesc

	i18n = var_12_9

	var_1(var_12_11, var_12_9(var_0_1.rank_tip))

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

	setText = var_10
	findTF = var_16_12

	local var_16_13 = var_16_12(arg_16_1, "time")

	tostring = var_13

	var_10(var_16_13, var_13(var_16_4))

	setActive = var_10
	findTF = var_16_13

	var_10(var_16_13(arg_16_1, "imgMy"), var_16_6)

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

function var_0_0.showRank(arg_18_0, arg_18_1)
	setActive = var_1_10002

	var_1_10002(arg_18_0.rankUI, arg_18_1)

	return
end

function var_0_0.updateSettlementUI(arg_19_0)
	GetComponent = var_1_10001
	findTF = var_1_10003

	local var_19_0 = var_1_10003(arg_19_0.settlementUI, "ad")

	typeof = var_1_10004
	Animator = var_6

	local var_19_1 = var_1_10001(var_19_0, var_1_10004(var_6))

	var_1.Play(var_19_1, "settlement", -1, 0)

	local var_19_2 = var_0_1.scoreNum

	math = var_19_0

	local var_19_3 = var_19_0.floor(var_0_1.gameDragTime)

	getProxy = var_19_1
	MiniGameProxy = var_6

	local var_19_4 = var_19_1(var_6)
	local var_19_5

	if not var_4.GetHighScore(var_19_4, var_0_1.game_id) or not (#var_4 > 0) or not var_4[1] then
		var_19_5 = 0
	end

	if var_4 then
		local var_19_6 = #var_4
		local var_19_7

		if not (1 < var_19_6) or not var_4[2] then
			var_19_7 = 0
		end

		setActive = var_7
		findTF = var_1_10009

		var_7(var_1_10009(arg_19_0.settlementUI, "ad/new"), var_19_5 < var_19_2)

		local var_19_9

		if 0 < var_19_2 and var_19_5 < var_19_2 then
			local var_19_8 = arg_19_0._event

			var_19_9 = var_19_9.emit
			PipeGameEvent = var_10

			var_19_9(var_19_8, var_10.STORE_SERVER, {
				var_19_2,
				var_19_3
			})
		elseif 0 < var_19_2 and var_19_2 == var_19_5 and var_19_7 < var_19_3 then
			local var_19_10 = arg_19_0._event

			var_19_9 = var_19_9.emit
			PipeGameEvent = var_10

			var_19_9(var_19_10, var_10.STORE_SERVER, {
				var_19_2,
				var_19_3
			})
		end

		findTF = var_19_9

		local var_19_11 = var_19_9(arg_19_0.settlementUI, "ad/highText")

		findTF = var_1_10008

		local var_19_12 = var_1_10008(arg_19_0.settlementUI, "ad/currentText")

		setText = var_9

		var_9(var_19_12, var_19_2)

		setText = var_9

		var_9(var_19_11, var_19_3)

		local var_19_13 = arg_19_0._event
		local var_19_14 = var_9.emit

		PipeGameEvent = var_12

		var_19_14(var_19_13, var_12.SUBMIT_GAME_SUCCESS)

		return
	end
end

function var_0_0.backPressed(arg_20_0)
	isActive = var_1_10001

	local var_20_1

	if var_1_10001(arg_20_0.pauseUI) then
		arg_20_0:resumeGame()

		local var_20_0 = arg_20_0._event

		var_20_1 = var_20_1.emit
		PipeGameEvent = var_1_10004

		var_20_1(var_20_0, var_1_10004.PAUSE_GAME, false)
	else
		isActive = var_20_1

		local var_20_3

		if var_20_1(arg_20_0.leaveUI) then
			arg_20_0:resumeGame()

			local var_20_2 = arg_20_0._event

			var_20_3 = var_20_3.emit
			PipeGameEvent = var_1_10004

			var_20_3(var_20_2, var_1_10004.LEVEL_GAME, false)
		else
			isActive = var_20_3

			if not var_20_3(arg_20_0.pauseUI) then
				isActive = var_1

				if not var_1(arg_20_0.pauseUI) then
					if not var_0_1.startSettlement then
						arg_20_0:popPauseUI()

						local var_20_4 = arg_20_0._event
						local var_20_5 = var_1.emit

						PipeGameEvent = var_1_10004

						var_20_5(var_20_4, var_1_10004.PAUSE_GAME, true)
					end

					goto label_20_0
				end
			end

			arg_20_0:resumeGame()
		end
	end

	::label_20_0::

	return
end

function var_0_0.resumeGame(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.leaveUI, false)

	setActive = var_1_10001

	var_1_10001(arg_21_0.pauseUI, false)

	return
end

function var_0_0.popLeaveUI(arg_22_0)
	isActive = var_1_10001

	if var_1_10001(arg_22_0.pauseUI) then
		setActive = var_1

		var_1(arg_22_0.pauseUI, false)
	end

	setActive = var_1

	var_1(arg_22_0.leaveUI, true)

	return
end

function var_0_0.popPauseUI(arg_23_0)
	isActive = var_1_10001

	if var_1_10001(arg_23_0.leaveUI) then
		setActive = var_1

		var_1(arg_23_0.leaveUI, false)
	end

	setActive = var_1

	var_1(arg_23_0.pauseUI, true)

	return
end

function var_0_0.updateGameUI(arg_24_0, arg_24_1)
	setText = var_1_10002

	var_1_10002(arg_24_0.scoreTf, arg_24_1.scoreNum)

	setText = var_1_10002

	local var_24_0 = arg_24_0.gameTimeS

	math = var_5

	var_1_10002(var_24_0, var_5.ceil(arg_24_1.gameTime))

	return
end

function var_0_0.readyStart(arg_25_0)
	arg_25_0:popCountUI(true)

	local var_25_0 = arg_25_0.countAnimator

	var_1.Play(var_25_0, "count")

	pg = var_1

	local var_25_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_25_1, var_0_1.SFX_COUNT_DOWN)

	return
end

function var_0_0.popCountUI(arg_26_0, arg_26_1)
	setActive = var_1_10002

	var_1_10002(arg_26_0.countUI, arg_26_1)

	return
end

function var_0_0.popSettlementUI(arg_27_0, arg_27_1)
	setActive = var_1_10002

	var_1_10002(arg_27_0.settlementUI, arg_27_1)

	return
end

function var_0_0.clearUI(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_28_0.countUI, false)

	return
end

return var_0_0
