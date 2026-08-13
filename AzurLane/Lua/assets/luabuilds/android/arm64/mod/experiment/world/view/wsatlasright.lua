class = var_0_10000

local var_0_0 = "WSAtlasRight"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
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

function var_0_1.Setup(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	local var_2_0 = arg_2_0.wsWorldInfo

	var_1.Dispose(var_2_0)

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.transform

	arg_3_0.rtBg = var_1.Find(var_3_0, "bg")
	arg_3_0.rtNameBg = var_1:Find("name_bg")
	arg_3_0.rtDisplayIcon = var_1:Find("line/display_icon")
	arg_3_0.rtDisplayPanel = var_1:Find("line/display_panel")

	local var_3_1 = arg_3_0.rtDisplayPanel

	arg_3_0.rtWorldInfo = var_2.Find(var_3_1, "world_info")

	local var_3_2 = arg_3_0.rtDisplayPanel

	arg_3_0.btnSettings = var_2.Find(var_3_2, "btns/settings_btn")

	local var_3_3 = arg_3_0.rtDisplayPanel

	arg_3_0.btnSwitch = var_2.Find(var_3_3, "btns/switch_btn")
	setText = var_2

	local var_3_4 = arg_3_0.rtWorldInfo
	local var_3_5 = var_4.Find(var_3_4, "power/bg/Word")

	i18n = var_5

	var_2(var_3_5, var_5("world_total_power"))

	setText = var_2

	local var_3_6 = arg_3_0.rtWorldInfo
	local var_3_7 = var_4.Find(var_3_6, "explore/mileage/Text")

	i18n = var_5

	var_2(var_3_7, var_5("world_mileage"))

	setText = var_2

	local var_3_8 = arg_3_0.rtWorldInfo
	local var_3_9 = var_4.Find(var_3_8, "explore/pressing/Text")

	i18n = var_5

	var_2(var_3_9, var_5("world_pressing"))

	WSWorldInfo = var_2
	arg_3_0.wsWorldInfo = var_2.New()
	arg_3_0.wsWorldInfo.transform = arg_3_0.rtWorldInfo

	local var_3_10 = arg_3_0.wsWorldInfo

	var_2.Setup(var_3_10)

	setActive = var_2

	local var_3_11 = arg_3_0.rtWorldInfo

	nowWorld = var_5

	local var_3_12 = var_5()
	local var_3_13 = var_5.IsSystemOpen

	WorldConst = var_1_10008

	var_2(var_3_11, var_3_13(var_3_12, var_1_10008.SystemWorldInfo))

	setText = var_2

	local var_3_14 = arg_3_0.rtDisplayIcon
	local var_3_15 = var_4.Find(var_3_14, "name")

	i18n = var_5

	var_2(var_3_15, var_5("world_map_title_tips"))

	onButton = var_2

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.rtDisplayIcon

	local function var_3_18()
		arg_3_0.isDisplay = not arg_3_0.isDisplay

		local var_4_0 = arg_3_0

		var_0.Collapse(var_4_0)

		return
	end

	SFX_PANEL = var_7

	var_2(var_3_16, var_3_17, var_3_18, var_7)

	arg_3_0.isDisplay = true

	arg_3_0:Collapse()

	return
end

function var_0_1.Collapse(arg_5_0)
	local var_5_0 = arg_5_0.rtDisplayIcon
	local var_5_1 = var_1.Find(var_5_0, "icon")

	if arg_5_0.isDisplay then
		Vector3 = var_5_2

		local var_5_2

		if not var_5_2.one then
			Vector3 = var_5_2
			var_5_2 = var_5_2(-1, 1, 1)
		end

		var_5_1.localScale = var_5_2
		setActive = var_5_1

		var_5_1(arg_5_0.rtDisplayPanel, arg_5_0.isDisplay)

		setActive = var_5_1

		var_5_1(arg_5_0.rtBg, arg_5_0.isDisplay)

		setActive = var_5_1

		var_5_1(arg_5_0.rtNameBg, not arg_5_0.isDisplay)

		return
	end
end

function var_0_1.SetOverSize(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.rtBg

	Vector2 = var_1_10003
	var_6_0.offsetMax = var_1_10003(-arg_6_1, arg_6_0.rtBg.offsetMax.y)

	local var_6_1 = arg_6_0.rtNameBg

	Vector2 = var_3
	var_6_1.offsetMax = var_3(-arg_6_1, arg_6_0.rtNameBg.offsetMax.y)

	return
end

return var_0_1
