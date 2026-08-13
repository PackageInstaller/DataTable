class = var_0_10000

local var_0_0 = "FourthAnniversaryPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0.hideIndex = {}
	arg_1_0.scrollAble = true
	PLATFORM_CODE = var_1
	PLATFORM_CH = var_1_10002

	if var_1 == var_1_10002 then
		arg_1_0.hideIndex = {}
		arg_1_0.scrollAble = true
	else
		PLATFORM_CODE = var_1
		PLATFORM_KR = var_1_10002

		if var_1 == var_1_10002 then
			arg_1_0.hideIndex = {
				1,
				2,
				3,
				4
			}
			arg_1_0.scrollAble = false
		else
			PLATFORM_CODE = var_1
			PLATFORM_CH = var_1_10002

			if var_1 ~= var_1_10002 then
				arg_1_0.hideIndex = {
					2,
					4
				}
				arg_1_0.scrollAble = true
			end
		end
	end

	arg_1_0:findUI()
	arg_1_0:initData()

	return
end

function var_0_1.findUI(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.paintBackTF = var_1.Find(var_2_0, "Paints/PaintBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.paintFrontTF = var_1.Find(var_2_1, "Paints/PaintFront")

	local var_2_2 = arg_2_0._tf

	arg_2_0.skinShopBtn = var_1.Find(var_2_2, "BtnShop")

	local var_2_3 = arg_2_0._tf

	arg_2_0.btnContainer = var_1.Find(var_2_3, "BtnList/Viewport/Content")

	local var_2_4 = arg_2_0.btnContainer.childCount / 3

	arg_2_0.btnList1 = {}

	for iter_2_0 = 0, var_2_4 - 1 do
		var_1_10006 = arg_2_0.btnList1

		local var_2_5 = iter_2_0 + 1
		local var_2_6 = arg_2_0.btnContainer

		var_1_10006[var_2_5] = var_8.GetChild(var_2_6, iter_2_0)
	end

	arg_2_0.btnList2 = {}

	for iter_2_1 = var_2_4, 2 * var_2_4 - 1 do
		var_1_10006 = arg_2_0.btnList2

		local var_2_7 = #arg_2_0.btnList2 + 1
		local var_2_8 = arg_2_0.btnContainer

		var_1_10006[var_2_7] = var_8.GetChild(var_2_8, iter_2_1)
	end

	arg_2_0.btnList3 = {}

	for iter_2_2 = var_2_4 * 2, 3 * var_2_4 - 1 do
		var_1_10006 = arg_2_0.btnList3

		local var_2_9 = #arg_2_0.btnList3 + 1
		local var_2_10 = arg_2_0.btnContainer

		var_1_10006[var_2_9] = var_8.GetChild(var_2_10, iter_2_2)
	end

	for iter_2_3 = 1, var_2_4 * 3 do
		table = var_1_10006

		if var_1_10006.contains(arg_2_0.hideIndex, iter_2_3 % 6) or not arg_2_0.scrollAble and 6 < iter_2_3 then
			setActive = var_1_10006

			local var_2_11 = arg_2_0.btnContainer

			var_1_10006(var_8.GetChild(var_2_11, iter_2_3 - 1), false)
		end
	end

	GetComponent = var_2
	arg_2_0.gridLayoutGroupCom = var_2(arg_2_0.btnContainer, "GridLayoutGroup")

	return
end

function var_0_1.initData(arg_3_0)
	arg_3_0.paintCount = 9
	arg_3_0.curPaintIndex = 1
	arg_3_0.paintSwitchTime = 1
	arg_3_0.paintStaticTime = 3.5
	arg_3_0.paintStaticCountValue = 0
	arg_3_0.paintPathPrefix = "clutter/"
	arg_3_0.paintNamePrefix = "fourtha"
	arg_3_0.btnCount = arg_3_0.btnContainer.childCount / 3
	arg_3_0.btnSpeed = 50
	arg_3_0.btnSizeX = arg_3_0.gridLayoutGroupCom.cellSize.x
	arg_3_0.btnMarginX = arg_3_0.gridLayoutGroupCom.spacing.x
	arg_3_0.moveLength = (arg_3_0.btnCount - #arg_3_0.hideIndex) * (arg_3_0.btnSizeX + arg_3_0.btnMarginX)
	arg_3_0.startAnchoredPosX = arg_3_0.btnContainer.anchoredPosition.x

	return
end

function var_0_1.switchNextPaint(arg_4_0)
	local var_4_0 = arg_4_0.frameTimer

	var_1.Stop(var_4_0)

	local var_4_1 = arg_4_0.curPaintIndex % arg_4_0.paintCount + 1
	local var_4_2 = arg_4_0.paintNamePrefix .. var_4_1
	local var_4_3 = arg_4_0.paintPathPrefix .. var_4_2

	setImageSprite = var_5

	local var_4_4 = arg_4_0.paintBackTF

	LoadSprite = var_1_10008

	var_5(var_4_4, var_1_10008(var_4_3, var_4_2))

	LeanTween = var_5

	local var_4_5 = var_5.value

	go = var_4_4

	local var_4_6 = var_4_5(var_4_4(arg_4_0.paintFrontTF), 1, 0, arg_4_0.paintSwitchTime)
	local var_4_7 = var_5.setOnUpdate

	System = var_8

	local var_4_8 = var_4_7(var_4_6, var_8.Action_float(function(arg_5_0)
		setImageAlpha = var_2_10001

		var_2_10001(arg_4_0.paintFrontTF, arg_5_0)

		setImageAlpha = var_2_10001

		var_2_10001(arg_4_0.paintBackTF, 1 - arg_5_0)

		return
	end))
	local var_4_9 = var_5.setOnComplete

	System = var_8

	var_4_9(var_4_8, var_8.Action(function()
		setImageFromImage = var_2_10000

		var_2_10000(arg_4_0.paintFrontTF, arg_4_0.paintBackTF)

		setImageAlpha = var_2_10000

		var_2_10000(arg_4_0.paintFrontTF, 1)

		setImageAlpha = var_2_10000

		var_2_10000(arg_4_0.paintBackTF, 0)

		arg_4_0.curPaintIndex = var_4_1

		local var_6_0 = arg_4_0.frameTimer

		var_0.Start(var_6_0)

		return
	end))

	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	onButton = var_1_10001

	var_1_10001(arg_7_0, arg_7_0.skinShopBtn, function()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_8_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_8_1(var_8_0, var_8_2, var_2_10004.SKINSHOP)

		return
	end)
	arg_7_0:initPaint()
	arg_7_0:initBtnList(arg_7_0.btnList1)
	arg_7_0:initBtnList(arg_7_0.btnList2)
	arg_7_0:initBtnList(arg_7_0.btnList3)
	arg_7_0:initTimer()

	return
end

function var_0_1.initPaint(arg_9_0)
	local var_9_0 = (arg_9_0.curPaintIndex - 1) % arg_9_0.paintCount + 1
	local var_9_1 = arg_9_0.paintNamePrefix .. var_1
	local var_9_2 = arg_9_0.paintPathPrefix .. var_9_1

	setImageSprite = var_5

	local var_9_3 = arg_9_0.paintFrontTF

	LoadSprite = var_1_10008

	var_5(var_9_3, var_1_10008(var_9_2, var_9_1))

	local var_9_4 = arg_9_0.paintNamePrefix .. var_9_0
	local var_9_5 = arg_9_0.paintPathPrefix .. var_9_4

	setImageSprite = var_5

	local var_9_6 = arg_9_0.paintBackTF

	LoadSprite = var_8

	var_5(var_9_6, var_8(var_9_5, var_9_4))

	return
end

function var_0_1.initBtnList(arg_10_0, arg_10_1)
	onButton = var_1_10002

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_1[1]

	local function var_10_2()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003.GO_PRAY_POOL)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_0, var_10_1, var_10_2, var_1_10007)

	onButton = var_1_10002

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_1[2]

	local function var_10_5()
		local var_12_0 = arg_10_0
		local var_12_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_12_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_12_1(var_12_0, var_12_2, var_2_10004.SUMMARY)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_3, var_10_4, var_10_5, var_1_10007)

	onButton = var_1_10002

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_1[3]

	local function var_10_8()
		local var_13_0 = arg_10_0
		local var_13_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_13_2 = var_2_10003.SELECT_ACTIVITY

		ActivityConst = var_2_10004

		var_13_1(var_13_0, var_13_2, var_2_10004.ACTIVITY_TYPE_RETURN_AWARD_ID4)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_6, var_10_7, var_10_8, var_1_10007)

	onButton = var_1_10002

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_1[4]

	local function var_10_11()
		local var_14_0 = arg_10_0
		local var_14_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_14_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_14_3 = var_2_10004.CHARGE
		local var_14_4 = {}

		ChargeScene = var_2_10006
		var_14_4.wrap = var_2_10006.TYPE_DIAMOND

		var_14_1(var_14_0, var_14_2, var_14_3, var_14_4)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_9, var_10_10, var_10_11, var_1_10007)

	onButton = var_1_10002

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_1[5]

	local function var_10_14()
		local var_15_0 = arg_10_0
		local var_15_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_15_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_15_1(var_15_0, var_15_2, var_2_10004.AMUSEMENT_PARK)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_12, var_10_13, var_10_14, var_1_10007)

	onButton = var_1_10002

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_1[6]

	local function var_10_17()
		local var_16_0 = arg_10_0
		local var_16_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_16_1(var_16_0, var_2_10003.GO_MINI_GAME, 23)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_15, var_10_16, var_10_17, var_1_10007)

	return
end

function var_0_1.initTimer(arg_17_0)
	local var_17_0 = 0.016666666666666666

	arg_17_0.paintStaticCountValue = 0
	Timer = var_2
	arg_17_0.frameTimer = var_2.New(function()
		arg_17_0.paintStaticCountValue = arg_17_0.paintStaticCountValue + var_17_0

		if arg_17_0.paintStaticCountValue >= arg_17_0.paintStaticTime then
			arg_17_0.paintStaticCountValue = 0

			local var_18_0 = arg_17_0

			var_0.switchNextPaint(var_18_0)
		end

		return
	end, var_17_0, -1, false)

	local var_17_1 = arg_17_0.frameTimer

	var_2.Start(var_17_1)

	Timer = var_2
	arg_17_0.frameTimer2 = var_2.New(function()
		if arg_17_0.scrollAble then
			local var_19_0 = arg_17_0.btnContainer.anchoredPosition.x - arg_17_0.btnSpeed * var_17_0

			if arg_17_0.startAnchoredPosX - var_19_0 >= arg_17_0.moveLength then
				var_19_0 = arg_17_0.btnContainer.anchoredPosition.x + arg_17_0.moveLength
			end

			local var_19_1 = arg_17_0.btnContainer

			Vector3 = var_2_10003
			var_19_1.anchoredPosition = var_2_10003(var_19_0, 0, 0)
		end

		return
	end, var_17_0, -1, false)

	local var_17_2 = arg_17_0.frameTimer2

	var_2.Start(var_17_2)

	return
end

function var_0_1.OnDestroy(arg_20_0)
	if arg_20_0.frameTimer then
		local var_20_0 = arg_20_0.frameTimer

		var_1.Stop(var_20_0)

		arg_20_0.frameTimer = nil
	end

	if arg_20_0.frameTimer2 then
		local var_20_1 = arg_20_0.frameTimer2

		var_1.Stop(var_20_1)

		arg_20_0.frameTimer2 = nil
	end

	return
end

return var_0_1
