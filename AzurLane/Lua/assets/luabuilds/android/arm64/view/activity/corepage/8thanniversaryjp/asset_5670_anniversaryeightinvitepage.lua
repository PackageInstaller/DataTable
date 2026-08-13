class = var_0_10000

local var_0_0 = "AnniversaryEightInvitePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.rtMarks = var_1.Find(var_1_0, "AD/image_02/progress")

	local var_1_1 = arg_1_0._tf

	arg_1_0.rtFinish = var_1.Find(var_1_1, "AD/image_02/award")

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
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_4_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.CITY_REBUILD_MAP)

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
	local var_6_1, var_6_2, var_6_3 = var_1.GetResProgress(var_6_0)
	local var_6_4 = arg_6_0.rtMarks.childCount
	local var_6_5 = arg_6_0.ptData
	local var_6_6 = var_5.GetDroptItemState
	local var_6_7 = arg_6_0.ptData
	local var_6_8 = var_6_6(var_6_5, var_8.GetCurrLevel(var_6_7))

	for iter_6_0 = 1, var_6_4 do
		local var_6_9 = arg_6_0.rtMarks
		local var_6_10 = var_10.GetChild(var_6_9, iter_6_0 - 1)

		setActive = var_1_10011

		var_1_10011(var_6_10:Find("mark"), iter_6_0 <= var_6_1)
	end

	setActive = var_6

	local var_6_11 = arg_6_0.rtBtns
	local var_6_12 = var_8.Find(var_6_11, "get")

	ActivityPtData = iter_6_0

	var_6(var_6_12, var_6_8 == iter_6_0.STATE_CAN_GET and var_6_2 <= var_6_1)

	setActive = var_6

	local var_6_13 = arg_6_0.rtBtns
	local var_6_14 = var_8.Find(var_6_13, "got")

	ActivityPtData = var_9

	var_6(var_6_14, var_6_8 == var_9.STATE_GOT and var_6_2 <= var_6_1)

	setActive = var_6

	local var_6_15 = arg_6_0.rtBtns
	local var_6_16 = var_8.Find(var_6_15, "red")

	ActivityPtData = var_9

	var_6(var_6_16, var_6_8 == var_9.STATE_CAN_GET and var_6_2 <= var_6_1)

	setActive = var_6

	local var_6_17 = arg_6_0.rtBtns

	var_6(var_8.Find(var_6_17, "go"), var_6_1 < var_6_2)

	setActive = var_6

	local var_6_18 = arg_6_0.rtFinish

	ActivityPtData = var_9

	var_6(var_6_18, var_6_8 == var_9.STATE_GOT)

	return
end

return var_0_1
