local var_0_0 = class("MainEducateCharIcon", import(".MainBaseIcon"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.iconTr = arg_1_1:Find("icon")
	arg_1_0.iconImg = arg_1_0.iconTr:GetComponent(typeof(Image))

	return
end

function var_0_0.Load(arg_2_0, arg_2_1)
	setActive(arg_2_0.iconTr, true)
	GetImageSpriteFromAtlasAsync("SquareIcon/" .. arg_2_1, "", arg_2_0.iconTr, true)

	return
end

function var_0_0.Unload(arg_3_0)
	setActive(arg_3_0.iconTr, false)

	arg_3_0.iconImg.sprite = nil

	return
end

return var_0_0
