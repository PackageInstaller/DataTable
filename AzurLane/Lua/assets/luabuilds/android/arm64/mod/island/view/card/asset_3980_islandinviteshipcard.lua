class = var_0_10000

local var_0_0 = var_0_10000("IslandInviteShipCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.selectedTF = var_2.Find(var_1_0, "frame/sel")

	local var_1_1 = arg_1_0._tf

	arg_1_0.selectedDotTF = var_2.Find(var_1_1, "frame/sel_dot")

	local var_1_2 = arg_1_0._tf

	arg_1_0.frameTF = var_2.Find(var_1_2, "frame")

	local var_1_3 = arg_1_0.frameTF

	arg_1_0.iconTF = var_2.Find(var_1_3, "main")

	local var_1_4 = arg_1_0.frameTF

	arg_1_0.textTF = var_2.Find(var_1_4, "main/Text")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.item = arg_2_1
	setText = var_1_10003

	var_1_10003(arg_2_0.textTF, "")

	GetImageSpriteFromAtlasAsync = var_1_10003
	string = var_5

	var_1_10003(var_5.format("island/islandInvitation/invite_%s", arg_2_0.item.shipId), "", arg_2_0.iconTF)
	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1 == arg_3_0.item.shipId

	SetCompomentEnabled = var_1_10003

	var_1_10003(arg_3_0.frameTF, "EventTriggerListener", var_3_0)

	setActive = var_1_10003

	var_1_10003(arg_3_0.selectedTF, var_3_0)

	setActive = var_1_10003

	var_1_10003(arg_3_0.selectedDotTF, var_3_0)

	local var_3_1 = var_3_0 and 1 or 0.8

	setLocalScale = var_1_10004

	var_1_10004(arg_3_0.frameTF, {
		x = var_3_1,
		y = var_3_1,
		z = var_3_1
	})

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
