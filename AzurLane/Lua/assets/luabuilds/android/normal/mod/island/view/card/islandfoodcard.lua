class = var_0_10000

local var_0_0 = var_0_10000("IslandFoodCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.iconTF = var_2.Find(var_1_0, "bg/icon")

	local var_1_1 = arg_1_0._tf

	arg_1_0.barTF = var_2.Find(var_1_1, "bg/silder/bar")

	local var_1_2 = arg_1_0._tf

	arg_1_0.countTF = var_2.Find(var_1_2, "count/Text")

	local var_1_3 = arg_1_0._tf

	arg_1_0.eventTF = var_2.Find(var_1_3, "event")

	local var_1_4 = arg_1_0._tf

	arg_1_0.selectedTF = var_2.Find(var_1_4, "selected")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.item = arg_2_1
	GetImageSpriteFromAtlasAsync = var_1_10005

	local var_2_0 = "island/"
	local var_2_1 = arg_2_0.item

	var_1_10005(var_2_0 .. var_7.GetIcon(var_2_1), "", arg_2_0.iconTF)
	arg_2_0:UpdateSelectedCnt(arg_2_2)

	setActive = var_5

	var_5(arg_2_0.eventTF, arg_2_3)

	setFillAmount = var_5

	var_5(arg_2_0.barTF, arg_2_4)

	return
end

function var_0_0.UpdateSelectedCnt(arg_3_0, arg_3_1)
	setText = var_1_10002

	local var_3_0 = arg_3_0.countTF
	local var_3_1 = arg_3_0.item

	var_1_10002(var_3_0, var_4.GetCount(var_3_1) - arg_3_1)

	setActive = var_1_10002

	var_1_10002(arg_3_0.selectedTF, arg_3_1 > 0)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
