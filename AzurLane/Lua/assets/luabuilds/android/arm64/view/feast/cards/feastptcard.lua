class = var_0_10000

local var_0_0 = var_0_10000("FeastPtCard")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "Text")
	local var_1_2 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.indexTxt = var_1_2(var_1_1, var_6(var_1_10008))

	local var_1_3 = arg_1_0._tf

	arg_1_0.lockBtn = var_3.Find(var_1_3, "btns/lock")

	local var_1_4 = arg_1_0._tf

	arg_1_0.getBtn = var_3.Find(var_1_4, "btns/get")

	local var_1_5 = arg_1_0._tf

	arg_1_0.gotBtn = var_3.Find(var_1_5, "btns/got")

	local var_1_6 = arg_1_0._tf

	arg_1_0.award = var_3.Find(var_1_6, "award")
	setText = var_3

	local var_1_7 = arg_1_0.getBtn
	local var_1_8 = var_5.Find(var_1_7, "Text")

	i18n = var_6

	var_3(var_1_8, var_6("feast_task_pt_get"))

	setText = var_3

	local var_1_9 = arg_1_0.gotBtn
	local var_1_10 = var_5.Find(var_1_9, "Text")

	i18n = var_6

	var_3(var_1_10, var_6("feast_task_pt_got"))

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.indexTxt

	i18n = var_1_10004
	var_2_0.text = var_1_10004("feast_task_pt_level", arg_2_2)

	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.GetDrop(var_2_1, arg_2_2)

	updateDrop = var_4

	var_4(arg_2_0.award, var_2_2)

	onButton = var_4

	local var_2_3 = arg_2_0.binder
	local var_2_4 = arg_2_0.award

	local function var_2_5()
		local var_3_0 = arg_2_0.binder
		local var_3_1 = var_0.emit

		BaseUI = var_2_10003

		var_3_1(var_3_0, var_2_10003.ON_DROP, var_2_2)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_2_3, var_2_4, var_2_5, var_1_10009)

	local var_2_6 = arg_2_1:GetDroptItemState(arg_2_2)

	setActive = var_2_1

	local var_2_7 = arg_2_0.lockBtn

	ActivityPtData = var_2_5

	var_2_1(var_2_7, var_2_6 == var_2_5.STATE_LOCK)

	setActive = var_2_1

	local var_2_8 = arg_2_0.getBtn

	ActivityPtData = var_8

	var_2_1(var_2_8, var_2_6 == var_8.STATE_CAN_GET)

	setActive = var_2_1

	local var_2_9 = arg_2_0.gotBtn

	ActivityPtData = var_8

	var_2_1(var_2_9, var_2_6 == var_8.STATE_GOT)

	onButton = var_2_1

	local var_2_10 = arg_2_0.binder
	local var_2_11 = arg_2_0._tf

	local function var_2_12()
		local var_4_0 = var_2_6

		ActivityPtData = var_2_10001

		if var_4_0 == var_2_10001.STATE_CAN_GET then
			local var_4_1 = arg_2_1
			local var_4_2 = var_0.GetPtTarget(var_4_1, arg_2_2)
			local var_4_3 = arg_2_0.binder
			local var_4_4 = var_1.emit

			FeastMediator = var_2_10004

			local var_4_5 = var_2_10004.EVENT_PT_OPERATION
			local var_4_6 = {
				cmd = 1
			}
			local var_4_7 = arg_2_1

			var_4_6.activity_id = var_6.GetId(var_4_7)
			var_4_6.arg1 = var_4_2

			var_4_4(var_4_3, var_4_5, var_4_6)
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_2_1(var_2_10, var_2_11, var_2_12, var_1_10010)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
