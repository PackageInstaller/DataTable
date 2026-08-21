local var_0_0 = class("BannerScrollRectDorm3dShop", import("view.newMain.page.BannerScrollRect"))

function var_0_0.UpdateDotPosition(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_0.TriggerDot(arg_2_0, arg_2_1, arg_2_2)
	setActive(arg_2_1:Find("short"), not arg_2_2)
	setActive(arg_2_1:Find("long"), arg_2_2)

	return
end

function var_0_0.GetItemChild(arg_3_0, arg_3_1)
	if arg_3_0.items[arg_3_1] then
		if arg_3_1 > arg_3_0.total then
			arg_3_0.total = arg_3_1
		end

		return arg_3_0.items[arg_3_1]
	else
		return nil
	end

	return
end

return var_0_0
