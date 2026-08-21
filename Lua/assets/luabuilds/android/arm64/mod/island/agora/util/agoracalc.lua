local var_0_0 = class("AgoraCalc")

function var_0_0.GetSizeCoord(arg_1_0)
	return Vector4(math.floor((arg_1_0.x - 1) / 2) * -1, math.ceil((arg_1_0.y - 1) / 2), math.ceil((arg_1_0.x - 1) / 2), math.floor((arg_1_0.y - 1) / 2) * -1)
end

function var_0_0.GetArea(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.GetSizeCoord(arg_2_1)

	for iter_2_0 = var_2_0.x, var_2_0.z do
		for iter_2_1 = var_2_0.w, var_2_0.y do
			table.insert({}, Vector2(iter_2_0, iter_2_1) + arg_2_0)
		end
	end

	return {}
end

function var_0_0.GetAreaCenterPos(arg_3_0)
	local var_3_0 = math.huge
	local var_3_1 = -math.huge
	local var_3_2 = math.huge
	local var_3_3 = -math.huge

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
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

function var_0_0.GetCenterScreenPos()
	return (var_0_0.CameraPosToHitPoint(IslandCameraMgr.instance._mainCamera, IslandConst.LAYER_GROUND))
end

function var_0_0.ScreenPostion2MapPosition(arg_5_0)
	local var_5_0 = var_0_0.ScreenToHitPoint(IslandCameraMgr.instance._mainCamera, arg_5_0, IslandConst.LAYER_GROUND)

	if var_5_0 then
		return var_0_0.WorldPosition2MapPosition(var_5_0)
	else
		return nil
	end

	return
end

function var_0_0.WorldPosition2MapPosition(arg_6_0)
	return Vector2(math.floor(arg_6_0.x + 0.5), math.floor(arg_6_0.z + 0.5))
end

function var_0_0.WorldPosition2ScreenPosition(arg_7_0)
	return IslandCameraMgr.instance._mainCamera:WorldToScreenPoint(arg_7_0)
end

function var_0_0.ScreenPosition2LocalPosition(arg_8_0, arg_8_1)
	local var_8_0 = pg.UIMgr.GetInstance().uiCameraComp

	return (LuaHelper.ScreenToLocal(arg_8_0:GetComponent("RectTransform"), var_8_0:ViewportToScreenPoint((IslandCameraMgr.instance._mainCamera:ScreenToViewportPoint(arg_8_1))), var_8_0))
end

function var_0_0.GetCenterMapPos()
	local var_9_0 = var_0_0.GetCenterScreenPos()

	if var_9_0 then
		return var_0_0.WorldPosition2MapPosition(var_9_0)
	else
		return nil
	end

	return
end

function var_0_0.MapPosition2WorldPosition(arg_10_0)
	return Vector3(arg_10_0.x, 0, arg_10_0.y)
end

function var_0_0.CameraPosToHitPoint(arg_11_0, arg_11_1)
	local var_11_0 = IslandHelper.Raycast(arg_11_0.transform.position, arg_11_0.transform.forward, arg_11_1)

	if var_11_0.w == 1 then
		return Vector3(var_11_0.x, var_11_0.y, var_11_0.z)
	else
		return nil
	end

	return
end

function var_0_0.ScreenToHitPoint(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = IslandHelper.RaycastRay(arg_12_0:ViewportPointToRay((pg.UIMgr.GetInstance().uiCameraComp:ScreenToViewportPoint(Vector3(arg_12_1.x, arg_12_1.y, 0)))), arg_12_2)

	if var_12_0.w == 1 then
		return Vector3(var_12_0.x, var_12_0.y, var_12_0.z)
	else
		return nil
	end

	return
end

function var_0_0.GetUniqueId(arg_13_0, arg_13_1)
	return arg_13_0 * 100 + arg_13_1
end

function var_0_0.RevertFormUniqueId(arg_14_0)
	return math.floor(arg_14_0 * 0.01)
end

function var_0_0.DecodeLayer(arg_15_0)
	local var_15_0 = LuaHelper.DecodeAgoraLayerProt(arg_15_0)
	local var_15_1, var_15_2 = var_0_0.GroundPoint2MapPoint(var_15_0[2], var_15_0[3])

	return var_0_0.GetUniqueId(var_15_0[0], 1), var_15_0[1], var_15_1, var_15_2
end

function var_0_0.EncodeLayer(arg_16_0)
	return _.map(arg_16_0, function(arg_17_0)
		local var_17_0, var_17_1 = var_0_0.MapPoint2GroundPoint(arg_17_0.x, arg_17_0.y)

		return LuaHelper.EncodeAgoraLayerProt(var_0_0.RevertFormUniqueId(arg_17_0.id), arg_17_0.shapeId, var_17_0, var_17_1)
	end)
end

function var_0_0.GetGroundLeftBottomPoint()
	local var_18_0 = AgoraCalc.GetSizeCoord((Vector2(IslandConst.AGORA_LEVEL_2_SIZE[#IslandConst.AGORA_LEVEL_2_SIZE], IslandConst.AGORA_LEVEL_2_SIZE[#IslandConst.AGORA_LEVEL_2_SIZE])))

	return Vector2(var_18_0.x, var_18_0.w)
end

function var_0_0.MapPoint2GroundPoint(arg_19_0, arg_19_1)
	local var_19_0 = Vector2(arg_19_0, arg_19_1) - var_0_0.GetGroundLeftBottomPoint()

	return var_19_0.x, var_19_0.y
end

function var_0_0.GroundPoint2MapPoint(arg_20_0, arg_20_1)
	local var_20_0 = Vector2(arg_20_0, arg_20_1) + var_0_0.GetGroundLeftBottomPoint()

	return var_20_0.x, var_20_0.y
end

function var_0_0.EncodePlaced(arg_21_0)
	return _.map(arg_21_0, function(arg_22_0)
		return {
			id = arg_22_0.id,
			x = arg_22_0.x,
			y = arg_22_0.y,
			dir = arg_22_0.dir
		}
	end)
end

function var_0_0.GetChangePlacementList(arg_23_0, arg_23_1)
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

	return _.select(arg_23_0, function(arg_28_0)
		return not var_23_0(arg_28_0, var_0) and not var_23_0(arg_28_0, var_0) and var_23_1(arg_28_0, arg_23_1)
	end), _.select(arg_23_1, function(arg_27_0)
		return not var_23_0(arg_27_0, arg_23_0)
	end), (_.select(arg_23_0, function(arg_26_0)
		return not var_23_0(arg_26_0, arg_23_1)
	end))
end

function var_0_0.BuildScreenShootSavePath(arg_29_0)
	return Application.persistentDataPath .. "/screen_scratch/island_theme" .. arg_29_0 .. ".jpg"
end

function var_0_0.GetVirtualInteractUnitId(arg_30_0, arg_30_1)
	return arg_30_0 * 10 + arg_30_1 - 1
end

return var_0_0
