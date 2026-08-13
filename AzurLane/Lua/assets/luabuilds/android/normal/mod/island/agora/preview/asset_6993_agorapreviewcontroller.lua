class = var_0_10000

local var_0_0 = "AgoraPreviewController"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..AgoraController"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.furnitureId = arg_1_3
	arg_1_0.lastExitPoint = arg_1_4

	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.GoBackLastExitPoint(arg_2_0)
	arg_2_0:ExitEditMode()

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10003

	var_2_1(var_2_0, var_1_10003.SWITCH_MAP_BY_POINT, arg_2_0.lastExitPoint)

	return
end

function var_0_1.EnterEditMode(arg_3_0)
	arg_3_0.isEidting = true

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10003

	var_3_1(var_3_0, var_1_10003.ENTER_EDIT)

	return
end

function var_0_1.ExitEditMode(arg_4_0)
	arg_4_0.isEidting = false

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10003

	var_4_1(var_4_0, var_1_10003.EXIT_EDIT)

	return
end

function var_0_1.SetUp(arg_5_0)
	var_0_1.super.super.SetUp(arg_5_0)

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10003

	local var_5_2 = var_1_10003.MAP_SIZE_UPDATE
	local var_5_3 = arg_5_0.agora

	var_5_1(var_5_0, var_5_2, var_4.GetSize(var_5_3))

	pairs = var_5_1

	local var_5_4 = arg_5_0.agora

	for iter_5_0, iter_5_1 in var_5_1(var_2.GetPlaceableList(var_5_4)) do
		local var_5_5 = arg_5_0
		local var_5_6 = arg_5_0.PlaceItem
		local var_5_7 = iter_5_1.id

		Vector2 = var_1_10009
		var_1_10009 = var_1_10009(0, 0)
		Vector3 = var_10

		var_5_6(var_5_5, var_5_7, var_1_10009, var_10(0, 0, 0))
	end

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_3

	var_5_9(var_5_8, var_3.END_LOAD_ITEMS)

	return
end

function var_0_1.UnPlaceItem(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TipsMgr.GetInstance()
	local var_6_1 = var_1.ShowTips

	i18n = var_1_10003

	var_6_1(var_6_0, var_1_10003("island_agora_function_unuse"))

	return
end

function var_0_1.CreateAgora(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetAgoraAgency()
	local var_7_1 = arg_7_0.furnitureId
	local var_7_2 = {}

	ipairs = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10005({
		{
			count = 1,
			id = var_7_1
		}
	}) do
		for iter_7_2 = 1, iter_7_1.count do
			AgoraCalc = var_1_10014
			var_1_10014 = var_1_10014.GetUniqueId(iter_7_1.id, iter_7_2)
			AgoraFurniture = var_15
			var_7_2[var_15.New({
				id = var_1_10014,
				configId = iter_7_1.id
			}).id] = var_15
		end
	end

	local var_7_3 = var_7_0
	local var_7_4 = var_7_0.GetLevel(var_7_3)

	math = var_7_3

	local var_7_5 = var_7_3.clamp
	local var_7_6 = var_7_4
	local var_7_7 = 1

	IslandConst = iter_7_1

	local var_7_8 = var_7_5(var_7_6, var_7_7, #iter_7_1.AGORA_LEVEL_2_SIZE)

	IslandConst = var_7_6

	local var_7_9 = var_7_6.AGORA_LEVEL_2_SIZE[var_7_8]
	local var_7_10 = var_7_0
	local var_7_11 = var_7_0.GetCapacity(var_7_10)

	Agora = var_7_10

	local var_7_12 = var_7_10.New
	local var_7_13 = {}

	Vector2 = var_1_10011
	var_7_13.size = var_1_10011(var_7_9, var_7_9)
	var_7_13.placeableList = var_7_2
	var_7_13.capacity = var_7_11
	var_7_13.themes = {}
	var_7_13.systemThemes = {}

	return var_7_12(var_7_13), {
		placedlist = {},
		placedFloor = {},
		placedTile = {}
	}
end

return var_0_1
