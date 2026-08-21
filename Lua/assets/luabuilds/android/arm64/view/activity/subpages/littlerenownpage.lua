local var_0_0 = class("LittleRenownPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.heartTpl = arg_1_0.bg:Find("HeartTpl")
	arg_1_0.heartContainer = arg_1_0.bg:Find("HeartContainer")
	arg_1_0.heartUIItemList = UIItemList.New(arg_1_0.heartContainer, arg_1_0.heartTpl)

	arg_1_0.heartUIItemList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			setActive(arg_2_2:Find("Full"), not (arg_1_0.ptData:GetLevelProgress() < arg_2_1 + 1))
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)

	local var_3_0, var_3_1 = arg_3_0.ptData:GetLevelProgress()

	arg_3_0.heartUIItemList:align(var_3_1)

	return
end

return var_0_0
