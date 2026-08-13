class = var_0_10000

local var_0_0 = "CommanderHomeBaseSelPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.OnLoaded(arg_1_0)
	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_1.Find(var_1_0, "scrollrect")

	arg_1_0.scrollrect = var_1.GetComponent(var_1_1, "LScrollRect")

	local var_1_2 = arg_1_0._tf

	arg_1_0.okBtn = var_1.Find(var_1_2, "ok_button")
	setActive = var_1

	var_1(arg_1_0._tf, true)

	return
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0.cards = {}

	function arg_2_0.scrollrect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_1.OnInitItem(arg_5_0, arg_5_1)
	CommanderCard = var_1_10002

	local var_5_0 = var_1_10002.New(arg_5_1)

	onButton = var_1_10003

	local var_5_1 = arg_5_0
	local var_5_2 = var_5_0._tf

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.OnSelected(var_6_0, var_5_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_5_1, var_5_2, var_5_3, var_1_10008)

	arg_5_0.cards[arg_5_1] = var_5_0

	return
end

function var_0_1.OnUpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if not arg_7_0.cards[arg_7_2] then
		arg_7_0:OnInitItem(arg_7_2)

		var_7_0 = arg_7_0.cards[arg_7_2]
	end

	local var_7_1 = arg_7_1 + 1
	local var_7_2 = arg_7_0.displays[var_7_1]

	var_7_0:update(var_7_2)

	setActive = var_6

	local var_7_3 = var_7_0._tf

	var_6(var_8.Find(var_7_3, "line"), var_7_1 % 4 == 1)

	return
end

function var_0_1.Update(arg_8_0)
	local var_8_0 = arg_8_0

	arg_8_0.Show(var_8_0)

	getProxy = var_1
	CommanderProxy = var_8_0

	local var_8_1 = var_1(var_8_0)
	local var_8_2 = var_1.getData(var_8_1)

	arg_8_0.displays = {}
	pairs = var_2

	for iter_8_0, iter_8_1 in var_2(var_8_2) do
		table = var_1_10007

		var_1_10007.insert(arg_8_0.displays, iter_8_1)
	end

	getProxy = var_2
	FleetProxy = var_4

	local var_8_3 = var_2(var_4)
	local var_8_4 = var_2.getCommandersInFleet(var_8_3)

	table = var_3

	var_3.sort(arg_8_0.displays, function(arg_9_0, arg_9_1)
		table = var_2_10002

		local var_9_0 = var_2_10002.contains(var_8_4, arg_9_0.id) and 1 or 0

		table = var_2_10003

		if var_9_0 == (var_2_10003.contains(var_8_4, arg_9_1.id) and 1 or 0) then
			return arg_9_0.level > arg_9_1.level
		else
			return var_3 < var_9_0
		end

		return
	end)

	local var_8_5 = 8 - #arg_8_0.displays

	for iter_8_2 = 1, var_8_5 do
		table = var_1_10009

		var_1_10009.insert(arg_8_0.displays, false)
	end

	local var_8_6 = arg_8_0.scrollrect

	var_5.SetTotalCount(var_8_6, #arg_8_0.displays, -1)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.cards) do
		iter_10_1:clear()
	end

	return
end

function var_0_1.OnSelected(arg_11_0)
	return
end

return var_0_1
