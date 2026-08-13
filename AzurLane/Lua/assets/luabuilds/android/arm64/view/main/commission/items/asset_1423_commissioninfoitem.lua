class = var_0_10000

local var_0_0 = var_0_10000("CommissionInfoItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_2
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.parentTF = arg_1_0._tf.parent

	local var_1_0 = arg_1_0._tf

	arg_1_0.goBtn = var_3.Find(var_1_0, "frame/go_btn")

	local var_1_1 = arg_1_0._tf

	arg_1_0.finishedBtn = var_3.Find(var_1_1, "frame/finish_btn")

	local var_1_2 = arg_1_0._tf

	arg_1_0.toggle = var_3.Find(var_1_2, "frame")

	local var_1_3 = arg_1_0._tf

	arg_1_0.foldFlag = var_3.Find(var_1_3, "frame/tip")

	local var_1_4 = arg_1_0._tf

	arg_1_0.finishedCounterContainer = var_3.Find(var_1_4, "frame/counter/finished")

	local var_1_5 = arg_1_0._tf

	arg_1_0.ongoingCounterContainer = var_3.Find(var_1_5, "frame/counter/ongoing")

	local var_1_6 = arg_1_0._tf

	arg_1_0.leisureCounterContainer = var_3.Find(var_1_6, "frame/counter/leisure")

	local var_1_7 = arg_1_0._tf
	local var_1_8 = var_3.Find(var_1_7, "frame/counter/finished/Text")
	local var_1_9 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.finishedCounter = var_1_9(var_1_8, var_6(var_1_10008))

	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_3.Find(var_1_10, "frame/counter/ongoing/Text")
	local var_1_12 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.ongoingCounter = var_1_12(var_1_11, var_6(var_1_10008))

	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_3.Find(var_1_13, "frame/counter/leisure/Text")
	local var_1_15 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.leisureCounter = var_1_15(var_1_14, var_6(var_1_10008))

	local var_1_16 = arg_1_0._tf
	local var_1_17 = var_3.Find(var_1_16, "list")
	local var_1_18 = var_3.GetChild(var_1_17, 0)

	UIItemList = var_1_16
	arg_1_0.uilist = var_1_16.New(var_3, var_1_18)
	setActive = var_5

	var_5(arg_1_0.finishedCounterContainer, false)

	setActive = var_5

	var_5(arg_1_0.ongoingCounterContainer, false)

	setActive = var_5

	var_5(arg_1_0.leisureCounterContainer, false)

	getProxy = var_5
	SettingsProxy = var_7

	local var_1_19 = var_5(var_7)

	if var_5.IsMellowStyle(var_1_19) then
		setText = var_5

		local var_1_20 = arg_1_0.goBtn
		local var_1_21 = var_7.Find(var_1_20, "Image")

		i18n = var_8

		var_5(var_1_21, var_8("commission_label_go_mellow"))

		setText = var_5

		local var_1_22 = arg_1_0.finishedBtn
		local var_1_23 = var_7.Find(var_1_22, "Image")

		i18n = var_8

		var_5(var_1_23, var_8("commission_label_finish_mellow"))

		setText = var_5

		local var_1_24 = var_1_18:Find("unlock/leisure/go_btn/Image")

		i18n = var_8

		var_5(var_1_24, var_8("commission_label_go_mellow"))

		setText = var_5

		local var_1_25 = var_1_18:Find("unlock/finished/finish_btn/Image")

		i18n = var_8

		var_5(var_1_25, var_8("commission_label_finish_mellow"))
	else
		setText = var_5

		local var_1_26 = arg_1_0.goBtn
		local var_1_27 = var_7.Find(var_1_26, "Image")

		i18n = var_8

		var_5(var_1_27, var_8("commission_label_go"))

		setText = var_5

		local var_1_28 = arg_1_0.finishedBtn
		local var_1_29 = var_7.Find(var_1_28, "Image")

		i18n = var_8

		var_5(var_1_29, var_8("commission_label_finish"))

		setText = var_5

		local var_1_30 = var_1_18:Find("unlock/leisure/go_btn/Image")

		i18n = var_8

		var_5(var_1_30, var_8("commission_label_go"))

		setText = var_5

		local var_1_31 = var_1_18:Find("unlock/finished/finish_btn/Image")

		i18n = var_8

		var_5(var_1_31, var_8("commission_label_finish"))
	end

	arg_1_0.timers = {}

	return
end

function var_0_0.Init(arg_2_0)
	onToggle = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.toggle

	local function var_2_2(arg_3_0)
		local var_3_0 = arg_2_0.foldFlag

		Vector3 = var_2_10002
		var_3_0.localScale = var_2_10002(1, arg_3_0 and -1 or 1, 1)

		if not arg_3_0 then
			return
		end

		local var_3_1 = arg_2_0
		local var_3_2, var_3_3 = var_1.CanOpen(var_3_1)

		if not var_3_2 then
			pg = var_3_1

			local var_3_4 = var_3_1.TipsMgr.GetInstance()

			var_3.ShowTips(var_3_4, var_3_3)

			triggerToggle = var_3

			var_3(arg_2_0._tf, false)

			return
		end

		local var_3_5 = arg_2_0

		var_3.Adpater(var_3_5)

		if not arg_2_0.isInitList then
			local var_3_6 = arg_2_0

			var_3.UpdateList(var_3_6)

			arg_2_0.isInitList = true
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.goBtn

	local function var_2_5()
		local var_4_0 = arg_2_0

		var_0.OnSkip(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.finishedBtn

	local function var_2_8()
		local var_5_0 = arg_2_0

		var_0.OnFinishAll(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10006)

	local var_2_9 = arg_2_0.uilist

	var_1.make(var_2_9, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_2_0.list[arg_6_1 + 1]
			local var_6_1 = arg_2_0

			var_4.UpdateListItem(var_6_1, arg_6_1 + 1, var_6_0, arg_6_2)
		end

		return
	end)
	arg_2_0:Flush()

	return
end

function var_0_0.Adpater(arg_7_0)
	local var_7_0

	var_7_0, Vector3 = arg_7_0.parentTF.localPosition.x, var_1_10002
	math = var_1_10005

	local var_7_1 = var_1_10002(var_7_0, var_1_10005.abs(arg_7_0._tf.localPosition.y), 0)

	arg_7_0.parentTF.localPosition = var_7_1

	return
end

function var_0_0.CanOpen(arg_8_0)
	return true
end

function var_0_0.Flush(arg_9_0)
	if arg_9_0:CanOpen() then
		arg_9_0:OnFlush()
	end

	return
end

function var_0_0.Update(arg_10_0)
	arg_10_0:Flush()

	if arg_10_0.isInitList then
		arg_10_0:UpdateList()
	end

	return
end

function var_0_0.RemoveTimers(arg_11_0)
	pairs = var_1_10001

	local var_11_0

	if not arg_11_0.timers then
		var_11_0 = {}
	end

	for iter_11_0, iter_11_1 in var_1_10001(var_11_0) do
		iter_11_1:Stop()
	end

	arg_11_0.timers = {}

	return
end

function var_0_0.UpdateList(arg_12_0)
	arg_12_0:RemoveTimers()

	local var_12_0, var_12_1 = arg_12_0:GetList()
	local var_12_2 = arg_12_0.uilist

	var_3.align(var_12_2, var_12_1 or #var_12_0)

	arg_12_0.list = var_12_0

	return
end

function var_0_0.OnFlush(arg_13_0)
	return
end

function var_0_0.UpdateListItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return
end

function var_0_0.GetList(arg_15_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_0.OnSkip(arg_16_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_0.OnFinishAll(arg_17_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_0.emit(arg_18_0, ...)
	local var_18_0 = arg_18_0.view

	var_1.emit(var_18_0, ...)

	return
end

function var_0_0.Dispose(arg_19_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_19_0)
	arg_19_0:RemoveTimers()

	return
end

return var_0_0
