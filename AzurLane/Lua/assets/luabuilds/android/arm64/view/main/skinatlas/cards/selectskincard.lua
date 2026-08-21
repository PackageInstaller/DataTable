local var_0_0 = class("SelectSkinCard", import(".SkinAtlasCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.ownTr = arg_1_0._tf:Find("own")
	arg_1_0.timeLimitTr = arg_1_0._tf:Find("timelimit")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super.Update(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = isActive(arg_2_0.usingTr) or isActive(arg_2_0.unavailableTr)

	setAnchoredPosition(arg_2_0.timeLimitTr, {
		y = var_2_0 and -40 or 0
	})
	setActive(arg_2_0.timeLimitTr, arg_2_3)
	setActive(arg_2_0.ownTr, arg_2_4)

	return
end

return var_0_0
