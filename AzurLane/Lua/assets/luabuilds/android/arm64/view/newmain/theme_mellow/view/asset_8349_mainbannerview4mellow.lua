class = var_0_10000

local var_0_0 = "MainBannerView4Mellow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...theme_classic.view.MainBannerView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	BannerScrollRect4Mellow = var_3

	local var_1_0 = var_3.New

	findTF = var_5

	local var_1_1 = var_5(arg_1_1, "mask/content")

	findTF = var_6
	arg_1_0.scrollSnap = var_1_0(var_1_1, var_6(arg_1_1, "dots"))

	return
end

function var_0_1.GetDirection(arg_2_0)
	Vector2 = var_1_10001

	return var_1_10001.zero
end

return var_0_1
