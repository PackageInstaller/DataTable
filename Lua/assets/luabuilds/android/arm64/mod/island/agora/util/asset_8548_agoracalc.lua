local AgoraCalc = class("AgoraCalc")

function AgoraCalc:GetSizeCoord()
	return Vector4(math.floor((self.x - 1) / 2) * -1, math.ceil((self.y - 1) / 2), math.ceil((self.x - 1) / 2), math.floor((self.y - 1) / 2) * -1)
end

function AgoraCalc:GetArea(arg_2_1)
	local var_2_0 = {}
	local var_2_1 = AgoraCalc.GetSizeCoord(arg_2_1)

	for iter_2_0 = var_2_1.x, var_2_1.z do
		for iter_2_1 = var_2_1.w, var_2_1.y do
			table.insert(var_2_0, Vector2(iter_2_0, iter_2_1) + self)
		end
	end

	return var_2_0
end

function AgoraCalc:GetAreaCenterPos()
	local var_3_0 = math.huge
	local var_3_1 = -math.huge
	local var_3_2 = math.huge
	local var_3_3 = -math.huge

	for iter_3_0, iter_3_1 in ipairs(self) do
		if var_3_1 < iter_3_1.x then
			var_3_1 = iter_3_1.x
		end

		if var_3_0 > iter_3_1.x then
			var_3_0 = iter_3_1.x
		end

		if var_3_3 < iter_3_1.y then
			var_3_3 = iter_3_1.y
		end

		if var_3_2 > iter_3_1.y then
			var_3_2 = iter_3_1.y
		end
	end

	return Vector3((var_3_1 + var_3_0) * 0.5, 0, (var_3_2 + var_3_3) * 0.5)
end

function AgoraCalc.GetCenterScreenPos()
	return (AgoraCalc.CameraPosToHitPoint(IslandCameraMgr.instance._mainCamera, IslandConst.LAYER_GROUND))
end

function AgoraCalc:ScreenPostion2MapPosition()
	local var_5_0 = AgoraCalc.ScreenToHitPoint(IslandCameraMgr.instance._mainCamera, self, IslandConst.LAYER_GROUND)

	if var_5_0 then
		return AgoraCalc.WorldPosition2MapPosition(var_5_0)
	else
		return nil
	end

	return
end

function AgoraCalc:WorldPosition2MapPosition()
	return Vector2(math.floor(self.x + 0.5), math.floor(self.z + 0.5))
end

function AgoraCalc:WorldPosition2ScreenPosition()
	return IslandCameraMgr.instance._mainCamera:WorldToScreenPoint(self)
end

function AgoraCalc:ScreenPosition2LocalPosition(arg_8_1)
	local var_8_0 = pg.UIMgr.GetInstance().uiCameraComp

	return (LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), var_8_0:ViewportToScreenPoint((IslandCameraMgr.instance._mainCamera:ScreenToViewportPoint(arg_8_1))), var_8_0))
end

function AgoraCalc.GetCenterMapPos()
	local var_9_0 = AgoraCalc.GetCenterScreenPos()

	if var_9_0 then
		return AgoraCalc.WorldPosition2MapPosition(var_9_0)
	else
		return nil
	end

	return
end

function AgoraCalc:MapPosition2WorldPosition()
	return Vector3(self.x, 0, self.y)
end

function AgoraCalc:CameraPosToHitPoint(arg_11_1)
	local var_11_0 = IslandHelper.Raycast(self.transform.position, self.transform.forward, arg_11_1)

	if var_11_0.w == 1 then
		return Vector3(var_11_0.x, var_11_0.y, var_11_0.z)
	else
		return nil
	end

	return
end

function AgoraCalc:ScreenToHitPoint(arg_12_1, arg_12_2)
	local var_12_0 = IslandHelper.RaycastRay(self:ViewportPointToRay((pg.UIMgr.GetInstance().uiCameraComp:ScreenToViewportPoint(Vector3(arg_12_1.x, arg_12_1.y, 0)))), arg_12_2)

	if var_12_0.w == 1 then
		return Vector3(var_12_0.x, var_12_0.y, var_12_0.z)
	else
		return nil
	end

	return
end

function AgoraCalc:GetUniqueId(arg_13_1)
	return self * 100 + arg_13_1
end

function AgoraCalc:RevertFormUniqueId()
	return math.floor(self * 0.01)
end

function AgoraCalc:DecodeLayer()
	local var_15_0 = LuaHelper.DecodeAgoraLayerProt(self)
	local var_15_1, var_15_2 = AgoraCalc.GroundPoint2MapPoint(var_15_0[2], var_15_0[3])

	return AgoraCalc.GetUniqueId(var_15_0[0], 1), var_15_0[1], var_15_1, var_15_2
end

function AgoraCalc:EncodeLayer()
	return _.map(self, function(arg_17_0)
		local var_17_0, var_17_1 = AgoraCalc.MapPoint2GroundPoint(arg_17_0.x, arg_17_0.y)

		return LuaHelper.EncodeAgoraLayerProt(AgoraCalc.RevertFormUniqueId(arg_17_0.id), arg_17_0.shapeId, var_17_0, var_17_1)
	end)
end

function AgoraCalc.GetGroundLeftBottomPoint()
	local var_18_0 = AgoraCalc.GetSizeCoord((Vector2(IslandConst.AGORA_LEVEL_2_SIZE[#IslandConst.AGORA_LEVEL_2_SIZE], IslandConst.AGORA_LEVEL_2_SIZE[#IslandConst.AGORA_LEVEL_2_SIZE])))

	return Vector2(var_18_0.x, var_18_0.w)
end

function AgoraCalc:MapPoint2GroundPoint(arg_19_1)
	local var_19_0 = Vector2(self, arg_19_1) - AgoraCalc.GetGroundLeftBottomPoint()

	return var_19_0.x, var_19_0.y
end

function AgoraCalc:GroundPoint2MapPoint(arg_20_1)
	local var_20_0 = Vector2(self, arg_20_1) + AgoraCalc.GetGroundLeftBottomPoint()

	return var_20_0.x, var_20_0.y
end

function AgoraCalc:EncodePlaced()
	return _.map(self, function(arg_22_0)
		return {
			id = arg_22_0.id,
			x = arg_22_0.x,
			y = arg_22_0.y,
			dir = arg_22_0.dir
		}
	end)
end

function AgoraCalc:GetChangePlacementList(arg_23_1)
	local function var_23_0(arg_24_0, arg_24_1)
		for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
			if iter_24_1.id == arg_24_0.id then
				return true
			end
		end

		return false
	end

	local function var_23_1(arg_25_0, arg_25_1)
		local var_25_0

		for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
			if iter_25_1.id == arg_25_0.id then
				var_25_0 = iter_25_1

				break
			end
		end

		return not arg_25_0:IsSame(var_25_0)
	end

	local var_23_2 = _.select(self, function(arg_26_0)
		return not var_23_0(arg_26_0, arg_23_1)
	end)
	local var_23_3 = _.select(arg_23_1, function(arg_27_0)
		return not var_23_0(arg_27_0, self)
	end)

	return _.select(self, function(arg_28_0)
		return not var_23_0(arg_28_0, var_23_2) and not var_23_0(arg_28_0, var_23_3) and var_23_1(arg_28_0, arg_23_1)
	end), var_23_3, var_23_2
end

function AgoraCalc:BuildScreenShootSavePath()
	return Application.persistentDataPath .. "/screen_scratch/island_theme" .. self .. ".jpg"
end

function AgoraCalc:GetVirtualInteractUnitId(arg_30_1)
	return self * 10 + arg_30_1 - 1
end

return AgoraCalc
