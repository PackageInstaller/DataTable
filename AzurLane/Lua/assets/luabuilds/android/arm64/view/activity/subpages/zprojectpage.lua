local var_0_0 = class("ZProjectPage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.awardTF = arg_1_0._tf:Find("AD/award")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	updateDrop(arg_2_0.awardTF, arg_2_0.activity:getConfig("config_client").drop)
	onButton(arg_2_0, arg_2_0.awardTF, function()
		arg_2_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
