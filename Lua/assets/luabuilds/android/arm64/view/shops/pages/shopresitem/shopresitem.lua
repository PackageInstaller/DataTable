local var_0_0 = class("ShopResItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0.icon = findTF(arg_1_0._tf, "icon"):GetComponent(typeof(Image))
	arg_1_0.cntText = findTF(arg_1_0._tf, "Text")

	return
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setText(arg_2_0.cntText, arg_2_3)
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = arg_2_1,
		id = arg_2_2
	}):getIcon(), "", arg_2_0.icon)
	arg_2_0:Show(true)

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	setActive(arg_3_0._go, arg_3_1)

	return
end

function var_0_0.Dispose(arg_4_0)
	Object.Destroy(arg_4_0._go)

	arg_4_0._go = nil
	arg_4_0._tf = nil

	return
end

return var_0_0
