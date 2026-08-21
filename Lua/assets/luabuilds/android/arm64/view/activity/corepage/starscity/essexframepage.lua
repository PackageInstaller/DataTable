local var_0_0 = class("EssexFramePage", import("view.activity.CorePage.CoreNewFrameTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0._tf:Find("AD")
	arg_1_0.btnGroup = arg_1_0.AD:Find("btnGroup")
	arg_1_0.battleBtn = arg_1_0.btnGroup:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.btnGroup:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.btnGroup:Find("got_btn")
	arg_1_0.switcher = arg_1_0.AD:Find("switcher")
	arg_1_0.switchBtn = arg_1_0.switcher:Find("switch_btn")
	arg_1_0.phases = {
		arg_1_0.switcher:Find("phase1"),
		arg_1_0.switcher:Find("phase2")
	}
	arg_1_0.pas2Img = arg_1_0.phases[2]:Find("Image")
	arg_1_0.barContent = arg_1_0.pas2Img:Find("barContent")
	arg_1_0.bar = arg_1_0.barContent:Find("bar")
	arg_1_0.cur = arg_1_0.barContent:Find("step")
	arg_1_0.target = arg_1_0.barContent:Find("progress")
	arg_1_0.gotTag = arg_1_0.pas2Img:Find("got")
	arg_1_0.animClip1 = "anim_EssexFramePage_switcher"
	arg_1_0.animClip2 = "anim_EssexFramePage_switcher2"

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.phases) do
		setActive(iter_2_1, true)

		GetOrAddComponent(iter_2_1, typeof(CanvasGroup)).alpha = 0
	end

	var_0_0.super.OnFirstFlush(arg_2_0)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.activity.data1

	var_3_0 = arg_3_0.avatarConfig.target < arg_3_0.activity.data1 and arg_3_0.avatarConfig.target or var_3_0

	setActive(arg_3_0.cur, false)
	setText(arg_3_0.target, var_3_0 .. "/" .. arg_3_0.avatarConfig.target)

	return
end

function var_0_0.Switch(arg_4_0, arg_4_1)
	arg_4_0.isSwitching = true

	setToggleEnabled(arg_4_0.switchBtn, false)

	local var_4_0
	local var_4_1

	if arg_4_1 then
		var_4_1 = arg_4_0.phases[2]
		var_4_0 = arg_4_0.phases[1]

		quickPlayAnimation(arg_4_0.switcher, arg_4_0.animClip1)

		goto label_4_0

		var_4_1 = arg_4_0.phases[1]
	end

	var_4_0 = arg_4_0.phases[2]

	quickPlayAnimation(arg_4_0.switcher, arg_4_0.animClip2)

	::label_4_0::

	local var_4_2 = var_4_0.localPosition

	var_4_1:SetAsLastSibling()
	setCanvasGroupAlpha(GetOrAddComponent(var_4_0, typeof(CanvasGroup)), 0)
	setCanvasGroupAlpha(GetOrAddComponent(var_4_1, typeof(CanvasGroup)), 1)

	arg_4_0.isSwitching = nil

	setToggleEnabled(arg_4_0.switchBtn, true)

	return
end

return var_0_0
