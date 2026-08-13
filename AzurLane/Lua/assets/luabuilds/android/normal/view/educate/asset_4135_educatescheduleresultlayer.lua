class = var_0_10000

local var_0_0 = "EducateScheduleResultLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateScheduleResultUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "anim_root")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.anim = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "anim_root")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.animEvent = var_2_5(var_2_4, var_3(var_1_10004))
	arg_2_0.inAnimPlaying = true

	local var_2_6 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_6, function()
		arg_2_0.inAnimPlaying = false

		local var_3_0 = arg_2_0.animEvent

		var_0.SetEndEvent(var_3_0, function()
			local var_4_0 = arg_2_0

			var_0.emit(var_4_0, var_0_1.ON_CLOSE)

			return
		end)

		return
	end)

	local var_2_7 = arg_2_0._tf

	arg_2_0.windowTF = var_1.Find(var_2_7, "anim_root/window")

	local var_2_8 = arg_2_0.windowTF

	arg_2_0.personalTF = var_1.Find(var_2_8, "personal")

	local var_2_9 = arg_2_0.windowTF

	arg_2_0.majorArrTF = var_1.Find(var_2_9, "major")

	local var_2_10 = arg_2_0.windowTF

	arg_2_0.minorArrTF = var_1.Find(var_2_10, "minor")

	local var_2_11 = arg_2_0.windowTF

	arg_2_0.resTF = var_1.Find(var_2_11, "res/content")
	setText = var_1

	local var_2_12 = arg_2_0.windowTF
	local var_2_13 = var_2.Find(var_2_12, "tip")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("child_close_tip"))
	arg_2_0:BlurPanel(arg_2_0._tf, {
		groupDelta = 1
	})

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0._close(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	local var_5_3

	if not arg_5_0.contextData.plan_results then
		var_5_3 = {}
	end

	arg_5_0.result = {}
	arg_5_0.resResult = {}
	arg_5_0.resultEvent = {}
	arg_5_0.resResultEvent = {}
	arg_5_0.drops = {}

	local function var_5_4(arg_7_0, arg_7_1)
		ipairs = var_2_10002

		for iter_7_0, iter_7_1 in var_2_10002(arg_7_0) do
			table = var_2_10007

			var_2_10007.insert(arg_5_0.drops, iter_7_1)

			var_2_10007 = iter_7_1.type
			EducateConst = var_8

			if var_2_10007 == var_8.DROP_TYPE_ATTR then
				if arg_7_1 then
					if not arg_5_0.resultEvent[iter_7_1.id] then
						var_2_10007 = arg_5_0.resultEvent
						var_2_10007[iter_7_1.id] = 0
					end

					var_2_10007 = arg_5_0.resultEvent
					var_2_10007[iter_7_1.id] = arg_5_0.resultEvent[iter_7_1.id] + iter_7_1.number
				else
					if not arg_5_0.result[iter_7_1.id] then
						var_2_10007 = arg_5_0.result
						var_2_10007[iter_7_1.id] = 0
					end

					var_2_10007 = arg_5_0.result
					var_2_10007[iter_7_1.id] = arg_5_0.result[iter_7_1.id] + iter_7_1.number
				end
			end

			var_2_10007 = iter_7_1.type
			EducateConst = var_8

			if var_2_10007 == var_8.DROP_TYPE_RES then
				if arg_7_1 then
					if not arg_5_0.resResultEvent[iter_7_1.id] then
						var_2_10007 = arg_5_0.resResultEvent
						var_2_10007[iter_7_1.id] = 0
					end

					var_2_10007 = arg_5_0.resResultEvent
					var_2_10007[iter_7_1.id] = arg_5_0.resResultEvent[iter_7_1.id] + iter_7_1.number
				else
					if not arg_5_0.resResult[iter_7_1.id] then
						var_2_10007 = arg_5_0.resResult
						var_2_10007[iter_7_1.id] = 0
					end

					var_2_10007 = arg_5_0.resResult
					var_2_10007[iter_7_1.id] = arg_5_0.resResult[iter_7_1.id] + iter_7_1.number
				end
			end
		end

		return
	end

	ipairs = var_5_1

	for iter_5_0, iter_5_1 in var_5_1(var_5_3) do
		var_5_4(iter_5_1.plan_drops)
		var_5_4(iter_5_1.event_drops, true)
		var_5_4(iter_5_1.spec_event_drops)
	end

	getProxy = var_3
	EducateProxy = var_4

	local var_5_5 = var_3(var_4)

	arg_5_0.char = var_3.GetCharData(var_5_5)

	local var_5_6 = arg_5_0.char
	local var_5_7 = var_3.GetAttrIdsByType

	EducateChar = var_5
	arg_5_0.natureIds = var_5_7(var_5_6, var_5.ATTR_TYPE_PERSONALITY)

	local var_5_8 = arg_5_0.char
	local var_5_9 = var_3.GetAttrIdsByType

	EducateChar = var_5
	arg_5_0.majorIds = var_5_9(var_5_8, var_5.ATTR_TYPE_MAJOR)

	local var_5_10 = arg_5_0.char
	local var_5_11 = var_3.GetAttrIdsByType

	EducateChar = var_5
	arg_5_0.minorIds = var_5_11(var_5_10, var_5.ATTR_TYPE_MINOR)

	local var_5_12 = {}

	EducateChar = var_5_10
	var_5_12[1] = var_5_10.RES_MOOD_ID
	EducateChar = var_4
	var_5_12[2] = var_4.RES_MONEY_ID
	arg_5_0.resIds = var_5_12

	arg_5_0:updatePersonalPanel()
	arg_5_0:updateMajorPanel()
	arg_5_0:updateMinorPanel()
	arg_5_0:updateResPanel()

	return
end

function var_0_1.updatePersonalPanel(arg_8_0)
	EducateHelper = var_1_10001

	local var_8_0 = var_1_10001.IsShowNature()

	setActive = var_1_10002

	var_1_10002(arg_8_0.personalTF, var_8_0)

	if var_8_0 then
		ipairs = var_1_10002

		for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.natureIds) do
			local var_8_1 = arg_8_0.personalTF
			local var_8_2 = var_7.Find

			tostring = var_1_10009

			local var_8_3 = var_8_2(var_8_1, var_1_10009(iter_8_1))

			var_1_10009 = arg_8_0.char

			local var_8_4 = var_8.GetAttrById(var_1_10009, iter_8_1)

			setText = var_1_10009

			local var_8_5 = var_8_3
			local var_8_6 = var_8_3.Find(var_8_5, "old")

			pg = var_8_5

			var_1_10009(var_8_6, var_8_5.child_attr[iter_8_1].name .. " " .. var_8_4)

			if not arg_8_0.result[iter_8_1] then
				var_1_10009 = 0
			end

			setActive = var_8_6

			var_8_6(var_8_3:Find("new"), var_1_10009 ~= 0)

			if var_1_10009 ~= 0 then
				local var_8_7 = var_1_10009 > 0 and "39BFFF" or "FF6767"
				local var_8_8 = var_1_10009 > 0 and "+" or ""

				setText = var_12

				var_12(var_8_3:Find("new"), var_8_8 .. " " .. var_1_10009)

				setTextColor = var_12

				local var_8_9 = var_8_3
				local var_8_10 = var_8_3.Find(var_8_9, "new")

				Color = var_8_9

				var_12(var_8_10, var_8_9.NewHex(var_8_7))
			end
		end
	end

	return
end

function var_0_1.updateMajorPanel(arg_9_0)
	for iter_9_0 = 1, arg_9_0.majorArrTF.childCount do
		local var_9_0 = arg_9_0.majorArrTF
		local var_9_1 = var_5.GetChild(var_9_0, iter_9_0 - 1)
		local var_9_2 = arg_9_0.majorIds[iter_9_0]

		GetImageSpriteFromAtlasAsync = var_7

		var_7("ui/educatecommonui_atlas", "attr_" .. var_9_2, var_9_1:Find("icon_bg/icon"), true)

		setScrollText = var_7

		local var_9_3 = var_9_1
		local var_9_4 = var_9_1.Find(var_9_3, "name_mask/name")

		pg = var_9_3

		var_7(var_9_4, var_9_3.child_attr[var_9_2].name)

		local var_9_5 = arg_9_0.char
		local var_9_6 = var_7.GetAttrInfo(var_9_5, var_9_2)

		setText = var_9_5

		var_9_5(var_9_1:Find("grade/Text"), var_9_6)

		local var_9_7 = arg_9_0.char
		local var_9_8 = var_8.GetAttrById(var_9_7, var_9_2)

		setText = var_9_7

		var_9_7(var_9_1:Find("value_old"), var_9_8)

		EducateConst = var_9_7

		local var_9_9 = var_9_7.GRADE_2_COLOR[var_9_6][1]

		EducateConst = var_10

		local var_9_10 = var_10.GRADE_2_COLOR[var_9_6][2]

		setImageColor = var_11

		local var_9_11 = var_9_1
		local var_9_12 = var_9_1.Find(var_9_11, "gradient")

		Color = var_9_11

		var_11(var_9_12, var_9_11.NewHex(var_9_9))

		setImageColor = var_11

		local var_9_13 = var_9_1
		local var_9_14 = var_9_1.Find(var_9_13, "grade")

		Color = var_9_13

		var_11(var_9_14, var_9_13.NewHex(var_9_10))

		local var_9_15

		if not arg_9_0.result[var_9_2] then
			var_9_15 = 0
		end

		local var_9_16 = var_9_15 == 0 and "39393C" or "39BFFF"

		setActive = var_13

		var_13(var_9_1:Find("VX"), var_9_15 ~= 0)

		setImageColor = var_13

		local var_9_17 = var_9_1
		local var_9_18 = var_9_1.Find(var_9_17, "arrow")

		Color = var_9_17

		var_13(var_9_18, var_9_17.NewHex(var_9_16))

		setText = var_13

		var_13(var_9_1:Find("value_new"), var_9_8 + var_9_15)

		setTextColor = var_13

		local var_9_19 = var_9_1
		local var_9_20 = var_9_1.Find(var_9_19, "value_new")

		Color = var_9_19

		var_13(var_9_20, var_9_19.NewHex(var_9_16))
	end

	return
end

function var_0_1.updateMinorPanel(arg_10_0)
	for iter_10_0 = 1, arg_10_0.minorArrTF.childCount do
		local var_10_0 = arg_10_0.minorArrTF
		local var_10_1 = var_5.GetChild(var_10_0, iter_10_0 - 1)
		local var_10_2 = arg_10_0.minorIds[iter_10_0]

		GetImageSpriteFromAtlasAsync = var_7

		var_7("ui/educatecommonui_atlas", "attr_" .. var_10_2, var_10_1:Find("icon"), true)

		setText = var_7

		local var_10_3 = var_10_1
		local var_10_4 = var_10_1.Find(var_10_3, "name")

		pg = var_10_3

		var_7(var_10_4, var_10_3.child_attr[var_10_2].name)

		local var_10_5 = arg_10_0.char
		local var_10_6 = var_7.GetAttrById(var_10_5, var_10_2)

		setText = var_10_5

		var_10_5(var_10_1:Find("value/value/old"), var_10_6)

		local var_10_7

		if not arg_10_0.result[var_10_2] then
			var_10_7 = 0
		end

		setText = var_9

		var_9(var_10_1:Find("value/value/add"), "")

		local var_10_8

		if not arg_10_0.resultEvent[var_10_2] then
			var_10_8 = 0
		end

		setText = var_10

		var_10(var_10_1:Find("value/event_add"), "")

		local var_10_9 = var_10_7 ~= 0 or var_10_8 ~= 0

		setActive = var_11

		var_11(var_10_1:Find("VX"), var_10_9)

		if var_10_9 then
			onDelayTick = var_11

			var_11(function()
				if var_10_7 > 0 then
					setText = var_0

					local var_11_0 = var_10_1

					var_0(var_1.Find(var_11_0, "value/value/add"), "+" .. var_10_7)
				end

				if var_10_8 > 0 then
					setText = var_0

					local var_11_1 = var_10_1

					var_0(var_1.Find(var_11_1, "value/event_add"), "+" .. var_10_8)
				end

				return
			end, 0.891)
		end
	end

	return
end

function var_0_1.updateResPanel(arg_12_0)
	for iter_12_0 = 1, #arg_12_0.resIds do
		local var_12_0 = arg_12_0.resTF
		local var_12_1 = var_5.GetChild(var_12_0, iter_12_0 - 1)
		local var_12_2 = arg_12_0.resIds[iter_12_0]

		GetImageSpriteFromAtlasAsync = var_7

		var_7("ui/educatecommonui_atlas", "res_" .. var_12_2, var_12_1:Find("icon"), true)

		setText = var_7

		local var_12_3 = var_12_1
		local var_12_4 = var_12_1.Find(var_12_3, "name")

		pg = var_12_3

		var_7(var_12_4, var_12_3.child_resource[var_12_2].name)

		local var_12_5 = arg_12_0.char
		local var_12_6

		if var_7.GetResById(var_12_5, var_12_2) < 0 then
			var_12_6 = 0
		end

		setText = var_8

		var_8(var_12_1:Find("value/value/old"), var_12_6)

		local var_12_7

		if not arg_12_0.resResult[var_12_2] then
			var_12_7 = 0
		end

		local var_12_8 = var_12_7 == 0 and "" or "+" .. var_12_7

		setText = var_10

		var_10(var_12_1:Find("value/value/add"), var_12_8)

		local var_12_9

		if not arg_12_0.resResultEvent[var_12_2] then
			var_12_9 = 0
		end

		local var_12_10 = var_12_9 == 0 and "" or "+" .. var_12_9

		setText = var_12

		var_12(var_12_1:Find("value/event_add"), var_12_10)
	end

	return
end

function var_0_1._close(arg_13_0)
	if arg_13_0.inAnimPlaying then
		return
	end

	local var_13_0 = arg_13_0.anim

	var_1.Play(var_13_0, "anim_educate_result_out")

	return
end

function var_0_1.onBackPressed(arg_14_0)
	arg_14_0:_close()

	return
end

function var_0_1.willExit(arg_15_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)

	var_1.OnNextWeek(var_15_0)

	local var_15_1 = arg_15_0.animEvent

	var_1.SetEndEvent(var_15_1, nil)

	if arg_15_0.drops then
		EducateHelper = var_1

		var_1.UpdateDropsData(arg_15_0.drops)
	end

	arg_15_0:UnOverlayPanel(arg_15_0._tf)

	if arg_15_0.contextData.onExit then
		arg_15_0.contextData.onExit()
	end

	return
end

return var_0_1
