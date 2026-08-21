local var_0_0 = class("XiaoXinNongPtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.hearts = UIItemList.New(arg_1_0._tf:Find("AD/heart"), arg_1_0._tf:Find("AD/heart/mark"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.battleBtn, function()
		arg_2_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	var_0_0.super.OnUpdateFlush(arg_4_0)

	local var_4_0, var_4_1, var_4_2 = arg_4_0.ptData:GetLevelProgress()
	local var_4_3, var_4_4, var_4_5 = arg_4_0.ptData:GetResProgress()

	arg_4_0.hearts:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setActive(arg_5_2, arg_5_1 < arg_4_0.ptData.level)
		end

		return
	end)
	setText(arg_4_0.progress, setColorStr(var_4_3, "#7780D3") .. "/" .. setColorStr(var_4_4, "#ffffff"))
	arg_4_0.hearts:align(var_4_1)

	return
end

return var_0_0
