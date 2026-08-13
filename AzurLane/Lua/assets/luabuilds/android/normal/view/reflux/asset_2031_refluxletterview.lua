class = var_0_10000

local var_0_0 = "RefluxLetterView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "RefluxLetterUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	return
end

function var_0_1.OnBackPress(arg_4_0)
	arg_4_0:Hide()

	if arg_4_0.closeCB then
		arg_4_0.closeCB()
	end

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	RefluxProxy = var_1_10002
	arg_5_0.refluxProxy = var_1_10001(var_1_10002)

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.billboardTF = var_1.Find(var_6_0, "billboard")
	arg_6_0.yearText = var_1:Find("year")
	arg_6_0.monthText = var_1:Find("month")
	arg_6_0.dateText = var_1:Find("date")
	arg_6_0.daysText = var_1:Find("days")
	arg_6_0.countText = var_1:Find("count")
	arg_6_0.shareBtn = var_1:Find("btn_share")
	setActive = var_2

	var_2(arg_6_0.shareBtn, false)

	onButton = var_2

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.billboardTF

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.OnBackPress(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_6_1, var_6_2, var_6_3, var_1_10006)

	return
end

function var_0_1.updateUI(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.TimeMgr.GetInstance()
	local var_8_1 = arg_8_0.refluxProxy.returnLastTimestamp
	local var_8_2 = arg_8_0.refluxProxy.returnTimestamp
	local var_8_3 = var_8_0
	local var_8_4 = var_8_0.STimeDescS(var_8_3, var_8_1, "*t")

	setText = var_8_3

	var_8_3(arg_8_0.yearText, var_8_4.year % 100)

	setText = var_8_3

	var_8_3(arg_8_0.monthText, var_8_4.month)

	setText = var_8_3

	var_8_3(arg_8_0.dateText, var_8_4.day)

	setText = var_8_3

	var_8_3(arg_8_0.daysText, var_8_0:DiffDay(var_8_1, var_8_2))

	setText = var_8_3

	var_8_3(arg_8_0.countText, arg_8_0.refluxProxy.returnShipNum)

	return
end

function var_0_1.setCloseFunc(arg_9_0, arg_9_1)
	arg_9_0.closeCB = arg_9_1

	return
end

return var_0_1
