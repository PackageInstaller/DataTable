class = var_0_10000

local var_0_0 = var_0_10000("ShopResItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	Object = var_1_10003
	arg_1_0._go = var_1_10003.Instantiate(arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_0._go.transform
	findTF = var_3

	local var_1_0 = var_3(arg_1_0._tf, "icon")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0.icon = var_1_1(var_1_0, var_6(var_1_10008))
	findTF = var_3
	arg_1_0.cntText = var_3(arg_1_0._tf, "Text")

	return
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setText = var_1_10004

	var_1_10004(arg_2_0.cntText, arg_2_3)

	Drop = var_1_10004

	local var_2_0 = var_1_10004.New({
		type = arg_2_1,
		id = arg_2_2
	})

	GetImageSpriteFromAtlasAsync = var_1_10005

	var_1_10005(var_2_0:getIcon(), "", arg_2_0.icon)
	arg_2_0:Show(true)

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0._go, arg_3_1)

	return
end

function var_0_0.Dispose(arg_4_0)
	Object = var_1_10001

	var_1_10001.Destroy(arg_4_0._go)

	arg_4_0._go = nil
	arg_4_0._tf = nil

	return
end

return var_0_0
