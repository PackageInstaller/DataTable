class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGamePopUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initPauseUI()
	arg_1_0:initSettlementUI()
	arg_1_0:initSelectUI()

	return
end

function var_0_0.initSelectUI(arg_2_0)
	local function var_2_0(arg_3_0)
		if arg_2_0.selectChar and arg_2_0.selectChar == arg_3_0 then
			return
		end

		table = var_1

		if var_1.contains(arg_2_0.selectNpc, arg_3_0) then
			return
		end

		if arg_2_0.selectChar and arg_2_0.selectChar > 0 then
			setActive = var_1
			findTF = var_3

			var_1(var_3(arg_2_0.selectGridList[arg_2_0.selectChar], "ad/use"), false)
		end

		if 0 < arg_3_0 then
			setActive = var_1
			findTF = var_3

			var_1(var_3(arg_2_0.selectGridList[arg_3_0], "ad/use"), true)
		end

		GetSpriteFromAtlasAsync = var_1
		CutFruitGameConst = var_3

		var_1(var_3.ui_atlas, "char_" .. arg_3_0, function(arg_4_0)
			setImageSprite = var_3_10001

			var_3_10001(arg_2_0.selectCharTF, arg_4_0, true)

			return
		end)

		arg_2_0.selectChar = arg_3_0

		return
	end

	findTF = var_1_10002
	arg_2_0.selectUI = var_1_10002(arg_2_0._tf, "pop/SelectUI")
	findTF = var_2

	local var_2_1 = var_2(arg_2_0.selectUI, "ad/select_list/grid_tpl")

	setActive = var_1_10003

	var_1_10003(var_2_1, false)

	findTF = var_1_10003

	local var_2_2 = var_1_10003(arg_2_0.selectUI, "ad/select_list")

	arg_2_0.selectGridList = {}

	local var_2_3 = 1

	CutFruitGameConst = var_5

	for iter_2_0 = var_2_3, var_5.character_num do
		local var_2_4 = iter_2_0

		tf = var_1_10009
		instantiate = var_1_10011
		var_1_10009 = var_1_10009(var_1_10011(var_2_1))
		setActive = var_1_10010

		var_1_10010(var_1_10009, true)

		SetParent = var_1_10010

		var_1_10010(var_1_10009, var_2_2)

		onButton = var_1_10010

		local var_2_5 = arg_2_0._event
		local var_2_6 = var_1_10009

		local function var_2_7()
			var_2_0(var_2_4)

			return
		end

		SFX_CONFIRM = var_1_10015

		var_1_10010(var_2_5, var_2_6, var_2_7, var_1_10015)

		GetSpriteFromAtlasAsync = var_1_10010
		CutFruitGameConst = var_2_5

		var_1_10010(var_2_5.ui_atlas, "char_grid_" .. var_2_4, function(arg_6_0)
			setImageSprite = var_2_10001
			findTF = var_2_10003

			var_2_10001(var_2_10003(var_1_10009, "ad/char"), arg_6_0, true)

			return
		end)

		table = var_1_10010

		var_1_10010.insert(arg_2_0.selectGridList, var_1_10009)
	end

	findTF = var_2_3
	arg_2_0.selectCharTF = var_2_3(arg_2_0.selectUI, "ad/char")
	findTF = var_4
	arg_2_0.selectStartTF = var_4(arg_2_0.selectUI, "ad/start")
	findTF = var_4
	arg_2_0.selectCloseTF = var_4(arg_2_0.selectUI, "ad/close")
	onButton = var_4

	local var_2_8 = arg_2_0._event
	local var_2_9 = arg_2_0.selectStartTF

	local function var_2_10()
		local var_7_0 = arg_2_0._event
		local var_7_1 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_7_1(var_7_0, var_2_10003.READY_START, {
			char = arg_2_0.selectChar,
			npc = arg_2_0.selectNpc
		})

		local var_7_2 = arg_2_0

		var_0.PopSelectUI(var_7_2, false)

		return
	end

	SFX_CONFIRM = var_1_10009

	var_4(var_2_8, var_2_9, var_2_10, var_1_10009)

	onButton = var_4

	local var_2_11 = arg_2_0._event
	local var_2_12 = arg_2_0.selectCloseTF

	local function var_2_13()
		local var_8_0 = arg_2_0._event
		local var_8_1 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_8_1(var_8_0, var_2_10003.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_1_10009

	var_4(var_2_11, var_2_12, var_2_13, var_1_10009)

	CutFruitGameConst = var_4

	local var_2_14 = var_4.chapter_data
	local var_2_15 = arg_2_0._gameVo
	local var_2_16

	if var_2_14[var_5.GetGameRound(var_2_15)].char == 0 or not var_4.char then
		math = var_2_16
		var_2_16 = var_2_16.random

		local var_2_17 = 1

		CutFruitGameConst = var_2_13
		var_2_16 = var_2_16(var_2_17, var_2_13.character_num)
	end

	arg_2_0.selectChar = var_2_16

	local var_2_18

	if not (#var_4.npc > 0) or not var_4.npc then
		var_2_18 = arg_2_0:GetNpcRandom(arg_2_0.selectChar)
	end

	arg_2_0.selectNpc = var_2_18

	arg_2_0:updateSelectUI()

	return
end

function var_0_0.updateSelectUI(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.selectGridList do
		local var_9_0 = arg_9_0.selectGridList[iter_9_0]
		local var_9_1 = iter_9_0

		if arg_9_0.selectChar and arg_9_0.selectChar == var_9_1 then
			setActive = var_7
			findTF = var_1_10009

			var_7(var_1_10009(var_9_0, "ad/use"), true)

			GetSpriteFromAtlasAsync = var_7
			CutFruitGameConst = var_1_10009

			var_7(var_1_10009.ui_atlas, "char_" .. var_9_1, function(arg_10_0)
				setImageSprite = var_2_10001

				var_2_10001(arg_9_0.selectCharTF, arg_10_0, true)

				return
			end)
		else
			setActive = var_7
			findTF = var_1_10009

			var_7(var_1_10009(var_9_0, "ad/use"), false)
		end

		table = var_7

		if var_7.contains(arg_9_0.selectNpc, var_9_1) then
			setActive = var_7
			findTF = var_1_10009

			var_7(var_1_10009(var_9_0, "ad/npc"), true)
		else
			setActive = var_7
			findTF = var_1_10009

			var_7(var_1_10009(var_9_0, "ad/npc"), false)
		end
	end

	return
end

function var_0_0.GetNpcRandom(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = 1

	CutFruitGameConst = var_1_10005

	for iter_11_0 = var_11_2, var_1_10005.character_num do
		if iter_11_0 ~= arg_11_1 then
			table = var_1_10008

			var_1_10008.insert(var_11_1, iter_11_0)
		end
	end

	for iter_11_1 = 1, 2 do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_11_3 = var_11_0

		table = var_1_10011
		var_1_10011 = var_1_10011.remove

		local var_11_4 = var_11_1

		math = var_1_10014

		var_1_10008(var_11_3, var_1_10011(var_11_4, var_1_10014.random(1, #var_11_1)))
	end

	return var_11_0
end

function var_0_0.initCountUI(arg_12_0)
	findTF = var_1_10001
	arg_12_0.countUI = var_1_10001(arg_12_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_12_0 = var_3(arg_12_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_12_0.countAnimator = var_1(var_12_0, var_4(var_6))
	GetOrAddComponent = var_1
	findTF = var_12_0

	local var_12_1 = var_12_0(arg_12_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_12_0.countDft = var_1(var_12_1, var_4(var_6))

	local var_12_2 = arg_12_0.countDft

	var_1.SetTriggerEvent(var_12_2, function()
		return
	end)

	local var_12_3 = arg_12_0.countDft

	var_1.SetEndEvent(var_12_3, function()
		local var_14_0 = arg_12_0._event
		local var_14_1 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_14_1(var_14_0, var_2_10003.COUNT_DOWN)

		return
	end)

	return
end

function var_0_0.initLeavelUI(arg_15_0)
	findTF = var_1_10001
	arg_15_0.leaveUI = var_1_10001(arg_15_0._tf, "pop/LeaveUI")
	setActive = var_1

	var_1(arg_15_0.leaveUI, false)

	onButton = var_1

	local var_15_0 = arg_15_0._event

	findTF = var_4

	local var_15_1 = var_4(arg_15_0.leaveUI, "ad/btnConfirm")

	local function var_15_2()
		local var_16_0 = arg_15_0

		var_0.ResumeGame(var_16_0)

		local var_16_1 = arg_15_0._event
		local var_16_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_16_2(var_16_1, var_2_10003.LEVEL_GAME, true)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_15_0, var_15_1, var_15_2, var_6)

	onButton = var_1

	local var_15_3 = arg_15_0._event

	findTF = var_15_1

	local var_15_4 = var_15_1(arg_15_0.leaveUI, "ad/btnCancel")

	local function var_15_5()
		local var_17_0 = arg_15_0

		var_0.ResumeGame(var_17_0)

		local var_17_1 = arg_15_0._event
		local var_17_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_17_2(var_17_1, var_2_10003.LEVEL_GAME, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_15_3, var_15_4, var_15_5, var_6)

	return
end

function var_0_0.initPauseUI(arg_18_0)
	findTF = var_1_10001
	arg_18_0.pauseUI = var_1_10001(arg_18_0._tf, "pop/pauseUI")
	setActive = var_1

	var_1(arg_18_0.pauseUI, false)

	onButton = var_1

	local var_18_0 = arg_18_0._event

	findTF = var_4

	local var_18_1 = var_4(arg_18_0.pauseUI, "ad/btnOk")

	local function var_18_2()
		local var_19_0 = arg_18_0

		var_0.ResumeGame(var_19_0)

		local var_19_1 = arg_18_0._event
		local var_19_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_19_2(var_19_1, var_2_10003.PAUSE_GAME, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_18_0, var_18_1, var_18_2, var_6)

	return
end

function var_0_0.initSettlementUI(arg_20_0)
	findTF = var_1_10001
	arg_20_0.settlementUI = var_1_10001(arg_20_0._tf, "pop/SettleMentUI")
	setActive = var_1

	var_1(arg_20_0.settlementUI, false)

	onButton = var_1

	local var_20_0 = arg_20_0._event

	findTF = var_4

	local var_20_1 = var_4(arg_20_0.settlementUI, "ad/btnOver")

	local function var_20_2()
		local var_21_0 = arg_20_0

		var_0.ClearUI(var_21_0)

		local var_21_1 = arg_20_0._event
		local var_21_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_21_2(var_21_1, var_2_10003.BACK_MENU)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_20_0, var_20_1, var_20_2, var_6)

	onButton = var_1

	local var_20_3 = arg_20_0._event

	findTF = var_20_1

	local var_20_4 = var_20_1(arg_20_0.settlementUI, "ad/btnAgain")

	local function var_20_5()
		local var_22_0 = arg_20_0

		var_0.ClearUI(var_22_0)

		local var_22_1 = arg_20_0._event
		local var_22_2 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_22_2(var_22_1, var_2_10003.BACK_MENU, {
			restart = true
		})

		return
	end

	SFX_CANCEL = var_6

	var_1(var_20_3, var_20_4, var_20_5, var_6)

	return
end

function var_0_0.setChildVisible(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0 = 1, arg_23_1.childCount do
		local var_23_0 = arg_23_1:GetChild(iter_23_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_23_0, arg_23_2)
	end

	return
end

function var_0_0.PopSelectUI(arg_24_0, arg_24_1)
	setActive = var_1_10002

	var_1_10002(arg_24_0.selectUI, arg_24_1)

	return
end

function var_0_0.PopPauseUI(arg_25_0)
	isActive = var_1_10001

	if var_1_10001(arg_25_0.leaveUI) then
		setActive = var_1

		var_1(arg_25_0.leaveUI, false)
	end

	setActive = var_1

	var_1(arg_25_0.pauseUI, true)

	return
end

function var_0_0.PopCountUI(arg_26_0, arg_26_1)
	setActive = var_1_10002

	var_1_10002(arg_26_0.countUI, arg_26_1)

	return
end

function var_0_0.PopSettlementUI(arg_27_0, arg_27_1)
	setActive = var_1_10002

	var_1_10002(arg_27_0.settlementUI, arg_27_1)

	return
end

function var_0_0.PopLeaveUI(arg_28_0)
	isActive = var_1_10001

	if var_1_10001(arg_28_0.pauseUI) then
		setActive = var_1

		var_1(arg_28_0.pauseUI, false)
	end

	setActive = var_1

	var_1(arg_28_0.leaveUI, true)

	return
end

function var_0_0.UpdateSettlementUI(arg_29_0)
	local var_29_0 = arg_29_0._gameVo
	local var_29_1 = var_1.GetStepTimeInteger(var_29_0)
	local var_29_2 = arg_29_0._gameVo

	if var_2.GetSuccess(var_29_2) then
		setActive = var_29_0
		findTF = var_1_10005

		var_29_0(var_1_10005(arg_29_0.settlementUI, "ad/1"), true)

		setActive = var_29_0
		findTF = var_1_10005

		var_29_0(var_1_10005(arg_29_0.settlementUI, "ad/2"), false)

		setActive = var_29_0
		findTF = var_1_10005

		var_29_0(var_1_10005(arg_29_0.settlementUI, "ad/currentText"), true)
	else
		setActive = var_29_0
		findTF = var_1_10005

		var_29_0(var_1_10005(arg_29_0.settlementUI, "ad/1"), false)

		setActive = var_29_0
		findTF = var_5

		var_29_0(var_5(arg_29_0.settlementUI, "ad/2"), true)

		setActive = var_29_0
		findTF = var_5

		var_29_0(var_5(arg_29_0.settlementUI, "ad/currentText"), false)
	end

	findTF = var_29_0

	local var_29_3 = var_29_0(arg_29_0.settlementUI, "ad/currentText")

	if var_29_1 < 0 then
		var_29_1 = ""
	end

	setText = var_4

	var_4(var_29_3, var_29_1)

	local var_29_4 = arg_29_0._event
	local var_29_5 = var_4.emit

	SimpleMGEvent = var_7

	var_29_5(var_29_4, var_7.SUBMIT_GAME_SUCCESS, var_29_1)

	return
end

function var_0_0.BackPressed(arg_30_0)
	isActive = var_1_10001

	local var_30_1

	if var_1_10001(arg_30_0.pauseUI) then
		arg_30_0:ResumeGame()

		local var_30_0 = arg_30_0._event

		var_30_1 = var_30_1.emit
		SimpleMGEvent = var_1_10004

		var_30_1(var_30_0, var_1_10004.PAUSE_GAME, false)
	else
		isActive = var_30_1

		local var_30_3

		if var_30_1(arg_30_0.leaveUI) then
			arg_30_0:ResumeGame()

			local var_30_2 = arg_30_0._event

			var_30_3 = var_30_3.emit
			SimpleMGEvent = var_1_10004

			var_30_3(var_30_2, var_1_10004.LEVEL_GAME, false)
		else
			isActive = var_30_3

			if not var_30_3(arg_30_0.pauseUI) then
				isActive = var_1

				if not var_1(arg_30_0.pauseUI) then
					local var_30_4 = arg_30_0._gameVo

					if not var_1.IsSettlement(var_30_4) then
						arg_30_0:PopPauseUI()

						local var_30_5 = arg_30_0._event
						local var_30_6 = var_1.emit

						SimpleMGEvent = var_1_10004

						var_30_6(var_30_5, var_1_10004.PAUSE_GAME, true)
					end

					goto label_30_0
				end
			end

			arg_30_0:ResumeGame()
		end
	end

	::label_30_0::

	return
end

function var_0_0.ResumeGame(arg_31_0)
	setActive = var_1_10001

	var_1_10001(arg_31_0.leaveUI, false)

	setActive = var_1_10001

	var_1_10001(arg_31_0.pauseUI, false)

	return
end

function var_0_0.UpdateGameUI(arg_32_0, arg_32_1)
	setText = var_1_10002

	var_1_10002(arg_32_0.scoreTf, arg_32_1.scoreNum)

	setText = var_1_10002

	local var_32_0 = arg_32_0.gameTimeS

	math = var_5

	var_1_10002(var_32_0, var_5.ceil(arg_32_1.gameTime))

	return
end

function var_0_0.ReadyStart(arg_33_0)
	arg_33_0:PopCountUI(true)

	local var_33_0 = arg_33_0.countAnimator

	var_1.Play(var_33_0, "count")

	pg = var_1

	local var_33_1 = var_1.CriMgr.GetInstance()
	local var_33_2 = var_1.PlaySoundEffect_V3

	CutFruitGameConst = var_4

	var_33_2(var_33_1, var_4.SFX_COUNT_DOWN)

	return
end

function var_0_0.ClearUI(arg_34_0)
	setActive = var_1_10001

	var_1_10001(arg_34_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_34_0.countUI, false)

	return
end

return var_0_0
