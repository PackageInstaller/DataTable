class = var_0_10000

local var_0_0 = var_0_10000("IslandMapBuildPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	onButton = var_1_10003

	local var_1_0 = arg_1_0._event

	findTF = var_1_10005

	local var_1_1 = var_1_10005(arg_1_0._tf, "ad/go")

	local function var_1_2()
		local var_2_0 = arg_1_0

		var_0.onClickGo(var_2_0)

		return
	end

	SFX_CONFIRM = var_7

	var_1_10003(var_1_0, var_1_1, var_1_2, var_7)

	LoadImageSpriteAtlasAsync = var_1_10003
	IslandWorldMapConst = var_1_0

	local var_1_3 = var_1_0.build_panel_pic_path
	local var_1_4 = "build_1"

	findTF = var_1_2

	var_1_10003(var_1_3, var_1_4, var_1_2(arg_1_0._tf, "ad/buildPic"), false)

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
	setActive = var_1_10002

	var_1_10002(arg_6_0._tf, arg_6_1)

	return
end

return var_0_0
