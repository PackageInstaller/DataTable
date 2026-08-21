local var_0_0 = class("AgoraPreviewController", import("..AgoraController"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.furnitureId = arg_1_3
	arg_1_0.lastExitPoint = arg_1_4

	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_0.GoBackLastExitPoint(arg_2_0)
	arg_2_0:ExitEditMode()
	arg_2_0:NotifiyIsland(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, arg_2_0.lastExitPoint)

	return
end

function var_0_0.EnterEditMode(arg_3_0)
	arg_3_0.isEidting = true

	arg_3_0:NotifiyAgora(ISLAND_AGORA_EVT.ENTER_EDIT)

	return
end

function var_0_0.ExitEditMode(arg_4_0)
	arg_4_0.isEidting = false

	arg_4_0:NotifiyAgora(ISLAND_AGORA_EVT.EXIT_EDIT)

	return
end

function var_0_0.SetUp(arg_5_0)
	var_0_0.super.super.SetUp(arg_5_0)
	arg_5_0:NotifiyAgora(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, arg_5_0.agora:GetSize())

	for iter_5_0, iter_5_1 in pairs(arg_5_0.agora:GetPlaceableList()) do
		arg_5_0:PlaceItem(iter_5_1.id, Vector2(0, 0), Vector3(0, 0, 0))
	end

	arg_5_0:NotifiyAgora(ISLAND_AGORA_EVT.END_LOAD_ITEMS)

	return
end

function var_0_0.UnPlaceItem(arg_6_0)
	pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_function_unuse"))

	return
end

function var_0_0.CreateAgora(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetAgoraAgency()

	for iter_7_0, iter_7_1 in ipairs({
		{
			count = 1,
			id = arg_7_0.furnitureId
		}
	}) do
		for iter_7_2 = 1, iter_7_1.count do
			local var_7_1 = AgoraFurniture.New({
				id = AgoraCalc.GetUniqueId(iter_7_1.id, iter_7_2),
				configId = iter_7_1.id
			})

			;({})[var_7_1.id] = var_7_1
		end
	end

	local var_7_2 = IslandConst.AGORA_LEVEL_2_SIZE[math.clamp(var_7_0:GetLevel(), 1, #IslandConst.AGORA_LEVEL_2_SIZE)]

	return Agora.New({
		size = Vector2(var_7_2, var_7_2),
		placeableList = {},
		capacity = var_7_0:GetCapacity(),
		themes = {},
		systemThemes = {}
	}), {
		placedlist = {},
		placedFloor = {},
		placedTile = {}
	}
end

return var_0_0
