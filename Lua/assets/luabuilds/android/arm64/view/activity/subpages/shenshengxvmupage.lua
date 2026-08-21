local var_0_0 = class("ShenshengxvmuPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	setActive(arg_1_0.displayBtn, false)
	setActive(arg_1_0.awardTF, false)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = isActive(arg_3_0.battleBtn) and pg.TimeMgr.GetInstance():inTime((arg_3_0.activity:getConfig("config_client")))

	setActive(arg_3_0.battleBtn, var_3_0)
	setActive(arg_3_0.bg:Find("got"), not arg_3_0.ptData:CanGetNextAward())

	local var_3_1, var_3_2, var_3_3 = arg_3_0.ptData:GetResProgress()
	local var_3_4 = var_3_3 >= 1 and setColorStr(var_3_1, COLOR_GREEN) or var_3_1

	setText(arg_3_0.step, var_3_4)
	setText(arg_3_0.progress, "/" .. var_3_2)

	return
end

return var_0_0
