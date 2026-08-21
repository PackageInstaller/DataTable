local var_0_0 = class("SaratogaWFSkinPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.displayBtn, function()
		arg_1_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			type = arg_1_0.ptData.type,
			dropList = arg_1_0.ptData.dropList,
			targets = arg_1_0.ptData.targets,
			level = arg_1_0.ptData.level,
			count = arg_1_0.ptData.count,
			resId = arg_1_0.ptData.resId
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.getBtn, function()
		local var_4_0, var_4_1 = arg_1_0.ptData:GetResProgress()

		arg_1_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_1_0.ptData:GetId(),
			arg1 = var_4_1
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	var_0_0.super.OnUpdateFlush(arg_5_0)

	local var_5_0, var_5_1, var_5_2 = arg_5_0.ptData:GetResProgress()

	setText(arg_5_0.progress, setColorStr(var_5_0, "#F294B8FF") .. "/" .. var_5_1)

	return
end

return var_0_0
