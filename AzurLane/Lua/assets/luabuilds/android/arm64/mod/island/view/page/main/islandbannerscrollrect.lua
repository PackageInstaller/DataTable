local var_0_0 = class("IslandBannerScrollRect", import("view.newMain.page.BannerScrollRect"))

function var_0_0.UpdateDotPosition(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_0.TriggerDot(arg_2_0, arg_2_1, arg_2_2)
	setActive(arg_2_1:Find("unsel"), not arg_2_2)
	setActive(arg_2_1:Find("sel"), arg_2_2)

	return
end

return var_0_0
