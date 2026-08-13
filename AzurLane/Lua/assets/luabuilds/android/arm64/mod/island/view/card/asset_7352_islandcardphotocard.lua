class = var_0_10000

local var_0_0 = var_0_10000("IslandCardPhotoCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.iconTF = var_2.Find(var_1_0, "icon")

	local var_1_1 = arg_1_0._tf

	arg_1_0.selectedTF = var_2.Find(var_1_1, "sel")

	local var_1_2 = arg_1_0._tf

	arg_1_0.selectedTagTF = var_2.Find(var_1_2, "sel_tag")

	local var_1_3 = arg_1_0._tf

	arg_1_0.unSelectedTF = var_2.Find(var_1_3, "unsel")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	pg = var_1_10003

	local var_2_0 = var_1_10003.island_card_diy[arg_2_1].resource

	LoadImageSpriteAsync = var_1_10004

	var_1_10004(var_2_0, arg_2_0.iconTF, true)
	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1 == arg_3_0.id

	setActive = var_1_10003

	var_1_10003(arg_3_0.selectedTF, var_3_0)

	setActive = var_1_10003

	var_1_10003(arg_3_0.selectedTagTF, var_3_0)

	setActive = var_1_10003

	var_1_10003(arg_3_0.unSelectedTF, not var_3_0)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
