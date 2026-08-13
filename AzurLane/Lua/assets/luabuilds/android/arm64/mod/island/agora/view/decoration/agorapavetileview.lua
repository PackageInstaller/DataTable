class = var_0_10000

local var_0_0 = "AgoraPaveTileView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandASynLoadSubView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandAgoraPaveTileUI"
end

function var_0_1.FirstFlush(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "name")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "icon")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.icon = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf

	arg_2_0.exitBtn = var_1.Find(var_2_6, "exit")

	local var_2_7 = arg_2_0._tf

	arg_2_0.rotation = var_1.Find(var_2_7, "revert")

	local var_2_8 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_8, "confirm")

	local var_2_9 = arg_2_0._tf

	arg_2_0.mode = var_1.Find(var_2_9, "mode")
	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "desc")

	i18n = var_4

	var_1(var_2_11, var_4("island_agora_pave_tip"))
	arg_2_0:RegisterEvent()

	return
end

function var_0_1.RegisterEvent(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.exitBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Op(var_4_0, "RevertPaveLayer")

		local var_4_1 = arg_3_0
		local var_4_2 = var_0.GetView(var_4_1)

		var_0.ExitPaveTileMode(var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onToggle = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.mode, function(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.Op(var_5_0, "ChangePaveMode", arg_5_0)

		return
	end, true)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.rotation

	local function var_3_5()
		local var_6_0 = arg_3_0.shapeId

		IslandConst = var_2_10001

		if var_6_0 == var_2_10001.AGORA_TILE_SHAPE_ALL then
			return
		end

		arg_3_0.shapeId = arg_3_0.shapeId + 1

		if arg_3_0.shapeId > arg_3_0.maxShapeId then
			arg_3_0.shapeId = arg_3_0.minShapeId
		end

		local var_6_1 = arg_3_0

		var_0.Op(var_6_1, "ChangeSelectedShape", arg_3_0.shapeId)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_3_3, var_3_4, var_3_5, var_6)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.GetView(var_7_0)

		var_0.ExitPaveTileMode(var_7_1)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_3_6, var_3_7, var_3_8, var_6)

	return
end

function var_0_1.Flush(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.shapeId = arg_8_2
	arg_8_0.minShapeId = arg_8_2
	arg_8_0.maxShapeId = arg_8_0.shapeId + 3

	local var_8_0 = arg_8_0.nameTxt

	var_8_0.text = arg_8_1:GetName()
	LoadSpriteAsync = var_8_0

	var_8_0("island/IslandFurnitureIcon/" .. arg_8_1:GetIcon(), function(arg_9_0)
		arg_8_0.icon.sprite = arg_9_0

		return
	end)

	triggerToggle = var_8_0

	var_8_0(arg_8_0.mode, false)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	return
end

return var_0_1
