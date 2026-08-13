class = var_0_10000

local var_0_0 = "SSSSMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))
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

			var_6_1(var_6_0, var_6_2, var_3_10004.SSSS_ACADEMY)

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

	arg_2_0.shopBtn = var_1.Find(var_2_12, "shop")
	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.shopBtn

	local function var_2_15()
		local var_9_0 = arg_2_0

		var_0.PlayClickEffect(var_9_0, arg_2_0.shopBtn, function()
			configClinet = var_3_10000

			if var_3_10000.shopLinkActID then
				getProxy = var_10_0
				ActivityProxy = var_3_10002
				var_3_10002 = var_10_0(var_3_10002)

				local var_10_0 = var_10_0.getActivitiesById

				configClinet = var_3_10003

				if not var_10_0(var_3_10002, var_3_10003.shopLinkActID) then
					underscore = var_10_0
					var_10_0 = var_10_0.detect
					getProxy = var_3_10002
					ActivityProxy = var_3_10004
					var_3_10004 = var_3_10002(var_3_10004)

					local var_10_1 = var_2.getActivitiesByType

					ActivityConst = var_3_10005
					var_10_0 = var_10_0(var_10_1(var_3_10004, var_3_10005.ACTIVITY_TYPE_SHOP), function(arg_11_0)
						return not arg_11_0:isEnd()
					end)
				end

				if not var_10_0 or var_10_0:isEnd() then
					pg = var_3_10001

					local var_10_2 = var_3_10001.TipsMgr.GetInstance()
					local var_10_3 = var_1.ShowTips

					i18n = var_3_10004

					var_10_3(var_10_2, var_3_10004("common_activity_end"))

					return
				end

				local var_10_4 = arg_2_0
				local var_10_5 = var_1.emit

				ActivityMediator = var_3_10004

				local var_10_6 = var_3_10004.GO_SHOPS_LAYER
				local var_10_7 = {}

				NewShopsScene = var_3_10006
				var_10_7.warp = var_3_10006.TYPE_ACTIVITY
				var_10_7.actId = var_10_0.id

				var_10_5(var_10_4, var_10_6, var_10_7)

				return
			end
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_13, var_2_14, var_2_15, var_1_10006)

	local var_2_16 = arg_2_0.btnList

	arg_2_0.fightBtn = var_1.Find(var_2_16, "fight")
	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.fightBtn

	local function var_2_19()
		local var_12_0 = arg_2_0

		var_0.PlayClickEffect(var_12_0, arg_2_0.fightBtn, function()
			local var_13_0 = arg_2_0
			local var_13_1 = var_0.emit

			ActivityMediator = var_3_10003

			var_13_1(var_13_0, var_3_10003.BATTLE_OPERA)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_17, var_2_18, var_2_19, var_1_10006)
	arg_2_0:PlayOpenEffect()

	return
end

function var_0_1.PlayOpenEffect(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.effectBlankScreen, true)

	setActive = var_1_10001

	var_1_10001(arg_14_0.effectOpen, false)

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.managedTween

	LeanTween = var_4

	var_14_1(var_14_0, var_4.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_14_0.effectOpen, true)

		pg = var_2_10000

		local var_15_0 = var_2_10000.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_15_0, var_0_5)

		return
	end, var_0_3, nil)

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.managedTween

	LeanTween = var_4

	var_14_3(var_14_2, var_4.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_14_0.effectBlankScreen, false)

		return
	end, var_0_2, nil)

	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.managedTween

	LeanTween = var_4

	var_14_5(var_14_4, var_4.delayedCall, function()
		setActive = var_2_10000

		var_2_10000(arg_14_0.effectOpen, false)

		setActive = var_2_10000

		var_2_10000(arg_14_0.effectBlink, true)

		return
	end, var_0_3 + var_0_4, nil)

	return
end

function var_0_1.PlayClickEffect(arg_18_0, arg_18_1, arg_18_2)
	pg = var_1_10003

	local var_18_0 = var_1_10003.UIMgr.GetInstance().OverlayEffect
	local var_18_1 = var_3.GetChild(var_18_0, 0)

	Vector3 = var_1_10004

	local var_18_2 = var_1_10004(192, 60, 0)

	if var_18_1 then
		local var_18_3 = var_18_1.localPosition
		local var_18_4

		if not var_5.Sub(var_18_3, var_18_2) then
			var_18_4 = arg_18_1.localPosition
		end

		setLocalPosition = var_6

		var_6(arg_18_0.effectClick, var_18_4)

		setActive = var_6

		var_6(arg_18_0.effectClick, true)

		local var_18_5 = arg_18_0
		local var_18_6 = arg_18_0.managedTween

		LeanTween = var_9

		var_18_6(var_18_5, var_9.delayedCall, function()
			setActive = var_2_10000

			var_2_10000(arg_18_0.effectClick, false)

			if arg_18_2 then
				arg_18_2()
			end

			return
		end, 0.3, nil)

		return
	end
end

function var_0_1.OnDestroy(arg_20_0)
	arg_20_0:cleanManagedTween()

	return
end

return var_0_1
