local var_0_0 = class("OreMiniGameController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1

	arg_1_0:InitTimer()
	arg_1_0:InitGameUI(arg_1_2)
	arg_1_0:InitControl()
	arg_1_0:AddListener()

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_2_1.speed = arg_2_1
	end

	return
end

function var_0_0.InitTimer(arg_3_0)
	arg_3_0.timer = Timer.New(function()
		arg_3_0:OnTimer(OreGameConfig.TIME_INTERVAL)

		return
	end, OreGameConfig.TIME_INTERVAL, -1)
	arg_3_0.handle = arg_3_0.handle or UpdateBeat:CreateListener(arg_3_0.Update, arg_3_0)

	UpdateBeat:AddListener(arg_3_0.handle)

	return
end

function var_0_0.Update(arg_5_0)
	arg_5_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_6_0)
	if IsUnityEditor and Input.GetKeyDown(KeyCode.Space) then
		arg_6_0:OnCarryBtnClick()
	end

	return
end

function var_0_0.InitGameUI(arg_7_0, arg_7_1)
	arg_7_0.uiMgr = pg.UIMgr.GetInstance()
	arg_7_0.rtViewport = arg_7_1:Find("Viewport")
	arg_7_0.rtCharacter = arg_7_0.rtViewport:Find("MainContent/character")
	arg_7_0.bgManjuu = arg_7_0.rtViewport:Find("MainContent/bg_back/Manjuu_SW")
	arg_7_0.rtController = arg_7_1:Find("Controller")
	arg_7_0.rtTop = arg_7_1:Find("Controller/top")
	arg_7_0.TimeTextM = arg_7_0.rtTop:Find("title/TIME/Text_M")
	arg_7_0.TimeTextS = arg_7_0.rtTop:Find("title/TIME/Text_S")
	arg_7_0.pointText = arg_7_0.rtTop:Find("title/SCORE/Text")
	arg_7_0.rtBottom = arg_7_1:Find("Controller/bottom")
	arg_7_0.rtPointer = arg_7_0.rtBottom:Find("capacity/pointer")
	arg_7_0.rtJoyStick = arg_7_0.rtBottom:Find("handle_stick")

	onButton(arg_7_0.binder, arg_7_0.rtBottom:Find("btn_carry"), function()
		arg_7_0:OnCarryBtnClick()

		return
	end)

	return
end

function var_0_0.InitControl(arg_9_0)
	arg_9_0.collisionMgr = OreCollisionMgr.New(arg_9_0.binder)
	arg_9_0.akashiControl = OreAkashiControl.New(arg_9_0.binder, arg_9_0.rtCharacter:Find("Akashi"), arg_9_0.collisionMgr)
	arg_9_0.enemiesControl = OreEnemiesControl.New(arg_9_0.binder, arg_9_0.rtCharacter:Find("Enemies"), arg_9_0.collisionMgr)
	arg_9_0.minersControl = OreMinersControl.New(arg_9_0.binder, arg_9_0.rtCharacter:Find("Miners"), arg_9_0.collisionMgr)
	arg_9_0.oreGroupControl = OreGroupControl.New(arg_9_0.binder, arg_9_0.rtViewport:Find("MainContent/ore_group"), arg_9_0.collisionMgr)
	arg_9_0.containerControl = OreContainerControl.New(arg_9_0.binder, arg_9_0.rtViewport:Find("MainContent/container"))

	return
end

function var_0_0.AddListener(arg_10_0)
	arg_10_0.binder:bind(OreGameConfig.EVENT_DO_CARRY, function(arg_11_0, arg_11_1)
		arg_10_0.weight = arg_10_0.weight + arg_11_1.weight

		arg_10_0:UpdateWeightUI()

		return
	end)
	arg_10_0.binder:bind(OreGameConfig.EVENT_DELIVER, function(arg_12_0, arg_12_1)
		arg_10_0.point = arg_10_0.point + arg_12_1.point
		arg_10_0.weight = 0

		arg_10_0:UpdatePointUI()
		arg_10_0:UpdateWeightUI()
		arg_10_0.bgManjuu:GetComponent(typeof(Animator)):Play("Happy")

		return
	end)
	arg_10_0.binder:bind(OreGameConfig.EVENT_AKASHI_HIT, function(arg_13_0, arg_13_1)
		arg_10_0.weight = 0

		arg_10_0:UpdateWeightUI()
		arg_10_0.bgManjuu:GetComponent(typeof(Animator)):Play("Shock")

		return
	end)

	return
end

function var_0_0.OnCarryBtnClick(arg_14_0)
	arg_14_0.binder:emit(OreGameConfig.EVENT_CHECK_CARRY, {
		weight = arg_14_0.weight
	})

	return
end

function var_0_0.UpdateTimeUI(arg_15_0)
	if arg_15_0.timeCount < 60 then
		setText(arg_15_0.TimeTextM, "00")
	else
		setText(arg_15_0.TimeTextM, string.format("%02d", arg_15_0.timeCount / 60))
	end

	setText(arg_15_0.TimeTextS, string.format("%02d", arg_15_0.timeCount % 60))

	return
end

function var_0_0.UpdateWeightUI(arg_16_0)
	local var_16_0 = 90

	if arg_16_0.weight == 0 then
		setLocalEulerAngles(arg_16_0.rtPointer, Vector3(0, 0, 90))

		return
	end

	if arg_16_0.weight == OreGameConfig.MAX_WEIGHT then
		setLocalEulerAngles(arg_16_0.rtPointer, Vector3(0, 0, -90))

		return
	end

	local var_16_1 = OreGameConfig.CAPACITY

	var_16_0 = arg_16_0.weight <= OreGameConfig.CAPACITY.WOOD_BOX and 90 - arg_16_0.weight * 40 / var_16_1.WOOD_BOX or arg_16_0.weight <= var_16_1.IRON_BOX and 37 - (arg_16_0.weight - var_16_1.WOOD_BOX) * 60 / (var_16_1.IRON_BOX - var_16_1.WOOD_BOX) or -37 - (arg_16_0.weight - var_16_1.IRON_BOX) * 40 / (var_16_1.CART - var_16_1.IRON_BOX)

	setLocalEulerAngles(arg_16_0.rtPointer, Vector3(0, 0, var_16_0))

	return
end

function var_0_0.UpdatePointUI(arg_17_0)
	setText(arg_17_0.pointText, arg_17_0.point)

	return
end

function var_0_0.ResetGame(arg_18_0)
	arg_18_0.timeCount = OreGameConfig.PLAY_TIME
	arg_18_0.point = 0
	arg_18_0.weight = 0

	arg_18_0.akashiControl:Reset()
	arg_18_0.minersControl:Reset()
	arg_18_0.oreGroupControl:Reset()
	arg_18_0.collisionMgr:Reset()
	arg_18_0.enemiesControl:Reset()
	arg_18_0.containerControl:Reset()
	arg_18_0:UpdatePointUI()
	arg_18_0:UpdateWeightUI()
	arg_18_0:UpdateTimeUI()

	return
end

function var_0_0.StartGame(arg_19_0)
	arg_19_0.isStart = true

	arg_19_0:ResetGame()
	arg_19_0:StartTimer()

	return
end

function var_0_0.EndGame(arg_20_0)
	arg_20_0.isStart = false

	arg_20_0:PauseGame()
	arg_20_0.binder:openUI("result")

	return
end

function var_0_0.StartTimer(arg_21_0)
	if not arg_21_0.timer.running then
		arg_21_0.timer:Start()
		arg_21_0.uiMgr:AttachStickOb(arg_21_0.rtJoyStick)
	end

	var_0_1(arg_21_0.rtViewport, 1)

	return
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.timer.running then
		arg_22_0.timer:Stop()
		arg_22_0.uiMgr:ClearStick()
	end

	var_0_1(arg_22_0.rtViewport, 0)

	return
end

function var_0_0.PauseGame(arg_23_0)
	arg_23_0.isPause = true

	arg_23_0:StopTimer()

	return
end

function var_0_0.ResumeGame(arg_24_0)
	arg_24_0.isPause = false

	arg_24_0:StartTimer()

	return
end

function var_0_0.OnTimer(arg_25_0, arg_25_1)
	arg_25_0.timeCount = arg_25_0.timeCount - arg_25_1

	arg_25_0:UpdateTimeUI()

	if arg_25_0.timeCount <= 0 then
		arg_25_0:EndGame()
	end

	arg_25_0.akashiControl:OnTimer(arg_25_1)
	arg_25_0.minersControl:OnTimer(arg_25_1)
	arg_25_0.oreGroupControl:OnTimer(arg_25_1)
	arg_25_0.collisionMgr:OnTimer(arg_25_1)
	arg_25_0.enemiesControl:OnTimer(arg_25_1)
	arg_25_0.containerControl:OnTimer(arg_25_1)

	return
end

function var_0_0.willExit(arg_26_0)
	if arg_26_0.handle then
		UpdateBeat:RemoveListener(arg_26_0.handle)
	end

	if arg_26_0.timer.running then
		arg_26_0.timer:Stop()

		arg_26_0.timer = nil

		arg_26_0.uiMgr:ClearStick()
	end

	return
end

return var_0_0
