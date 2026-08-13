class = var_0_10000

local var_0_0 = var_0_10000("IslandCardSetLabelCard")

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

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_1
	arg_2_0.value = arg_2_2
	pg = var_1_10004

	local var_2_0 = var_1_10004.island_card_label[arg_2_0.id].name

	setText = var_5

	var_5(arg_2_0.nameTF, var_2_0)

	setText = var_5

	var_5(arg_2_0.valueTF, arg_2_2)
	arg_2_0:UpdateSelected(arg_2_3)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1 == arg_3_0.id

	setActive = var_1_10003

	var_1_10003(arg_3_0.selectedTF, var_3_0)

	setActive = var_1_10003

	var_1_10003(arg_3_0.unSelectedTF, not var_3_0)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
