class = var_0_10000

local var_0_0 = "MallSiteBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MallSiteBox"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.uiCloseBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	var_0_1.super.Show(arg_5_0)

	pg = var_2

	local var_5_0 = var_2.activity_mall_story[arg_5_1]

	setText = var_3

	var_3(arg_5_0.uiNameText, var_5_0.name)

	setText = var_3

	var_3(arg_5_0.uiDescText, var_5_0.desc)

	setImageSprite = var_3

	local var_5_1 = arg_5_0.uiIconImage

	LoadSprite = var_5

	var_3(var_5_1, var_5("ui/mallstorylineui_atlas", var_5_0.icon .. "_l"), true)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1
