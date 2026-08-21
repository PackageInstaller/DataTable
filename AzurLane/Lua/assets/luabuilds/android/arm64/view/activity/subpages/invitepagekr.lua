local var_0_0 = class("InvitePageKR", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0._tf:Find("AD")
	arg_1_0.btnGroup = arg_1_0.AD:Find("btn_list")
	arg_1_0.btnClick = arg_1_0.btnGroup:Find("click")
	arg_1_0.btnGet = arg_1_0.btnGroup:Find("get")
	arg_1_0.btnGot = arg_1_0.btnGroup:Find("got")
	arg_1_0.redpoint = arg_1_0.btnGroup:Find("red")
	arg_1_0.showList = arg_1_0.AD:Find("show_list")
	arg_1_0.progress = arg_1_0.showList:Find("progress")
	arg_1_0.tabCount = tf(arg_1_0.progress).childCount
	arg_1_0.tabsList = {}

	table.insert(arg_1_0.tabsList, arg_1_0.progress:Find("item"))

	for iter_1_0 = 1, 6 do
		table.insert(arg_1_0.tabsList, arg_1_0.progress:Find("item_" .. iter_1_0))
	end

	arg_1_0.award = arg_1_0.showList:Find("award")
	arg_1_0.gotAward = arg_1_0.award:Find("got")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.nday = arg_2_0.activity.data1

	arg_2_0:RefreshTab()
	warning("First是第几次签到" .. arg_2_0.nday)
	onButton(arg_2_0, arg_2_0.btnClick, function()
		if arg_2_0.activity:readyToAchieve() == false then
			return
		end

		arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end, SFX_CONFIRM)
	onButton(arg_2_0, arg_2_0.btnGet, function()
		if arg_2_0.activity:readyToAchieve() == false then
			return
		end

		arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	arg_5_0.nday = arg_5_0.activity.data1

	warning("update是第几次签到" .. arg_5_0.nday)
	arg_5_0:RefreshTab()

	local var_5_0 = arg_5_0.activity:readyToAchieve()

	setActive(arg_5_0.redpoint, var_5_0)
	setActive(arg_5_0.btnClick, arg_5_0.nday <= arg_5_0.tabCount - 1)
	setGray(arg_5_0.btnClick, not var_5_0 and not finsh)
	setActive(arg_5_0.btnGot, arg_5_0.nday >= arg_5_0.tabCount)
	setActive(arg_5_0.gotAward, arg_5_0.nday >= arg_5_0.tabCount)
	arg_5_0:lastDayShow(var_5_0)

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

function var_0_0.lastDayShow(arg_7_0, arg_7_1)
	if arg_7_0.nday == 6 and arg_7_1 then
		setActive(arg_7_0.tabsList[7], true)
		setActive(arg_7_0.btnGet, true)

		return
	end

	setActive(arg_7_0.btnGet, false)

	return
end

function var_0_0.RefreshTab(arg_8_0)
	for iter_8_0 = 1, arg_8_0.tabCount do
		setActive(arg_8_0.tabsList[iter_8_0], iter_8_0 <= arg_8_0.nday)
	end

	return
end

return var_0_0
