local var_0_0 = class("CattertAddHomeExpAndCommanderExpAnim", import(".CatteryAddHomeExpAnim"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.expSlider = findTF(arg_1_0._tf, "home/slider"):GetComponent(typeof(Slider))
	arg_1_0.levelTxt = findTF(arg_1_0._tf, "home/level"):GetComponent(typeof(Text))
	arg_1_0.expTxt = findTF(arg_1_0._tf, "home/exp"):GetComponent(typeof(Text))
	arg_1_0.addition = findTF(arg_1_0._tf, "home/addition")
	arg_1_0.additionExpTxt = arg_1_0.addition:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.uilist = UIItemList.New(findTF(arg_1_0._tf, "commanders"), findTF(arg_1_0._tf, "commanders/tpl"))
	arg_1_0.cards = {}

	arg_1_0.uilist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateCommander(arg_2_2, arg_1_0.displays[arg_2_1 + 1])
		end

		return
	end)

	arg_1_0.animRiseH = arg_1_0.addition.localPosition.y

	setActive(arg_1_0._tf, false)

	return
end

function var_0_0.RefreshAward(arg_3_0)
	return
end

function var_0_0.Action(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0.commanderExps = arg_4_1

	parallelAsync({
		function(arg_5_0)
			var_0_0.super.Action(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_4_0:InitCommanders()
			arg_4_0:DoCommandersAnim(arg_6_0)

			return
		end
	}, arg_4_5)

	return
end

function var_0_0.HideOrShowAddition(arg_7_0, arg_7_1)
	setActive(arg_7_0.addition, arg_7_1 > 0)

	return
end

function var_0_0.GetAwardOffset(arg_8_0)
	return 473
end

function var_0_0.InitCommanders(arg_9_0)
	arg_9_0.displays = {}

	for iter_9_0, iter_9_1 in pairs((getProxy(CommanderProxy):GetCommanderHome():GetCatteries())) do
		table.insert(arg_9_0.displays, iter_9_1)
	end

	table.sort(arg_9_0.displays, function(arg_10_0, arg_10_1)
		return arg_10_0:GetCommanderId() > arg_10_1:GetCommanderId()
	end)
	arg_9_0.uilist:align(#arg_9_0.displays)

	return
end

function var_0_0.DoCommandersAnim(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.cards) do
		table.insert({}, function(arg_12_0)
			iter_11_1:Action(arg_12_0)

			return
		end)
	end

	parallelAsync({}, arg_11_1)

	return
end

function var_0_0.UpdateCommander(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.cards[arg_13_1]

	if not arg_13_0.cards[arg_13_1] then
		var_13_0 = CatteryAnimCard.New(arg_13_1)
		arg_13_0.cards[arg_13_1] = var_13_0
	end

	local var_13_1 = 0
	local var_13_2 = _.detect(arg_13_0.commanderExps, function(arg_14_0)
		return arg_14_0.id == arg_13_2.id
	end)

	if var_13_2 then
		var_13_1 = var_13_2.value
	end

	var_13_0:Update(arg_13_2, var_13_1)

	return
end

function var_0_0.Clear(arg_15_0)
	var_0_0.super.Clear(arg_15_0)

	for iter_15_0, iter_15_1 in pairs(arg_15_0.cards) do
		iter_15_1:Clear()
	end

	return
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	for iter_16_0, iter_16_1 in pairs(arg_16_0.cards) do
		iter_16_1:Dispose()
	end

	arg_16_0.cards = nil

	return
end

return var_0_0
