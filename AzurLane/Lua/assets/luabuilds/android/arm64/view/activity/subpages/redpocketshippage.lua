local var_0_0 = class("RedPocketShipPage", import("...base.BaseActivityPage"))
local var_0_1 = 7
local var_0_2 = {
	[0] = 705.6,
	807.608,
	897.5893,
	987.5705,
	1077.552,
	1167.533,
	1257.514,
	1387.6
}

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.tip = arg_1_0._tf:Find("tip")
	arg_1_0.btn = arg_1_0._tf:Find("btn")
	arg_1_0.mainAward = arg_1_0._tf:Find("main_award")
	arg_1_0.subAward = arg_1_0._tf:Find("sub_award")
	arg_1_0.itemIcon = arg_1_0._tf:Find("icon")
	arg_1_0.slider = arg_1_0._tf:Find("slider")
	arg_1_0.uilist = UIItemList.New(arg_1_0.subAward, arg_1_0.subAward:Find("1"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity

	onButton(arg_2_0, arg_2_0.tip, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.metalgearsub_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btn, function()
		arg_2_0:emit(ActivityMediator.GO_SUBMARINE_RUN, var_2_0:getConfig("config_client").stage_ids[math.min(arg_2_0.progess + 1, arg_2_0.maxday)])

		return
	end, SFX_PANEL)

	local var_2_1 = Drop.Create(arg_2_0.activity:getConfig("config_client")[2])

	onButton(arg_2_0, arg_2_0.mainAward, function()
		arg_2_0:emit(BaseUI.ON_DROP, var_2_1)

		return
	end, SFX_PANEL)

	local var_2_2 = arg_2_0.activity:getConfig("config_client")[1]
	local var_2_3 = {
		type = var_2_2[1],
		id = var_2_2[2],
		count = var_2_2[3]
	}

	onButton(arg_2_0, arg_2_0.itemIcon, function()
		arg_2_0:emit(BaseUI.ON_DROP, var_2_3)

		return
	end, SFX_PANEL)
	arg_2_0.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			if LeanTween.isTweening(arg_7_2) then
				LeanTween.cancel(arg_7_2)
			end

			if arg_7_1 < arg_2_0.progess then
				setImageAlpha(arg_7_2, 1)
			else
				LeanTween.alpha(arg_7_2, 1, 1):setFrom(0.4):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()
			end
		elseif arg_7_0 == UIItemList.EventExcess and LeanTween.isTweening(arg_7_2) then
			LeanTween.cancel(arg_7_2)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	local var_8_0 = pg.TimeMgr.GetInstance()

	arg_8_0.progess = math.min(arg_8_0.activity.data2, var_0_1)
	arg_8_0.maxday = math.min(var_8_0:DiffDay(arg_8_0.activity.data1, var_8_0:GetServerTime()) + 1, var_0_1)

	arg_8_0.uilist:align(math.min(arg_8_0.maxday, var_0_1 - 1))
	setSlider(arg_8_0.slider, var_0_2[0], var_0_2[var_0_1], var_0_2[arg_8_0.progess])
	setActive(findTF(arg_8_0.mainAward, "dis"), not arg_8_0.activity.data4 or arg_8_0.activity.data4 == 0)
	setActive(findTF(arg_8_0.mainAward, "dis/lock"), arg_8_0.maxday < var_0_1)
	setActive(findTF(arg_8_0.mainAward, "get"), arg_8_0.activity.data4 > 0)

	if arg_8_0.activity.data4 == 0 and arg_8_0.progess >= var_0_1 then
		arg_8_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 3,
			activity_id = arg_8_0.activity.id
		})
	elseif defaultValue(arg_8_0.activity.data2_list[1], 0) > 0 or defaultValue(arg_8_0.activity.data2_list[2], 0) > 0 then
		arg_8_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 2,
			activity_id = arg_8_0.activity.id
		})
	end

	return
end

function var_0_0.OnDestroy(arg_9_0)
	clearImageSprite(arg_9_0.bg)

	return
end

return var_0_0
