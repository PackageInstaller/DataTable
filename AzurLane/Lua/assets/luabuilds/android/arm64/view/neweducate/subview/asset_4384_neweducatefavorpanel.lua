class = var_0_10000

local var_0_0 = "NewEducateFavorPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateFavorPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.favorPanelTF = var_1.Find(var_2_0, "favor_panel")

	local var_2_1 = arg_2_0.favorPanelTF
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.favorPanelAnim = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0.favorPanelTF
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.favorPanelAnimEvent = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0.favorPanelAnimEvent

	var_1.SetEndEvent(var_2_5, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.favorPanelTF, false)

		return
	end)

	setActive = var_1

	var_1(arg_2_0.favorPanelTF, false)

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "favor_panel/panel")
	local var_2_8 = var_1.Find(var_2_7, "bg/view/content")

	UIItemList = var_2_6
	arg_2_0.favorUIList = var_2_6.New(var_2_8, var_2_8:Find("tpl"))
	arg_2_0.favorCurTF = var_1:Find("bg/cur")

	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			var_1:Find("bg")
		}
	})

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "favor_panel")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	local var_4_4 = arg_4_0.favorUIList

	var_1.make(var_4_4, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_4_0

			var_3.UpdateItem(var_6_0, arg_6_1, arg_6_2)
		end

		return
	end)

	return
end

function var_0_1.UpdateFavorPanel(arg_7_0)
	local var_7_0 = arg_7_0.contextData.char
	local var_7_1 = var_1.GetFavorInfo(var_7_0)

	setText = var_1_10002

	local var_7_2 = arg_7_0.favorCurTF

	var_1_10002(var_4.Find(var_7_2, "lv"), var_7_1.lv)

	local var_7_3 = arg_7_0.contextData.char
	local var_7_4 = var_2.getConfig(var_7_3, "favor_exp")[var_7_1.lv]
	local var_7_5 = var_7_1.value .. "/" .. (var_7_4 or "Max")

	setText = var_4

	local var_7_6 = arg_7_0.favorCurTF
	local var_7_7 = var_6.Find(var_7_6, "progress")

	i18n = var_7

	var_4(var_7_7, var_7("child_favor_progress", var_7_5))

	setSlider = var_4

	local var_7_8 = arg_7_0.favorCurTF
	local var_7_9 = var_6.Find(var_7_8, "slider")
	local var_7_10 = 0
	local var_7_11 = 1
	local var_7_12

	if not var_7_4 or not (var_7_1.value / var_7_4) then
		var_7_12 = 1
	end

	var_4(var_7_9, var_7_10, var_7_11, var_7_12)

	local var_7_13 = arg_7_0.favorUIList
	local var_7_14 = var_4.align
	local var_7_15 = arg_7_0.contextData.char

	var_7_14(var_7_13, var_7.getConfig(var_7_15, "favor_level") - 1)

	return
end

function var_0_1.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1 + 1

	setText = var_1_10004

	var_1_10004(arg_8_2:Find("lv"), var_8_0 + 1)

	local var_8_1 = arg_8_0.contextData.char
	local var_8_2 = var_8_0 < var_4.GetFavorInfo(var_8_1).lv

	setActive = var_8_1

	var_8_1(arg_8_2:Find("lock"), not var_8_2)

	setActive = var_8_1

	var_8_1(arg_8_2:Find("award/got"), var_8_2)

	setText = var_8_1

	local var_8_3 = arg_8_2:Find("Text")

	i18n = var_9

	var_8_1(var_8_3, var_9("child_favor_lock1", var_8_0 + 1))

	setTextColor = var_8_1

	local var_8_4 = arg_8_2:Find("Text")

	Color = var_9

	var_8_1(var_8_4, var_9.NewHex(var_8_2 and "393A3C" or "F5F5F5"))

	setTextColor = var_8_1

	local var_8_5 = arg_8_2:Find("lv")

	Color = var_9

	var_8_1(var_8_5, var_9.NewHex(var_8_2 and "FFFFFF" or "F5F5F5"))

	local var_8_6 = arg_8_0.contextData.char
	local var_8_7 = var_6.getConfig(var_8_6, "favor_result_display")[var_8_0]

	NewEducateHelper = var_7

	local var_8_8 = var_7.Config2Drop(var_8_7)

	NewEducateHelper = var_8_6

	var_8_6.UpdateItem(arg_8_2:Find("award/item"), var_8_8)

	onButton = var_8

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_2
	local var_8_11 = arg_8_2.Find(var_8_10, "award")

	local function var_8_12()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		NewEducateBaseUI = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_ITEM, {
			drop = var_8_8
		})

		return
	end

	SFX_PANEL = var_8_10

	var_8(var_8_9, var_8_11, var_8_12, var_8_10)

	return
end

function var_0_1.Show(arg_10_0)
	var_0_1.super.Show(arg_10_0)

	setActive = var_1

	var_1(arg_10_0.favorPanelTF, true)
	arg_10_0:UpdateFavorPanel()

	return
end

function var_0_1.Hide(arg_11_0)
	local var_11_0 = arg_11_0.favorPanelAnim

	var_1.Play(var_11_0, "anim_educate_educateUI_favor_out")

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_1
