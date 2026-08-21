local var_0_0 = class("WSAtlasRight", import("...BaseEntity"))

var_0_0.Fields = {
	btnSettings = "userdata",
	btnSwitch = "userdata",
	rtDisplayIcon = "userdata",
	transform = "userdata",
	rtNameBg = "userdata",
	rtDisplayPanel = "userdata",
	isDisplay = "boolean",
	world = "table",
	rtMapInfo = "userdata",
	wsWorldInfo = "table",
	rtBg = "userdata",
	rtWorldInfo = "userdata"
}

function var_0_0.Setup(arg_1_0)
	pg.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.wsWorldInfo:Dispose()
	pg.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rtBg = arg_3_0.transform:Find("bg")
	arg_3_0.rtNameBg = arg_3_0.transform:Find("name_bg")
	arg_3_0.rtDisplayIcon = arg_3_0.transform:Find("line/display_icon")
	arg_3_0.rtDisplayPanel = arg_3_0.transform:Find("line/display_panel")
	arg_3_0.rtWorldInfo = arg_3_0.rtDisplayPanel:Find("world_info")
	arg_3_0.btnSettings = arg_3_0.rtDisplayPanel:Find("btns/settings_btn")
	arg_3_0.btnSwitch = arg_3_0.rtDisplayPanel:Find("btns/switch_btn")

	setText(arg_3_0.rtWorldInfo:Find("power/bg/Word"), i18n("world_total_power"))
	setText(arg_3_0.rtWorldInfo:Find("explore/mileage/Text"), i18n("world_mileage"))
	setText(arg_3_0.rtWorldInfo:Find("explore/pressing/Text"), i18n("world_pressing"))

	arg_3_0.wsWorldInfo = WSWorldInfo.New()
	arg_3_0.wsWorldInfo.transform = arg_3_0.rtWorldInfo

	arg_3_0.wsWorldInfo:Setup()
	setActive(arg_3_0.rtWorldInfo, nowWorld():IsSystemOpen(WorldConst.SystemWorldInfo))
	setText(arg_3_0.rtDisplayIcon:Find("name"), i18n("world_map_title_tips"))
	onButton(arg_3_0, arg_3_0.rtDisplayIcon, function()
		arg_3_0.isDisplay = not arg_3_0.isDisplay

		arg_3_0:Collapse()

		return
	end, SFX_PANEL)

	arg_3_0.isDisplay = true

	arg_3_0:Collapse()

	return
end

function var_0_0.Collapse(arg_5_0)
	local var_5_0 = arg_5_0.rtDisplayIcon:Find("icon")

	if arg_5_0.isDisplay then
		var_5_0.localScale = Vector3.one or Vector3(-1, 1, 1)

		setActive(arg_5_0.rtDisplayPanel, arg_5_0.isDisplay)
		setActive(arg_5_0.rtBg, arg_5_0.isDisplay)
		setActive(arg_5_0.rtNameBg, not arg_5_0.isDisplay)

		return
	end
end

function var_0_0.SetOverSize(arg_6_0, arg_6_1)
	arg_6_0.rtBg.offsetMax = Vector2(-arg_6_1, arg_6_0.rtBg.offsetMax.y)
	arg_6_0.rtNameBg.offsetMax = Vector2(-arg_6_1, arg_6_0.rtNameBg.offsetMax.y)

	return
end

return var_0_0
