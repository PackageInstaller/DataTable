local var_0_0 = class("SandiegoReformPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.progress = arg_1_0.bg:Find("progress/left")
	arg_1_0.gameBtn = arg_1_0.bg:Find("start")
	arg_1_0.helpBtn = arg_1_0.bg:Find("mic")
	arg_1_0.getSign = arg_1_0.bg:Find("get")
	arg_1_0.days = arg_1_0.bg:Find("days")
	arg_1_0.nums = arg_1_0.bg:Find("count")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity:getConfig("config_client")[1][1]

	if var_2_0 ~= nil then
		pg.NewStoryMgr.GetInstance():Play(var_2_0)
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	setText(arg_3_0.nums, _.reduce(_.slice(arg_3_0.activity:getConfig("config_client")[3], 1, arg_3_0.activity.data2), 0, function(arg_4_0, arg_4_1)
		return arg_4_0 + arg_4_1
	end))
	setActive(arg_3_0.getSign, arg_3_0.activity.data1 == 1)

	local var_3_0 = arg_3_0.activity:getConfig("config_data")[4]

	arg_3_0.progress.sizeDelta = Vector2.New(10 + 90 * math.max(arg_3_0.activity.data2 - 1, 0), arg_3_0.progress.sizeDelta.y)

	local var_3_1 = Color.New(1, 0.83, 0.15)
	local var_3_2 = Color.New(0.59, 0.62, 0.69)

	for iter_3_0 = 1, 7 do
		setTextColor(arg_3_0.days:Find(iter_3_0), iter_3_0 <= arg_3_0.activity.data2 and var_3_1 or var_3_2)
	end

	onButton(arg_3_0, arg_3_0.gameBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LINK_LINK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("link_link_help_tip")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
