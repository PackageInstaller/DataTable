class = var_0_10000

local var_0_0 = "ThirdAnniversaryJPPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
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

	local var_2_4 = arg_2_0.btnContainer.childCount / 2

	arg_2_0.btnList1 = {}

	for iter_2_0 = 0, var_2_4 - 1 do
		local var_2_5 = arg_2_0.btnList1
		local var_2_6 = iter_2_0 + 1
		local var_2_7 = arg_2_0.btnContainer

		var_2_5[var_2_6] = var_8.GetChild(var_2_7, iter_2_0)
	end

	arg_2_0.btnList2 = {}

	for iter_2_1 = 5, 2 * var_2_4 - 1 do
		local var_2_8 = arg_2_0.btnList2
		local var_2_9 = #arg_2_0.btnList2 + 1
		local var_2_10 = arg_2_0.btnContainer

		var_2_8[var_2_9] = var_8.GetChild(var_2_10, iter_2_1)
	end

	GetComponent = var_2
	arg_2_0.gridLayoutGroupCom = var_2(arg_2_0.btnContainer, "GridLayoutGroup")

	return
end

function var_0_1.initData(arg_3_0)
	arg_3_0.paintCount = 18
	arg_3_0.curPaintIndex = 1
	arg_3_0.paintSwitchTime = 1
	arg_3_0.paintStaticTime = 3.5
	arg_3_0.paintStaticCountValue = 0
	arg_3_0.paintPathPrefix = "thirdanniversaryjppage/"
	arg_3_0.paintNamePrefix = "paint"
	arg_3_0.btnCount = arg_3_0.btnContainer.childCount / 2
	arg_3_0.btnSpeed = 50
	arg_3_0.btnSizeX = arg_3_0.gridLayoutGroupCom.cellSize.x
	arg_3_0.btnMarginX = arg_3_0.gridLayoutGroupCom.spacing.x
	arg_3_0.moveLength = arg_3_0.btnCount * (arg_3_0.btnSizeX + arg_3_0.btnMarginX)
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

	LoadSprite = var_1_10007

	var_5(var_4_4, var_1_10007(var_4_3, var_4_2))

	LeanTween = var_5

	local var_4_5 = var_5.value

	go = var_4_4

	local var_4_6 = var_4_5(var_4_4(arg_4_0.paintFrontTF), 1, 0, arg_4_0.paintSwitchTime)
	local var_4_7 = var_5.setOnUpdate

	System = var_7

	local var_4_8 = var_4_7(var_4_6, var_7.Action_float(function(arg_5_0)
		setImageAlpha = var_2_10001

		var_2_10001(arg_4_0.paintFrontTF, arg_5_0)

		setImageAlpha = var_2_10001

		var_2_10001(arg_4_0.paintBackTF, 1 - arg_5_0)

		return
	end))
	local var_4_9 = var_5.setOnComplete

	System = var_7

	var_4_9(var_4_8, var_7.Action(function()
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
	arg_7_0:initPaint()
	arg_7_0:initBtnList(arg_7_0.btnList1)
	arg_7_0:initBtnList(arg_7_0.btnList2)
	arg_7_0:initTimer()

	return
end

function var_0_1.initPaint(arg_8_0)
	local var_8_0 = (arg_8_0.curPaintIndex - 1) % arg_8_0.paintCount + 1
	local var_8_1 = arg_8_0.paintNamePrefix .. var_1
	local var_8_2 = arg_8_0.paintPathPrefix .. var_8_1

	setImageSprite = var_5

	local var_8_3 = arg_8_0.paintFrontTF

	LoadSprite = var_1_10007

	var_5(var_8_3, var_1_10007(var_8_2, var_8_1))

	local var_8_4 = arg_8_0.paintNamePrefix .. var_8_0
	local var_8_5 = arg_8_0.paintPathPrefix .. var_8_4

	setImageSprite = var_5

	local var_8_6 = arg_8_0.paintBackTF

	LoadSprite = var_7

	var_5(var_8_6, var_7(var_8_5, var_8_4))

	return
end

function var_0_1.initBtnList(arg_9_0, arg_9_1)
	onButton = var_1_10002

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_1[1]

	local function var_9_2()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.GO_PRAY_POOL)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_9_0, var_9_1, var_9_2, var_1_10006)

	onButton = var_1_10002

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_1[2]

	local function var_9_5()
		local var_11_0 = arg_9_0
		local var_11_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_11_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_11_1(var_11_0, var_11_2, var_2_10003.SKINSHOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_9_3, var_9_4, var_9_5, var_1_10006)

	onButton = var_1_10002

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_1[3]

	local function var_9_8()
		ActivityConst = var_2_10000

		local var_12_0 = var_2_10000.ACTIVITY_TYPE_RETURN_AWARD
		local var_12_1 = arg_9_0
		local var_12_2 = var_1.emit

		ActivityMediator = var_2_10003

		local var_12_3 = var_2_10003.SELECT_ACTIVITY

		getProxy = var_2_10004
		ActivityProxy = var_2_10005

		local var_12_4 = var_2_10004(var_2_10005)

		var_12_2(var_12_1, var_12_3, var_4.getActivityByType(var_12_4, var_12_0).id)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_9_6, var_9_7, var_9_8, var_1_10006)

	onButton = var_1_10002

	local var_9_9 = arg_9_0
	local var_9_10 = arg_9_1[4]

	local function var_9_11()
		local var_13_0 = arg_9_0
		local var_13_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_13_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_13_1(var_13_0, var_13_2, var_2_10003.THIRD_ANNIVERSARY_AKIBA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_9_9, var_9_10, var_9_11, var_1_10006)

	onButton = var_1_10002

	local var_9_12 = arg_9_0
	local var_9_13 = arg_9_1[5]

	local function var_9_14()
		local var_14_0 = arg_9_0
		local var_14_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_14_2 = var_2_10002.SELECT_ACTIVITY

		pg = var_2_10003

		var_14_1(var_14_0, var_14_2, var_2_10003.activity_const.JIUJIU_ADVENTURE_ID.act_id)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_9_12, var_9_13, var_9_14, var_1_10006)

	return
end

function var_0_1.initTimer(arg_15_0)
	local var_15_0 = 0.016666666666666666

	arg_15_0.paintStaticCountValue = 0
	Timer = var_2
	arg_15_0.frameTimer = var_2.New(function()
		arg_15_0.paintStaticCountValue = arg_15_0.paintStaticCountValue + var_15_0

		if arg_15_0.paintStaticCountValue >= arg_15_0.paintStaticTime then
			arg_15_0.paintStaticCountValue = 0

			local var_16_0 = arg_15_0

			var_0.switchNextPaint(var_16_0)
		end

		return
	end, var_15_0, -1, false)

	local var_15_1 = arg_15_0.frameTimer

	var_2.Start(var_15_1)

	Timer = var_2
	arg_15_0.frameTimer2 = var_2.New(function()
		local var_17_0 = arg_15_0.btnContainer.anchoredPosition.x - arg_15_0.btnSpeed * var_15_0
		local var_17_1 = arg_15_0.startAnchoredPosX - var_17_0

		if arg_15_0.moveLength <= var_17_1 then
			var_17_0 = arg_15_0.btnContainer.anchoredPosition.x + arg_15_0.moveLength
		end

		local var_17_2 = arg_15_0.btnContainer

		Vector3 = var_2
		var_17_2.anchoredPosition = var_2(var_17_0, 0, 0)

		return
	end, var_15_0, -1, false)

	local var_15_2 = arg_15_0.frameTimer2

	var_2.Start(var_15_2)

	return
end

function var_0_1.OnDestroy(arg_18_0)
	if arg_18_0.frameTimer then
		local var_18_0 = arg_18_0.frameTimer

		var_1.Stop(var_18_0)

		arg_18_0.frameTimer = nil
	end

	if arg_18_0.frameTimer2 then
		local var_18_1 = arg_18_0.frameTimer2

		var_1.Stop(var_18_1)

		arg_18_0.frameTimer2 = nil
	end

	return
end

return var_0_1
