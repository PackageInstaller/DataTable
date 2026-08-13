class = var_0_10000

local var_0_0 = "EssexFramePage"

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

	arg_1_0.gotTag = var_1.Find(var_1_15, "got")
	arg_1_0.animClip1 = "anim_EssexFramePage_switcher"
	arg_1_0.animClip2 = "anim_EssexFramePage_switcher2"

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	ipairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0.phases) do
		setActive = var_1_10006

		var_1_10006(iter_2_1, true)

		GetOrAddComponent = var_1_10006

		local var_2_0 = iter_2_1

		typeof = var_9
		CanvasGroup = var_1_10011
		var_1_10006 = var_1_10006(var_2_0, var_9(var_1_10011))
		var_1_10006.alpha = 0
	end

	var_0_1.super.OnFirstFlush(arg_2_0)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.activity.data1

	var_3_0 = arg_3_0.avatarConfig.target < var_3_0 and var_2 or var_3_0
	setActive = var_3

	var_3(arg_3_0.cur, false)

	setText = var_3

	var_3(arg_3_0.target, var_3_0 .. "/" .. var_2)

	return
end

function var_0_1.Switch(arg_4_0, arg_4_1)
	arg_4_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_4_0.switchBtn, false)

	local var_4_0
	local var_4_1

	if arg_4_1 then
		local var_4_2 = arg_4_0.phases[1]

		var_4_1 = arg_4_0.phases[2]
		var_4_0 = var_4_2
		quickPlayAnimation = var_4_2

		var_4_2(arg_4_0.switcher, arg_4_0.animClip1)
	else
		local var_4_3 = arg_4_0.phases[2]

		var_4_1 = arg_4_0.phases[1]
		var_4_0 = var_4_3
		quickPlayAnimation = var_4_3

		var_4_3(arg_4_0.switcher, arg_4_0.animClip2)
	end

	local var_4_4 = var_4_0.localPosition
	local var_4_5 = var_4_1.localPosition
	local var_4_6 = var_4_1

	var_4_1.SetAsLastSibling(var_4_6)

	setCanvasGroupAlpha = var_6
	GetOrAddComponent = var_4_6

	local var_4_7 = var_4_0

	typeof = var_1_10011
	CanvasGroup = var_1_10013

	var_6(var_4_6(var_4_7, var_1_10011(var_1_10013)), 0)

	setCanvasGroupAlpha = var_6
	GetOrAddComponent = var_8

	local var_4_8 = var_4_1

	typeof = var_11
	CanvasGroup = var_1_10013

	var_6(var_8(var_4_8, var_11(var_1_10013)), 1)

	arg_4_0.isSwitching = nil
	setToggleEnabled = var_6

	var_6(arg_4_0.switchBtn, true)

	return
end

return var_0_1
