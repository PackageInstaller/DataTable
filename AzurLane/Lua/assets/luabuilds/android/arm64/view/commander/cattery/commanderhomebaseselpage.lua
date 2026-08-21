local var_0_0 = class("CommanderHomeBaseSelPage", import("view.base.BaseSubView"))

function var_0_0.OnLoaded(arg_1_0)
	arg_1_0.scrollrect = arg_1_0._tf:Find("scrollrect"):GetComponent("LScrollRect")
	arg_1_0.okBtn = arg_1_0._tf:Find("ok_button")

	setActive(arg_1_0._tf, true)

	return
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.cards = {}

	function arg_2_0.scrollrect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_0.OnInitItem(arg_5_0, arg_5_1)
	local var_5_0 = CommanderCard.New(arg_5_1)

	onButton(arg_5_0, var_5_0._tf, function()
		arg_5_0:OnSelected(var_5_0)

		return
	end, SFX_PANEL)

	arg_5_0.cards[arg_5_1] = var_5_0

	return
end

function var_0_0.OnUpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.cards[arg_7_2]

	if not arg_7_0.cards[arg_7_2] then
		arg_7_0:OnInitItem(arg_7_2)

		var_7_0 = arg_7_0.cards[arg_7_2]
	end

	local var_7_1 = arg_7_1 + 1

	var_7_0:update(arg_7_0.displays[arg_7_1 + 1])
	setActive(var_7_0._tf:Find("line"), var_7_1 % 4 == 1)

	return
end

function var_0_0.Update(arg_8_0)
	arg_8_0:Show()

	arg_8_0.displays = {}

	for iter_8_0, iter_8_1 in pairs((getProxy(CommanderProxy):getData())) do
		table.insert(arg_8_0.displays, iter_8_1)
	end

	local var_8_0 = getProxy(FleetProxy):getCommandersInFleet()

	table.sort(arg_8_0.displays, function(arg_9_0, arg_9_1)
		local var_9_0 = table.contains(var_8_0, arg_9_0.id) and 1 or 0
		local var_9_1 = table.contains(var_8_0, arg_9_1.id) and 1 or 0

		if var_9_0 == var_9_1 then
			return arg_9_0.level > arg_9_1.level
		else
			return var_9_1 < var_9_0
		end

		return
	end)

	for iter_8_2 = 1, 8 - #arg_8_0.displays do
		table.insert(arg_8_0.displays, false)
	end

	arg_8_0.scrollrect:SetTotalCount(#arg_8_0.displays, -1)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.cards) do
		iter_10_1:clear()
	end

	return
end

function var_0_0.OnSelected(arg_11_0)
	return
end

return var_0_0
