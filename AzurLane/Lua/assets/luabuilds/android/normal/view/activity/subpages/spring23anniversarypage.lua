class = var_0_10000

local var_0_0 = "Spring23AnniversaryPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = 42
local var_0_3 = {}
local var_0_4 = 3.5
local var_0_5 = 1
local var_0_6 = 6

SCENE = var_0_10006

local var_0_7 = var_0_10006.NEWYEAR_BACKHILL_2023
local var_0_8 = "spring23a"

function var_0_1.OnInit(arg_1_0)
	arg_1_0.hideIndex = {}
	arg_1_0.scrollAble = false
	findTF = var_1

	local var_1_0 = var_1(arg_1_0._tf, "BtnList")

	setActive = var_2

	var_2(var_1_0, false)

	PLATFORM_CODE = var_2
	PLATFORM_CH = var_3

	if var_2 == var_3 then
		var_0_3 = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16
		}
	else
		PLATFORM_CODE = var_2
		PLATFORM_CHT = var_3

		if var_2 == var_3 then
			var_0_3 = {
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8,
				9,
				10,
				11,
				12,
				13,
				14,
				15,
				16
			}
		else
			var_0_3 = {
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8,
				9,
				10,
				11,
				12,
				13,
				14,
				15,
				16
			}
		end
	end

	PLATFORM_CODE = var_2
	PLATFORM_JP = var_3

	if var_2 ~= var_3 then
		PLATFORM_CODE = var_2
		PLATFORM_CHT = var_3

		if var_2 == var_3 then
			arg_1_0.hideIndex = {}
			arg_1_0.scrollAble = true
			Vector2 = var_2
			var_1_0.anchoredPosition = var_2(-11, -20)
			Vector2 = var_2
			var_1_0.sizeDelta = var_2(1437, 90)
		else
			PLATFORM_CODE = var_2
			PLATFORM_US = var_3

			if var_2 == var_3 then
				arg_1_0.hideIndex = {}
				arg_1_0.scrollAble = false
				Vector2 = var_2
				var_1_0.anchoredPosition = var_2(678, -20)
				Vector2 = var_2
				var_1_0.sizeDelta = var_2(1186, 90)
			else
				arg_1_0.hideIndex = {}
				arg_1_0.scrollAble = false
				Vector2 = var_2
				var_1_0.anchoredPosition = var_2(115, -20)
				Vector2 = var_2
				var_1_0.sizeDelta = var_2(1186, 90)
			end
		end

		arg_1_0:findUI()

		return
	end
end

function var_0_1.findUI(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.paintBackTF = var_1.Find(var_2_0, "Paints/PaintBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.paintFrontTF = var_1.Find(var_2_1, "Paints/PaintFront")

	local var_2_2 = arg_2_0._tf

	arg_2_0.skinShopBtn = var_1.Find(var_2_2, "BtnShop")

	local var_2_3 = arg_2_0._tf

	arg_2_0.btnGo = var_1.Find(var_2_3, "BtnGo")

	local var_2_4 = arg_2_0._tf

	arg_2_0.btnContainer = var_1.Find(var_2_4, "BtnList/Viewport/Content")

	local var_2_5 = arg_2_0.btnContainer.childCount / 3

	arg_2_0.btnList1 = {}

	for iter_2_0 = 0, var_2_5 - 1 do
		var_1_10006 = arg_2_0.btnList1

		local var_2_6 = iter_2_0 + 1
		local var_2_7 = arg_2_0.btnContainer

		var_1_10006[var_2_6] = var_8.GetChild(var_2_7, iter_2_0)
	end

	arg_2_0.btnList2 = {}

	for iter_2_1 = var_2_5, 2 * var_2_5 - 1 do
		var_1_10006 = arg_2_0.btnList2

		local var_2_8 = #arg_2_0.btnList2 + 1
		local var_2_9 = arg_2_0.btnContainer

		var_1_10006[var_2_8] = var_8.GetChild(var_2_9, iter_2_1)
	end

	arg_2_0.btnList3 = {}

	for iter_2_2 = var_2_5 * 2, 3 * var_2_5 - 1 do
		var_1_10006 = arg_2_0.btnList3

		local var_2_10 = #arg_2_0.btnList3 + 1
		local var_2_11 = arg_2_0.btnContainer

		var_1_10006[var_2_10] = var_8.GetChild(var_2_11, iter_2_2)
	end

	for iter_2_3 = 1, var_2_5 * 3 do
		table = var_1_10006

		if var_1_10006.contains(arg_2_0.hideIndex, (iter_2_3 - 1) % var_0_6 + 1) or not arg_2_0.scrollAble and var_0_6 < iter_2_3 then
			setActive = var_1_10006

			local var_2_12 = arg_2_0.btnContainer

			var_1_10006(var_7.GetChild(var_2_12, iter_2_3 - 1), false)
		end
	end

	GetComponent = var_2
	arg_2_0.gridLayoutGroupCom = var_2(arg_2_0.btnContainer, "GridLayoutGroup")

	return
end

function var_0_1.initData(arg_3_0)
	local var_3_0 = arg_3_0.activity

	arg_3_0.displayDatas = var_1.getConfig(var_3_0, "config_client").display_link

	local var_3_1 = {}

	if arg_3_0.displayDatas and #arg_3_0.displayDatas then
		for iter_3_0 = 1, #arg_3_0.displayDatas do
			var_1_10007 = arg_3_0.displayDatas[iter_3_0][1]

			if var_6[2] and var_8 ~= 0 then
				pg = var_1_10009
				var_1_10009 = var_1_10009.shop_template[var_8].time
				pg = var_1_10010

				local var_3_2 = var_1_10010.TimeMgr.GetInstance()
				local var_3_3

				var_1_10010, var_3_3 = var_1_10010.inTime(var_3_2, var_1_10009)

				if not var_1_10010 then
					table = var_12

					var_12.insert(var_3_1, var_1_10007)
				end
			end
		end
	end

	if var_3_1 and #var_3_1 > 0 then
		for iter_3_1 = #var_0_3, 1, -1 do
			local var_3_4 = var_0_3[iter_3_1]

			table = var_1_10007

			if var_1_10007.contains(var_3_1, var_3_4) then
				table = var_1_10007

				var_1_10007.remove(var_0_3, iter_3_1)
			end
		end
	end

	arg_3_0.paintCount = #var_0_3
	math = var_2
	arg_3_0.curPaintIndex = var_2.random(1, #var_0_3)
	arg_3_0.paintSwitchTime = var_0_5
	arg_3_0.paintStaticTime = var_0_4
	arg_3_0.paintStaticCountValue = 0
	arg_3_0.paintPathPrefix = "clutter/"
	arg_3_0.paintNamePrefix = var_0_8
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
	local var_4_2 = arg_4_0.paintNamePrefix .. var_0_3[var_4_1]
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
	arg_7_0:initData()

	onButton = var_1

	var_1(arg_7_0, arg_7_0.skinShopBtn, function()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_8_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.SKINSHOP)

		return
	end)

	onButton = var_1

	var_1(arg_7_0, arg_7_0.btnGo, function()
		local var_9_0 = arg_7_0
		local var_9_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_9_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_9_1(var_9_0, var_9_2, var_2_10003.SPRING_FESTIVAL_BACKHILL_2023)

		return
	end)
	arg_7_0:initPaint()
	arg_7_0:initBtnList(arg_7_0.btnList1)
	arg_7_0:initBtnList(arg_7_0.btnList2)
	arg_7_0:initBtnList(arg_7_0.btnList3)
	arg_7_0:initTimer()

	return
end

function var_0_1.initPaint(arg_10_0)
	local var_10_0 = (arg_10_0.curPaintIndex - 1) % arg_10_0.paintCount + 1
	local var_10_1 = arg_10_0.paintNamePrefix .. var_0_3[var_10_0]
	local var_10_2 = arg_10_0.paintPathPrefix .. var_10_1

	setImageSprite = var_5

	local var_10_3 = arg_10_0.paintFrontTF

	LoadSprite = var_1_10007

	var_5(var_10_3, var_1_10007(var_10_2, var_10_1))

	local var_10_4 = arg_10_0.paintNamePrefix .. var_0_3[var_10_0]
	local var_10_5 = arg_10_0.paintPathPrefix .. var_10_4

	setImageSprite = var_5

	local var_10_6 = arg_10_0.paintBackTF

	LoadSprite = var_7

	var_5(var_10_6, var_7(var_10_5, var_10_4))

	return
end

function var_0_1.initBtnList(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_1 do
		arg_11_0:initBtnEvent(arg_11_1[iter_11_0], iter_11_0)
	end

	return
end

function var_0_1.initBtnEvent(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == 1 then
		onButton = var_1_10003

		local var_12_0 = arg_12_0
		local var_12_1 = arg_12_1

		local function var_12_2()
			local var_13_0 = arg_12_0
			local var_13_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_13_1(var_13_0, var_2_10002.GO_PRAY_POOL)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10003(var_12_0, var_12_1, var_12_2, var_1_10007)
	elseif arg_12_2 == 2 then
		onButton = var_1_10003

		local var_12_3 = arg_12_0
		local var_12_4 = arg_12_1

		local function var_12_5()
			local var_14_0 = arg_12_0
			local var_14_1 = var_0.emit

			ActivityMediator = var_2_10002

			local var_14_2 = var_2_10002.SELECT_ACTIVITY

			ActivityConst = var_2_10003

			var_14_1(var_14_0, var_14_2, var_2_10003.ACTIVITY_TYPE_RETURN_AWARD_ID5)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10003(var_12_3, var_12_4, var_12_5, var_1_10007)
	elseif arg_12_2 == 3 then
		onButton = var_1_10003

		local var_12_6 = arg_12_0
		local var_12_7 = arg_12_1

		local function var_12_8()
			local var_15_0 = arg_12_0
			local var_15_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_15_1(var_15_0, var_2_10002.EVENT_GO_SCENE, var_0_7)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10003(var_12_6, var_12_7, var_12_8, var_1_10007)
	elseif arg_12_2 == 4 then
		onButton = var_1_10003

		local var_12_9 = arg_12_0
		local var_12_10 = arg_12_1

		local function var_12_11()
			local var_16_0 = arg_12_0
			local var_16_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_16_1(var_16_0, var_2_10002.GO_MINI_GAME, var_0_2)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10003(var_12_9, var_12_10, var_12_11, var_1_10007)
	elseif arg_12_2 == 5 then
		onButton = var_1_10003

		local var_12_12 = arg_12_0
		local var_12_13 = arg_12_1

		local function var_12_14()
			local var_17_0 = arg_12_0
			local var_17_1 = var_0.emit

			ActivityMediator = var_2_10002

			local var_17_2 = var_2_10002.EVENT_GO_SCENE

			SCENE = var_2_10003

			var_17_1(var_17_0, var_17_2, var_2_10003.SUMMARY)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10003(var_12_12, var_12_13, var_12_14, var_1_10007)
	elseif arg_12_2 == 6 then
		onButton = var_1_10003

		local var_12_15 = arg_12_0
		local var_12_16 = arg_12_1

		local function var_12_17()
			local var_18_0 = arg_12_0
			local var_18_1 = var_0.emit

			ActivityMediator = var_2_10002

			local var_18_2 = var_2_10002.EVENT_GO_SCENE

			SCENE = var_2_10003

			local var_18_3 = var_2_10003.CHARGE
			local var_18_4 = {}

			ChargeScene = var_2_10005
			var_18_4.wrap = var_2_10005.TYPE_DIAMOND

			var_18_1(var_18_0, var_18_2, var_18_3, var_18_4)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10003(var_12_15, var_12_16, var_12_17, var_1_10007)
	end

	return
end

function var_0_1.initTimer(arg_19_0)
	local var_19_0 = 0.016666666666666666

	arg_19_0.paintStaticCountValue = 0
	Timer = var_2
	arg_19_0.frameTimer = var_2.New(function()
		arg_19_0.paintStaticCountValue = arg_19_0.paintStaticCountValue + var_19_0

		if arg_19_0.paintStaticCountValue >= arg_19_0.paintStaticTime then
			arg_19_0.paintStaticCountValue = 0

			local var_20_0 = arg_19_0

			var_0.switchNextPaint(var_20_0)
		end

		return
	end, var_19_0, -1, false)

	local var_19_1 = arg_19_0.frameTimer

	var_2.Start(var_19_1)

	if arg_19_0.scrollAble then
		Timer = var_2
		arg_19_0.frameTimer2 = var_2.New(function()
			local var_21_0 = arg_19_0.btnContainer.anchoredPosition.x - arg_19_0.btnSpeed * var_19_0

			if arg_19_0.startAnchoredPosX - var_21_0 >= arg_19_0.moveLength then
				var_21_0 = arg_19_0.btnContainer.anchoredPosition.x + arg_19_0.moveLength
			end

			local var_21_1 = arg_19_0.btnContainer

			Vector3 = var_2_10003
			var_21_1.anchoredPosition = var_2_10003(var_21_0, 0, 0)

			return
		end, var_19_0, -1, false)

		local var_19_2 = arg_19_0.frameTimer2

		var_2.Start(var_19_2)
	end

	return
end

function var_0_1.OnDestroy(arg_22_0)
	LeanTween = var_1_10001

	local var_22_0 = var_1_10001.isTweening

	go = var_1_10002

	if var_22_0(var_1_10002(arg_22_0.paintFrontTF)) then
		LeanTween = var_1

		local var_22_1 = var_1.cancel

		go = var_2

		var_22_1(var_2(arg_22_0.paintFrontTF))
	end

	if arg_22_0.frameTimer then
		local var_22_2 = arg_22_0.frameTimer

		var_1.Stop(var_22_2)

		arg_22_0.frameTimer = nil
	end

	if arg_22_0.frameTimer2 then
		local var_22_3 = arg_22_0.frameTimer2

		var_1.Stop(var_22_3)

		arg_22_0.frameTimer2 = nil
	end

	return
end

return var_0_1
