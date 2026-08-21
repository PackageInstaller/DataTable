local var_0_0 = class("IslandCardPhotoCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.iconTF = arg_1_0._tf:Find("icon")
	arg_1_0.selectedTF = arg_1_0._tf:Find("sel")
	arg_1_0.selectedTagTF = arg_1_0._tf:Find("sel_tag")
	arg_1_0.unSelectedTF = arg_1_0._tf:Find("unsel")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1

	LoadImageSpriteAsync(pg.island_card_diy[arg_2_1].resource, arg_2_0.iconTF, true)
	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1 == arg_3_0.id

	setActive(arg_3_0.selectedTF, arg_3_1 and arg_3_1 == arg_3_0.id)
	setActive(arg_3_0.selectedTagTF, var_3_0)
	setActive(arg_3_0.unSelectedTF, not var_3_0)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
