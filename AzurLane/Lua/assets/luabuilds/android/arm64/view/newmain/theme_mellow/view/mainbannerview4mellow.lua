local var_0_0 = class("MainBannerView4Mellow", import("...theme_classic.view.MainBannerView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.scrollSnap = BannerScrollRect4Mellow.New(findTF(arg_1_1, "mask/content"), findTF(arg_1_1, "dots"))

	return
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2.zero
end

return var_0_0
