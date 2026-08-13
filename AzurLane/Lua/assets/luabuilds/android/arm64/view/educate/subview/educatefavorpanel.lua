class = var_0_10000

local var_0_0 = "EducateFavorPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EducateFavorPanel"
end

function var_0_1.OnInit(arg_2_0)
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

	UIItemList = var_1

	local var_2_6 = var_1.New
	local var_2_7 = arg_2_0.favorPanelTF
	local var_2_8 = var_3.Find(var_2_7, "panel/bg/view/content")
	local var_2_9 = arg_2_0.favorPanelTF

	arg_2_0.favorUIList = var_2_6(var_2_8, var_4.Find(var_2_9, "panel/bg/view/content/tpl"))

	local var_2_10 = arg_2_0.favorPanelTF

	arg_2_0.favorCurTF = var_1.Find(var_2_10, "panel/bg/cur")

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.OverlayPanel
	local var_2_13 = arg_2_0._tf
	local var_2_14 = {}
	local var_2_15 = {}
	local var_2_16 = arg_2_0.favorPanelTF

	var_2_15[1] = var_7.Find(var_2_16, "panel/bg")
	var_2_14.pbList = var_2_15

	var_2_12(var_2_11, var_2_13, var_2_14)
	arg_2_0:addListener()
	arg_2_0:Flush()

	return
end

function var_0_1.addListener(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.favorPanelTF

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	local var_4_3 = arg_4_0.favorUIList

	var_1.make(var_4_3, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_4_0

			var_3.updateFavorItem(var_6_0, arg_6_1, arg_6_2)
		end

		return
	end)

	return
end

function var_0_1.updateFavorPanel(arg_7_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)

	arg_7_0.char = var_1.GetCharData(var_7_0)

	local var_7_1 = arg_7_0.char
	local var_7_2 = var_1.GetFavor(var_7_1)

	setText = var_1_10002

	local var_7_3 = arg_7_0.favorCurTF

	var_1_10002(var_4.Find(var_7_3, "lv"), var_7_2.lv)

	local var_7_4 = arg_7_0.char
	local var_7_5 = var_2.GetFavorUpgradExp(var_7_4, var_7_2.lv)
	local var_7_6 = var_7_2.exp .. "/" .. var_7_5

	setText = var_4

	local var_7_7 = arg_7_0.favorCurTF
	local var_7_8 = var_6.Find(var_7_7, "progress")

	i18n = var_7

	var_4(var_7_8, var_7("child_favor_progress", var_7_6))

	setSlider = var_4

	local var_7_9 = arg_7_0.favorCurTF

	var_4(var_6.Find(var_7_9, "slider"), 0, 1, var_7_2.exp / var_7_5)

	local var_7_10 = arg_7_0.favorUIList
	local var_7_11 = var_4.align
	local var_7_12 = arg_7_0.char

	var_7_11(var_7_10, var_7.getConfig(var_7_12, "favor_level") - 1)

	return
end

function var_0_1.updateFavorItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1 + 1

	setText = var_1_10004

	var_1_10004(arg_8_2:Find("lv"), var_8_0 + 1)

	local var_8_1 = arg_8_0.char
	local var_8_2 = var_8_0 < var_4.GetFavor(var_8_1).lv

	setActive = var_8_1

	var_8_1(arg_8_2:Find("lock"), not var_8_2)

	setActive = var_8_1

	local var_8_3 = arg_8_2

	var_8_1(arg_8_2.Find(var_8_3, "unlock"), var_8_2)

	if not var_8_2 then
		local var_8_4 = arg_8_0.char
		local var_8_5 = var_6.GetFavorUpgradExp(var_8_4, var_8_0)

		setText = var_7

		local var_8_6 = arg_8_2:Find("Text")

		i18n = var_8_3

		var_7(var_8_6, var_8_3("child_favor_lock1", var_8_0 + 1))

		setTextColor = var_7

		local var_8_7 = arg_8_2:Find("Text")

		Color = var_8_3

		var_7(var_8_7, var_8_3.NewHex("F5F5F5"))

		setTextColor = var_7

		local var_8_8 = arg_8_2:Find("lv")

		Color = var_8_3

		var_7(var_8_8, var_8_3.NewHex("F5F5F5"))
	else
		local var_8_9 = arg_8_0.char
		local var_8_10

		if var_6.GetPerformByReplace(var_8_9, var_8_0)[1] then
			pg = var_8_10
			var_8_10 = var_8_10.child_performance[var_6[1]].param
			var_8_3 = arg_8_0

			local var_8_11 = arg_8_0.getStoryTitle(var_8_3, var_8_10)

			setText = var_9

			var_9(arg_8_2:Find("Text"), var_8_11)
		end

		setTextColor = var_8_10

		local var_8_12 = arg_8_2:Find("Text")

		Color = var_8_3

		var_8_10(var_8_12, var_8_3.NewHex("393A3C"))

		setTextColor = var_8_10

		local var_8_13 = arg_8_2:Find("lv")

		Color = var_10

		var_8_10(var_8_13, var_10.NewHex("FFFFFF"))

		onButton = var_8_10

		local var_8_14 = arg_8_0
		local var_8_15 = arg_8_2
		local var_8_16 = arg_8_2.Find(var_8_15, "unlock")

		local function var_8_17()
			pg = var_2_10000

			local var_9_0 = var_2_10000.PerformMgr.GetInstance()

			var_0.PlayOne(var_9_0, var_0[1])

			return
		end

		SFX_PANEL = var_8_15

		var_8_10(var_8_14, var_8_16, var_8_17, var_8_15)
	end

	return
end

function var_0_1.getStoryTitle(arg_10_0, arg_10_1)
	ipairs = var_1_10002
	pg = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10002(var_1_10004.memory_template.all) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.memory_template[iter_10_1]
		table = var_1_10008

		if var_1_10008.contains(var_1_10007.unlock_pre, arg_10_1) then
			return var_1_10007.title
		end
	end

	return arg_10_1
end

function var_0_1.Show(arg_11_0)
	if not arg_11_0:GetLoaded() then
		return
	end

	setActive = var_1

	var_1(arg_11_0.favorPanelTF, true)
	arg_11_0:updateFavorPanel()

	return
end

function var_0_1.Hide(arg_12_0)
	local var_12_0 = arg_12_0.favorPanelAnim

	var_1.Play(var_12_0, "anim_educate_educateUI_favor_out")

	return
end

function var_0_1.Flush(arg_13_0)
	if not arg_13_0:GetLoaded() then
		return
	end

	arg_13_0:updateFavorPanel()

	return
end

function var_0_1.OnDestroy(arg_14_0)
	local var_14_0 = arg_14_0.favorPanelAnimEvent

	var_1.SetEndEvent(var_14_0, nil)
	arg_14_0:UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_1
