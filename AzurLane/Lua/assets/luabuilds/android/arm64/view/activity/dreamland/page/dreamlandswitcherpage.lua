class = var_0_10000

local var_0_0 = "DreamlandSwitcherPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "DreamlandSwitcherUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_0, "bg/confirm")

	local var_2_1 = {}
	local var_2_2 = arg_2_0._tf

	var_2_1[1] = var_2.Find(var_2_2, "bg/conent/1")

	local var_2_3 = arg_2_0._tf

	var_2_1[2] = var_2.Find(var_2_3, "bg/conent/2")

	local var_2_4 = arg_2_0._tf

	var_2_1[3] = var_2.Find(var_2_4, "bg/conent/3")
	arg_2_0.times = var_2_1
	setText = var_2_1

	local var_2_5 = arg_2_0.times[1]
	local var_2_6 = var_3.Find(var_2_5, "title")

	i18n = var_2_4

	var_2_1(var_2_6, var_2_4("dreamland_label_day"))

	setText = var_2_1

	local var_2_7 = arg_2_0.times[2]
	local var_2_8 = var_3.Find(var_2_7, "title")

	i18n = var_4

	var_2_1(var_2_8, var_4("dreamland_label_dusk"))

	setText = var_2_1

	local var_2_9 = arg_2_0.times[3]
	local var_2_10 = var_3.Find(var_2_9, "title")

	i18n = var_4

	var_2_1(var_2_10, var_4("dreamland_label_night"))

	return
end

function var_0_1.OnInit(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.times) do
		onToggle = var_1_10006

		local var_3_0 = arg_3_0
		local var_3_1 = iter_3_1

		local function var_3_2(arg_4_0)
			if arg_4_0 then
				arg_3_0.selected = iter_3_0
			end

			local var_4_0 = arg_3_0

			var_1.UpdateToggleStyle(var_4_0, iter_3_1, arg_4_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_3_0, var_3_1, var_3_2, var_1_10011)
	end

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.confirmBtn

	local function var_3_5()
		if not arg_3_0.selected then
			return
		end

		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		DreamlandScene = var_2_10003

		var_5_1(var_5_0, var_2_10003.EVENT_SWITCH_TIME, arg_3_0.selected)

		local var_5_2 = arg_3_0

		var_0.Hide(var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	triggerToggle = var_2

	var_2(arg_7_0.times[arg_7_1], true)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)
	arg_7_0:InitTogglesStyle(arg_7_1)

	return
end

function var_0_1.InitTogglesStyle(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.times) do
		if iter_8_0 ~= arg_8_1 then
			arg_8_0:UpdateToggleStyle(iter_8_1, false)
		end
	end

	return
end

function var_0_1.UpdateToggleStyle(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:Find("icon")
	local var_9_1 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008

	local var_9_2 = var_9_1(var_9_0, var_6(var_1_10008))
	local var_9_3 = arg_9_1:Find("title_icon")
	local var_9_4 = var_4.GetComponent

	typeof = var_7
	Image = var_1_10009

	local var_9_5 = var_9_4(var_9_3, var_7(var_1_10009))
	local var_9_6 = arg_9_1:Find("title")
	local var_9_7 = var_5.GetComponent

	typeof = var_8
	Text = var_1_10010

	local var_9_8 = var_9_7(var_9_6, var_8(var_1_10010))

	Color = var_9_3

	local var_9_9 = var_9_3.New(1, 1, 1, 1)

	Color = var_9_6

	local var_9_10 = var_9_6.New(0.4235294, 0.4313726, 0.5137255, 1)

	var_9_2.color = arg_9_2 and var_9_9 or var_9_10
	var_9_5.color = arg_9_2 and var_9_9 or var_9_10
	var_9_8.color = arg_9_2 and var_9_9 or var_9_10

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	if arg_11_0:isShowing() then
		arg_11_0:Hide()
	end

	return
end

return var_0_1
