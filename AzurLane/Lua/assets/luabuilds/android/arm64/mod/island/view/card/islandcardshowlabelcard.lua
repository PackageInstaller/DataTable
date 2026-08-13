class = var_0_10000

local var_0_0 = var_0_10000("IslandCardShowLabelCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.nameTF = var_2.Find(var_1_0, "name")

	local var_1_1 = arg_1_0._tf

	arg_1_0.valueTF = var_2.Find(var_1_1, "value")

	local var_1_2 = arg_1_0._tf

	arg_1_0.selectedTF = var_2.Find(var_1_2, "sel")

	local var_1_3 = arg_1_0._tf

	arg_1_0.unSelectedTF = var_2.Find(var_1_3, "unsel")
	setActive = var_2

	var_2(arg_1_0.selectedTF, false)

	setActive = var_2

	var_2(arg_1_0.unSelectedTF, true)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.value = arg_2_2
	pg = var_1_10003

	local var_2_0 = var_1_10003.island_card_label[arg_2_0.id].name

	setText = var_4

	var_4(arg_2_0.nameTF, var_2_0)

	setText = var_4

	var_4(arg_2_0.valueTF, arg_2_2)

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
