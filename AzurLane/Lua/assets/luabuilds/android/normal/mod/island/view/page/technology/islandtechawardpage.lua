class = var_0_10000

local var_0_0 = "IslandTechAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTechAwardUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.nameTF = var_1.Find(var_2_0, "window/name_bg/Text")

	local var_2_1 = arg_2_0._tf

	arg_2_0.iconTF = var_1.Find(var_2_1, "window/icon_bg/Image")

	local var_2_2 = arg_2_0._tf

	arg_2_0.tipTF = var_1.Find(var_2_2, "window/tip")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnShow(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.island_technology_template[arg_5_1]

	LoadImageSpriteAsync = var_1_10003

	var_1_10003("island/IslandTechnology/" .. var_5_0.tech_icon, arg_5_0.iconTF, true)

	setText = var_1_10003

	var_1_10003(arg_5_0.nameTF, var_5_0.tech_name)

	setText = var_1_10003

	var_1_10003(arg_5_0.tipTF, var_5_0.complete_tips)
	arg_5_0:BlurPanel()

	return
end

function var_0_1.OnHide(arg_6_0)
	arg_6_0:UnBlurPanel()

	return
end

function var_0_1.OnDisable(arg_7_0)
	arg_7_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_8_0)
	arg_8_0:OnHide()

	return
end

return var_0_1
