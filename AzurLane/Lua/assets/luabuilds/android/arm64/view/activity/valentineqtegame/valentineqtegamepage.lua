class = var_0_10000

local var_0_0 = var_0_10000("ValentineQteGamePage")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	findTF = var_1_10001
	arg_2_0.root = var_1_10001(arg_2_0._tf, "root")
	findTF = var_1
	arg_2_0.slideWay = var_1(arg_2_0._tf, "slideway")
	findTF = var_1
	arg_2_0.slider = var_1(arg_2_0._tf, "slider")
	findTF = var_1
	arg_2_0.goodArea = var_1(arg_2_0._tf, "good")
	findTF = var_1
	arg_2_0.greatArea = var_1(arg_2_0._tf, "great")
	findTF = var_1
	arg_2_0.perfectArea = var_1(arg_2_0._tf, "perfect")
	findTF = var_1

	local var_2_0 = var_1(arg_2_0._tf, "score/Text")
	local var_2_1 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.scoreTxt = var_2_1(var_2_0, var_4(var_1_10006))
	findTF = var_1

	local var_2_2 = var_1(arg_2_0._tf, "score/combo")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.comboTxt = var_2_3(var_2_2, var_4(var_1_10006))
	findTF = var_1

	local var_2_4 = var_1(arg_2_0._tf, "score/label")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006

	local var_2_6 = var_2_5(var_2_4, var_4(var_1_10006))

	var_1.SetNativeSize(var_2_6)

	findTF = var_1

	local var_2_7 = var_1(arg_2_0._tf, "bg/refrigerator")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	SpineAnimUI = var_1_10006
	arg_2_0.refrigerator = var_2_8(var_2_7, var_4(var_1_10006))
	findTF = var_1

	local var_2_9 = var_1(arg_2_0._tf, "bg/char")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	SpineAnimUI = var_1_10006
	arg_2_0.char = var_2_10(var_2_9, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.backBtn = var_1(arg_2_0._tf, "back")
	findTF = var_1
	arg_2_0.puaseBtn = var_1(arg_2_0._tf, "pause")
	findTF = var_1

	local var_2_11 = var_1(arg_2_0._tf, "time/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.timeTxt = var_2_12(var_2_11, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.lineTr = var_1(arg_2_0._tf, "slideway/line")
	setActive = var_1

	var_1(arg_2_0.lineTr, false)

	findTF = var_1
	arg_2_0.itemContainer = var_1(arg_2_0._tf, "items")
	findTF = var_1
	arg_2_0.effectContainer = var_1(arg_2_0._tf, "effects")
	findTF = var_1
	arg_2_0.finger = var_1(arg_2_0._tf, "finger")
	findTF = var_1

	local var_2_13 = var_1(arg_2_0._tf, "gear")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.gearTr = var_2_14(var_2_13, var_4(var_1_10006))
	arg_2_0.gearTrPos = arg_2_0.gearTr.transform.localPosition.y

	local var_2_15 = {}

	ValentineQteGameConst = var_1_10002

	local var_2_16 = var_1_10002.OP_SCORE_GEAR_PERFECT

	GetSpriteFromAtlas = var_2_13
	var_2_15[var_2_16] = var_2_13("ui/minigameui/valentineqtegame_atlas", "Perfect")
	ValentineQteGameConst = var_2_16

	local var_2_17 = var_2_16.OP_SCORE_GEAR_GREAT

	GetSpriteFromAtlas = var_3
	var_2_15[var_2_17] = var_3("ui/minigameui/valentineqtegame_atlas", "Great")
	ValentineQteGameConst = var_2_17

	local var_2_18 = var_2_17.OP_SCORE_GEAR_GOOD

	GetSpriteFromAtlas = var_3
	var_2_15[var_2_18] = var_3("ui/minigameui/valentineqtegame_atlas", "Good")
	ValentineQteGameConst = var_2_18

	local var_2_19 = var_2_18.OP_SCORE_GEAR_MISS

	GetSpriteFromAtlas = var_3
	var_2_15[var_2_19] = var_3("ui/minigameui/valentineqtegame_atlas", "Miss")
	arg_2_0.gearSps = var_2_15
	ValentineQteGameMsgBox = var_2_15

	local var_2_20 = var_2_15.New
	local var_2_21 = arg_2_0._tf

	arg_2_0.msgBox = var_2_20(var_3.Find(var_2_21, "msgbox"))
	ValentineQteGamePoolMgr = var_1

	local var_2_22 = var_1.New
	local var_2_23 = arg_2_0._tf

	arg_2_0.itemPoolMgr = var_2_22(var_3.Find(var_2_23, "root/item"), 2, 4)
	ValentineQteGameResultWindow = var_1

	local var_2_24 = var_1.New
	local var_2_25 = arg_2_0._tf

	arg_2_0.resultWindow = var_2_24(var_3.Find(var_2_25, "result_panel"))
	findTF = var_1
	arg_2_0.countDownWindow = var_1(arg_2_0._tf, "countdown")
	findTF = var_1
	arg_2_0.countDown1 = var_1(arg_2_0._tf, "countdown/1")
	findTF = var_1
	arg_2_0.countDown2 = var_1(arg_2_0._tf, "countdown/2")
	findTF = var_1
	arg_2_0.countDown3 = var_1(arg_2_0._tf, "countdown/3")
	arg_2_0.effectPools = {}

	return
end

function var_0_0.SetUp(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.onComplete = arg_3_1
	arg_3_0.onExist = arg_3_2
	arg_3_0.isClick = not arg_3_3

	arg_3_0:Show()

	return
end

function var_0_0.Show(arg_4_0)
	arg_4_0:UpdateFinger()

	parallelAsync = var_1

	var_1({
		function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.CountDown(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			seriesAsync = var_2_10001

			var_2_10001({
				function(arg_7_0)
					local var_7_0 = arg_4_0

					var_1.LoadEffects(var_7_0, arg_7_0)

					return
				end,
				function(arg_8_0)
					local var_8_0 = arg_4_0

					var_1.InitGame(var_8_0, arg_8_0)

					return
				end,
				function(arg_9_0)
					local var_9_0 = arg_4_0

					var_1.Reset(var_9_0, arg_9_0)

					return
				end
			}, arg_6_0)

			return
		end
	}, function()
		local var_10_0 = arg_4_0

		var_0.StartGame(var_10_0)

		return
	end)

	return
end

function var_0_0.CountDown(arg_11_0, arg_11_1)
	local function var_11_0(arg_12_0)
		setActive = var_2_10001

		var_2_10001(arg_11_0.countDown1, arg_12_0 == 3)

		setActive = var_2_10001

		var_2_10001(arg_11_0.countDown2, arg_12_0 == 2)

		setActive = var_2_10001

		var_2_10001(arg_11_0.countDown3, arg_12_0 == 1)

		return
	end

	setActive = var_1_10003

	var_1_10003(arg_11_0.countDownWindow, true)

	local var_11_1 = 1

	Timer = var_1_10004
	arg_11_0.countDownTimer = var_1_10004.New(function()
		var_11_1 = var_11_1 + 1

		var_11_0(var_11_1)

		if var_11_1 == 4 then
			setActive = var_0

			var_0(arg_11_0.countDownWindow, false)
			arg_11_1()
		end

		return
	end, 1, 3)

	local var_11_2 = arg_11_0.countDownTimer

	var_4.Start(var_11_2)
	var_11_0(var_11_1)

	return
end

function var_0_0.LoadEffects(arg_14_0, arg_14_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_15_0)
			LoadAndInstantiateAsync = var_2_10001

			var_2_10001("ui", "chufang_Prefect", function(arg_16_0)
				SetParent = var_3_10001

				var_3_10001(arg_16_0, arg_14_0.root)

				ValentineQteGamePoolMgr = var_3_10001

				local var_16_0 = var_3_10001.New(arg_16_0, 1, 2)
				local var_16_1 = arg_14_0.effectPools

				ValentineQteGameConst = var_3
				var_16_1[var_3.OP_SCORE_GEAR_PERFECT] = var_16_0

				arg_15_0()

				return
			end)

			return
		end,
		function(arg_17_0)
			LoadAndInstantiateAsync = var_2_10001

			var_2_10001("ui", "chufang_Great", function(arg_18_0)
				SetParent = var_3_10001

				var_3_10001(arg_18_0, arg_14_0.root)

				ValentineQteGamePoolMgr = var_3_10001

				local var_18_0 = var_3_10001.New(arg_18_0, 1, 2)
				local var_18_1 = arg_14_0.effectPools

				ValentineQteGameConst = var_3
				var_18_1[var_3.OP_SCORE_GEAR_GREAT] = var_18_0

				arg_17_0()

				return
			end)

			return
		end,
		function(arg_19_0)
			LoadAndInstantiateAsync = var_2_10001

			var_2_10001("ui", "chufang_Good", function(arg_20_0)
				SetParent = var_3_10001

				var_3_10001(arg_20_0, arg_14_0.root)

				ValentineQteGamePoolMgr = var_3_10001

				local var_20_0 = var_3_10001.New(arg_20_0, 1, 2)
				local var_20_1 = arg_14_0.effectPools

				ValentineQteGameConst = var_3
				var_20_1[var_3.OP_SCORE_GEAR_GOOD] = var_20_0

				arg_19_0()

				return
			end)

			return
		end,
		function(arg_21_0)
			LoadAndInstantiateAsync = var_2_10001

			var_2_10001("ui", "chufang_Miss", function(arg_22_0)
				SetParent = var_3_10001

				var_3_10001(arg_22_0, arg_14_0.root)

				ValentineQteGamePoolMgr = var_3_10001

				local var_22_0 = var_3_10001.New(arg_22_0, 1, 2)
				local var_22_1 = arg_14_0.effectPools

				ValentineQteGameConst = var_3
				var_22_1[var_3.OP_SCORE_GEAR_MISS] = var_22_0

				arg_21_0()

				return
			end)

			return
		end,
		function(arg_23_0)
			LoadAndInstantiateAsync = var_2_10001

			var_2_10001("ui", "chufang_shiqu", function(arg_24_0)
				SetParent = var_3_10001

				var_3_10001(arg_24_0, arg_14_0.root)

				ValentineQteGamePoolMgr = var_3_10001

				local var_24_0 = var_3_10001.New(arg_24_0, 1, 2)

				arg_14_0.pickPool = var_24_0

				arg_23_0()

				return
			end)

			return
		end
	}, arg_14_1)

	return
end

function var_0_0.InitGame(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.slideWay

	Vector2 = var_1_10003
	ValentineQteGameConst = var_1_10005
	var_25_0.sizeDelta = var_1_10003(var_1_10005.SLIDEWAY_WIDTH, arg_25_0.slideWay.sizeDelta.y)

	local var_25_1 = arg_25_0.slider

	Vector2 = var_3
	ValentineQteGameConst = var_5
	var_25_1.sizeDelta = var_3(var_5.SLIDER_WIDTH, arg_25_0.slider.sizeDelta.y)

	local var_25_2 = arg_25_0.goodArea

	Vector2 = var_3
	ValentineQteGameConst = var_5
	var_25_2.sizeDelta = var_3(var_5.GOOD_WIDTH, arg_25_0.goodArea.sizeDelta.y)

	local var_25_3 = arg_25_0.greatArea

	Vector2 = var_3
	ValentineQteGameConst = var_5
	var_25_3.sizeDelta = var_3(var_5.GREAT_WIDTH, arg_25_0.greatArea.sizeDelta.y)

	local var_25_4 = arg_25_0.perfectArea

	Vector2 = var_3
	ValentineQteGameConst = var_5
	var_25_4.sizeDelta = var_3(var_5.PERFECT_WIDTH, arg_25_0.perfectArea.sizeDelta.y)
	arg_25_0.scoreTxt.text = 0
	arg_25_0.comboTxt.text = 0

	local var_25_5 = arg_25_0.slideWay

	Vector3 = var_3
	var_25_5.localPosition = var_3(0, arg_25_0.slideWay.localPosition.y, 0)

	local var_25_6 = arg_25_0.goodArea

	Vector3 = var_3
	var_25_6.localPosition = var_3(0, arg_25_0.goodArea.localPosition.y, 0)

	local var_25_7 = arg_25_0.greatArea

	Vector3 = var_3
	var_25_7.localPosition = var_3(0, arg_25_0.greatArea.localPosition.y, 0)

	local var_25_8 = arg_25_0.perfectArea

	Vector3 = var_3
	var_25_8.localPosition = var_3(0, arg_25_0.perfectArea.localPosition.y, 0)

	local var_25_9 = arg_25_0.slider.sizeDelta.x * 0.5

	arg_25_0.missMinPosX, arg_25_0.missMaxPosX = arg_25_0:CalcGearArea(arg_25_0.slideWay, var_25_9)
	arg_25_0.goodMinPosX, arg_25_0.goodMaxPosX = arg_25_0:CalcGearArea(arg_25_0.goodArea, var_25_9)
	arg_25_0.greatMinPosX, arg_25_0.greatMaxPosX = arg_25_0:CalcGearArea(arg_25_0.greatArea, var_25_9)

	local var_25_10, var_25_11 = arg_25_0:CalcGearArea(arg_25_0.perfectArea, var_25_9)

	arg_25_0.prefectMaxPosX = var_25_11
	arg_25_0.prefectMinPosX = var_25_10

	local var_25_12 = arg_25_0.slider

	Vector3 = var_25_11
	var_25_12.localPosition = var_25_11(arg_25_0.missMinPosX, arg_25_0.slideWay.localPosition.y, 0)
	Vector2 = var_25_12
	arg_25_0.itemGenMinArea = var_25_12(arg_25_0.missMinPosX - var_25_9 + 40, arg_25_0.goodMinPosX - var_25_9 - 40)
	Vector2 = var_3
	arg_25_0.itemGenMaxArea = var_3(arg_25_0.goodMaxPosX + var_25_9 + 40, arg_25_0.missMaxPosX + var_25_9 - 40)
	ValentineQteGameConst = var_3

	if var_3.DEBUG then
		arg_25_0:InitDebugView()
	end

	arg_25_1()

	return
end

function var_0_0.Reset(arg_26_0, arg_26_1)
	ValentineQteGameConst = var_1_10002
	arg_26_0.speedX = var_1_10002.INIT_SPEED
	ValentineQteGameConst = var_2
	arg_26_0.time = var_2.GMAE_TIME
	arg_26_0.comboCnt = 0
	arg_26_0.score = 0
	arg_26_0.opCdTime = 0
	arg_26_0.elapseTimes = {}
	arg_26_0.accelerated = 0
	arg_26_0.items = {}
	arg_26_0.genItemTime = 0
	arg_26_0.gearShowTime = 0
	arg_26_0.timers = {}
	arg_26_0.startFlag = false
	arg_26_0.statistics = {
		Score = 0,
		Combo = 0,
		Great = 0,
		Perfect = 0,
		Good = 0,
		Miss = 0
	}

	arg_26_1()

	return
end

function var_0_0.InitDebugView(arg_27_0)
	arg_27_0:CreateDebugLinePos("missMinPosX")
	arg_27_0:CreateDebugLinePos("missMaxPosX")
	arg_27_0:CreateDebugLinePos("goodMinPosX")
	arg_27_0:CreateDebugLinePos("goodMaxPosX")
	arg_27_0:CreateDebugLinePos("greatMinPosX")
	arg_27_0:CreateDebugLinePos("greatMaxPosX")
	arg_27_0:CreateDebugLinePos("prefectMinPosX")
	arg_27_0:CreateDebugLinePos("prefectMaxPosX")
	arg_27_0:CreateDebugArea("itemGenMinArea")
	arg_27_0:CreateDebugArea("itemGenMaxArea")

	return
end

function var_0_0.CreateDebugArea(arg_28_0, arg_28_1)
	cloneTplTo = var_1_10002

	local var_28_0 = var_1_10002(arg_28_0.lineTr, arg_28_0.lineTr.parent, arg_28_1 .. "01")

	Vector3 = var_1_10003
	var_28_0.localPosition = var_1_10003(arg_28_0[arg_28_1].x, var_28_0.localPosition.y, 0)
	setActive = var_3

	var_3(var_28_0, true)

	cloneTplTo = var_3

	local var_28_1 = var_3(arg_28_0.lineTr, arg_28_0.lineTr.parent, arg_28_1 .. "02")

	Vector3 = var_4
	var_28_1.localPosition = var_4(arg_28_0[arg_28_1].y, var_28_1.localPosition.y, 0)
	setActive = var_4

	var_4(var_28_1, true)

	return
end

function var_0_0.CreateDebugLinePos(arg_29_0, arg_29_1)
	cloneTplTo = var_1_10002

	local var_29_0 = var_1_10002(arg_29_0.lineTr, arg_29_0.lineTr.parent, arg_29_1)

	Vector3 = var_1_10003
	var_29_0.localPosition = var_1_10003(arg_29_0[arg_29_1], var_29_0.localPosition.y, 0)
	setActive = var_3

	var_3(var_29_0, true)

	return
end

function var_0_0.CalcGearArea(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = -arg_30_1.sizeDelta.x * 0.5 + arg_30_2
	local var_30_1 = arg_30_1.sizeDelta.x * 0.5 - arg_30_2

	return var_30_0, var_30_1
end

function var_0_0.StartGame(arg_31_0)
	arg_31_0.startFlag = true

	if not arg_31_0.handle then
		UpdateBeat = var_1
		arg_31_0.handle = var_1:CreateListener(arg_31_0.UpdateGame, arg_31_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_31_0.handle)

	local var_31_0 = arg_31_0.char

	var_1.SetAction(var_31_0, "1", 0)

	onButton = var_1

	local var_31_1 = arg_31_0
	local var_31_2 = arg_31_0.puaseBtn

	local function var_31_3()
		if not arg_31_0.puaseGameFlag then
			local var_32_0 = arg_31_0

			var_0.PuaseGame(var_32_0)

			local var_32_1 = arg_31_0.msgBox
			local var_32_2 = var_0.Show
			local var_32_3 = {
				noNo = true
			}

			ValentineQteGameMsgBox = var_2_10004
			var_32_3.content = var_2_10004.PAUSE_TXT

			function var_32_3.onYes()
				local var_33_0 = arg_31_0

				var_0.ResumeGame(var_33_0)

				return
			end

			function var_32_3.onNo()
				local var_34_0 = arg_31_0

				var_0.ResumeGame(var_34_0)

				return
			end

			var_32_2(var_32_1, var_32_3)
		else
			local var_32_4 = arg_31_0

			var_0.ResumeGame(var_32_4)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_31_1, var_31_2, var_31_3, var_1_10006)

	onButton = var_1

	local var_31_4 = arg_31_0
	local var_31_5 = arg_31_0.backBtn

	local function var_31_6()
		local var_35_0 = arg_31_0

		var_0.PuaseGame(var_35_0)

		local var_35_1 = arg_31_0.msgBox
		local var_35_2 = var_0.Show
		local var_35_3 = {}

		ValentineQteGameMsgBox = var_2_10004
		var_35_3.content = var_2_10004.EXIT_TXT

		function var_35_3.onYes()
			local var_36_0 = arg_31_0

			var_0.EndGame(var_36_0, true)

			return
		end

		function var_35_3.onNo()
			local var_37_0 = arg_31_0

			var_0.ResumeGame(var_37_0)

			return
		end

		var_35_2(var_35_1, var_35_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_31_4, var_31_5, var_31_6, var_1_10006)

	GetOrAddComponent = var_1
	arg_31_0.dragDelegate = var_1(arg_31_0._tf, "EventTriggerListener")

	local var_31_7 = arg_31_0.dragDelegate

	var_1.AddPointDownFunc(var_31_7, function()
		arg_31_0.isClick = true

		if arg_31_0.opCdTime <= 0 and not arg_31_0.puaseGameFlag then
			local var_38_0 = arg_31_0

			var_0.Snap(var_38_0)

			local var_38_1 = arg_31_0

			ValentineQteGameConst = var_1
			var_38_1.opCdTime = var_1.OP_INTERVAL
		end

		local var_38_2 = arg_31_0

		var_0.UpdateFinger(var_38_2)

		return
	end)

	return
end

function var_0_0.UpdateFinger(arg_39_0)
	setActive = var_1_10001

	var_1_10001(arg_39_0.finger, not arg_39_0.isClick)

	return
end

function var_0_0.UpdateGame(arg_40_0)
	if arg_40_0.puaseGameFlag then
		return
	end

	arg_40_0:HideGear()
	arg_40_0:CheckDisapperItems()
	arg_40_0:UpdateSlider()
	arg_40_0:UpdateSpeed()
	arg_40_0:UpdateTime()
	arg_40_0:UpdateOpCdTime()
	arg_40_0:CheckAndGenItem()
	arg_40_0:CheckInteraction()

	return
end

function var_0_0.CheckInteraction(arg_41_0)
	local function var_41_0()
		local var_42_0 = arg_41_0.time

		ValentineQteGameConst = var_2_10001

		return var_42_0 <= var_2_10001.OPEN_DOOR_TIME
	end

	if not arg_41_0.isInteraction and var_41_0() then
		arg_41_0.isInteraction = true

		local var_41_1 = arg_41_0.refrigerator

		var_2.SetActionCallBack(var_41_1, function(arg_43_0)
			if arg_43_0 == "finish" then
				local var_43_0 = arg_41_0.refrigerator

				var_1.SetActionCallBack(var_43_0, nil)

				local var_43_1 = arg_41_0.refrigerator

				var_1.SetAction(var_43_1, "3", 0)
			end

			return
		end)

		local var_41_2 = arg_41_0.refrigerator

		var_2.SetAction(var_41_2, "2", 0)
	end

	return
end

function var_0_0.HideGear(arg_44_0)
	if arg_44_0.gearShowTime <= 0 then
		return
	end

	local var_44_0 = arg_44_0.gearShowTime - arg_44_0.time

	ValentineQteGameConst = var_2

	if var_44_0 >= var_2.GEAR_SHOW_TIME then
		arg_44_0.gearShowTime = 0
		setActive = var_1

		var_1(arg_44_0.gearTr.gameObject, false)
	end

	return
end

function var_0_0.CheckDisapperItems(arg_45_0)
	for iter_45_0 = #arg_45_0.items, 1, -1 do
		local var_45_0 = arg_45_0.items[iter_45_0]

		if var_5.ShouldDisapper(var_45_0, arg_45_0.time) then
			var_5:Destroy()

			local var_45_1 = arg_45_0.itemPoolMgr

			var_6.Enqueue(var_45_1, var_5._go)

			table = var_6

			var_6.remove(arg_45_0.items, iter_45_0)
		end
	end

	return
end

function var_0_0.CheckAndGenItem(arg_46_0)
	local var_46_0 = #arg_46_0.items

	ValentineQteGameConst = var_1_10002

	if var_46_0 >= var_1_10002.MAX_ITEM_COUNT then
		return
	end

	local var_46_1 = false

	if arg_46_0.genItemTime == 0 then
		local var_46_2 = arg_46_0.time

		ValentineQteGameConst = var_1_10003

		local var_46_3 = var_1_10003.GMAE_TIME

		ValentineQteGameConst = var_1_10004

		if not (var_46_2 <= var_46_3 - var_1_10004.GEN_ITEM_FIRST_TIME) then
			if arg_46_0.genItemTime > 0 then
				local var_46_4 = arg_46_0.genItemTime - arg_46_0.time

				ValentineQteGameConst = var_3

				if var_46_4 > var_3.GEN_ITEM_INTERVAL then
					var_46_1 = true
				end
			end

			if var_46_1 then
				arg_46_0:RandomItemPosition(0)
			end

			return
		end
	end
end

function var_0_0.IsValidItemPos(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0.slider.sizeDelta.x + 80

	ipairs = var_1_10003

	for iter_47_0, iter_47_1 in var_1_10003(arg_47_0.items) do
		if not iter_47_1:IsSufficientLength(arg_47_1, var_47_0) then
			return false
		end
	end

	return true
end

function var_0_0.RandomItemPosition(arg_48_0, arg_48_1)
	if 10 < arg_48_1 then
		return
	end

	math = var_2

	local var_48_0

	if var_2.random(1, 2) % 2 ~= 0 or not arg_48_0.itemGenMinArea then
		var_48_0 = arg_48_0.itemGenMaxArea
	end

	math = var_4

	local var_48_1 = var_4.random(var_48_0.x, var_48_0.y)

	if arg_48_0:IsValidItemPos(var_48_1) then
		arg_48_0.genItemTime = arg_48_0.time

		local var_48_2 = arg_48_0.itemPoolMgr
		local var_48_3 = var_5.Dequeue(var_48_2)

		SetParent = var_6

		var_6(var_48_3, arg_48_0.itemContainer)

		ValentineQteGameItem = var_6

		local var_48_4 = var_6.New
		local var_48_5 = var_48_3

		Vector2 = var_9

		local var_48_6 = var_48_4(var_48_5, var_9(var_48_1, arg_48_0.slider.localPosition.y), arg_48_0.time)

		table = var_48_2

		var_48_2.insert(arg_48_0.items, var_48_6)
	else
		arg_48_0:RandomItemPosition(arg_48_1 + 1)
	end

	return
end

function var_0_0.UpdateSlider(arg_49_0)
	if arg_49_0.slider.localPosition.x == arg_49_0.missMinPosX or var_1.x == arg_49_0.missMaxPosX then
		arg_49_0.speedX = -arg_49_0.speedX
	end

	math = var_2

	local var_49_0 = var_2.clamp
	local var_49_1 = var_1.x
	local var_49_2 = arg_49_0.speedX

	Time = var_1_10006

	local var_49_3 = var_49_0(var_49_1 + var_49_2 * var_1_10006.deltaTime, arg_49_0.missMinPosX, arg_49_0.missMaxPosX)
	local var_49_4 = arg_49_0.slider

	Vector3 = var_4
	var_49_4.localPosition = var_4(var_49_3, var_1.y, 0)

	return
end

function var_0_0.UpdateTime(arg_50_0)
	local var_50_0 = arg_50_0.time

	Time = var_1_10002
	arg_50_0.time = var_50_0 - var_1_10002.deltaTime

	if arg_50_0.time <= 0 then
		arg_50_0:EndGame(true)
	end

	arg_50_0:UpdateTimeText(arg_50_0.time)

	return
end

function var_0_0.UpdateSpeed(arg_51_0)
	math = var_1_10001

	local var_51_0 = var_1_10001.floor

	math = var_1_10003

	local var_51_1 = var_1_10003.ceil

	ValentineQteGameConst = var_1_10005

	if var_51_0(var_51_1(var_1_10005.GMAE_TIME - arg_51_0.time) / 5) > 0 and not arg_51_0.elapseTimes[var_1] then
		local var_51_2 = arg_51_0.accelerated

		ValentineQteGameConst = var_3

		local var_51_3 = var_51_2 + var_3.INIT_SPEED

		ValentineQteGameConst = var_3

		if var_51_3 < var_3.MAX_SPEED then
			arg_51_0.elapseTimes[var_1] = true

			local var_51_4 = arg_51_0.accelerated

			ValentineQteGameConst = var_3
			arg_51_0.accelerated = var_51_4 + var_3.SPEED_UP

			if arg_51_0.speedX < 0 then
				arg_51_0.speedX = arg_51_0.speedX - arg_51_0.accelerated
			else
				arg_51_0.speedX = arg_51_0.speedX + arg_51_0.accelerated
			end
		end
	end

	return
end

function var_0_0.UpdateOpCdTime(arg_52_0)
	if arg_52_0.opCdTime > 0 then
		math = var_1

		local var_52_0 = var_1.max
		local var_52_1 = 0
		local var_52_2 = arg_52_0.opCdTime

		Time = var_1_10005
		arg_52_0.opCdTime = var_52_0(var_52_1, var_52_2 - var_1_10005.deltaTime)
	end

	return
end

function var_0_0.Snap(arg_53_0)
	local var_53_0 = arg_53_0.slider.localPosition.x
	local var_53_1 = arg_53_0:GetScoreGear(var_53_0)
	local var_53_2 = {}
	local var_53_3 = false

	ValentineQteGameConst = var_5

	local var_53_4

	if var_53_1 == var_5.OP_SCORE_GEAR_GREAT then
		arg_53_0.comboCnt = arg_53_0.comboCnt + 1
		var_53_4 = arg_53_0.statistics
		var_53_4.Great = arg_53_0.statistics.Great + 1
	else
		ValentineQteGameConst = var_53_4

		if var_53_1 == var_53_4.OP_SCORE_GEAR_PERFECT then
			arg_53_0.comboCnt = arg_53_0.comboCnt + 1
			arg_53_0.statistics.Perfect = arg_53_0.statistics.Perfect + 1
		else
			local var_53_5

			if arg_53_0:CanPickItem(var_53_0, var_53_2) then
				arg_53_0.comboCnt = arg_53_0.comboCnt + 1
				ValentineQteGameConst = var_53_5
				var_53_1 = var_53_5.OP_SCORE_GEAR_PERFECT
				var_53_5 = arg_53_0.statistics
				var_53_5.Perfect = arg_53_0.statistics.Perfect + 1

				arg_53_0:PickItems(var_53_2)

				var_53_3 = true
			else
				ValentineQteGameConst = var_53_5

				local var_53_6

				if var_53_1 == var_53_5.OP_SCORE_GEAR_MISS then
					arg_53_0.comboCnt = 0
					var_53_6 = arg_53_0.statistics
					var_53_6.Miss = arg_53_0.statistics.Miss + 1
				else
					ValentineQteGameConst = var_53_6

					if var_53_1 == var_53_6.OP_SCORE_GEAR_GOOD then
						arg_53_0.comboCnt = 0
						arg_53_0.statistics.Good = arg_53_0.statistics.Good + 1
					end
				end
			end
		end
	end

	local var_53_7 = arg_53_0:GetScore(var_53_1, arg_53_0.comboCnt)

	arg_53_0.score = arg_53_0.score + var_53_7

	arg_53_0:UpdateScoreText(arg_53_0.score)
	arg_53_0:UpdateComboText(arg_53_0.comboCnt)

	if arg_53_0.comboCnt > arg_53_0.statistics.Combo then
		arg_53_0.statistics.Combo = arg_53_0.comboCnt
	end

	arg_53_0:UpdateGear(var_53_1, var_53_3)

	return
end

function var_0_0.UpdateGear(arg_54_0, arg_54_1, arg_54_2)
	LeanTween = var_1_10003

	if var_1_10003.isTweening(arg_54_0.gearTr.gameObject) then
		LeanTween = var_3

		var_3.cancel(arg_54_0.gearTr.gameObject)
	end

	arg_54_0.gearTr.sprite = arg_54_0.gearSps[arg_54_1]

	local var_54_0 = arg_54_0.gearTr

	var_3.SetNativeSize(var_54_0)

	arg_54_0.gearShowTime = arg_54_0.time
	setActive = var_3

	var_3(arg_54_0.gearTr.gameObject, true)

	if arg_54_2 then
		setActive = var_3

		var_3(arg_54_0.gearTr.gameObject, false)

		local var_54_1 = arg_54_0
		local var_54_2 = arg_54_0.GenEffect

		ValentineQteGameConst = var_6

		var_54_2(var_54_1, var_6.OP_SCORE_GEAR_GREAT)

		local var_54_3 = arg_54_0
		local var_54_4 = arg_54_0.PlaySound

		ValentineQteGameConst = var_6

		var_54_4(var_54_3, var_6.SOUND_PICK_ITEM)
	else
		arg_54_0:GenEffect(arg_54_1)
		arg_54_0:GearAnim()

		local var_54_5 = arg_54_0
		local var_54_6 = arg_54_0.PlaySound

		ValentineQteGameConst = var_6

		var_54_6(var_54_5, var_6.GEAR_SOUND[arg_54_1])
	end

	return
end

function var_0_0.PlaySound(arg_55_0, arg_55_1)
	pg = var_1_10002

	local var_55_0 = var_1_10002.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_55_0, arg_55_1)

	return
end

function var_0_0.GearAnim(arg_56_0)
	local var_56_0 = arg_56_0.gearTr.gameObject.transform

	Vector3 = var_1_10002
	var_56_0.localPosition = var_1_10002(arg_56_0.gearTr.gameObject.transform.localPosition.x, arg_56_0.gearTrPos, 0)
	LeanTween = var_56_0

	local var_56_1 = var_56_0.value(arg_56_0.gearTr.gameObject, arg_56_0.gearTrPos, arg_56_0.gearTrPos + 50, 0.3)
	local var_56_2 = var_1.setOnUpdate

	System = var_4

	local var_56_3 = var_56_2(var_56_1, var_4.Action_float(function(arg_57_0)
		local var_57_0 = arg_56_0.gearTr.gameObject.transform

		Vector3 = var_2_10002
		var_57_0.localPosition = var_2_10002(arg_56_0.gearTr.gameObject.transform.localPosition.x, arg_57_0, 0)

		return
	end))
	local var_56_4 = var_1.setOnComplete

	System = var_4

	var_56_4(var_56_3, var_4.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_56_0.gearTr.gameObject, false)

		return
	end))

	return
end

function var_0_0.GenEffect(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0.effectPools[arg_59_1]
	local var_59_1 = var_2.Dequeue(var_59_0)

	SetParent = var_1_10004

	var_1_10004(var_59_1, arg_59_0.effectContainer)

	local var_59_2 = var_59_1.transform

	Vector3 = var_59_0
	var_59_2.localPosition = var_59_0(arg_59_0.slider.localPosition.x, arg_59_0.slider.localPosition.y, -100)
	Timer = var_59_2

	local var_59_3 = var_59_2.New(function()
		local var_60_0 = var_0

		var_0.Enqueue(var_60_0, var_59_1)

		return
	end, 2, 1)

	var_4.Start(var_59_3)

	table = var_5

	var_5.insert(arg_59_0.timers, var_4)

	return
end

function var_0_0.CanPickItem(arg_61_0, arg_61_1, arg_61_2)
	ipairs = var_1_10003

	for iter_61_0, iter_61_1 in var_1_10003(arg_61_0.items) do
		if iter_61_1:IsOverlap(arg_61_0.slider) then
			table = var_8

			var_8.insert(arg_61_2, iter_61_1)
		end
	end

	return #arg_61_2 > 0
end

function var_0_0.PickItems(arg_62_0, arg_62_1)
	ipairs = var_1_10002

	for iter_62_0, iter_62_1 in var_1_10002(arg_62_1) do
		arg_62_0:PlayPickAnim(iter_62_1, function()
			local var_63_0 = iter_62_1

			var_0.Destroy(var_63_0)

			local var_63_1 = arg_62_0.itemPoolMgr

			var_0.Enqueue(var_63_1, iter_62_1._tf)

			return
		end)

		table = var_7

		var_7.removebyvalue(arg_62_0.items, iter_62_1)
	end

	return
end

function var_0_0.PlayPickAnim(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = arg_64_1._tf.localPosition.y

	LeanTween = var_1_10004

	local var_64_1 = var_1_10004.value(arg_64_1._go, var_64_0, var_64_0 + 70, 0.3)
	local var_64_2 = var_4.setOnUpdate

	System = var_7

	local var_64_3 = var_64_2(var_64_1, var_7.Action_float(function(arg_65_0)
		local var_65_0 = arg_64_1._tf

		Vector3 = var_2_10002
		var_65_0.localPosition = var_2_10002(arg_64_1._tf.localPosition.x, arg_65_0, 0)

		return
	end))
	local var_64_4 = var_4.setOnComplete

	System = var_7

	var_64_4(var_64_3, var_7.Action(function()
		local var_66_0 = arg_64_0.pickPool
		local var_66_1 = var_0.Dequeue(var_66_0)

		SetParent = var_2_10001

		var_2_10001(var_66_1, arg_64_0.effectContainer)

		local var_66_2 = var_66_1.transform

		Vector3 = var_66_0
		var_66_2.localPosition = var_66_0(arg_64_1._tf.localPosition.x, arg_64_1._tf.localPosition.y, -100)
		Timer = var_66_2

		local var_66_3 = var_66_2.New(function()
			local var_67_0 = arg_64_0.pickPool

			var_0.Enqueue(var_67_0, var_66_1)

			return
		end, 2, 1)

		var_1.Start(var_66_3)

		table = var_2

		var_2.insert(arg_64_0.timers, var_1)
		arg_64_2()

		return
	end))

	return
end

function var_0_0.UpdateTimeText(arg_68_0, arg_68_1)
	math = var_1_10002

	if var_1_10002.ceil(arg_68_1) <= 0 then
		arg_68_0.timeTxt.text = "0"
	else
		local var_68_0 = arg_68_0.timeTxt

		math = var_4
		var_68_0.text = var_4.max(0, var_2)
	end

	return
end

function var_0_0.UpdateScoreText(arg_69_0, arg_69_1)
	arg_69_0.scoreTxt.text = arg_69_1

	return
end

function var_0_0.UpdateComboText(arg_70_0, arg_70_1)
	arg_70_0.comboTxt.text = arg_70_1

	return
end

function var_0_0.GetScoreGear(arg_71_0, arg_71_1)
	if arg_71_1 >= arg_71_0.prefectMinPosX and arg_71_1 <= arg_71_0.prefectMaxPosX then
		ValentineQteGameConst = var_2

		return var_2.OP_SCORE_GEAR_PERFECT
	end

	if arg_71_1 >= arg_71_0.greatMinPosX and arg_71_1 <= arg_71_0.greatMaxPosX then
		ValentineQteGameConst = var_2

		return var_2.OP_SCORE_GEAR_GREAT
	end

	if arg_71_0.goodMinPosX <= arg_71_1 and arg_71_1 <= arg_71_0.goodMaxPosX then
		ValentineQteGameConst = var_2

		return var_2.OP_SCORE_GEAR_GOOD
	end

	ValentineQteGameConst = var_2

	return var_2.OP_SCORE_GEAR_MISS
end

function var_0_0.GetScore(arg_72_0, arg_72_1, arg_72_2)
	ValentineQteGameConst = var_1_10003

	local var_72_0 = var_1_10003.OP_SCORE[arg_72_1]

	ValentineQteGameConst = var_1_10004

	local var_72_1 = var_1_10004.BASE_OP_SCORE * var_72_0
	local var_72_2 = 0

	ipairs = var_1_10006
	ValentineQteGameConst = var_1_10008

	for iter_72_0, iter_72_1 in var_1_10006(var_1_10008.COMBO_EXTRA_SCORE_RATIO) do
		local var_72_3 = iter_72_1[1]
		local var_72_4 = iter_72_1[2]
		local var_72_5 = iter_72_1[3]

		if var_72_3 <= arg_72_2 and arg_72_2 <= var_72_4 then
			var_72_2 = var_72_5

			break
		end
	end

	ValentineQteGameConst = var_6

	return var_72_1 + var_6.BASE_OP_SCORE * var_72_2 * 0.01
end

function var_0_0.PuaseGame(arg_73_0)
	arg_73_0.puaseGameFlag = true

	local var_73_0 = arg_73_0.char

	var_1.Pause(var_73_0)

	return
end

function var_0_0.ResumeGame(arg_74_0)
	arg_74_0.puaseGameFlag = false

	local var_74_0 = arg_74_0.char

	var_1.Resume(var_74_0)

	return
end

function var_0_0.EndGame(arg_75_0, arg_75_1)
	if arg_75_0.handle then
		UpdateBeat = var_2

		var_2:RemoveListener(arg_75_0.handle)
	end

	ClearEventTrigger = var_2

	var_2(arg_75_0.dragDelegate)

	removeOnButton = var_2

	var_2(arg_75_0.puaseBtn)

	if arg_75_1 then
		arg_75_0.statistics.Score = arg_75_0.score

		local var_75_0 = arg_75_0.resultWindow

		var_2.Show(var_75_0, arg_75_0.statistics, function()
			local var_76_0 = arg_75_0

			var_0.Destroy(var_76_0)

			return
		end)
	end

	if arg_75_0.onComplete and arg_75_1 then
		arg_75_0.onComplete()
	end

	arg_75_0.onComplete = nil

	return
end

function var_0_0.ExitGame(arg_77_0)
	arg_77_0:EndGame(false)

	if arg_77_0.onExist then
		arg_77_0.onExist()

		arg_77_0.onExist = nil
	end

	return
end

function var_0_0.onBackPressed(arg_78_0)
	if arg_78_0.startFlag and not arg_78_0.puaseGameFlag then
		triggerButton = var_1

		var_1(arg_78_0.puaseBtn)

		return true
	end

	isActive = var_1

	if var_1(arg_78_0.msgBox._tf) then
		triggerButton = var_1

		var_1(arg_78_0.msgBox.cancelBtn)

		return true
	end

	return false
end

function var_0_0.Destroy(arg_79_0)
	if arg_79_0.countDownTimer then
		local var_79_0 = arg_79_0.countDownTimer

		var_1.Stop(var_79_0)

		arg_79_0.countDownTimer = nil
	end

	LeanTween = var_1

	if var_1.isTweening(arg_79_0.gearTr.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_79_0.gearTr.gameObject)
	end

	ipairs = var_1

	for iter_79_0, iter_79_1 in var_1(arg_79_0.timers) do
		iter_79_1:Stop()
	end

	arg_79_0.timers = nil
	pairs = var_1

	for iter_79_2, iter_79_3 in var_1(arg_79_0.effectPools) do
		iter_79_3:Destroy()
	end

	arg_79_0.effectPools = nil

	local var_79_1 = arg_79_0.refrigerator

	var_1.SetActionCallBack(var_79_1, nil)

	if arg_79_0.msgBox then
		local var_79_2 = arg_79_0.msgBox

		var_1.Destroy(var_79_2)

		arg_79_0.msgBox = nil
	end

	if arg_79_0.resultWindow then
		local var_79_3 = arg_79_0.resultWindow

		var_1.Destroy(var_79_3)

		arg_79_0.resultWindow = nil
	end

	arg_79_0:ExitGame()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_79_0)

	if arg_79_0.itemPoolMgr then
		local var_79_4 = arg_79_0.itemPoolMgr

		var_1.Destroy(var_79_4)

		arg_79_0.itemPoolMgr = nil
	end

	arg_79_0.gearSps = nil

	return
end

return var_0_0
