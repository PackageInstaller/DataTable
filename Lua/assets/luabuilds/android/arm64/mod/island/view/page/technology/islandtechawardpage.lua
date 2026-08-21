local var_0_0 = class("IslandTechAwardPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandTechAwardUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.nameTF = arg_2_0._tf:Find("window/name_bg/Text")
	arg_2_0.iconTF = arg_2_0._tf:Find("window/icon_bg/Image")
	arg_2_0.tipTF = arg_2_0._tf:Find("window/tip")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_5_0, arg_5_1)
	LoadImageSpriteAsync("island/IslandTechnology/" .. pg.island_technology_template[arg_5_1].tech_icon, arg_5_0.iconTF, true)
	setText(arg_5_0.nameTF, pg.island_technology_template[arg_5_1].tech_name)
	setText(arg_5_0.tipTF, pg.island_technology_template[arg_5_1].complete_tips)
	arg_5_0:BlurPanel()

	return
end

function var_0_0.OnHide(arg_6_0)
	arg_6_0:UnBlurPanel()

	return
end

function var_0_0.OnDisable(arg_7_0)
	arg_7_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_8_0)
	arg_8_0:OnHide()

	return
end

return var_0_0
