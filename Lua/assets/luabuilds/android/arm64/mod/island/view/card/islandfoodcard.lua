local var_0_0 = class("IslandFoodCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.iconTF = arg_1_0._tf:Find("bg/icon")
	arg_1_0.barTF = arg_1_0._tf:Find("bg/silder/bar")
	arg_1_0.countTF = arg_1_0._tf:Find("count/Text")
	arg_1_0.eventTF = arg_1_0._tf:Find("event")
	arg_1_0.selectedTF = arg_1_0._tf:Find("selected")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.item = arg_2_1

	GetImageSpriteFromAtlasAsync("island/" .. arg_2_0.item:GetIcon(), "", arg_2_0.iconTF)
	arg_2_0:UpdateSelectedCnt(arg_2_2)
	setActive(arg_2_0.eventTF, arg_2_3)
	setFillAmount(arg_2_0.barTF, arg_2_4)

	return
end

function var_0_0.UpdateSelectedCnt(arg_3_0, arg_3_1)
	setText(arg_3_0.countTF, arg_3_0.item:GetCount() - arg_3_1)
	setActive(arg_3_0.selectedTF, arg_3_1 > 0)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
