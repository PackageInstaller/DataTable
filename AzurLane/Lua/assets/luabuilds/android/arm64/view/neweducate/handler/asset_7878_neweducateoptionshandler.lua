class = var_0_10000

local var_0_0 = var_0_10000("NewEducateOptionsHandler")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.tpl = var_2.Find(var_1_0, "tpl")
	UIItemList = var_2
	arg_1_0.optionUIList = var_2.New(arg_1_0._tf, arg_1_0.tpl)

	local var_1_1 = arg_1_0.optionUIList

	var_2.make(var_1_1, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.UpdateOption(var_2_0, arg_2_1, arg_2_2)
		end

		return
	end)

	return
end

function var_0_0.Play(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.callName then
		getProxy = var_3
		NewEducateProxy = var_1_10005

		local var_3_0 = var_3(var_1_10005)
		local var_3_1 = var_3.GetCurChar(var_3_0)

		arg_3_0.callName = var_3.GetCallName(var_3_1)
	end

	setActive = var_3

	var_3(arg_3_0._go, true)

	arg_3_0.optionIds = arg_3_1
	arg_3_0.callback = arg_3_2

	local var_3_2 = arg_3_0.optionUIList

	var_3.align(var_3_2, #arg_3_0.optionIds)

	return
end

function var_0_0._GetText(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.child2_word[arg_4_1].word

	string = var_1_10003

	return var_1_10003.gsub(var_4_0, "$1", arg_4_0.callName)
end

function var_0_0.UpdateOption(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.optionIds[arg_5_1 + 1]

	pg = var_4

	local var_5_1 = var_4.child2_node[var_5_0]

	setScrollText = var_1_10005

	local var_5_2 = arg_5_2:Find("mask/Text")
	local var_5_3 = arg_5_0

	var_1_10005(var_5_2, arg_5_0._GetText(var_5_3, var_5_1.text))

	onButton = var_1_10005

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_2

	local function var_5_6()
		existCall = var_2_10000

		var_2_10000(arg_5_0.callback(var_5_0))

		local var_6_0 = arg_5_0

		var_0.Reset(var_6_0)

		return
	end

	SFX_PANEL = var_5_3

	var_1_10005(var_5_4, var_5_5, var_5_6, var_5_3)

	return
end

function var_0_0.UpdateCallName(arg_7_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.GetCurChar(var_7_0)

	arg_7_0.callName = var_1.GetCallName(var_7_1)

	return
end

function var_0_0.Reset(arg_8_0)
	arg_8_0.callback = nil
	setActive = var_1

	var_1(arg_8_0._go, false)

	return
end

function var_0_0.Destroy(arg_9_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_9_0)

	return
end

return var_0_0
