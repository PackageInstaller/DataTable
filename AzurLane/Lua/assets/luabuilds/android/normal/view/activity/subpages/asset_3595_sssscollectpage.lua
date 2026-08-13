class = var_0_10000

local var_0_0 = "SSSSCollectPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.LinkCollectTemplatePage"))
local var_0_2 = 0.45
local var_0_3 = 0.2
local var_0_4 = 1.2
local var_0_5 = "event:/ui/kaiji"

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
	var_0_1.super.OnFirstFlush(arg_2_0)

	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client")

	if arg_2_0.furnitureThemeBtn and var_2_1.furniture_theme_link then
		removeOnButton = var_2

		var_2(arg_2_0.furnitureThemeBtn)

		onButton = var_2

		local var_2_2 = arg_2_0
		local var_2_3 = arg_2_0.furnitureThemeBtn

		local function var_2_4()
			local var_3_0 = arg_2_0

			var_0.PlayClickEffect(var_3_0, arg_2_0.furnitureThemeBtn, function()
				local var_4_0 = arg_2_0

				var_0.DoSkip(var_4_0, var_2_1.furniture_theme_link[1], var_2_1.furniture_theme_link[2])

				return
			end)

			return
		end

		SFX_PANEL = var_1_10006

		var_2(var_2_2, var_2_3, var_2_4, var_1_10006)
	end

	if arg_2_0.medalBtn and var_2_1.medal_link then
		removeOnButton = var_2

		var_2(arg_2_0.medalBtn)

		onButton = var_2

		local var_2_5 = arg_2_0
		local var_2_6 = arg_2_0.medalBtn

		local function var_2_7()
			local var_5_0 = arg_2_0

			var_0.PlayClickEffect(var_5_0, arg_2_0.furnitureThemeBtn, function()
				local var_6_0 = arg_2_0

				var_0.DoSkip(var_6_0, var_2_1.medal_link[1], var_2_1.medal_link[2])

				return
			end)

			return
		end

		SFX_PANEL = var_1_10006

		var_2(var_2_5, var_2_6, var_2_7, var_1_10006)
	end

	arg_2_0:PlayOpenEffect()

	return
end

function var_0_1.PlayOpenEffect(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0.effectBlankScreen, true)

	setActive = var_1_10001

	var_1_10001(arg_7_0.effectOpen, false)

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.managedTween

	LeanTween = var_3

	var_7_1(var_7_0, var_3.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_7_0.effectOpen, true)

		pg = var_2_10000

		local var_8_0 = var_2_10000.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_8_0, var_0_5)

		return
	end, var_0_3, nil)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.managedTween

	LeanTween = var_3

	var_7_3(var_7_2, var_3.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_7_0.effectBlankScreen, false)

		return
	end, var_0_2, nil)

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.managedTween

	LeanTween = var_3

	var_7_5(var_7_4, var_3.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_7_0.effectOpen, false)

		setActive = var_2_10000

		var_2_10000(arg_7_0.effectBlink, true)

		return
	end, var_0_3 + var_0_4, nil)

	return
end

function var_0_1.PlayClickEffect(arg_11_0, arg_11_1, arg_11_2)
	pg = var_1_10003

	local var_11_0 = var_1_10003.UIMgr.GetInstance().OverlayEffect
	local var_11_1 = var_3.GetChild(var_11_0, 0)

	Vector3 = var_11_0

	local var_11_2 = var_11_0(192, 60, 0)

	if var_11_1 then
		local var_11_3 = var_11_1.localPosition
		local var_11_4

		if not var_5.Sub(var_11_3, var_11_2) then
			var_11_4 = arg_11_1.localPosition
		end

		setLocalPosition = var_11_3

		var_11_3(arg_11_0.effectClick, var_11_4)

		setActive = var_11_3

		var_11_3(arg_11_0.effectClick, true)

		local var_11_5 = arg_11_0
		local var_11_6 = arg_11_0.managedTween

		LeanTween = var_8

		var_11_6(var_11_5, var_8.delayedCall, function()
			setActive = var_2_10000

			var_2_10000(arg_11_0.effectClick, false)

			if arg_11_2 then
				arg_11_2()
			end

			return
		end, 0.3, nil)

		return
	end
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0:cleanManagedTween()

	return
end

return var_0_1
