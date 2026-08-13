class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	findTF = var_1_10001
	arg_2_0._gameUI = var_1_10001(arg_2_0._tf, "ui/gamingUI")
	findTF = var_1
	arg_2_0.btnBack = var_1(arg_2_0._gameUI, "back")
	findTF = var_1
	arg_2_0.btnPause = var_1(arg_2_0._gameUI, "pause")
	findTF = var_1
	arg_2_0.timeTF = var_1(arg_2_0._gameUI, "top/ad/time")
	onButton = var_1

	local var_2_0 = arg_2_0._event
	local var_2_1 = arg_2_0.btnBack

	local function var_2_2()
		if not arg_2_0._gameVo.startSettlement then
			local var_3_0 = arg_2_0._event
			local var_3_1 = var_0.emit

			SimpleMGEvent = var_2_10002

			var_3_1(var_3_0, var_2_10002.PAUSE_GAME, true)

			local var_3_2 = arg_2_0._event
			local var_3_3 = var_0.emit

			SimpleMGEvent = var_2

			var_3_3(var_3_2, var_2.OPEN_LEVEL_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1

	local var_2_3 = arg_2_0._event
	local var_2_4 = arg_2_0.btnPause

	local function var_2_5()
		if not arg_2_0._gameVo.startSettlement then
			local var_4_0 = arg_2_0._event
			local var_4_1 = var_0.emit

			SimpleMGEvent = var_2_10002

			var_4_1(var_4_0, var_2_10002.PAUSE_GAME, true)

			local var_4_2 = arg_2_0._event
			local var_4_3 = var_0.emit

			SimpleMGEvent = var_2

			var_4_3(var_4_2, var_2.OPEN_PAUSE_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_3, var_2_4, var_2_5, var_1_10005)

	findTF = var_1
	arg_2_0.btnUp = var_1(arg_2_0._gameUI, "up")
	findTF = var_1
	arg_2_0.btnDown = var_1(arg_2_0._gameUI, "down")
	findTF = var_1
	arg_2_0.btnLeft = var_1(arg_2_0._gameUI, "left")
	findTF = var_1
	arg_2_0.btnRight = var_1(arg_2_0._gameUI, "right")
	onButton = var_1

	var_1(arg_2_0._event, arg_2_0.btnUp, function()
		local var_5_0 = arg_2_0._event
		local var_5_1 = var_0.emit

		CutFruitGameView = var_2_10002

		local var_5_2 = var_2_10002.EVENT_DIRECT

		CutFruitGameConst = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.DIRECT_UP)

		return
	end)

	onButton = var_1

	var_1(arg_2_0._event, arg_2_0.btnDown, function()
		local var_6_0 = arg_2_0._event
		local var_6_1 = var_0.emit

		CutFruitGameView = var_2_10002

		local var_6_2 = var_2_10002.EVENT_DIRECT

		CutFruitGameConst = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.DIRECT_DOWN)

		return
	end)

	onButton = var_1

	var_1(arg_2_0._event, arg_2_0.btnLeft, function()
		local var_7_0 = arg_2_0._event
		local var_7_1 = var_0.emit

		CutFruitGameView = var_2_10002

		local var_7_2 = var_2_10002.EVENT_DIRECT

		CutFruitGameConst = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.DIRECT_LEFT)

		return
	end)

	onButton = var_1

	var_1(arg_2_0._event, arg_2_0.btnRight, function()
		local var_8_0 = arg_2_0._event
		local var_8_1 = var_0.emit

		CutFruitGameView = var_2_10002

		local var_8_2 = var_2_10002.EVENT_DIRECT

		CutFruitGameConst = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.DIRECT_RIGHT)

		return
	end)

	return
end

function var_0_0.Show(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0._gameUI, arg_9_1)

	return
end

function var_0_0.Update(arg_10_0)
	return
end

function var_0_0.Start(arg_11_0)
	arg_11_0.subGameStepTime = 0

	arg_11_0:Show(true)

	local var_11_0 = arg_11_0._gameVo

	arg_11_0._editorFlag = var_1.GetEditor(var_11_0)
	getProxy = var_1
	MiniGameProxy = var_11_0

	local var_11_1 = var_1(var_11_0)
	local var_11_2 = var_1.GetHighScore
	local var_11_3 = arg_11_0._gameVo

	if not var_11_2(var_11_1, var_3.GetGameId(var_11_3)) or not (#var_1 > 0) or not var_1[1] then
		local var_11_4 = 0
	end

	arg_11_0._score = 0
	arg_11_0._time = -1

	return
end

function var_0_0.Step(arg_12_0)
	local var_12_0 = arg_12_0._time
	local var_12_1 = arg_12_0._gameVo

	if var_12_0 ~= var_2.GetTimeInteger(var_12_1) then
		local var_12_2 = arg_12_0._gameVo

		arg_12_0._time = var_1.GetTimeInteger(var_12_2)

		if arg_12_0._time < 0 then
			arg_12_0._time = 0
		end

		setText = var_1

		local var_12_3 = arg_12_0.timeTF

		math = var_12_1

		var_1(var_12_3, var_12_1.floor(arg_12_0._time))
	end

	local var_12_4 = arg_12_0._score
	local var_12_5 = arg_12_0._gameVo

	if var_12_4 ~= var_2.GetScore(var_12_5) then
		local var_12_6 = arg_12_0._gameVo

		arg_12_0._score = var_1.GetScore(var_12_6)
	end

	return
end

function var_0_0.SetChildVisible(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0 = 1, arg_13_1.childCount do
		local var_13_0 = arg_13_1
		local var_13_1 = arg_13_1.GetChild(var_13_0, iter_13_0 - 1)

		setActive = var_13_0

		var_13_0(var_13_1, arg_13_2)
	end

	return
end

function var_0_0.Press(arg_14_0, arg_14_1, arg_14_2)
	return
end

return var_0_0
