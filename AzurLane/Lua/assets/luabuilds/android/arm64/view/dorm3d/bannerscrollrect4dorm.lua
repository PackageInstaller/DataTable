local var_0_0 = class("BannerScrollRect4Dorm", import("view.newMain.page.BannerScrollRect"))

function var_0_0.UpdateDotPosition(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_0.TriggerDot(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:GetComponent(typeof(LayoutElement)).minWidth = arg_2_2 and 52 or 12

	return
end

return var_0_0
