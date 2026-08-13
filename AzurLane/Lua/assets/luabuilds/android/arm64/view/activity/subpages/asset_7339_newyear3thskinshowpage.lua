class = var_0_10000

local var_0_0 = "NewYear3thSkinShowPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

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

	arg_2_0.goBtn = var_1.Find(var_2_3, "BtnGO")
	onButton = var_1

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.skinShopBtn

	local function var_2_6()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.SKINSHOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_4, var_2_5, var_2_6, var_1_10006)

	onButton = var_1

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.goBtn

	local function var_2_9()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.SPRING_TOWN)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_7, var_2_8, var_2_9, var_1_10006)

	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.paintCount = 20
	arg_5_0.curPaintIndex = 1
	arg_5_0.paintSwitchTime = 1
	arg_5_0.paintStaticTime = 3.5
	arg_5_0.paintStaticCountValue = 0
	arg_5_0.paintPathPrefix = "newyear3thskinshowpage/"
	arg_5_0.paintNamePrefix = "NewYearSkin"

	return
end

function var_0_1.switchNextPaint(arg_6_0)
	local var_6_0 = arg_6_0.frameTimer

	var_1.Stop(var_6_0)

	local var_6_1 = arg_6_0.curPaintIndex % arg_6_0.paintCount + 1
	local var_6_2 = arg_6_0.paintNamePrefix .. var_6_1
	local var_6_3 = arg_6_0.paintPathPrefix .. var_6_2

	setImageSprite = var_5

	local var_6_4 = arg_6_0.paintBackTF

	LoadSprite = var_1_10008

	var_5(var_6_4, var_1_10008(var_6_3, var_6_2))

	LeanTween = var_5

	local var_6_5 = var_5.value

	go = var_6_4

	local var_6_6 = var_6_5(var_6_4(arg_6_0.paintFrontTF), 1, 0, arg_6_0.paintSwitchTime)
	local var_6_7 = var_5.setOnUpdate

	System = var_8

	local var_6_8 = var_6_7(var_6_6, var_8.Action_float(function(arg_7_0)
		setImageAlpha = var_2_10001

		var_2_10001(arg_6_0.paintFrontTF, arg_7_0)

		setImageAlpha = var_2_10001

		var_2_10001(arg_6_0.paintBackTF, 1 - arg_7_0)

		return
	end))
	local var_6_9 = var_5.setOnComplete

	System = var_8

	var_6_9(var_6_8, var_8.Action(function()
		setImageFromImage = var_2_10000

		var_2_10000(arg_6_0.paintFrontTF, arg_6_0.paintBackTF)

		setImageAlpha = var_2_10000

		var_2_10000(arg_6_0.paintFrontTF, 1)

		setImageAlpha = var_2_10000

		var_2_10000(arg_6_0.paintBackTF, 0)

		arg_6_0.curPaintIndex = var_6_1

		local var_8_0 = arg_6_0.frameTimer

		var_0.Start(var_8_0)

		return
	end))

	return
end

function var_0_1.OnFirstFlush(arg_9_0)
	arg_9_0:initPaint()
	arg_9_0:initTimer()

	return
end

function var_0_1.initPaint(arg_10_0)
	local var_10_0 = (arg_10_0.curPaintIndex - 1) % arg_10_0.paintCount + 1
	local var_10_1 = arg_10_0.paintNamePrefix .. var_1
	local var_10_2 = arg_10_0.paintPathPrefix .. var_10_1

	setImageSprite = var_5

	local var_10_3 = arg_10_0.paintFrontTF

	LoadSprite = var_1_10008

	var_5(var_10_3, var_1_10008(var_10_2, var_10_1))

	local var_10_4 = arg_10_0.paintNamePrefix .. var_10_0
	local var_10_5 = arg_10_0.paintPathPrefix .. var_10_4

	setImageSprite = var_5

	local var_10_6 = arg_10_0.paintBackTF

	LoadSprite = var_8

	var_5(var_10_6, var_8(var_10_5, var_10_4))

	return
end

function var_0_1.initTimer(arg_11_0)
	local var_11_0 = 0.016666666666666666

	arg_11_0.paintStaticCountValue = 0
	Timer = var_2
	arg_11_0.frameTimer = var_2.New(function()
		arg_11_0.paintStaticCountValue = arg_11_0.paintStaticCountValue + var_11_0

		if arg_11_0.paintStaticCountValue >= arg_11_0.paintStaticTime then
			arg_11_0.paintStaticCountValue = 0

			local var_12_0 = arg_11_0

			var_0.switchNextPaint(var_12_0)
		end

		return
	end, var_11_0, -1, false)

	local var_11_1 = arg_11_0.frameTimer

	var_2.Start(var_11_1)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	if arg_13_0.frameTimer then
		local var_13_0 = arg_13_0.frameTimer

		var_1.Stop(var_13_0)

		arg_13_0.frameTimer = nil
	end

	return
end

return var_0_1
