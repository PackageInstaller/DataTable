local var_0_0 = class("CrossRoadGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	arg_2_0._gameUI = findTF(arg_2_0._tf, "ui/gamingUI")
	arg_2_0.btnBack = findTF(arg_2_0._gameUI, "back")
	arg_2_0.lifeTF = findTF(arg_2_0._gameUI, "top/ad/life")
	arg_2_0.scoreTF = findTF(arg_2_0._gameUI, "top/ad/score")
	arg_2_0.joyStick = findTF(arg_2_0._gameUI, "joyStick")
	arg_2_0.movebtnGroup = arg_2_0.joyStick:Find("left_btn_layout/move_btn")
	arg_2_0.moveLeftBtn = arg_2_0.movebtnGroup:Find("left")
	arg_2_0.moveRightBtn = arg_2_0.movebtnGroup:Find("right")
	arg_2_0.workBtn = arg_2_0.joyStick:Find("right_btn_layout")
	arg_2_0.goBtn = arg_2_0.workBtn:Find("go/img")
	arg_2_0.stopBtn = arg_2_0.workBtn:Find("stop/img")
	arg_2_0.time = 0
	arg_2_0._life = 0
	arg_2_0.joyData = {
		go = false,
		stop = false,
		left = false,
		right = false
	}

	onButton(arg_2_0._event, arg_2_0.btnBack, function()
		if not arg_2_0._gameVo.startSettlement then
			arg_2_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
			arg_2_0._event:emit(CrossRoadGameView.OPEN_LEAVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	arg_2_0:bindEventTrigger(arg_2_0.moveLeftBtn, "left")
	arg_2_0:bindEventTrigger(arg_2_0.moveRightBtn, "right")
	arg_2_0:bindEventTrigger(arg_2_0.goBtn, "go")
	arg_2_0:bindEventTrigger(arg_2_0.stopBtn, "stop")

	return
end

function var_0_0.bindEventTrigger(arg_4_0, arg_4_1, arg_4_2)
	GetOrAddComponent(arg_4_1, "EventTriggerListener"):AddPointDownFunc(function()
		arg_4_0:setJoyData(arg_4_2, true)

		return
	end)
	GetOrAddComponent(arg_4_1, "EventTriggerListener"):AddPointUpFunc(function()
		arg_4_0:setJoyData(arg_4_2, false)

		return
	end)

	return
end

function var_0_0.setJoyData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.joyData[arg_7_1] = arg_7_2

	arg_7_0._gameVo:SetJoyStickData(arg_7_0.joyData)

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	setActive(arg_8_0._gameUI, arg_8_1)

	return
end

function var_0_0.Start(arg_9_0)
	arg_9_0.subGameStepTime = 0

	arg_9_0:Show(true)
	arg_9_0._gameVo:SetJoyStickData(arg_9_0.joyData)

	local var_9_0 = getProxy(MiniGameProxy):GetHighScore(arg_9_0._gameVo:GetGameId())

	if not var_9_0 or #var_9_0 <= 0 or not var_9_0[1] then
		-- block empty
	end

	setText(arg_9_0.scoreTF, 0)

	if arg_9_0._editorFlag then
		setActive(findTF(arg_9_0._gameUI, "joyStick"), false)
		setActive(findTF(arg_9_0._gameUI, "top"), false)
		setActive(findTF(arg_9_0._gameUI, "bg_top"), false)
	end

	arg_9_0._score = 0
	arg_9_0._time = -1

	return
end

function var_0_0.Step(arg_10_0)
	arg_10_0:AddDebugInput()

	if arg_10_0._score ~= arg_10_0._gameVo:GetScore() then
		arg_10_0._score = arg_10_0._gameVo:GetScore()

		setText(arg_10_0.scoreTF, arg_10_0._score)
	end

	if arg_10_0._life ~= arg_10_0._gameVo:GetLife() then
		arg_10_0._life = arg_10_0._gameVo:GetLife()

		setText(arg_10_0.lifeTF, "X" .. arg_10_0._life)
	end

	return
end

function var_0_0.AddDebugInput(arg_11_0)
	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			arg_11_0:setJoyData("left", true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			arg_11_0:setJoyData("left", false)
		end

		if Input.GetKeyDown(KeyCode.D) then
			arg_11_0:setJoyData("right", true)
		end

		if Input.GetKeyUp(KeyCode.D) then
			arg_11_0:setJoyData("right", false)
		end

		if Input.GetKeyDown(KeyCode.J) then
			arg_11_0:setJoyData("go", true)
		end

		if Input.GetKeyUp(KeyCode.J) then
			arg_11_0:setJoyData("go", false)
		end

		if Input.GetKeyDown(KeyCode.K) then
			arg_11_0:setJoyData("stop", true)
		end

		if Input.GetKeyUp(KeyCode.K) then
			arg_11_0:setJoyData("stop", false)
		end
	end

	return
end

function var_0_0.SetChildVisible(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		setActive(arg_12_1:GetChild(iter_12_0 - 1), arg_12_2)
	end

	return
end

return var_0_0
