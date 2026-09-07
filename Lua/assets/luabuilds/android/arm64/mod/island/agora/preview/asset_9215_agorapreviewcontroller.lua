local AgoraPreviewController = class("AgoraPreviewController", import("..AgoraController"))

function AgoraPreviewController:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.furnitureId = arg_1_3
	self.lastExitPoint = arg_1_4

	AgoraPreviewController.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function AgoraPreviewController:GoBackLastExitPoint()
	self:ExitEditMode()
	self:NotifiyIsland(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, self.lastExitPoint)

	return
end

function AgoraPreviewController:EnterEditMode()
	self.isEidting = true

	self:NotifiyAgora(ISLAND_AGORA_EVT.ENTER_EDIT)

	return
end

function AgoraPreviewController:ExitEditMode()
	self.isEidting = false

	self:NotifiyAgora(ISLAND_AGORA_EVT.EXIT_EDIT)

	return
end

function AgoraPreviewController:SetUp()
	AgoraPreviewController.super.super.SetUp(self)
	self:NotifiyAgora(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, self.agora:GetSize())

	for iter_5_0, iter_5_1 in pairs(self.agora:GetPlaceableList()) do
		self:PlaceItem(iter_5_1.id, Vector2(0, 0), Vector3(0, 0, 0))
	end

	self:NotifiyAgora(ISLAND_AGORA_EVT.END_LOAD_ITEMS)

	return
end

function AgoraPreviewController:UnPlaceItem()
	pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_function_unuse"))

	return
end

function AgoraPreviewController:CreateAgora(arg_7_1)
	local var_7_0 = arg_7_1:GetAgoraAgency()
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs({
		{
			count = 1,
			id = self.furnitureId
		}
	}) do
		for iter_7_2 = 1, iter_7_1.count do
			local var_7_2 = AgoraFurniture.New({
				id = AgoraCalc.GetUniqueId(iter_7_1.id, iter_7_2),
				configId = iter_7_1.id
			})

			var_7_1[var_7_2.id] = var_7_2
		end
	end

	local var_7_3 = IslandConst.AGORA_LEVEL_2_SIZE[math.clamp(var_7_0:GetLevel(), 1, #IslandConst.AGORA_LEVEL_2_SIZE)]

	return Agora.New({
		size = Vector2(var_7_3, var_7_3),
		placeableList = var_7_1,
		capacity = var_7_0:GetCapacity(),
		themes = {},
		systemThemes = {}
	}), {
		placedlist = {},
		placedFloor = {},
		placedTile = {}
	}
end

return AgoraPreviewController
