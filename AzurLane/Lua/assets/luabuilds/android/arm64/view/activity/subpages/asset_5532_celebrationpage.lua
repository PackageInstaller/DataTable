class = var_0_10000

local var_0_0 = "CelebrationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.rtMarks = var_1.Find(var_1_0, "AD/progress")

	local var_1_1 = arg_1_0._tf

	arg_1_0.rtFinish = var_1.Find(var_1_1, "AD/award")

	local var_1_2 = arg_1_0._tf

	arg_1_0.rtBtns = var_1.Find(var_1_2, "AD/btn_list")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		local var_2_0 = arg_2_0.ptData

		var_1.Update(var_2_0, arg_2_0.activity)
	else
		ActivityPtData = var_1
		arg_2_0.ptData = var_1.New(arg_2_0.activity)
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.rtBtns
	local var_3_2 = var_4.Find(var_3_1, "go")

	local function var_3_3()
		Context = var_2_10000

		local var_4_0 = var_2_10000.New
		local var_4_1 = {}

		HolidayVillaShopMediator = var_2_10003
		var_4_1.mediator = var_2_10003
		HolidayVillaShopLayer = var_2_10003
		var_4_1.viewComponent = var_2_10003

		local var_4_2 = var_4_0(var_4_1)
		local var_4_3 = arg_3_0
		local var_4_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_4_4(var_4_3, var_2_10004.OPEN_LAYER, var_4_2)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.rtBtns
	local var_3_6 = var_4.Find(var_3_5, "get")

	local function var_3_7()
		local var_5_0 = arg_3_0.ptData
		local var_5_1 = var_0.GetCurrTarget(var_5_0)
		local var_5_2 = arg_3_0
		local var_5_3 = var_1.emit

		ActivityMediator = var_2_10004

		local var_5_4 = var_2_10004.EVENT_PT_OPERATION
		local var_5_5 = {
			cmd = 4
		}
		local var_5_6 = arg_3_0.ptData

		var_5_5.activity_id = var_6.GetId(var_5_6)
		var_5_5.arg1 = var_5_1

		var_5_3(var_5_2, var_5_4, var_5_5)

		return
	end

	SFX_PANEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.ptData
	local var_6_1 = var_1.GetCurrTarget(var_6_0)
	local var_6_2 = arg_6_0.ptData
	local var_6_3 = var_2.GetLevel(var_6_2)
	local var_6_4 = arg_6_0.rtMarks.childCount

	for iter_6_0 = 1, var_6_4 do
		local var_6_5 = arg_6_0.rtMarks
		local var_6_6 = var_8.GetChild(var_6_5, iter_6_0 - 1)

		setActive = var_1_10009

		var_1_10009(var_6_6:Find("icon"), iter_6_0 <= var_6_1)

		setActive = var_1_10009

		var_1_10009(var_6_6:Find("mark"), var_6_1 < iter_6_0)
	end

	setActive = var_4

	local var_6_7 = arg_6_0.rtBtns

	var_4(var_6.Find(var_6_7, "get"), var_6_3 == 0 and var_6_1 >= 7)

	setActive = var_4

	local var_6_8 = arg_6_0.rtBtns

	var_4(var_6.Find(var_6_8, "got"), var_6_3 > 0)

	setActive = var_4

	local var_6_9 = arg_6_0.rtBtns

	var_4(var_6.Find(var_6_9, "go"), var_6_1 < 7)

	setActive = var_4

	local var_6_10 = arg_6_0.rtBtns

	var_4(var_6.Find(var_6_10, "red"), var_6_3 == 0 and var_6_1 >= 7 and var_6_3 ~= 1)

	return
end

return var_0_1
