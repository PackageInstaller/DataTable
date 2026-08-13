class = var_0_10000

local var_0_0 = var_0_10000("SortGamePopUI")

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
	findTF = var_2

	local var_2_0 = var_2(arg_2_0.countUI, "count")

	typeof = var_3
	Animator = var_4
	arg_2_0.countAnimator = var_1(var_2_0, var_3(var_4))
	GetOrAddComponent = var_1
	findTF = var_2_0

	local var_2_1 = var_2_0(arg_2_0.countUI, "count")

	typeof = var_3
	DftAniEvent = var_4
	arg_2_0.countDft = var_1(var_2_1, var_3(var_4))

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

	setText = var_1
	findTF = var_5_0

	local var_5_1 = var_5_0(arg_5_0.leaveUI, "ad/btnConfirmDesc")

	i18n = var_3

	var_1(var_5_1, var_3("ryza_task_confirm"))

	setText = var_1
	findTF = var_5_1

	local var_5_2 = var_5_1(arg_5_0.leaveUI, "ad/btnCancelDesc")

	i18n = var_3

	var_1(var_5_2, var_3("ryza_task_cancel"))

	setActive = var_1

	var_1(arg_5_0.leaveUI, false)

	onButton = var_1

	local var_5_3 = arg_5_0._event

	findTF = var_3

	local var_5_4 = var_3(arg_5_0.leaveUI, "ad/btnConfirm")

	local function var_5_5()
		local var_6_0 = arg_5_0

		var_0.ResumeGame(var_6_0)

		local var_6_1 = arg_5_0._event
		local var_6_2 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_6_2(var_6_1, var_2_10002.LEVEL_GAME, true)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_5_3, var_5_4, var_5_5, var_5)

	onButton = var_1

	local var_5_6 = arg_5_0._event

	findTF = var_5_4

	local var_5_7 = var_5_4(arg_5_0.leaveUI, "ad/btnCancel")

	local function var_5_8()
		local var_7_0 = arg_5_0

		var_0.ResumeGame(var_7_0)

		local var_7_1 = arg_5_0._event
		local var_7_2 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_7_2(var_7_1, var_2_10002.LEVEL_GAME, false)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_5_6, var_5_7, var_5_8, var_5)

	return
end

function var_0_0.initPauseUI(arg_8_0)
	findTF = var_1_10001
	arg_8_0.pauseUI = var_1_10001(arg_8_0._tf, "pop/pauseUI")
	setActive = var_1

	var_1(arg_8_0.pauseUI, false)

	setText = var_1
	findTF = var_2

	local var_8_0 = var_2(arg_8_0.pauseUI, "ad/desc")

	i18n = var_3

	var_1(var_8_0, var_3("mini_game_pause"))

	setText = var_1
	findTF = var_8_0

	local var_8_1 = var_8_0(arg_8_0.pauseUI, "ad/btnDesc")

	i18n = var_3

	var_1(var_8_1, var_3("mini_game_continue"))

	onButton = var_1

	local var_8_2 = arg_8_0._event

	findTF = var_3

	local var_8_3 = var_3(arg_8_0.pauseUI, "ad/btnOk")

	local function var_8_4()
		local var_9_0 = arg_8_0

		var_0.ResumeGame(var_9_0)

		local var_9_1 = arg_8_0._event
		local var_9_2 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_9_2(var_9_1, var_2_10002.PAUSE_GAME, false)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_8_2, var_8_3, var_8_4, var_5)

	return
end

function var_0_0.initSettlementUI(arg_10_0)
	findTF = var_1_10001
	arg_10_0.settlementUI = var_1_10001(arg_10_0._tf, "pop/SettleMentUI")
	setText = var_1
	findTF = var_2

	local var_10_0 = var_2(arg_10_0.settlementUI, "ad/btnOver/text")

	i18n = var_3

	var_1(var_10_0, var_3("mini_game_over_game"))

	setText = var_1
	findTF = var_10_0

	local var_10_1 = var_10_0(arg_10_0.settlementUI, "ad/HighDesc")

	i18n = var_3

	var_1(var_10_1, var_3("mini_game_high_score"))

	setText = var_1
	findTF = var_10_1

	local var_10_2 = var_10_1(arg_10_0.settlementUI, "ad/CurDesc")

	i18n = var_3

	var_1(var_10_2, var_3("mini_game_cur_score"))

	setActive = var_1

	var_1(arg_10_0.settlementUI, false)

	onButton = var_1

	local var_10_3 = arg_10_0._event

	findTF = var_3

	local var_10_4 = var_3(arg_10_0.settlementUI, "ad/btnOver")

	local function var_10_5()
		local var_11_0 = arg_10_0

		var_0.ClearUI(var_11_0)

		local var_11_1 = arg_10_0._event
		local var_11_2 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_11_2(var_11_1, var_2_10002.BACK_MENU)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_10_3, var_10_4, var_10_5, var_5)

	return
end

function var_0_0.initRankUI(arg_12_0)
	findTF = var_1_10001
	arg_12_0.rankUI = var_1_10001(arg_12_0._tf, "pop/RankUI")

	arg_12_0:PopRankUI(false)

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

	local var_12_0 = arg_12_0._event

	findTF = var_3

	local var_12_1 = var_3(arg_12_0.rankUI, "ad/close")

	local function var_12_2()
		local var_13_0 = arg_12_0

		var_0.PopRankUI(var_13_0, false)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_12_0, var_12_1, var_12_2, var_5)

	onButton = var_1

	local var_12_3 = arg_12_0._event
	local var_12_4 = arg_12_0._rankBtnClose

	local function var_12_5()
		local var_14_0 = arg_12_0

		var_0.PopRankUI(var_14_0, false)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_12_3, var_12_4, var_12_5, var_5)

	return
end

function var_0_0.setChildVisible(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0 = 1, arg_15_1.childCount do
		local var_15_0 = arg_15_1
		local var_15_1 = arg_15_1.GetChild(var_15_0, iter_15_0 - 1)

		setActive = var_15_0

		var_15_0(var_15_1, arg_15_2)
	end

	return
end

function var_0_0.PopPauseUI(arg_16_0)
	isActive = var_1_10001

	if var_1_10001(arg_16_0.leaveUI) then
		setActive = var_1

		var_1(arg_16_0.leaveUI, false)
	end

	setActive = var_1

	var_1(arg_16_0.pauseUI, true)

	return
end

function var_0_0.PopCountUI(arg_17_0, arg_17_1)
	setActive = var_1_10002

	var_1_10002(arg_17_0.countUI, arg_17_1)

	return
end

function var_0_0.PopSettlementUI(arg_18_0, arg_18_1)
	setActive = var_1_10002

	var_1_10002(arg_18_0.settlementUI, arg_18_1)

	return
end

function var_0_0.PopRankUI(arg_19_0, arg_19_1)
	setActive = var_1_10002

	var_1_10002(arg_19_0.rankUI, arg_19_1)

	return
end

function var_0_0.PopLeaveUI(arg_20_0)
	isActive = var_1_10001

	if var_1_10001(arg_20_0.pauseUI) then
		setActive = var_1

		var_1(arg_20_0.pauseUI, false)
	end

	setActive = var_1

	var_1(arg_20_0.leaveUI, true)

	return
end

function var_0_0.UpdateRankData(arg_21_0, arg_21_1)
	for iter_21_0 = 1, #arg_21_1 do
		var_1_10006 = nil

		if #arg_21_0._rankItems < iter_21_0 then
			tf = var_7
			instantiate = var_1_10008

			local var_21_0 = var_7(var_1_10008(arg_21_0._rankItemTpl))

			setActive = var_1_10008

			var_1_10008(var_21_0, false)

			setParent = var_1_10008

			var_1_10008(var_21_0, arg_21_0._rankContent)

			table = var_1_10008

			var_1_10008.insert(arg_21_0._rankItems, var_21_0)
		end

		var_1_10006 = arg_21_0._rankItems[iter_21_0]
		var_1_10008 = arg_21_0

		arg_21_0.SetRankItemData(var_1_10008, var_1_10006, arg_21_1[iter_21_0], iter_21_0)

		setActive = var_7

		var_7(var_1_10006, true)
	end

	for iter_21_1 = #arg_21_1 + 1, #arg_21_0._rankItems do
		setActive = var_1_10006

		var_1_10006(arg_21_0._rankItems, false)
	end

	setActive = var_2

	var_2(arg_21_0._rankEmpty, #arg_21_1 == 0)

	setActive = var_2

	var_2(arg_21_0._rankImg, #arg_21_1 > 0)

	return
end

function var_0_0.SetRankItemData(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_2.name
	local var_22_1 = arg_22_2.player_id
	local var_22_2 = arg_22_2.position
	local var_22_3 = arg_22_2.score
	local var_22_4 = arg_22_2.time_data

	getProxy = var_1_10009
	PlayerProxy = var_1_10010

	local var_22_5 = var_1_10009(var_1_10010)
	local var_22_6 = var_9.isSelf(var_22_5, var_22_1)

	setText = var_22_5
	findTF = var_11

	var_22_5(var_11(arg_22_1, "nameText"), var_22_0)

	local var_22_7 = arg_22_0
	local var_22_8 = arg_22_0.setChildVisible

	findTF = var_12

	var_22_8(var_22_7, var_12(arg_22_1, "bg"), false)

	local var_22_9 = arg_22_0
	local var_22_10 = arg_22_0.setChildVisible

	findTF = var_12

	var_22_10(var_22_9, var_12(arg_22_1, "rank"), false)

	if arg_22_3 <= 3 then
		setActive = var_10
		findTF = var_22_9

		var_10(var_22_9(arg_22_1, "bg/" .. arg_22_3), true)

		setActive = var_10
		findTF = var_22_9

		var_10(var_22_9(arg_22_1, "rank/" .. arg_22_3), true)
	elseif var_22_6 then
		setActive = var_10
		findTF = var_22_9

		var_10(var_22_9(arg_22_1, "bg/me"), true)

		setActive = var_10
		findTF = var_22_9

		var_10(var_22_9(arg_22_1, "rank/count"), true)
	else
		setActive = var_10
		findTF = var_22_9

		var_10(var_22_9(arg_22_1, "bg/other"), true)

		setActive = var_10
		findTF = var_22_9

		var_10(var_22_9(arg_22_1, "rank/count"), true)
	end

	setText = var_10
	findTF = var_22_9

	local var_22_11 = var_22_9(arg_22_1, "rank/count")

	tostring = var_12

	var_10(var_22_11, var_12(arg_22_3))

	setText = var_10
	findTF = var_22_11

	local var_22_12 = var_22_11(arg_22_1, "score")

	tostring = var_12

	var_10(var_22_12, var_12(var_22_3))

	setActive = var_10
	findTF = var_22_12

	var_10(var_22_12(arg_22_1, "imgMy"), var_22_6)

	return
end

function var_0_0.UpdateSettlementUI(arg_23_0)
	GetComponent = var_1_10001
	findTF = var_1_10002

	local var_23_0 = var_1_10002(arg_23_0.settlementUI, "ad")

	typeof = var_3
	Animator = var_4

	local var_23_1 = var_1_10001(var_23_0, var_3(var_4))

	var_1.Play(var_23_1, "settlement", -1, 0)

	local var_23_2 = arg_23_0._gameVo
	local var_23_3 = var_2.GetScore(var_23_2)
	local var_23_4
	local var_23_5 = arg_23_0._gameVo
	local var_23_6 = var_4.GetConfig(var_23_5, "game_room")
	local var_23_7

	if 0 < var_23_6 then
		getProxy = var_23_6
		GameRoomProxy = var_23_7
		var_23_7 = var_23_6(var_23_7)
		var_23_6 = var_23_6.getRoomScore

		local var_23_8 = arg_23_0._gameVo

		var_23_4 = var_23_6(var_23_7, var_6.GetConfig(var_23_8, "game_room"))
	else
		getProxy = var_23_6
		MiniGameProxy = var_23_7
		var_23_7 = var_23_6(var_23_7)
		var_23_6 = var_23_6.GetHighScore

		local var_23_9 = arg_23_0._gameVo

		var_23_4 = var_23_6(var_23_7, var_6.GetGameId(var_23_9)) and #var_23_6 > 0 and var_23_6[1] or 0
	end

	setActive = var_23_6
	findTF = var_23_7

	var_23_6(var_23_7(arg_23_0.settlementUI, "ad/new"), var_23_4 < var_23_3)

	local var_23_10 = arg_23_0._event
	local var_23_11 = var_4.emit

	SimpleMGEvent = var_6

	var_23_11(var_23_10, var_6.STORE_SERVER, {
		var_23_3,
		1
	})

	findTF = var_23_11

	local var_23_12 = var_23_11(arg_23_0.settlementUI, "ad/highText")

	findTF = var_5

	local var_23_13 = var_5(arg_23_0.settlementUI, "ad/currentText")

	findTF = var_6

	local var_23_14 = var_6(arg_23_0.settlementUI, "ad/currentText_1")

	setText = var_7

	var_7(var_23_13, var_23_3)

	setText = var_7

	var_7(var_23_14, var_23_3)

	setText = var_7

	var_7(var_23_12, var_23_4)

	local var_23_15 = arg_23_0._event
	local var_23_16 = var_7.emit

	SimpleMGEvent = var_9

	var_23_16(var_23_15, var_9.SUBMIT_GAME_SUCCESS, var_23_3)

	return
end

function var_0_0.BackPressed(arg_24_0)
	isActive = var_1_10001

	local var_24_1

	if var_1_10001(arg_24_0.pauseUI) then
		arg_24_0:ResumeGame()

		local var_24_0 = arg_24_0._event

		var_24_1 = var_24_1.emit
		SimpleMGEvent = var_1_10003

		var_24_1(var_24_0, var_1_10003.PAUSE_GAME, false)
	else
		isActive = var_24_1

		local var_24_3

		if var_24_1(arg_24_0.leaveUI) then
			arg_24_0:ResumeGame()

			local var_24_2 = arg_24_0._event

			var_24_3 = var_24_3.emit
			SimpleMGEvent = var_1_10003

			var_24_3(var_24_2, var_1_10003.LEVEL_GAME, false)
		else
			isActive = var_24_3

			if not var_24_3(arg_24_0.pauseUI) then
				isActive = var_1

				if not var_1(arg_24_0.pauseUI) then
					local var_24_4 = arg_24_0._gameVo

					if not var_1.IsSettlement(var_24_4) then
						arg_24_0:PopPauseUI()

						local var_24_5 = arg_24_0._event
						local var_24_6 = var_1.emit

						SimpleMGEvent = var_1_10003

						var_24_6(var_24_5, var_1_10003.PAUSE_GAME, true)
					end

					goto label_24_0
				end
			end

			arg_24_0:ResumeGame()
		end
	end

	::label_24_0::

	return
end

function var_0_0.ResumeGame(arg_25_0)
	setActive = var_1_10001

	var_1_10001(arg_25_0.leaveUI, false)

	setActive = var_1_10001

	var_1_10001(arg_25_0.pauseUI, false)

	return
end

function var_0_0.UpdateGameUI(arg_26_0, arg_26_1)
	setText = var_1_10002

	var_1_10002(arg_26_0.scoreTf, arg_26_1.scoreNum)

	setText = var_1_10002

	local var_26_0 = arg_26_0.gameTimeS

	math = var_4

	var_1_10002(var_26_0, var_4.ceil(arg_26_1.gameTime))

	return
end

function var_0_0.ReadyStart(arg_27_0)
	arg_27_0:PopCountUI(true)

	local var_27_0 = arg_27_0.countAnimator

	var_1.Play(var_27_0, "count")

	pg = var_1

	local var_27_1 = var_1.CriMgr.GetInstance()
	local var_27_2 = var_1.PlaySoundEffect_V3

	SortGameConst = var_3

	var_27_2(var_27_1, var_3.SFX_COUNT_DOWN)

	return
end

function var_0_0.ClearUI(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_28_0.countUI, false)

	return
end

return var_0_0
