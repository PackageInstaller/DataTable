local var_0_0 = class("IslandMapBuildPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2

	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/go"), function()
		arg_1_0:onClickGo()

		return
	end, SFX_CONFIRM)
	LoadImageSpriteAtlasAsync(IslandWorldMapConst.build_panel_pic_path, "build_1", findTF(arg_1_0._tf, "ad/buildPic"), false)

	return
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.buildType = arg_3_1

	return
end

function var_0_0.onClickGo(arg_4_0)
	return
end

function var_0_0.dispose(arg_5_0)
	return
end

function var_0_0.setActive(arg_6_0, arg_6_1)
	setActive(arg_6_0._tf, arg_6_1)

	return
end

return var_0_0
