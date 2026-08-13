class = var_0_10000

local var_0_0 = "ALYCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityMainScene"))
local var_0_2 = 7

function var_0_1.getUIName(arg_1_0)
	return "ALYCoreActivityUI"
end

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	pg = var_1

	local var_2_0 = var_1.TimeMgr.GetInstance()
	local var_2_1 = var_1.inTime

	pg = var_3

	local var_2_2, var_2_3 = var_2_1(var_2_0, var_3.activity_template[var_0_2].time)
	local var_2_4
	local var_2_6

	if var_2_3 then
		pg = var_2_6

		local var_2_5 = var_2_6.TimeMgr.GetInstance()

		var_2_6 = var_2_6.Table2ServerTime(var_2_5, var_2_3)

		local var_2_7 = var_0_1

		var_2_4 = var_5.skinCommdityTimeStamps(var_2_7, var_2_6)
	end

	setText = var_2_6

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_5.Find(var_2_8, "adapt/top/btn_home/text_tip/Text (Legacy)")

	i18n = var_2_8

	var_2_6(var_2_9, var_2_8("yumia_main_tip_4", var_2_4))
	arg_2_0:Reset()

	local var_2_10 = arg_2_0.tabsList

	var_4.make(var_2_10, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			underscore = var_3

			if not var_3.detect(arg_2_0.activities, function(arg_4_0)
				tostring = var_3_10001

				return var_3_10001(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end) or var_3:isEnd() then
				setActive = var_4

				var_4(arg_3_2, false)
			elseif not arg_2_0.pageDic[var_3.id] then
				warning = var_4
				string = var_5

				var_4(var_5.format("without page in act:", var_3.id))
			else
				local var_3_0 = arg_2_0.pageDic[var_3.id]
				local var_3_2

				if var_3.id == 15 or var_3.id == 10 then
					local var_3_1 = arg_3_2

					var_3_2 = arg_3_2.Find(var_3_1, "tip")
					setActive = var_3_1

					local var_3_3 = var_3_2

					var_2_10009 = var_3

					var_3_1(var_3_3, var_3.readyToAchieve(var_2_10009))
				else
					setActive = var_3_2

					var_3_2(arg_3_2:Find("tip"), false)
				end

				onToggle = var_3_2

				local var_3_4 = arg_2_0
				local var_3_5 = arg_3_2

				local function var_3_6(arg_5_0)
					warning = var_3_10001

					var_3_10001(arg_3_1, arg_5_0)

					if arg_5_0 then
						if arg_3_1 == 3 then
							setActive = var_1

							local var_5_0 = arg_2_0._tf

							var_1(var_2.Find(var_5_0, "Image/VX"), false)
						else
							setActive = var_1

							local var_5_1 = arg_2_0._tf

							var_1(var_2.Find(var_5_1, "Image/VX"), true)
						end

						local var_5_2 = arg_2_0

						var_1.selectActivity(var_5_2, var_0)

						quickPlayAnimation = var_1

						local var_5_3 = arg_3_2

						var_1(var_2.Find(var_5_3, "on"), "Anim_ALYCoreActivityUI_tabs_selected")
					end

					return
				end

				SFX_PANEL = var_2_10009

				var_3_2(var_3_4, var_3_5, var_3_6, var_2_10009)
			end
		end

		return
	end)

	pg = var_4

	local var_2_11 = var_4.CameraFixMgr.GetInstance()
	local var_2_12 = var_4.bind

	pg = var_6
	arg_2_0.camEventId = var_2_12(var_2_11, var_6.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.UpdateAdapt(var_6_0)

		return
	end)

	arg_2_0:UpdateAdapt()

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_4.Find(var_2_13, "adapt/tabs/1/off")
	local var_2_15 = var_4.GetComponent

	typeof = var_6
	Animation = var_7
	arg_2_0.anim_1 = var_2_15(var_2_14, var_6(var_7))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_4.Find(var_2_16, "adapt/tabs/2/off")
	local var_2_18 = var_4.GetComponent

	typeof = var_6
	Animation = var_7
	arg_2_0.anim_2 = var_2_18(var_2_17, var_6(var_7))

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_4.Find(var_2_19, "adapt/tabs/3/off")
	local var_2_21 = var_4.GetComponent

	typeof = var_6
	Animation = var_7
	arg_2_0.anim_3 = var_2_21(var_2_20, var_6(var_7))

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_4.Find(var_2_22, "adapt/tabs/4/off")
	local var_2_24 = var_4.GetComponent

	typeof = var_6
	Animation = var_7
	arg_2_0.anim_4 = var_2_24(var_2_23, var_6(var_7))

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_4.Find(var_2_25, "adapt/tabs/5/off")
	local var_2_27 = var_4.GetComponent

	typeof = var_6
	Animation = var_7
	arg_2_0.anim_5 = var_2_27(var_2_26, var_6(var_7))

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_4.GetComponent

	typeof = var_6
	DftAniEvent = var_7
	arg_2_0.anim_tf_Event = var_2_29(var_2_28, var_6(var_7))

	local var_2_30 = arg_2_0.anim_tf_Event

	var_4.SetStartEvent(var_2_30, function()
		setCanvasGroupAlpha = var_2_10000

		local var_7_0 = arg_2_0._tf

		var_2_10000(var_1.Find(var_7_0, "adapt/tabs/1"), 1)

		for iter_7_0 = 4, 5 do
			onDelayTick = var_2_10004

			var_2_10004(function()
				if iter_7_0 == 4 then
					setCanvasGroupAlpha = var_0

					local var_8_0 = arg_2_0._tf

					var_0(var_1.Find(var_8_0, "adapt/tabs/3"), 1)

					setCanvasGroupAlpha = var_0

					local var_8_1 = arg_2_0._tf

					var_0(var_1.Find(var_8_1, "adapt/tabs/4"), 1)
				elseif iter_7_0 == 5 then
					setCanvasGroupAlpha = var_0

					local var_8_2 = arg_2_0._tf

					var_0(var_1.Find(var_8_2, "adapt/tabs/2"), 1)

					setCanvasGroupAlpha = var_0

					local var_8_3 = arg_2_0._tf

					var_0(var_1.Find(var_8_3, "adapt/tabs/5"), 1)
				end

				return
			end, 0.08 * (iter_7_0 - 3))
		end

		return
	end)

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_4.Find(var_2_31, "adapt/tabs/1/off")
	local var_2_33 = var_4.GetComponent

	typeof = var_6
	DftAniEvent = var_7
	arg_2_0.anim_1_Event = var_2_33(var_2_32, var_6(var_7))

	local var_2_34 = arg_2_0.anim_1_Event

	var_4.SetStartEvent(var_2_34, function()
		setCanvasGroupAlpha = var_2_10000

		local var_9_0 = arg_2_0._tf

		var_2_10000(var_1.Find(var_9_0, "adapt/tabs/3"), 1)

		setCanvasGroupAlpha = var_2_10000

		local var_9_1 = arg_2_0._tf

		var_2_10000(var_1.Find(var_9_1, "adapt/tabs/4"), 1)

		return
	end)

	return
end

function var_0_1.didEnter(arg_10_0)
	var_0_1.super.didEnter(arg_10_0)

	return
end

function var_0_1.UpdateAdapt(arg_11_0)
	local var_11_0 = 1.3333333333333333
	local var_11_1 = 2.1666666666666665

	pg = var_1_10003

	local var_11_2 = var_1_10003.CameraFixMgr.GetInstance().currentWidth / var_3.currentHeight

	math = var_5

	local var_11_3 = var_5.clamp(var_11_2, var_11_0, var_11_1)
	local var_11_4 = arg_11_0._tf
	local var_11_5 = var_5.GetComponent

	typeof = var_7
	AspectRatioFitter = var_8
	var_11_5(var_11_4, var_7(var_8)).aspectRatio = var_11_3

	return
end

function var_0_1.Reset(arg_12_0)
	for iter_12_0 = 1, 5 do
		setText = var_1_10005

		local var_12_0 = arg_12_0._tf
		local var_12_1 = var_6.Find(var_12_0, "adapt/tabs/" .. iter_12_0 .. "/off/Label/name_bg/name")

		i18n = var_12_0

		var_1_10005(var_12_1, var_12_0("yumia_main_tip_" .. iter_12_0 + 4))

		setText = var_1_10005

		local var_12_2 = arg_12_0._tf
		local var_12_3 = var_6.Find(var_12_2, "adapt/tabs/" .. iter_12_0 .. "/on/Label/name_bg/name")

		i18n = var_12_2

		var_1_10005(var_12_3, var_12_2("yumia_main_tip_" .. iter_12_0 + 4))
	end

	return
end

function var_0_1.skinCommdityTimeStamps(arg_13_0, arg_13_1)
	pg = var_1_10002

	local var_13_0 = var_1_10002.TimeMgr.GetInstance()
	local var_13_1 = var_2.GetServerTime(var_13_0)

	math = var_13_0

	local var_13_2 = var_13_0.max(arg_13_1 - var_13_1, 0)

	math = var_4

	if var_4.floor(var_13_2 / 0) > 0 then
		return var_4
	elseif var_4 <= 0 then
		return 0
	end

	return
end

function var_0_1.willExit(arg_14_0)
	var_0_1.super.willExit(arg_14_0)

	if arg_14_0.camEventId then
		pg = var_1

		local var_14_0 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_14_0, arg_14_0.camEventId)

		arg_14_0.camEventId = nil
	end

	return
end

return var_0_1
