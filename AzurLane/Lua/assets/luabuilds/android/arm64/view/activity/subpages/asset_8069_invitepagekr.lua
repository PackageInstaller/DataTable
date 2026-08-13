class = var_0_10000

local var_0_0 = "InvitePageKR"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.AD

	arg_1_0.btnGroup = var_1.Find(var_1_1, "btn_list")

	local var_1_2 = arg_1_0.btnGroup

	arg_1_0.btnClick = var_1.Find(var_1_2, "click")

	local var_1_3 = arg_1_0.btnGroup

	arg_1_0.btnGet = var_1.Find(var_1_3, "get")

	local var_1_4 = arg_1_0.btnGroup

	arg_1_0.btnGot = var_1.Find(var_1_4, "got")

	local var_1_5 = arg_1_0.btnGroup

	arg_1_0.redpoint = var_1.Find(var_1_5, "red")

	local var_1_6 = arg_1_0.AD

	arg_1_0.showList = var_1.Find(var_1_6, "show_list")

	local var_1_7 = arg_1_0.showList

	arg_1_0.progress = var_1.Find(var_1_7, "progress")
	tf = var_1
	arg_1_0.tabCount = var_1(arg_1_0.progress).childCount
	arg_1_0.tabsList = {}
	table = var_1

	local var_1_8 = var_1.insert
	local var_1_9 = arg_1_0.tabsList
	local var_1_10 = arg_1_0.progress

	var_1_8(var_1_9, var_4.Find(var_1_10, "item"))

	for iter_1_0 = 1, 6 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_1_11 = arg_1_0.tabsList
		local var_1_12 = arg_1_0.progress

		var_1_10005(var_1_11, var_8.Find(var_1_12, "item_" .. iter_1_0))
	end

	local var_1_13 = arg_1_0.showList

	arg_1_0.award = var_1.Find(var_1_13, "award")

	local var_1_14 = arg_1_0.award

	arg_1_0.gotAward = var_1.Find(var_1_14, "got")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	arg_2_0.nday = arg_2_0.activity.data1

	arg_2_0:RefreshTab()

	warning = var_1

	var_1("First是第几次签到" .. arg_2_0.nday)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.btnClick

	local function var_2_2()
		local var_3_0 = arg_2_0.activity

		if var_0.readyToAchieve(var_3_0) == false then
			return
		end

		local var_3_1 = arg_2_0
		local var_3_2 = var_1.emit

		ActivityMediator = var_2_10004

		var_3_2(var_3_1, var_2_10004.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.btnGet

	local function var_2_5()
		local var_4_0 = arg_2_0.activity

		if var_0.readyToAchieve(var_4_0) == false then
			return
		end

		local var_4_1 = arg_2_0
		local var_4_2 = var_1.emit

		ActivityMediator = var_2_10004

		var_4_2(var_4_1, var_2_10004.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	arg_5_0.nday = arg_5_0.activity.data1
	warning = var_1

	var_1("update是第几次签到" .. arg_5_0.nday)
	arg_5_0:RefreshTab()

	local var_5_0 = arg_5_0.activity
	local var_5_1 = var_1.readyToAchieve(var_5_0)

	setActive = var_1_10002

	var_1_10002(arg_5_0.redpoint, var_5_1)

	setActive = var_1_10002

	var_1_10002(arg_5_0.btnClick, arg_5_0.nday <= arg_5_0.tabCount - 1)

	setGray = var_1_10002

	local var_5_2 = arg_5_0.btnClick
	local var_5_3

	if not var_5_1 then
		finsh = var_5
		var_5_3 = not var_5
	else
		var_5_3 = false
	end

	if false then
		var_5_3 = true
	end

	var_1_10002(var_5_2, var_5_3)

	setActive = var_1_10002

	var_1_10002(arg_5_0.btnGot, arg_5_0.nday >= arg_5_0.tabCount)

	setActive = var_1_10002

	var_1_10002(arg_5_0.gotAward, arg_5_0.nday >= arg_5_0.tabCount)
	arg_5_0:lastDayShow(var_5_1)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

function var_0_1.lastDayShow(arg_7_0, arg_7_1)
	if arg_7_0.nday == 6 and arg_7_1 then
		setActive = var_2

		var_2(arg_7_0.tabsList[7], true)

		setActive = var_2

		var_2(arg_7_0.btnGet, true)

		return
	end

	setActive = var_2

	var_2(arg_7_0.btnGet, false)

	return
end

function var_0_1.RefreshTab(arg_8_0)
	for iter_8_0 = 1, arg_8_0.tabCount do
		setActive = var_1_10005

		var_1_10005(arg_8_0.tabsList[iter_8_0], iter_8_0 <= arg_8_0.nday)
	end

	return
end

return var_0_1
