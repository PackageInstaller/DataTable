class = var_0_10000

local var_0_0 = "FireworkFactoryView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

Mathf = var_0_0

function var_0_1.getUIName(arg_1_0)
	return "FireworkFactoryUI"
end

local var_0_2 = 50
local var_0_3 = {
	{
		color = "FFD26FFF",
		name = "na"
	},
	{
		color = "DE89ECFF",
		name = "k"
	},
	{
		color = "8F77DFFF",
		name = "rb"
	},
	{
		color = "70ad9f",
		name = "zn"
	},
	{
		color = "FF7069FF",
		name = "ca"
	},
	{
		color = "7faf6e",
		name = "cu"
	}
}
local var_0_4 = {
	"s",
	"a",
	"b",
	"c"
}

function var_0_1.TransformColor(arg_2_0)
	tonumber = var_1_10001
	string = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002.sub(arg_2_0, 1, 2), 16)

	tonumber = var_2
	string = var_3

	local var_2_1 = var_2(var_3.sub(arg_2_0, 3, 4), 16)

	tonumber = var_3
	string = var_4

	local var_2_2 = var_3(var_4.sub(arg_2_0, 5, 6), 16)

	Color = var_4

	return var_4.New(var_2_0 / 255, var_2_1 / 255, var_2_2 / 255)
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.top = var_1.Find(var_3_0, "top")

	local var_3_1 = arg_3_0._tf

	arg_3_0.plate = var_1.Find(var_3_1, "plate")

	local var_3_2 = arg_3_0._tf

	arg_3_0.storage = var_1.Find(var_3_2, "storage")

	local var_3_3 = arg_3_0._tf

	arg_3_0.dispenseView = var_1.Find(var_3_3, "top/dispenseView")
	setActive = var_1

	var_1(arg_3_0.dispenseView, false)

	local var_3_4 = arg_3_0._tf

	arg_3_0.resultWindow = var_1.Find(var_3_4, "top/resultwindow")
	setActive = var_1

	var_1(arg_3_0.resultWindow, false)

	local var_3_5 = arg_3_0.top

	arg_3_0.btn_back = var_1.Find(var_3_5, "noAdaptPanel/back")

	local var_3_6 = arg_3_0.top

	arg_3_0.btn_help = var_1.Find(var_3_6, "noAdaptPanel/title/help")

	local var_3_7 = arg_3_0.top

	arg_3_0.timesText = var_1.Find(var_3_7, "times/text")

	local var_3_8 = arg_3_0.plate

	arg_3_0.ballPlate = var_1.Find(var_3_8, "ball_plate")
	arg_3_0.plateRings = {}

	for iter_3_0 = 1, 3 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_3_9 = arg_3_0.plateRings
		local var_3_10 = arg_3_0.ballPlate

		var_1_10005(var_3_9, var_7.GetChild(var_3_10, iter_3_0))
	end

	local var_3_11 = arg_3_0.plate

	arg_3_0.btn_load = var_1.Find(var_3_11, "btn_load")

	local var_3_12 = arg_3_0.plate

	arg_3_0.ballSelectPanel = var_1.Find(var_3_12, "panel/layout")
	CustomIndexLayer = var_1
	arg_3_0.ballSelects = var_1.Clone2Full(arg_3_0.ballSelectPanel, 3)
	arg_3_0.ballSelectStatus = {
		0,
		0,
		0
	}
	arg_3_0.lastSelectedBall = nil

	local var_3_13 = arg_3_0.storage

	arg_3_0.ballStoragePanel = var_1.Find(var_3_13, "house/layout")
	CustomIndexLayer = var_1
	arg_3_0.ballStorages = var_1.Clone2Full(arg_3_0.ballStoragePanel, 6)

	local var_3_14 = arg_3_0._tf

	arg_3_0.screen_mask = var_1.Find(var_3_14, "mask")

	local var_3_15 = arg_3_0._tf

	arg_3_0.btn_next = var_1.Find(var_3_15, "Button")

	local var_3_16 = arg_3_0.btn_next

	arg_3_0.btn_next_text = var_1.Find(var_3_16, "Image")

	local var_3_17 = arg_3_0.dispenseView

	arg_3_0.desc_dispense = var_1.Find(var_3_17, "intro/Scroll View/Viewport/text")
	setText = var_1

	local var_3_18 = arg_3_0.desc_dispense

	i18n = var_3

	var_1(var_3_18, var_3("help_firework_produce"))

	local var_3_19 = arg_3_0.dispenseView

	arg_3_0.btn_dispenseBG = var_1.Find(var_3_19, "bg")

	local var_3_20 = arg_3_0.dispenseView

	arg_3_0.btn_hammer = var_1.Find(var_3_20, "container/Button")

	local var_3_21 = arg_3_0.btn_hammer

	arg_3_0.btn_hammer_text = var_1.Find(var_3_21, "text")

	local var_3_22 = arg_3_0.dispenseView
	local var_3_23 = var_1.Find(var_3_22, "container/Slider/Fill Area")

	arg_3_0.slider_powder = var_1.GetComponent(var_3_23, "Slider")

	local var_3_24 = arg_3_0.dispenseView
	local var_3_25 = var_1.Find(var_3_24, "progress/Slider")

	arg_3_0.slider_progress = var_1.GetComponent(var_3_25, "Slider")

	local var_3_26 = arg_3_0.dispenseView

	arg_3_0.slider_progress_bg = var_1.Find(var_3_26, "progress/Slider/Background/progressdi")

	local var_3_27 = arg_3_0.dispenseView

	arg_3_0.slider_bubble = var_1.Find(var_3_27, "container/Slider/Fill Area/Fill/handler/bubble")

	local var_3_28 = arg_3_0.slider_bubble

	arg_3_0.slider_bubble_text = var_1.Find(var_3_28, "text")

	local var_3_29 = arg_3_0.dispenseView

	arg_3_0.progress_width = var_1.Find(var_3_29, "progress/Slider/Handle Slide Area").rect.width

	local var_3_30 = arg_3_0.dispenseView

	arg_3_0.progress_sub_mark_1 = var_1.Find(var_3_30, "progress/Slider/Handle Slide Area/submark1")

	local var_3_31 = arg_3_0.dispenseView

	arg_3_0.progress_sub_mark_2 = var_1.Find(var_3_31, "progress/Slider/Handle Slide Area/submark2")
	arg_3_0.progress_dis = {}

	for iter_3_1 = 0, arg_3_0.slider_progress_bg.childCount - 1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_3_32 = arg_3_0.progress_dis
		local var_3_33 = arg_3_0.slider_progress_bg

		var_1_10005(var_3_32, var_7.GetChild(var_3_33, iter_3_1))
	end

	arg_3_0.result_digits = {}
	pg = var_1

	local var_3_34 = var_1.PoolMgr.GetInstance()

	var_1.GetPrefab(var_3_34, "ui/light01", "", true, function(arg_4_0)
		tf = var_2_10001

		local var_4_0 = var_2_10001(arg_4_0)

		var_1.SetParent(var_4_0, arg_3_0.dispenseView, false)
		arg_4_0:SetActive(false)

		arg_3_0.effect_light = arg_4_0

		return
	end)

	local var_3_35 = arg_3_0.resultWindow

	arg_3_0.result_bg = var_1.Find(var_3_35, "bg")

	local var_3_36 = arg_3_0.resultWindow

	arg_3_0.result_desc = var_1.Find(var_3_36, "window/Text")
	setText = var_1

	local var_3_37 = arg_3_0.result_desc

	i18n = var_3

	var_1(var_3_37, var_3("result_firework_produce"))

	local var_3_38 = arg_3_0.resultWindow

	arg_3_0.btn_result_confirm = var_1.Find(var_3_38, "window/button")

	local var_3_39 = arg_3_0.resultWindow
	local var_3_40 = var_1.Find(var_3_39, "window/pingjia")

	arg_3_0.result_pingjia = var_1.GetComponent(var_3_40, "Image")
	arg_3_0.flagStart = false
	arg_3_0.flagDispense = false
	arg_3_0.progressDispense = 0

	return
end

function var_0_1.SetSprite(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetComponent("Image")

	arg_5_0:SetImageSprite(var_5_0, arg_5_2)

	return
end

function var_0_1.SetImageSprite(arg_6_0, arg_6_1, arg_6_2)
	pg = var_1_10003

	local var_6_0 = var_1_10003.PoolMgr.GetInstance()

	var_3.GetSprite(var_6_0, "ui/fireworkfactoryui_atlas", arg_6_2, false, function(arg_7_0)
		arg_6_1.sprite = arg_7_0

		return
	end)

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.btn_back, function()
		if arg_8_0.flagDispense then
			local var_9_0 = arg_8_0

			var_0.ExitDispenseView(var_9_0)
		else
			local var_9_1 = arg_8_0

			if var_0.CheckpowderDispensed(var_9_1) and arg_8_0.flagStart then
				pg = var_0

				local var_9_2 = var_0.MsgboxMgr.GetInstance()
				local var_9_3 = var_0.ShowMsgBox
				local var_9_4 = {}

				i18n = var_2_10003
				var_9_4.content = var_2_10003("tips_firework_exit")

				function var_9_4.onYes()
					local var_10_0 = arg_8_0

					var_0.emit(var_10_0, var_0_1.ON_BACK_PRESSED)

					return
				end

				var_9_3(var_9_2, var_9_4)
			else
				local var_9_5 = arg_8_0

				var_0.emit(var_9_5, var_0_1.ON_BACK)
			end
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.btn_dispenseBG, function()
		local var_11_0 = arg_8_0

		var_0.ExitDispenseView(var_11_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.btn_help, function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_12_2.type = var_2_10003
		pg = var_2_10003
		var_12_2.helps = var_2_10003.gametip.help_xinnian2022_firework.tip

		var_12_1(var_12_0, var_12_2)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.btn_next, function()
		if not arg_8_0.flagStart then
			arg_8_0.flagStart = true

			local var_13_0 = arg_8_0

			var_0.UpdateNextBtn(var_13_0)
		else
			local var_13_1 = arg_8_0

			if var_0.CheckballLoaded(var_13_1) then
				local var_13_2 = arg_8_0

				var_0.EnterDispenseView(var_13_2)
			end
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.btn_hammer, function()
		if arg_8_0.progressDispense == 0 then
			local var_14_0 = arg_8_0

			var_1.ResetHammerAnim(var_14_0)

			local var_14_1 = arg_8_0

			var_1.FindNextPowderProgress(var_14_1)

			local var_14_2 = arg_8_0

			var_1.UpdateContainer(var_14_2)
		elseif var_0 == 1 then
			arg_8_0.result_digits[1] = arg_8_0.slider_powder.value * 100

			local var_14_3 = arg_8_0

			var_1.FindandStopProgress(var_14_3)

			local var_14_4 = arg_8_0

			var_1.UpdateContainer(var_14_4)
		elseif var_0 == 2 then
			arg_8_0.result_digits[2] = arg_8_0.slider_powder.value * 100

			local var_14_5 = arg_8_0

			var_1.FindandStopProgress(var_14_5)

			local var_14_6 = arg_8_0

			var_1.UpdateContainer(var_14_6)
		elseif var_0 == 3 then
			arg_8_0.result_digits[3] = arg_8_0.slider_powder.value * 100

			local var_14_7 = arg_8_0

			var_1.FindandStopProgress(var_14_7)

			local var_14_8 = arg_8_0

			var_1.UpdateContainer(var_14_8)
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.btn_result_confirm, function()
		local var_15_0 = arg_8_0

		var_0.ShowResult(var_15_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.result_bg, function()
		local var_16_0 = arg_8_0

		var_0.ShowResult(var_16_0)

		return
	end)

	for iter_8_0 = 1, #arg_8_0.ballStorages do
		local var_8_0 = arg_8_0.ballStorages[iter_8_0]

		arg_8_0:UpdateBall(var_8_0, iter_8_0)

		onButton = var_6

		var_6(arg_8_0, var_8_0:Find("mask"), function()
			if not arg_8_0.lastSelectedBall or arg_8_0.lastSelectedBall <= 0 then
				return
			end

			arg_8_0.ballSelectStatus[arg_8_0.lastSelectedBall] = iter_8_0

			local var_17_0 = arg_8_0

			var_0.UpdateRing(var_17_0, arg_8_0.lastSelectedBall, iter_8_0)

			local var_17_1 = arg_8_0
			local var_17_2 = var_0.UpdateBall
			local var_17_3 = arg_8_0.ballSelects[arg_8_0.lastSelectedBall]

			var_17_2(var_17_1, var_2.Find(var_17_3, "ball"), iter_8_0)

			local var_17_4 = arg_8_0

			var_0.UdpateSelectedBall(var_17_4, arg_8_0.lastSelectedBall + 1)

			local var_17_5 = arg_8_0

			var_0.UpdateNextBtn(var_17_5)

			return
		end)
	end

	for iter_8_1 = 1, #arg_8_0.ballSelects do
		local var_8_1 = arg_8_0.ballSelects[iter_8_1]

		arg_8_0:UpdateBall(var_8_1:Find("ball"), 0)
		arg_8_0:UpdateRing(iter_8_1, 0)

		onButton = var_6

		var_6(arg_8_0, var_8_1:Find("mask"), function()
			arg_8_0.ballSelectStatus[iter_8_1] = 0

			local var_18_0 = arg_8_0
			local var_18_1 = var_0.UpdateBall
			local var_18_2 = arg_8_0.ballSelects[iter_8_1]

			var_18_1(var_18_0, var_2.Find(var_18_2, "ball"), 0)

			local var_18_3 = arg_8_0

			var_0.UpdateRing(var_18_3, iter_8_1, 0)

			local var_18_4 = arg_8_0

			var_0.UdpateSelectedBall(var_18_4, iter_8_1)

			local var_18_5 = arg_8_0

			var_0.UpdateNextBtn(var_18_5)

			return
		end)
	end

	arg_8_0:ResetView()

	pg = var_1

	local var_8_2 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_8_2, arg_8_0.top)

	local var_8_3 = arg_8_0:GetMGData()
	local var_8_4 = var_1.GetSimpleValue(var_8_3, "score_reference")
	local var_8_5 = {}

	var_8_5[1] = 0
	ipairs = var_4

	for iter_8_2, iter_8_3 in var_4(var_8_4) do
		var_8_5[#var_8_4 - iter_8_2 + 2] = iter_8_3[1]
		var_8_5[#var_8_4 + iter_8_2 + 1] = iter_8_3[2]
	end

	var_8_5[#var_8_5] = 300

	for iter_8_4 = 1, #var_8_5 - 1 do
		local var_8_6 = var_8_5[iter_8_4] / 300
		local var_8_7 = var_8_5[iter_8_4 + 1] / 300
		local var_8_8 = arg_8_0.progress_dis[iter_8_4]

		Vector2 = var_1_10011
		var_8_8.anchorMin = var_1_10011(var_8_6, 0)

		local var_8_9 = arg_8_0.progress_dis[iter_8_4]

		Vector2 = var_1_10011
		var_8_9.anchorMax = var_1_10011(var_8_7, 1)

		local var_8_10 = arg_8_0.progress_dis[iter_8_4]

		Vector2 = var_1_10011
		var_8_10.sizeDelta = var_1_10011.zero
	end

	return
end

function var_0_1.UpdateNextBtn(arg_19_0)
	local var_19_0

	if not arg_19_0.flagStart then
		var_19_0 = "dispense_ready"

		local var_19_1 = arg_19_0:GetMGData()

		if var_2.GetRuntimeData(var_19_1, "elements") then
			local var_19_2 = #var_3

			if 3 < var_19_2 then
				local var_19_3 = var_3[4]

				SummerFeastScene = var_5

				if var_19_3 == var_5.GetCurrentDay() then
					var_19_0 = "dispense_retry"
				end
			end
		end

		arg_19_0:SetSprite(arg_19_0.btn_next_text, var_19_0)
	else
		arg_19_0:SetSprite(arg_19_0.btn_next_text, "dispense_confirm")
	end

	setActive = var_19_0

	var_19_0(arg_19_0.screen_mask, not arg_19_0.flagStart)

	local var_19_4, var_19_5

	if arg_19_0.flagStart then
		var_19_4 = arg_19_0
		var_19_5 = arg_19_0.CheckballLoaded(var_19_4)

		if false then
			var_19_5 = false
		end
	else
		var_19_5 = true
	end

	setButtonEnabled = var_19_4

	var_19_4(arg_19_0.btn_next, var_19_5)

	return
end

function var_0_1.UpdateDispenseBtn(arg_20_0)
	local var_20_0 = arg_20_0:CheckpowderDispensed()

	arg_20_0:SetImageSprite(arg_20_0.btn_load_img, var_20_0 and "btn_loadcompleted" or "btn_load")
	arg_20_0:SetSprite(arg_20_0.btn_load_text, var_20_0 and "load_completed" or "load_ready")

	setButtonEnabled = var_2

	var_2(arg_20_0.btn_load, not var_20_0)

	return
end

local var_0_5 = {
	"start",
	"first_time",
	"second_time",
	"third_time",
	"finish_time"
}

function var_0_1.FindandStopProgress(arg_21_0)
	arg_21_0:StopHammerAnim()

	setButtonEnabled = var_1

	var_1(arg_21_0.btn_hammer, false)

	setButtonEnabled = var_1

	var_1(arg_21_0.btn_dispenseBG, false)

	setText = var_1

	local var_21_0 = arg_21_0.slider_bubble_text

	math = var_3

	var_1(var_21_0, var_3.ceil(arg_21_0.result_digits[#arg_21_0.result_digits]) .. "%")

	setActive = var_1

	var_1(arg_21_0.slider_bubble, true)

	setActive = var_1

	var_1(arg_21_0.effect_light, true)

	arg_21_0.progressDispense = #arg_21_0.result_digits >= 3 and 4 or 0

	local var_21_1 = 0

	for iter_21_0 = 1, 3 do
		if arg_21_0.result_digits[iter_21_0] then
			var_21_1 = var_21_1 + var_6
		end
	end

	local var_21_2 = 0

	for iter_21_1 = 1, #arg_21_0.result_digits - 1 do
		if arg_21_0.result_digits[iter_21_1] then
			var_21_2 = var_21_2 + var_7

			if iter_21_1 == 1 then
				setActive = var_1_10008

				var_1_10008(arg_21_0.progress_sub_mark_1, true)

				Vector2 = var_1_10008
				var_1_10008 = var_1_10008(arg_21_0.progress_width * var_21_2 / 300, 27)
				arg_21_0.progress_sub_mark_1.anchoredPosition = var_1_10008
			elseif iter_21_1 == 2 then
				setActive = var_1_10008

				var_1_10008(arg_21_0.progress_sub_mark_2, true)

				Vector2 = var_1_10008
				var_1_10008 = var_1_10008(arg_21_0.progress_width * var_21_2 / 300, 27)
				arg_21_0.progress_sub_mark_2.anchoredPosition = var_1_10008
			end
		end
	end

	local var_21_3 = arg_21_0.slider_bubble.transform.position
	local var_21_4 = arg_21_0.slider_progress.transform.position
	local var_21_5 = arg_21_0.slider_progress.value

	LeanTween = iter_21_1

	local var_21_6 = iter_21_1.value(arg_21_0.slider_progress.gameObject, 0, 1, 1.5)
	local var_21_7 = var_6.setEase

	LeanTweenType = var_8

	local var_21_8 = var_21_7(var_21_6, var_8.linear)
	local var_21_9 = var_6.setOnUpdate

	System = var_8

	local var_21_10 = var_21_9(var_21_8, var_8.Action_float(function(arg_22_0)
		arg_21_0.slider_progress.value = var_0_0.Lerp(var_21_5, var_21_1 / 300, arg_22_0)

		if arg_21_0.effect_light then
			local var_22_0 = arg_21_0.effect_light.transform

			Vector3 = var_2

			local var_22_1 = var_2.Lerp(var_21_3, var_21_4, arg_22_0 * 3)

			Vector3 = var_3
			var_22_0.position = var_22_1 - var_3(0, 0, 2)

			if arg_22_0 * 3 > 1 then
				setActive = var_1

				var_1(arg_21_0.effect_light, false)
			end
		end

		return
	end))
	local var_21_11 = var_6.setOnComplete

	System = var_8
	arg_21_0.progressAnim = var_21_11(var_21_10, var_8.Action(function()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_21_0.btn_hammer, true)

		setButtonEnabled = var_2_10000

		var_2_10000(arg_21_0.btn_dispenseBG, true)

		if arg_21_0.progressDispense > 3 then
			local var_23_0 = arg_21_0

			var_0.FindNextPowderProgress(var_23_0)
		end

		return
	end))

	return
end

function var_0_1.FindNextPowderProgress(arg_24_0)
	arg_24_0.progressDispense = #arg_24_0.result_digits + 1

	if arg_24_0.progressDispense > 3 then
		arg_24_0:StopHammerAnim()

		setButtonEnabled = var_1

		var_1(arg_24_0.btn_hammer, false)
		arg_24_0:ShowResultWindow()
	end

	return
end

function var_0_1.ShowResultWindow(arg_25_0)
	if #arg_25_0.result_digits < 3 then
		return
	end

	setActive = var_1

	var_1(arg_25_0.resultWindow, true)

	local var_25_0 = arg_25_0:GetMGData()
	local var_25_1 = var_1.GetSimpleValue(var_25_0, "score_reference")
	local var_25_2 = 0

	for iter_25_0 = 1, 3 do
		var_25_2 = var_25_2 + arg_25_0.result_digits[iter_25_0]
	end

	local var_25_3 = 4

	ipairs = var_5

	for iter_25_1, iter_25_2 in var_5(var_25_1) do
		if var_25_2 >= iter_25_2[1] and var_25_2 <= iter_25_2[2] then
			var_25_3 = iter_25_1

			break
		end
	end

	if var_25_3 <= 0 then
		return
	end

	arg_25_0:SetImageSprite(arg_25_0.result_pingjia, var_0_4[var_25_3])

	return
end

function var_0_1.ShowResult(arg_26_0)
	if arg_26_0:GetMGHubData().count <= 0 then
		arg_26_0:AfterResult()
	else
		arg_26_0:GetReward()
	end

	setActive = var_2

	var_2(arg_26_0.resultWindow, false)

	return
end

function var_0_1.OnGetAwardDone(arg_27_0, arg_27_1)
	if arg_27_0:GetMGHubData().ultimate == 0 then
		local var_27_0 = var_2.usedtime

		var_1_10005 = var_2

		local var_27_1

		if not (var_27_0 >= var_2.getConfig(var_1_10005, "reward_need")) then
			var_27_1 = false
		else
			var_27_1 = true
		end

		local var_27_2 = arg_27_1.cmd

		MiniGameOPCommand = var_1_10005

		local var_27_3

		if var_27_2 == var_1_10005.CMD_COMPLETE and var_27_1 then
			pg = var_27_2
			var_27_3 = var_27_2.m02

			local var_27_4 = var_4.sendNotification

			GAME = var_1_10006

			local var_27_5 = var_1_10006.SEND_MINI_GAME_OP
			local var_27_6 = {
				hubid = var_2.id
			}

			MiniGameOPCommand = var_8
			var_27_6.cmd = var_8.CMD_ULTIMATE
			var_27_6.args1 = {}

			var_27_4(var_27_3, var_27_5, var_27_6)
		else
			local var_27_7 = arg_27_1.cmd

			MiniGameOPCommand = var_27_3

			if var_27_7 == var_27_3.CMD_ULTIMATE then
				arg_27_0:AfterResult()
			else
				arg_27_0:AfterResult()
			end
		end

		return
	end
end

function var_0_1.AfterResult(arg_28_0)
	SummerFeastScene = var_1_10001

	local var_28_0 = var_1_10001.GetCurrentDay()

	Clone = var_1_10002

	local var_28_1 = var_1_10002(arg_28_0.ballSelectStatus)

	table = var_3

	var_3.insert(var_28_1, var_28_0)
	arg_28_0:StoreDataToServer(var_28_1)

	onNextTick = var_3

	var_3(function()
		local var_29_0 = arg_28_0

		var_0.emit(var_29_0, var_0_1.ON_BACK)

		return
	end)

	return
end

function var_0_1.reset(arg_30_0)
	arg_30_0:ExitDispenseView()

	arg_30_0.flagStart = false
	arg_30_0.flagDispense = false
	arg_30_0.progressDispense = 0
	arg_30_0.result_digits = {}

	arg_30_0:ResetView()
	arg_30_0:UpdateNextBtn()

	return
end

function var_0_1.GetReward(arg_31_0)
	if #arg_31_0.result_digits < 3 then
		return
	end

	local var_31_0 = arg_31_0:GetMGData()
	local var_31_1 = var_1.GetSimpleValue(var_31_0, "score_reference")
	local var_31_2 = 0

	for iter_31_0 = 1, 3 do
		var_31_2 = var_31_2 + arg_31_0.result_digits[iter_31_0]
	end

	local var_31_3 = 4

	ipairs = var_5

	for iter_31_1, iter_31_2 in var_5(var_31_1) do
		if var_31_2 >= iter_31_2[1] and var_31_2 <= iter_31_2[2] then
			var_31_3 = iter_31_1

			break
		end
	end

	if var_31_3 <= 0 then
		return
	end

	arg_31_0:SendSuccess(var_31_3)

	return
end

function var_0_1.ResetHammerAnim(arg_32_0)
	if arg_32_0.hammerAnim then
		arg_32_0:StopHammerAnim()
	end

	setActive = var_1

	var_1(arg_32_0.slider_bubble, false)

	local var_32_0 = arg_32_0:GetMGData()
	local var_32_1

	if not var_1.GetSimpleValue(var_32_0, "roundTime") then
		var_32_1 = var_0_2
	end

	local var_32_2 = var_32_1 / 100

	LeanTween = var_32_0

	local var_32_3 = var_32_0.value(arg_32_0.slider_powder.gameObject, 0, 1, var_32_2 * 2)
	local var_32_4 = var_3.setEase

	LeanTweenType = var_5

	local var_32_5 = var_32_4(var_32_3, var_5.linear)
	local var_32_6 = var_3.setLoopPingPong(var_32_5)
	local var_32_7 = var_3.setOnUpdate

	System = var_5
	arg_32_0.hammerAnim = var_32_7(var_32_6, var_5.Action_float(function(arg_33_0)
		arg_32_0.slider_powder.value = arg_33_0

		return
	end))

	return
end

function var_0_1.StopHammerAnim(arg_34_0)
	if not arg_34_0.hammerAnim then
		return
	end

	LeanTween = var_1

	var_1.cancel(arg_34_0.hammerAnim.uniqueId)

	arg_34_0.hammerAnim = nil

	return
end

function var_0_1.UpdateContainer(arg_35_0)
	arg_35_0:SetSprite(arg_35_0.btn_hammer_text, var_0_5[arg_35_0.progressDispense + 1])

	local var_35_0 = 0
	local var_35_1 = true

	for iter_35_0 = 1, 3 do
		local var_35_2 = arg_35_0.result_digits[iter_35_0]

		var_35_1 = var_35_1 and var_35_2 ~= nil

		if var_35_2 then
			var_35_0 = var_35_0 + var_35_2
		end
	end

	arg_35_0.slider_progress.value = var_35_0 / 300

	return
end

function var_0_1.StopProgressAnim(arg_36_0)
	if not arg_36_0.progressAnim then
		return
	end

	LeanTween = var_1

	var_1.cancel(arg_36_0.progressAnim.uniqueId)

	arg_36_0.progressAnim = nil

	return
end

function var_0_1.CheckballLoaded(arg_37_0)
	_ = var_1_10001

	return var_1_10001.all(arg_37_0.ballSelectStatus, function(arg_38_0)
		return arg_38_0 > 0
	end)
end

function var_0_1.CheckpowderDispensed(arg_39_0)
	return #arg_39_0.result_digits >= 3
end

function var_0_1.UpdateBall(arg_40_0, arg_40_1, arg_40_2)
	setActive = var_1_10003

	var_1_10003(arg_40_1, arg_40_2 > 0)

	if arg_40_2 <= 0 then
		return
	end

	arg_40_1:GetComponent("Image").color = arg_40_0.TransformColor(var_0_3[arg_40_2].color)

	arg_40_0:SetSprite(arg_40_1:Find("symbol"), var_0_3[arg_40_2].name)

	return
end

function var_0_1.UpdateRing(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 <= 0 or arg_41_1 > 3 then
		return
	end

	local var_41_0 = arg_41_0.plateRings[arg_41_1]

	setActive = var_1_10004

	var_1_10004(var_41_0, arg_41_2 > 0)

	if arg_41_2 <= 0 then
		return
	end

	var_41_0:GetComponent("Image").color = arg_41_0.TransformColor(var_0_3[arg_41_2].color)

	return
end

function var_0_1.ResetView(arg_42_0)
	_ = var_1_10001

	var_1_10001.each(arg_42_0.plateRings, function(arg_43_0)
		setActive = var_2_10001

		var_2_10001(arg_43_0, false)

		return
	end)

	_ = var_1

	var_1.each(arg_42_0.ballSelects, function(arg_44_0)
		setActive = var_2_10001

		var_2_10001(arg_44_0:Find("ball"), false)

		setActive = var_2_10001

		var_2_10001(arg_44_0:Find("selected"), false)

		return
	end)

	local var_42_0 = arg_42_0
	local var_42_1 = arg_42_0.GetMGHubData(var_42_0)

	setText = var_42_0

	var_42_0(arg_42_0.timesText, var_42_1.count)

	local var_42_2 = arg_42_0:GetMGData()

	if var_2.GetRuntimeData(var_42_2, "elements") then
		local var_42_3 = #var_3

		if 3 < var_42_3 then
			local var_42_4 = var_3[4]

			SummerFeastScene = var_5

			if var_42_4 == var_5.GetCurrentDay() then
				for iter_42_0 = 1, 3 do
					local var_42_5 = var_3[iter_42_0]

					arg_42_0.ballSelectStatus[iter_42_0] = var_42_5

					if var_42_5 > 0 then
						arg_42_0:UpdateRing(iter_42_0, var_42_5)

						local var_42_6 = arg_42_0.ballSelects[iter_42_0]
						local var_42_7 = var_9.Find(var_42_6, "ball")

						arg_42_0:UpdateBall(var_42_7, var_42_5)
					end
				end
			end
		end
	end

	arg_42_0:UdpateSelectedBall(1)
	arg_42_0:UpdateNextBtn()

	setActive = var_4

	var_4(arg_42_0.slider_bubble, false)

	setActive = var_4

	var_4(arg_42_0.progress_sub_mark_1, false)

	setActive = var_4

	var_4(arg_42_0.progress_sub_mark_2, false)

	return
end

function var_0_1.UdpateSelectedBall(arg_45_0, arg_45_1)
	if arg_45_1 <= 0 or arg_45_1 > 3 then
		return
	end

	if arg_45_0.lastSelectedBall then
		if arg_45_0.lastSelectedBall == arg_45_1 then
			return
		end

		setActive = var_2

		local var_45_0 = arg_45_0.ballSelects[arg_45_0.lastSelectedBall]

		var_2(var_3.Find(var_45_0, "selected"), false)
	end

	setActive = var_2

	local var_45_1 = arg_45_0.ballSelects[arg_45_1]

	var_2(var_3.Find(var_45_1, "selected"), true)

	arg_45_0.lastSelectedBall = arg_45_1

	return
end

function var_0_1.EnterDispenseView(arg_46_0)
	setActive = var_1_10001

	var_1_10001(arg_46_0.dispenseView, true)

	arg_46_0.flagDispense = true
	arg_46_0.progressDispense = #arg_46_0.result_digits >= 3 and 4 or 0

	arg_46_0:UpdateContainer()

	arg_46_0.slider_powder.value = 0

	return
end

function var_0_1.ExitDispenseView(arg_47_0)
	if not arg_47_0.flagDispense then
		return
	end

	arg_47_0:UpdateNextBtn()
	arg_47_0:StopHammerAnim()
	arg_47_0:StopProgressAnim()

	arg_47_0.progressDispense = 0
	setActive = var_1

	var_1(arg_47_0.dispenseView, false)

	setButtonEnabled = var_1

	var_1(arg_47_0.btn_hammer, true)

	local var_47_0 = arg_47_0
	local var_47_1 = arg_47_0.GetMGHubData(var_47_0)

	setText = var_47_0

	var_47_0(arg_47_0.timesText, var_47_1.count)

	setActive = var_47_0

	var_47_0(arg_47_0.slider_bubble, false)

	if arg_47_0.effect_light then
		setActive = var_2

		var_2(arg_47_0.effect_light, false)
	end

	arg_47_0.flagDispense = false

	return
end

function var_0_1.willExit(arg_48_0)
	arg_48_0:ExitDispenseView()

	pg = var_1

	local var_48_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_48_0, arg_48_0.top, arg_48_0._tf)

	if arg_48_0.effect_light then
		pg = var_1

		local var_48_1 = var_1.PoolMgr.GetInstance()

		var_1.ReturnPrefab(var_48_1, "ui/light01", "", arg_48_0.effect_light)
	end

	pg = var_1

	local var_48_2 = var_1.PoolMgr.GetInstance()

	var_1.DestroyPrefab(var_48_2, "ui/light01", "")

	pg = var_1

	local var_48_3 = var_1.PoolMgr.GetInstance()

	var_1.DestroySprite(var_48_3, "ui/fireworkfactoryui_atlas")

	if arg_48_0.OPTimer then
		local var_48_4 = arg_48_0.OPTimer

		var_1.Stop(var_48_4)

		arg_48_0.OPTimer = nil
	end

	return
end

return var_0_1
