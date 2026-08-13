class = var_0_10000

local var_0_0 = "OtherWorldMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))
local var_0_2 = 0.45
local var_0_3 = 0.2
local var_0_4 = 1.2

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.effectBlankScreen = var_1.Find(var_1_0, "blank_screen_effect")

	local var_1_1 = arg_1_0.bg

	arg_1_0.effectOpen = var_1.Find(var_1_1, "open_effect")

	local var_1_2 = arg_1_0.bg

	arg_1_0.effectBlink = var_1.Find(var_1_2, "blink_effect")

	local var_1_3 = arg_1_0.bg

	arg_1_0.effectClick = var_1.Find(var_1_3, "click_effect")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.btnList

	arg_2_0.skinshopBtn = var_1.Find(var_2_0, "skinshop")
	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.skinshopBtn

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.PlayClickEffect(var_3_0, arg_2_0.skinshopBtn, function()
			pg = var_3_10000

			local var_4_0 = var_3_10000.m02
			local var_4_1 = var_0.sendNotification

			GAME = var_3_10003

			local var_4_2 = var_3_10003.GO_SCENE

			SCENE = var_3_10004

			var_4_1(var_4_0, var_4_2, var_3_10004.SKINSHOP)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

	local var_2_4 = arg_2_0.btnList

	arg_2_0.mountainBtn = var_1.Find(var_2_4, "mountain")
	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.mountainBtn

	local function var_2_7()
		local var_5_0 = arg_2_0

		var_0.PlayClickEffect(var_5_0, arg_2_0.mountainBtn, function()
			pg = var_3_10000

			local var_6_0 = var_3_10000.m02
			local var_6_1 = var_0.sendNotification

			GAME = var_3_10003

			local var_6_2 = var_3_10003.GO_SCENE

			SCENE = var_3_10004

			var_6_1(var_6_0, var_6_2, var_3_10004.OTHERWORLD_BACKHILL)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_5, var_2_6, var_2_7, var_1_10006)

	local var_2_8 = arg_2_0.btnList

	arg_2_0.buildBtn = var_1.Find(var_2_8, "build")
	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.buildBtn

	local function var_2_11()
		local var_7_0 = arg_2_0

		var_0.PlayClickEffect(var_7_0, arg_2_0.buildBtn, function()
			local var_8_0 = arg_2_0
			local var_8_1 = var_0.emit

			ActivityMediator = var_3_10003

			local var_8_2 = var_3_10003.EVENT_GO_SCENE

			SCENE = var_3_10004

			local var_8_3 = var_3_10004.GETBOAT
			local var_8_4 = {}

			BuildShipScene = var_3_10006
			var_8_4.projectName = var_3_10006.PROJECTS.ACTIVITY

			var_8_1(var_8_0, var_8_2, var_8_3, var_8_4)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_9, var_2_10, var_2_11, var_1_10006)

	local var_2_12 = arg_2_0.btnList

	arg_2_0.fightBtn = var_1.Find(var_2_12, "fight")
	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.fightBtn

	local function var_2_15()
		local var_9_0 = arg_2_0

		var_0.PlayClickEffect(var_9_0, arg_2_0.fightBtn, function()
			pg = var_3_10000

			local var_10_0 = var_3_10000.m02
			local var_10_1 = var_0.sendNotification

			GAME = var_3_10003

			local var_10_2 = var_3_10003.GO_SCENE

			SCENE = var_3_10004

			var_10_1(var_10_0, var_10_2, var_3_10004.OTHERWORLD_MAP)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_13, var_2_14, var_2_15, var_1_10006)
	arg_2_0:PlayOpenEffect()

	return
end

function var_0_1.PlayOpenEffect(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0.effectBlankScreen, true)

	setActive = var_1_10001

	var_1_10001(arg_11_0.effectOpen, false)

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.managedTween

	LeanTween = var_4

	var_11_1(var_11_0, var_4.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_11_0.effectOpen, true)

		return
	end, var_0_3, nil)

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.managedTween

	LeanTween = var_4

	var_11_3(var_11_2, var_4.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_11_0.effectBlankScreen, false)

		return
	end, var_0_2, nil)

	local var_11_4 = arg_11_0
	local var_11_5 = arg_11_0.managedTween

	LeanTween = var_4

	var_11_5(var_11_4, var_4.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_11_0.effectOpen, false)

		setActive = var_2_10000

		var_2_10000(arg_11_0.effectBlink, true)

		return
	end, var_0_3 + var_0_4, nil)

	return
end

function var_0_1.PlayClickEffect(arg_15_0, arg_15_1, arg_15_2)
	pg = var_1_10003

	local var_15_0 = var_1_10003.UIMgr.GetInstance().OverlayEffect
	local var_15_1 = var_3.GetChild(var_15_0, 0)

	Vector3 = var_1_10004

	local var_15_2 = var_1_10004(192, 60, 0)

	if var_15_1 then
		local var_15_3 = var_15_1.localPosition
		local var_15_4

		if not var_5.Sub(var_15_3, var_15_2) then
			var_15_4 = arg_15_1.localPosition
		end

		setLocalPosition = var_6

		var_6(arg_15_0.effectClick, var_15_4)

		setActive = var_6

		var_6(arg_15_0.effectClick, true)

		local var_15_5 = arg_15_0
		local var_15_6 = arg_15_0.managedTween

		LeanTween = var_9

		var_15_6(var_15_5, var_9.delayedCall, function()
			setActive = var_2_10000

			var_2_10000(arg_15_0.effectClick, false)

			if arg_15_2 then
				arg_15_2()
			end

			return
		end, 0.3, nil)

		return
	end
end

function var_0_1.OnDestroy(arg_17_0)
	arg_17_0:cleanManagedTween()

	return
end

return var_0_1
