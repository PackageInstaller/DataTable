local var_0_0 = class("WarspiteTransformationPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.btn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.tip = arg_1_0.bg:Find("help")
	arg_1_0.mainAward = arg_1_0.bg:Find("award")
	arg_1_0.subAwards = CustomIndexLayer.Clone2Full(arg_1_0.bg:Find("list"), 7)
	arg_1_0.step = arg_1_0.bg:Find("receivetimes")
	arg_1_0.score = arg_1_0.bg:Find("highscore")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	if arg_2_0.activity.data4 == 0 and arg_2_0.activity.data2 >= 7 then
		arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 3,
			activity_id = arg_2_0.activity.id
		})

		return true
	elseif defaultValue(arg_2_0.activity.data2_list[1], 0) > 0 or defaultValue(arg_2_0.activity.data2_list[2], 0) > 0 then
		arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 2,
			activity_id = arg_2_0.activity.id
		})

		return true
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity:getConfig("config_client")[2]
	local var_3_1 = {
		type = var_3_0[1],
		id = var_3_0[2],
		count = var_3_0[3]
	}

	onButton(arg_3_0, arg_3_0.mainAward, function()
		arg_3_0:emit(BaseUI.ON_DROP, var_3_1)

		return
	end, SFX_PANEL)

	for iter_3_0 = 1, 7 do
		local var_3_2 = arg_3_0.activity:getConfig("config_client")[1]
		local var_3_3 = {
			type = var_3_2[1],
			id = var_3_2[2],
			count = var_3_2[3]
		}

		onButton(arg_3_0, arg_3_0.subAwards[iter_3_0], function()
			arg_3_0:emit(BaseUI.ON_DROP, var_3_3)

			return
		end, SFX_PANEL)
	end

	onButton(arg_3_0, arg_3_0.tip, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.goldship_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.btn, function()
		arg_3_0:emit(ActivityMediator.GO_DODGEM)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	local var_8_0 = pg.TimeMgr.GetInstance()
	local var_8_1 = var_8_0:DiffDay(arg_8_0.activity.data1, var_8_0:GetServerTime()) + 1

	setActive(findTF(arg_8_0.mainAward, "get"), arg_8_0.activity.data4 > 0)

	for iter_8_0 = 1, 7 do
		local var_8_2 = arg_8_0.subAwards[iter_8_0]

		setActive(findTF(arg_8_0.subAwards[iter_8_0], "get"), iter_8_0 <= arg_8_0.activity.data2)
		setActive(findTF(var_8_2, "lock"), var_8_1 < iter_8_0)
	end

	setText(arg_8_0.step, arg_8_0.activity.data2)
	setText(arg_8_0.score, arg_8_0.activity.data1_list[1])

	return
end

return var_0_0
