local var_0_0 = class("YingxiV3FrameRePage", import(".TemplatePage.NewFrameTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.battleBtn = arg_1_0.bg:Find("btn/battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("btn/get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("btn/got_btn")
	arg_1_0.bar = arg_1_0.bg:Find("barContent/bar")
	arg_1_0.cur = arg_1_0.bg:Find("progress/cur")
	arg_1_0.target = arg_1_0.bg:Find("progress/target")
	arg_1_0.gotTag = arg_1_0.bg:Find("tag/got")
	arg_1_0.getTag = arg_1_0.bg:Find("tag/get")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.battleBtn, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.getBtn, function()
		arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end, SFX_PANEL)

	arg_2_0.inPhase2 = arg_2_0.timeStamp and pg.TimeMgr.GetInstance():GetServerTime() - arg_2_0.timeStamp > 0

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	var_0_0.super.OnUpdateFlush(arg_5_0)

	local var_5_0 = arg_5_0.activity.data2 >= 1
	local var_5_1 = arg_5_0.avatarConfig.target <= arg_5_0.activity.data1
	local var_5_3 = arg_5_0.inPhase2 and not var_5_0 and var_5_1

	var_5_2(arg_5_0.getTag, var_5_3)

	return
end

return var_0_0
