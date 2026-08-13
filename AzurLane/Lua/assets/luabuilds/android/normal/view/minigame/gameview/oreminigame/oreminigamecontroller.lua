class = var_0_10000

local var_0_0 = var_0_10000("OreMiniGameController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1

	arg_1_0:InitTimer()
	arg_1_0:InitGameUI(arg_1_2)
	arg_1_0:InitControl()
	arg_1_0:AddListener()

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetComponentsInChildren

	typeof = var_1_10004
	Animator = var_1_10005

	local var_2_2 = var_2_1(var_2_0, var_1_10004(var_1_10005), true)
	local var_2_3 = var_2.ToTable(var_2_2)

	ipairs = var_2_2

	for iter_2_0, iter_2_1 in var_2_2(var_2_3) do
		iter_2_1.speed = arg_2_1
	end

	return
end

function var_0_0.InitTimer(arg_3_0)
	Timer = var_1_10001

	local var_3_0 = var_1_10001.New

	local function var_3_1()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.OnTimer

		OreGameConfig = var_2_10002

		var_4_1(var_4_0, var_2_10002.TIME_INTERVAL)

		return
	end

	OreGameConfig = var_1_10003
	arg_3_0.timer = var_3_0(var_3_1, var_1_10003.TIME_INTERVAL, -1)

	if not arg_3_0.handle then
		UpdateBeat = var_1
		arg_3_0.handle = var_1:CreateListener(arg_3_0.Update, arg_3_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_3_0.handle)

	return
end

function var_0_0.Update(arg_5_0)
	arg_5_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_6_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		Input = var_1_10001

		local var_6_0 = var_1_10001.GetKeyDown

		KeyCode = var_1_10002

		if var_6_0(var_1_10002.Space) then
			arg_6_0:OnCarryBtnClick()
		end
	end

	return
end

function var_0_0.InitGameUI(arg_7_0, arg_7_1)
	pg = var_1_10002
	arg_7_0.uiMgr = var_1_10002.UIMgr.GetInstance()
	arg_7_0.rtViewport = arg_7_1:Find("Viewport")

	local var_7_0 = arg_7_0.rtViewport

	arg_7_0.rtCharacter = var_2.Find(var_7_0, "MainContent/character")

	local var_7_1 = arg_7_0.rtViewport

	arg_7_0.bgManjuu = var_2.Find(var_7_1, "MainContent/bg_back/Manjuu_SW")
	arg_7_0.rtController = arg_7_1:Find("Controller")
	arg_7_0.rtTop = arg_7_1:Find("Controller/top")

	local var_7_2 = arg_7_0.rtTop

	arg_7_0.TimeTextM = var_2.Find(var_7_2, "title/TIME/Text_M")

	local var_7_3 = arg_7_0.rtTop

	arg_7_0.TimeTextS = var_2.Find(var_7_3, "title/TIME/Text_S")

	local var_7_4 = arg_7_0.rtTop

	arg_7_0.pointText = var_2.Find(var_7_4, "title/SCORE/Text")
	arg_7_0.rtBottom = arg_7_1:Find("Controller/bottom")

	local var_7_5 = arg_7_0.rtBottom

	arg_7_0.rtPointer = var_2.Find(var_7_5, "capacity/pointer")

	local var_7_6 = arg_7_0.rtBottom

	arg_7_0.rtJoyStick = var_2.Find(var_7_6, "handle_stick")
	onButton = var_2

	local var_7_7 = arg_7_0.binder
	local var_7_8 = arg_7_0.rtBottom

	var_2(var_7_7, var_4.Find(var_7_8, "btn_carry"), function()
		local var_8_0 = arg_7_0

		var_0.OnCarryBtnClick(var_8_0)

		return
	end)

	return
end

function var_0_0.InitControl(arg_9_0)
	OreCollisionMgr = var_1_10001
	arg_9_0.collisionMgr = var_1_10001.New(arg_9_0.binder)
	OreAkashiControl = var_1

	local var_9_0 = var_1.New
	local var_9_1 = arg_9_0.binder
	local var_9_2 = arg_9_0.rtCharacter

	arg_9_0.akashiControl = var_9_0(var_9_1, var_3.Find(var_9_2, "Akashi"), arg_9_0.collisionMgr)
	OreEnemiesControl = var_1

	local var_9_3 = var_1.New
	local var_9_4 = arg_9_0.binder
	local var_9_5 = arg_9_0.rtCharacter

	arg_9_0.enemiesControl = var_9_3(var_9_4, var_3.Find(var_9_5, "Enemies"), arg_9_0.collisionMgr)
	OreMinersControl = var_1

	local var_9_6 = var_1.New
	local var_9_7 = arg_9_0.binder
	local var_9_8 = arg_9_0.rtCharacter

	arg_9_0.minersControl = var_9_6(var_9_7, var_3.Find(var_9_8, "Miners"), arg_9_0.collisionMgr)
	OreGroupControl = var_1

	local var_9_9 = var_1.New
	local var_9_10 = arg_9_0.binder
	local var_9_11 = arg_9_0.rtViewport

	arg_9_0.oreGroupControl = var_9_9(var_9_10, var_3.Find(var_9_11, "MainContent/ore_group"), arg_9_0.collisionMgr)
	OreContainerControl = var_1

	local var_9_12 = var_1.New
	local var_9_13 = arg_9_0.binder
	local var_9_14 = arg_9_0.rtViewport

	arg_9_0.containerControl = var_9_12(var_9_13, var_3.Find(var_9_14, "MainContent/container"))

	return
end

function var_0_0.AddListener(arg_10_0)
	local var_10_0 = arg_10_0.binder
	local var_10_1 = var_1.bind

	OreGameConfig = var_1_10003

	var_10_1(var_10_0, var_1_10003.EVENT_DO_CARRY, function(arg_11_0, arg_11_1)
		arg_10_0.weight = arg_10_0.weight + arg_11_1.weight

		local var_11_0 = arg_10_0

		var_2.UpdateWeightUI(var_11_0)

		return
	end)

	local var_10_2 = arg_10_0.binder
	local var_10_3 = var_1.bind

	OreGameConfig = var_3

	var_10_3(var_10_2, var_3.EVENT_DELIVER, function(arg_12_0, arg_12_1)
		arg_10_0.point = arg_10_0.point + arg_12_1.point
		arg_10_0.weight = 0

		local var_12_0 = arg_10_0

		var_2.UpdatePointUI(var_12_0)

		local var_12_1 = arg_10_0

		var_2.UpdateWeightUI(var_12_1)

		local var_12_2 = arg_10_0.bgManjuu
		local var_12_3 = var_2.GetComponent

		typeof = var_4
		Animator = var_2_10005

		local var_12_4 = var_12_3(var_12_2, var_4(var_2_10005))

		var_2.Play(var_12_4, "Happy")

		return
	end)

	local var_10_4 = arg_10_0.binder
	local var_10_5 = var_1.bind

	OreGameConfig = var_3

	var_10_5(var_10_4, var_3.EVENT_AKASHI_HIT, function(arg_13_0, arg_13_1)
		arg_10_0.weight = 0

		local var_13_0 = arg_10_0

		var_2.UpdateWeightUI(var_13_0)

		local var_13_1 = arg_10_0.bgManjuu
		local var_13_2 = var_2.GetComponent

		typeof = var_2_10004
		Animator = var_2_10005

		local var_13_3 = var_13_2(var_13_1, var_2_10004(var_2_10005))

		var_2.Play(var_13_3, "Shock")

		return
	end)

	return
end

function var_0_0.OnCarryBtnClick(arg_14_0)
	local var_14_0 = arg_14_0.binder
	local var_14_1 = var_1.emit

	OreGameConfig = var_1_10003

	var_14_1(var_14_0, var_1_10003.EVENT_CHECK_CARRY, {
		weight = arg_14_0.weight
	})

	return
end

function var_0_0.UpdateTimeUI(arg_15_0)
	if arg_15_0.timeCount < 60 then
		setText = var_1

		var_1(arg_15_0.TimeTextM, "00")
	else
		setText = var_1

		local var_15_0 = arg_15_0.TimeTextM

		string = var_1_10003

		var_1(var_15_0, var_1_10003.format("%02d", arg_15_0.timeCount / 60))
	end

	setText = var_1

	local var_15_1 = arg_15_0.TimeTextS

	string = var_1_10003

	var_1(var_15_1, var_1_10003.format("%02d", arg_15_0.timeCount % 60))

	return
end

function var_0_0.UpdateWeightUI(arg_16_0)
	local var_16_0 = 90

	if arg_16_0.weight == 0 then
		setLocalEulerAngles = var_2
		var_1_10003 = arg_16_0.rtPointer
		Vector3 = var_1_10004

		var_2(var_1_10003, var_1_10004(0, 0, 90))

		return
	end

	local var_16_1 = arg_16_0.weight

	OreGameConfig = var_1_10003

	if var_16_1 == var_1_10003.MAX_WEIGHT then
		setLocalEulerAngles = var_16_1

		local var_16_2 = arg_16_0.rtPointer

		Vector3 = var_1_10004

		var_16_1(var_16_2, var_1_10004(0, 0, -90))

		return
	end

	OreGameConfig = var_16_1

	local var_16_3 = var_16_1.CAPACITY

	if arg_16_0.weight <= var_16_3.WOOD_BOX then
		var_16_0 = 90 - arg_16_0.weight * 40 / var_16_3.WOOD_BOX
	elseif arg_16_0.weight <= var_16_3.IRON_BOX then
		var_16_0 = 37 - (arg_16_0.weight - var_16_3.WOOD_BOX) * 60 / (var_16_3.IRON_BOX - var_16_3.WOOD_BOX)
	else
		var_16_0 = -37 - (arg_16_0.weight - var_16_3.IRON_BOX) * 40 / (var_16_3.CART - var_16_3.IRON_BOX)
	end

	setLocalEulerAngles = var_3

	local var_16_4 = arg_16_0.rtPointer

	Vector3 = var_1_10005

	var_3(var_16_4, var_1_10005(0, 0, var_16_0))

	return
end

function var_0_0.UpdatePointUI(arg_17_0)
	setText = var_1_10001

	var_1_10001(arg_17_0.pointText, arg_17_0.point)

	return
end

function var_0_0.ResetGame(arg_18_0)
	OreGameConfig = var_1_10001
	arg_18_0.timeCount = var_1_10001.PLAY_TIME
	arg_18_0.point = 0
	arg_18_0.weight = 0

	local var_18_0 = arg_18_0.akashiControl

	var_1.Reset(var_18_0)

	local var_18_1 = arg_18_0.minersControl

	var_1.Reset(var_18_1)

	local var_18_2 = arg_18_0.oreGroupControl

	var_1.Reset(var_18_2)

	local var_18_3 = arg_18_0.collisionMgr

	var_1.Reset(var_18_3)

	local var_18_4 = arg_18_0.enemiesControl

	var_1.Reset(var_18_4)

	local var_18_5 = arg_18_0.containerControl

	var_1.Reset(var_18_5)
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

	local var_20_0 = arg_20_0.binder

	var_1.openUI(var_20_0, "result")

	return
end

function var_0_0.StartTimer(arg_21_0)
	if not arg_21_0.timer.running then
		local var_21_0 = arg_21_0.timer

		var_1.Start(var_21_0)

		local var_21_1 = arg_21_0.uiMgr

		var_1.AttachStickOb(var_21_1, arg_21_0.rtJoyStick)
	end

	var_0_1(arg_21_0.rtViewport, 1)

	return
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.timer.running then
		local var_22_0 = arg_22_0.timer

		var_1.Stop(var_22_0)

		local var_22_1 = arg_22_0.uiMgr

		var_1.ClearStick(var_22_1)
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

	local var_25_0 = arg_25_0.akashiControl

	var_2.OnTimer(var_25_0, arg_25_1)

	local var_25_1 = arg_25_0.minersControl

	var_2.OnTimer(var_25_1, arg_25_1)

	local var_25_2 = arg_25_0.oreGroupControl

	var_2.OnTimer(var_25_2, arg_25_1)

	local var_25_3 = arg_25_0.collisionMgr

	var_2.OnTimer(var_25_3, arg_25_1)

	local var_25_4 = arg_25_0.enemiesControl

	var_2.OnTimer(var_25_4, arg_25_1)

	local var_25_5 = arg_25_0.containerControl

	var_2.OnTimer(var_25_5, arg_25_1)

	return
end

function var_0_0.willExit(arg_26_0)
	if arg_26_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_26_0.handle)
	end

	if arg_26_0.timer.running then
		local var_26_0 = arg_26_0.timer

		var_1.Stop(var_26_0)

		arg_26_0.timer = nil

		local var_26_1 = arg_26_0.uiMgr

		var_1.ClearStick(var_26_1)
	end

	return
end

return var_0_0
