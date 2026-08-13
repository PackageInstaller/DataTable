class = var_0_10000

local var_0_0 = "YidaliV5FramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreNewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.AD

	arg_1_0.btnGroup = var_1.Find(var_1_1, "btnGroup")

	local var_1_2 = arg_1_0.btnGroup

	arg_1_0.battleBtn = var_1.Find(var_1_2, "battle_btn")

	local var_1_3 = arg_1_0.btnGroup

	arg_1_0.getBtn = var_1.Find(var_1_3, "get_btn")

	local var_1_4 = arg_1_0.btnGroup

	arg_1_0.gotBtn = var_1.Find(var_1_4, "got_btn")

	local var_1_5 = arg_1_0.AD

	arg_1_0.switcher = var_1.Find(var_1_5, "switcher")

	local var_1_6 = arg_1_0.switcher

	arg_1_0.switchBtn = var_1.Find(var_1_6, "switch_btn")

	local var_1_7 = {}
	local var_1_8 = arg_1_0.switcher

	var_1_7[1] = var_2.Find(var_1_8, "phase1")

	local var_1_9 = arg_1_0.switcher

	var_1_7[2] = var_2.Find(var_1_9, "phase2")
	arg_1_0.phases = var_1_7

	local var_1_10 = arg_1_0.phases[2]

	arg_1_0.pas2Img = var_1.Find(var_1_10, "Image")

	local var_1_11 = arg_1_0.pas2Img

	arg_1_0.barContent = var_1.Find(var_1_11, "barContent")

	local var_1_12 = arg_1_0.barContent

	arg_1_0.bar = var_1.Find(var_1_12, "bar")

	local var_1_13 = arg_1_0.barContent

	arg_1_0.cur = var_1.Find(var_1_13, "step")

	local var_1_14 = arg_1_0.barContent

	arg_1_0.target = var_1.Find(var_1_14, "progress")

	local var_1_15 = arg_1_0.pas2Img

	arg_1_0.gotTag = var_1.Find(var_1_15, "award/got")

	local var_1_16 = arg_1_0.switcher
	local var_1_17 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_1_0.phaseAnim = var_1_17(var_1_16, var_4(var_1_10006))
	arg_1_0.animClip1 = "anim_YidaliV5FramePage_switcher"
	arg_1_0.animClip2 = "anim_YidaliV5FramePage_switcher2"

	return
end

function var_0_1.InitBtnLocalText(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.getBtn
	local var_2_1 = var_3.Find(var_2_0, "Text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("YidaliV5FramePage_get"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.gotBtn
	local var_2_3 = var_3.Find(var_2_2, "Text")

	i18n = var_4

	var_1_10001(var_2_3, var_4("YidaliV5FramePage_got"))

	setText = var_1_10001

	local var_2_4 = arg_2_0.battleBtn
	local var_2_5 = var_3.Find(var_2_4, "Text")

	i18n = var_4

	var_1_10001(var_2_5, var_4("YidaliV5FramePage_go"))

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	arg_3_0.phaseAnim.playAutomatically = false

	arg_3_0:InitBtnLocalText()

	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.phases) do
		setActive = var_1_10006

		var_1_10006(iter_3_1, true)

		GetOrAddComponent = var_1_10006

		local var_3_0 = iter_3_1

		typeof = var_9
		CanvasGroup = var_1_10011
		var_1_10006 = var_1_10006(var_3_0, var_9(var_1_10011))
		var_1_10006.alpha = 0
	end

	var_0_1.super.OnFirstFlush(arg_3_0)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	var_0_1.super.OnUpdateFlush(arg_4_0)

	return
end

function var_0_1.Switch(arg_5_0, arg_5_1)
	arg_5_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_5_0.switchBtn, false)

	local var_5_0
	local var_5_1

	if arg_5_1 then
		local var_5_2 = arg_5_0.phases[1]

		var_5_1 = arg_5_0.phases[2]
		var_5_0 = var_5_2
		quickPlayAnimation = var_5_2

		var_5_2(arg_5_0.switcher, arg_5_0.animClip1)
	else
		local var_5_3 = arg_5_0.phases[2]

		var_5_1 = arg_5_0.phases[1]
		var_5_0 = var_5_3
		quickPlayAnimation = var_5_3

		var_5_3(arg_5_0.switcher, arg_5_0.animClip2)
	end

	local var_5_4 = var_5_0.localPosition
	local var_5_5 = var_5_1.localPosition
	local var_5_6 = var_5_1

	var_5_1.SetAsLastSibling(var_5_6)

	setCanvasGroupAlpha = var_6
	GetOrAddComponent = var_5_6

	local var_5_7 = var_5_0

	typeof = var_1_10011
	CanvasGroup = var_1_10013

	var_6(var_5_6(var_5_7, var_1_10011(var_1_10013)), 0)

	setCanvasGroupAlpha = var_6
	GetOrAddComponent = var_8

	local var_5_8 = var_5_1

	typeof = var_11
	CanvasGroup = var_1_10013

	var_6(var_8(var_5_8, var_11(var_1_10013)), 1)

	arg_5_0.isSwitching = nil
	setToggleEnabled = var_6

	var_6(arg_5_0.switchBtn, true)

	return
end

return var_0_1
