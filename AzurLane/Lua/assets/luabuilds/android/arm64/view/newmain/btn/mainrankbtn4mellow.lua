local var_0_0 = class("MainRankBtn4Mellow", import(".MainRankBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.rankImage = arg_1_1:Find("root/Image"):GetComponent(typeof(Image))

	return
end

function var_0_0.Flush(arg_2_0)
	local var_2_0 = arg_2_0:IsActive()

	setActive(arg_2_0._tf:Find("root/lock"), not var_2_0)

	arg_2_0.rankImage.color = var_2_0 and Color(1, 1, 1, 1) or Color(0.3, 0.3, 0.3, 1)

	return
end

return var_0_0
