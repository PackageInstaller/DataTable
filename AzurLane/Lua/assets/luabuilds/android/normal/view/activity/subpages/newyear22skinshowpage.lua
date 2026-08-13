class = var_0_10000

local var_0_0 = "NewYear22SkinShowPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = {
	{
		id = 403101,
		name = "Y22_adaerbote"
	},
	{
		id = 499061,
		name = "Y22_aogusite"
	},
	{
		id = 399051,
		name = "Y22_bailong"
	},
	{
		id = 405011,
		name = "Y22_bisimai"
	},
	{
		id = 108021,
		name = "Y22_daqinghuayu"
	},
	{
		id = 205091,
		name = "Y22_hao"
	},
	{
		id = 402041,
		name = "Y22_laibixi"
	},
	{
		id = 302211,
		name = "Y22_lei"
	},
	{
		id = 402061,
		name = "Y22_magedebao"
	},
	{
		id = 699011,
		name = "Y22_makeboluo"
	},
	{
		id = 202071,
		name = "Y22_nananpudun"
	},
	{
		id = 303141,
		name = "Y22_niaohai"
	},
	{
		id = 202291,
		name = "Y22_peineiluopo"
	},
	{
		id = 408021,
		name = "Y22_U47"
	},
	{
		id = 408121,
		name = "Y22_U1206"
	},
	{
		id = 405031,
		name = "Y22_wuerlixi"
	},
	{
		id = 401461,
		name = "Y22_Z46"
	},
	{
		id = 406021,
		name = "Y22_yibei"
	},
	{
		id = 201331,
		name = "Y22_yikaluosi"
	},
	{
		id = 205011,
		name = "Y22_yilishabai"
	}
}

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

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.SKINSHOP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_4, var_2_5, var_2_6, var_1_10005)

	onButton = var_1

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.goBtn

	local function var_2_9()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.NEWYEAR_BACKHILL_2022)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_7, var_2_8, var_2_9, var_1_10005)

	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.paintCount = 20
	arg_5_0.curPaintIndex = 1
	arg_5_0.paintSwitchTime = 1
	arg_5_0.paintStaticTime = 3.5
	arg_5_0.paintStaticCountValue = 0
	arg_5_0.paintPathPrefix = "NewYear22SkinShowPage/"

	return
end

function var_0_1.switchNextPaint(arg_6_0)
	local var_6_0 = arg_6_0.frameTimer

	var_1.Stop(var_6_0)

	local var_6_1 = arg_6_0.curPaintIndex % arg_6_0.paintCount + 1
	local var_6_2 = var_0_2[var_6_1].name
	local var_6_3 = arg_6_0.paintPathPrefix .. var_6_2

	pg = var_5

	local var_6_4 = var_5.ship_data_statistics[var_0_2[var_6_1].id].name

	setImageSprite = var_6

	local var_6_5 = arg_6_0.paintBackTF

	LoadSprite = var_1_10008

	var_6(var_6_5, var_1_10008(var_6_3, var_6_2))

	setText = var_6
	findTF = var_6_5

	var_6(var_6_5(arg_6_0.paintBackTF, "txt"), var_6_4)

	setText = var_6
	findTF = var_7

	var_6(var_7(arg_6_0.paintBackTF, "outlineTxt"), var_6_4)

	GetComponent = var_6

	local var_6_6 = arg_6_0.paintFrontTF

	typeof = var_8
	CanvasGroup = var_9

	local var_6_7 = var_6(var_6_6, var_8(var_9))

	GetComponent = var_6_6

	local var_6_8 = arg_6_0.paintBackTF

	typeof = var_9
	CanvasGroup = var_10

	local var_6_9 = var_6_6(var_6_8, var_9(var_10))

	LeanTween = var_6_8

	local var_6_10 = var_6_8.value

	go = var_9

	local var_6_11 = var_6_10(var_9(arg_6_0.paintFrontTF), 1, 0, arg_6_0.paintSwitchTime)
	local var_6_12 = var_8.setOnUpdate

	System = var_10

	local var_6_13 = var_6_12(var_6_11, var_10.Action_float(function(arg_7_0)
		var_6_7.alpha = arg_7_0
		var_6_9.alpha = 1 - arg_7_0

		return
	end))
	local var_6_14 = var_8.setOnComplete

	System = var_10

	var_6_14(var_6_13, var_10.Action(function()
		setImageFromImage = var_2_10000

		var_2_10000(arg_6_0.paintFrontTF, arg_6_0.paintBackTF)

		var_6_7.alpha = 1

		local var_8_0 = var_6_9

		var_8_0.alpha = 0
		setText = var_8_0
		findTF = var_1

		var_8_0(var_1(arg_6_0.paintFrontTF, "txt"), var_6_4)

		setText = var_8_0
		findTF = var_1

		var_8_0(var_1(arg_6_0.paintFrontTF, "outlineTxt"), var_6_4)

		arg_6_0.curPaintIndex = var_6_1

		local var_8_1 = arg_6_0.frameTimer

		var_0.Start(var_8_1)

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

	pg = var_3

	local var_10_1 = var_3.ship_data_statistics[var_0_2[var_10_0].id].name
	local var_10_2 = var_0_2[var_1].name
	local var_10_3 = arg_10_0.paintPathPrefix .. var_10_2

	setImageSprite = var_6

	local var_10_4 = arg_10_0.paintFrontTF

	LoadSprite = var_1_10008

	var_6(var_10_4, var_1_10008(var_10_3, var_10_2))

	setText = var_6
	findTF = var_10_4

	var_6(var_10_4(arg_10_0.paintFrontTF, "txt"), var_10_1)

	setText = var_6
	findTF = var_7

	var_6(var_7(arg_10_0.paintFrontTF, "outlineTxt"), var_10_1)

	pg = var_6

	local var_10_5 = var_6.ship_data_statistics[var_0_2[var_10_0].id].name
	local var_10_6 = var_0_2[var_10_0].name
	local var_10_7 = arg_10_0.paintPathPrefix .. var_10_6

	setImageSprite = var_7

	local var_10_8 = arg_10_0.paintBackTF

	LoadSprite = var_9

	var_7(var_10_8, var_9(var_10_7, var_10_6))

	setText = var_7
	findTF = var_10_8

	var_7(var_10_8(arg_10_0.paintBackTF, "txt"), var_10_5)

	setText = var_7
	findTF = var_8

	var_7(var_8(arg_10_0.paintBackTF, "outlineTxt"), var_10_5)

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
