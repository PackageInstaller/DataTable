local var_0_0 = class("YidaliV5FramePage", import("view.activity.CorePage.CoreNewFrameTemplatePage"))

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
	arg_1_0.gotTag = arg_1_0.pas2Img:Find("award/got")
	arg_1_0.phaseAnim = arg_1_0.switcher:GetComponent(typeof(Animation))
	arg_1_0.animClip1 = "anim_YidaliV5FramePage_switcher"
	arg_1_0.animClip2 = "anim_YidaliV5FramePage_switcher2"

	return
end

function var_0_0.InitBtnLocalText(arg_2_0)
	setText(arg_2_0.getBtn:Find("Text"), i18n("YidaliV5FramePage_get"))
	setText(arg_2_0.gotBtn:Find("Text"), i18n("YidaliV5FramePage_got"))
	setText(arg_2_0.battleBtn:Find("Text"), i18n("YidaliV5FramePage_go"))

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0.phaseAnim.playAutomatically = false

	arg_3_0:InitBtnLocalText()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.phases) do
		setActive(iter_3_1, true)

		GetOrAddComponent(iter_3_1, typeof(CanvasGroup)).alpha = 0
	end

	var_0_0.super.OnFirstFlush(arg_3_0)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	var_0_0.super.OnUpdateFlush(arg_4_0)

	return
end

function var_0_0.Switch(arg_5_0, arg_5_1)
	arg_5_0.isSwitching = true

	setToggleEnabled(arg_5_0.switchBtn, false)

	local var_5_0
	local var_5_1

	if arg_5_1 then
		var_5_1 = arg_5_0.phases[2]
		var_5_0 = arg_5_0.phases[1]

		quickPlayAnimation(arg_5_0.switcher, arg_5_0.animClip1)

		goto label_5_0

		var_5_1 = arg_5_0.phases[1]
	end

	var_5_0 = arg_5_0.phases[2]

	quickPlayAnimation(arg_5_0.switcher, arg_5_0.animClip2)

	::label_5_0::

	local var_5_2 = var_5_0.localPosition

	var_5_1:SetAsLastSibling()
	setCanvasGroupAlpha(GetOrAddComponent(var_5_0, typeof(CanvasGroup)), 0)
	setCanvasGroupAlpha(GetOrAddComponent(var_5_1, typeof(CanvasGroup)), 1)

	arg_5_0.isSwitching = nil

	setToggleEnabled(arg_5_0.switchBtn, true)

	return
end

return var_0_0
