local var_0_0 = class("MainActInsBtn", import(".MainBaseSpcailActBtn"))

function var_0_0.GetContainer(arg_1_0)
	return arg_1_0.root
end

function var_0_0.InShowTime(arg_2_0)
	return true
end

function var_0_0.GetUIName(arg_3_0)
	return "MainUIInsBtn"
end

function var_0_0.OnClick(arg_4_0)
	arg_4_0.event:emit(NewMainMediator.SKIP_INS)

	return
end

function var_0_0.OnRegister(arg_5_0)
	arg_5_0.initX = getAnchoredPosition(arg_5_0._tf).x

	return
end

function var_0_0.OnInit(arg_6_0)
	arg_6_0.animator = arg_6_0._tf:Find("icon"):GetComponent(typeof(Animator))

	local var_6_0 = getProxy(InstagramProxy):ShouldShowTip()

	if not var_6_0 then
		var_6_0 = getProxy(InstagramChatProxy):ShouldShowTip()
		var_6_0 = var_6_0 or getProxy(InstagramProxy):ShouldShowTip()
	end

	arg_6_0.animator.enabled = var_6_0

	setActive(arg_6_0._tf:Find("Tip"), var_6_0)

	local var_6_1 = arg_6_0._tf

	var_6_1.localScale = arg_6_0.isScale and Vector3(0.85, 0.85, 1) or Vector3(1, 1, 1)

	if arg_6_0.isOverflow then
		local var_6_2 = arg_6_0.initX - 200 or arg_6_0.initX

		setAnchoredPosition(arg_6_0._tf, {
			x = var_6_2,
			y = arg_6_0.isScale and -950 or -752.5
		})

		return
	end
end

return var_0_0
