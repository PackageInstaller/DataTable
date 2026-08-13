class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadGamingUI")

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
	arg_2_0.lifeTF = var_1(arg_2_0._gameUI, "top/ad/life")
	findTF = var_1
	arg_2_0.scoreTF = var_1(arg_2_0._gameUI, "top/ad/score")
	findTF = var_1
	arg_2_0.joyStick = var_1(arg_2_0._gameUI, "joyStick")

	local var_2_0 = arg_2_0.joyStick

	arg_2_0.movebtnGroup = var_1.Find(var_2_0, "left_btn_layout/move_btn")

	local var_2_1 = arg_2_0.movebtnGroup

	arg_2_0.moveLeftBtn = var_1.Find(var_2_1, "left")

	local var_2_2 = arg_2_0.movebtnGroup

	arg_2_0.moveRightBtn = var_1.Find(var_2_2, "right")

	local var_2_3 = arg_2_0.joyStick

	arg_2_0.workBtn = var_1.Find(var_2_3, "right_btn_layout")

	local var_2_4 = arg_2_0.workBtn

	arg_2_0.goBtn = var_1.Find(var_2_4, "go/img")

	local var_2_5 = arg_2_0.workBtn

	arg_2_0.stopBtn = var_1.Find(var_2_5, "stop/img")
	arg_2_0.time = 0
	arg_2_0._life = 0
	arg_2_0.joyData = {
		go = false,
		stop = false,
		left = false,
		right = false
	}
	onButton = var_1

	local var_2_6 = arg_2_0._event
	local var_2_7 = arg_2_0.btnBack

	local function var_2_8()
		if not arg_2_0._gameVo.startSettlement then
			local var_3_0 = arg_2_0._event
			local var_3_1 = var_0.emit

			SimpleMGEvent = var_2_10003

			var_3_1(var_3_0, var_2_10003.PAUSE_GAME, true)

			local var_3_2 = arg_2_0._event
			local var_3_3 = var_0.emit

			CrossRoadGameView = var_3

			var_3_3(var_3_2, var_3.OPEN_LEAVEL_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_6, var_2_7, var_2_8, var_1_10006)
	arg_2_0:bindEventTrigger(arg_2_0.moveLeftBtn, "left")
	arg_2_0:bindEventTrigger(arg_2_0.moveRightBtn, "right")
	arg_2_0:bindEventTrigger(arg_2_0.goBtn, "go")
	arg_2_0:bindEventTrigger(arg_2_0.stopBtn, "stop")

	return
end

function var_0_0.bindEventTrigger(arg_4_0, arg_4_1, arg_4_2)
	GetOrAddComponent = var_1_10003

	local var_4_0 = var_1_10003(arg_4_1, "EventTriggerListener")

	var_3.AddPointDownFunc(var_4_0, function()
		local var_5_0 = arg_4_0

		var_0.setJoyData(var_5_0, arg_4_2, true)

		return
	end)

	GetOrAddComponent = var_3

	local var_4_1 = var_3(arg_4_1, "EventTriggerListener")

	var_3.AddPointUpFunc(var_4_1, function()
		local var_6_0 = arg_4_0

		var_0.setJoyData(var_6_0, arg_4_2, false)

		return
	end)

	return
end

function var_0_0.setJoyData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.joyData[arg_7_1] = arg_7_2

	local var_7_0 = arg_7_0._gameVo

	var_3.SetJoyStickData(var_7_0, arg_7_0.joyData)

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0._gameUI, arg_8_1)

	return
end

function var_0_0.Start(arg_9_0)
	arg_9_0.subGameStepTime = 0

	arg_9_0:Show(true)

	local var_9_0 = arg_9_0._gameVo

	var_1.SetJoyStickData(var_9_0, arg_9_0.joyData)

	getProxy = var_1
	MiniGameProxy = var_9_0

	local var_9_1 = var_1(var_9_0)
	local var_9_2 = var_1.GetHighScore
	local var_9_3 = arg_9_0._gameVo

	if var_9_2(var_9_1, var_4.GetGameId(var_9_3)) then
		local var_9_4 = #var_1

		if not (0 < var_9_4) or not var_1[1] then
			local var_9_5 = 0
		end

		setText = var_9_1

		var_9_1(arg_9_0.scoreTF, 0)

		if arg_9_0._editorFlag then
			setActive = var_3
			findTF = var_5

			var_3(var_5(arg_9_0._gameUI, "joyStick"), false)

			setActive = var_3
			findTF = var_5

			var_3(var_5(arg_9_0._gameUI, "top"), false)

			setActive = var_3
			findTF = var_5

			var_3(var_5(arg_9_0._gameUI, "bg_top"), false)
		end

		arg_9_0._score = 0
		arg_9_0._time = -1

		return
	end
end

function var_0_0.Step(arg_10_0)
	arg_10_0:AddDebugInput()

	local var_10_0 = arg_10_0._score
	local var_10_1 = arg_10_0._gameVo

	if var_10_0 ~= var_2.GetScore(var_10_1) then
		local var_10_2 = arg_10_0._gameVo

		arg_10_0._score = var_1.GetScore(var_10_2)
		setText = var_1

		var_1(arg_10_0.scoreTF, arg_10_0._score)
	end

	local var_10_3 = arg_10_0._life
	local var_10_4 = arg_10_0._gameVo

	if var_10_3 ~= var_2.GetLife(var_10_4) then
		local var_10_5 = arg_10_0._gameVo

		arg_10_0._life = var_1.GetLife(var_10_5)
		setText = var_1

		var_1(arg_10_0.lifeTF, "X" .. arg_10_0._life)
	end

	return
end

function var_0_0.AddDebugInput(arg_11_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		Input = var_1_10001

		local var_11_0 = var_1_10001.GetKeyDown

		KeyCode = var_1_10003

		local var_11_1

		if var_11_0(var_1_10003.A) then
			var_11_1 = arg_11_0

			arg_11_0.setJoyData(var_11_1, "left", true)
		end

		Input = var_1

		local var_11_2 = var_1.GetKeyUp

		KeyCode = var_11_1

		local var_11_3

		if var_11_2(var_11_1.A) then
			var_11_3 = arg_11_0

			arg_11_0.setJoyData(var_11_3, "left", false)
		end

		Input = var_1

		local var_11_4 = var_1.GetKeyDown

		KeyCode = var_11_3

		local var_11_5

		if var_11_4(var_11_3.D) then
			var_11_5 = arg_11_0

			arg_11_0.setJoyData(var_11_5, "right", true)
		end

		Input = var_1

		local var_11_6 = var_1.GetKeyUp

		KeyCode = var_11_5

		local var_11_7

		if var_11_6(var_11_5.D) then
			var_11_7 = arg_11_0

			arg_11_0.setJoyData(var_11_7, "right", false)
		end

		Input = var_1

		local var_11_8 = var_1.GetKeyDown

		KeyCode = var_11_7

		local var_11_9

		if var_11_8(var_11_7.J) then
			var_11_9 = arg_11_0

			arg_11_0.setJoyData(var_11_9, "go", true)
		end

		Input = var_1

		local var_11_10 = var_1.GetKeyUp

		KeyCode = var_11_9

		local var_11_11

		if var_11_10(var_11_9.J) then
			var_11_11 = arg_11_0

			arg_11_0.setJoyData(var_11_11, "go", false)
		end

		Input = var_1

		local var_11_12 = var_1.GetKeyDown

		KeyCode = var_11_11

		local var_11_13

		if var_11_12(var_11_11.K) then
			var_11_13 = arg_11_0

			arg_11_0.setJoyData(var_11_13, "stop", true)
		end

		Input = var_1

		local var_11_14 = var_1.GetKeyUp

		KeyCode = var_11_13

		if var_11_14(var_11_13.K) then
			arg_11_0:setJoyData("stop", false)
		end
	end

	return
end

function var_0_0.SetChildVisible(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		local var_12_0 = arg_12_1:GetChild(iter_12_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_12_0, arg_12_2)
	end

	return
end

return var_0_0
