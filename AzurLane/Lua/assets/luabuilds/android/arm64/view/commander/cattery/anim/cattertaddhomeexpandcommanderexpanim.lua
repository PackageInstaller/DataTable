class = var_0_10000

local var_0_0 = "CattertAddHomeExpAndCommanderExpAnim"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CatteryAddHomeExpAnim"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	findTF = var_1_10002

	local var_1_0 = var_1_10002(arg_1_0._tf, "home/slider")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Slider = var_1_10007
	arg_1_0.expSlider = var_1_1(var_1_0, var_5(var_1_10007))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tf, "home/level")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.levelTxt = var_1_3(var_1_2, var_5(var_1_10007))
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._tf, "home/exp")
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.expTxt = var_1_5(var_1_4, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.addition = var_2(arg_1_0._tf, "home/addition")

	local var_1_6 = arg_1_0.addition
	local var_1_7 = var_2.Find(var_1_6, "Text")
	local var_1_8 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.additionExpTxt = var_1_8(var_1_7, var_5(var_1_10007))
	UIItemList = var_2

	local var_1_9 = var_2.New

	findTF = var_1_7

	local var_1_10 = var_1_7(arg_1_0._tf, "commanders")

	findTF = var_5
	arg_1_0.uilist = var_1_9(var_1_10, var_5(arg_1_0._tf, "commanders/tpl"))
	arg_1_0.cards = {}

	local var_1_11 = arg_1_0.uilist

	var_2.make(var_1_11, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.UpdateCommander(var_2_0, arg_2_2, arg_1_0.displays[arg_2_1 + 1])
		end

		return
	end)

	arg_1_0.animRiseH = arg_1_0.addition.localPosition.y
	setActive = var_2

	var_2(arg_1_0._tf, false)

	return
end

function var_0_1.RefreshAward(arg_3_0)
	return
end

function var_0_1.Action(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0.commanderExps = arg_4_1
	parallelAsync = var_1_10006

	var_1_10006({
		function(arg_5_0)
			var_0_1.super.Action(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.InitCommanders(var_6_0)

			local var_6_1 = arg_4_0

			var_1.DoCommandersAnim(var_6_1, arg_6_0)

			return
		end
	}, arg_4_5)

	return
end

function var_0_1.HideOrShowAddition(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0.addition, arg_7_1 > 0)

	return
end

function var_0_1.GetAwardOffset(arg_8_0)
	return 473
end

function var_0_1.InitCommanders(arg_9_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.GetCommanderHome(var_9_0)
	local var_9_2 = var_1.GetCatteries(var_9_1)

	arg_9_0.displays = {}
	pairs = var_3

	for iter_9_0, iter_9_1 in var_3(var_9_2) do
		table = var_1_10008

		var_1_10008.insert(arg_9_0.displays, iter_9_1)
	end

	table = var_3

	var_3.sort(arg_9_0.displays, function(arg_10_0, arg_10_1)
		return arg_10_0:GetCommanderId() > arg_10_1:GetCommanderId()
	end)

	local var_9_3 = arg_9_0.uilist

	var_3.align(var_9_3, #arg_9_0.displays)

	return
end

function var_0_1.DoCommandersAnim(arg_11_0, arg_11_1)
	local var_11_0 = {}

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.cards) do
		table = var_1_10008

		var_1_10008.insert(var_11_0, function(arg_12_0)
			local var_12_0 = iter_11_1

			var_1.Action(var_12_0, arg_12_0)

			return
		end)
	end

	parallelAsync = var_3

	var_3(var_11_0, arg_11_1)

	return
end

function var_0_1.UpdateCommander(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if not arg_13_0.cards[arg_13_1] then
		CatteryAnimCard = var_1_10004
		var_13_0 = var_1_10004.New(arg_13_1)
		arg_13_0.cards[arg_13_1] = var_13_0
	end

	local var_13_1 = 0

	_ = var_1_10005

	if var_1_10005.detect(arg_13_0.commanderExps, function(arg_14_0)
		return arg_14_0.id == arg_13_2.id
	end) then
		var_13_1 = var_5.value
	end

	var_13_0:Update(arg_13_2, var_13_1)

	return
end

function var_0_1.Clear(arg_15_0)
	var_0_1.super.Clear(arg_15_0)

	pairs = var_1

	for iter_15_0, iter_15_1 in var_1(arg_15_0.cards) do
		iter_15_1:Clear()
	end

	return
end

function var_0_1.Dispose(arg_16_0)
	var_0_1.super.Dispose(arg_16_0)

	pairs = var_1

	for iter_16_0, iter_16_1 in var_1(arg_16_0.cards) do
		iter_16_1:Dispose()
	end

	arg_16_0.cards = nil

	return
end

return var_0_1
