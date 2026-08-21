local var_0_0 = class("IslandCardShowLabelCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.nameTF = arg_1_0._tf:Find("name")
	arg_1_0.valueTF = arg_1_0._tf:Find("value")
	arg_1_0.selectedTF = arg_1_0._tf:Find("sel")
	arg_1_0.unSelectedTF = arg_1_0._tf:Find("unsel")

	setActive(arg_1_0.selectedTF, false)
	setActive(arg_1_0.unSelectedTF, true)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.value = arg_2_2

	setText(arg_2_0.nameTF, pg.island_card_label[arg_2_0.id].name)
	setText(arg_2_0.valueTF, arg_2_2)

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
