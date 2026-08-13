class = var_0_10000

local var_0_0 = "IslandMechaModelPreviewPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.ship.IslandBaseShipDisplayPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandMechaModePreviewUI"
end

function var_0_1.NeedCache(arg_2_0)
	return false
end

function var_0_1.GetActiveCamName(arg_3_0)
	IslandConst = var_1_10001

	return var_1_10001.MODEL_PREVIEW_CAMERA_NAME
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.backBtn = var_1.Find(var_4_0, "adapt/left_panel/back")
	setText = var_1

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "adapt/left_panel/title/Text")

	i18n = var_4

	var_1(var_4_2, var_4("island_dressup_titile"))

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.backBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	return
end

function var_0_1.Show(arg_7_0)
	var_0_1.super.Show(arg_7_0)

	pg = var_1

	local var_7_0 = var_1.island_unit_character[0]

	arg_7_0:LoadCharacter({
		model = var_7_0.model,
		animator = var_7_0.animator
	}, false)

	return
end

function var_0_1.GetSmoothRotateObject(arg_8_0)
	local var_8_0 = arg_8_0._tf

	return var_1.Find(var_8_0, "adapt/char")
end

function var_0_1.Hide(arg_9_0)
	var_0_1.super.Hide(arg_9_0)

	if arg_9_0.timer then
		local var_9_0 = arg_9_0.timer

		var_1.Stop(var_9_0)
	end

	return
end

function var_0_1.SetObjInitRotaion(arg_10_0, arg_10_1)
	local var_10_0

	var_10_0, GetOrAddComponent = arg_10_0:GetSmoothRotateObject(), var_1_10003
	typeof = var_1_10006
	SmoothRotateObject = var_1_10008

	local var_10_1 = var_1_10003(var_10_0, var_1_10006(var_1_10008))

	var_10_1.rotationSpeed = 5
	ReflectionHelp = var_4

	local var_10_2 = var_4.RefSetProperty

	typeof = var_6
	SmoothRotateObject = var_1_10008

	var_10_2(var_6(var_1_10008), "targetRotation", var_10_1, arg_10_1)

	if arg_10_0.timer then
		local var_10_3 = arg_10_0.timer

		var_4.Stop(var_10_3)
	end

	Timer = var_4
	arg_10_0.timer = var_4.New(function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.island_set.character_detail_camera_speed.key_value_int

		var_10_1.rotationSpeed = var_11_0

		return
	end, 0.5, 1)

	local var_10_4 = arg_10_0.timer

	var_4.Start(var_10_4)

	return
end

function var_0_1.IsPreviewScene(arg_12_0)
	return true
end

function var_0_1.GetDressByType(arg_13_0)
	local var_13_0 = {}

	IslandShipDressHelperNew = var_1_10002
	var_13_0[var_1_10002.DressType.Body] = 1060013

	return var_13_0
end

return var_0_1
