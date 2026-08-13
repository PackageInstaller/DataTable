class = var_0_10000

local var_0_0 = var_0_10000("AgoraCalc")

function var_0_0.GetSizeCoord(arg_1_0)
	local var_1_0 = (arg_1_0.x - 1) / 2
	local var_1_1 = (arg_1_0.y - 1) / 2

	math = var_1_10003

	local var_1_2 = var_1_10003.ceil(var_1_0)

	math = var_4

	local var_1_3 = var_4.floor(var_1_0) * -1

	math = var_5

	local var_1_4 = var_5.ceil(var_1_1)

	math = var_6

	local var_1_5 = var_6.floor(var_1_1) * -1

	Vector4 = var_7

	return var_7(var_1_3, var_1_4, var_1_2, var_1_5)
end

function var_0_0.GetArea(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0 = var_0_0.GetSizeCoord(arg_2_1).x, var_3.z do
		for iter_2_1 = var_3.w, var_3.y do
			table = var_1_10012
			var_1_10012 = var_1_10012.insert

			local var_2_1 = var_2_0

			Vector2 = var_1_10014

			var_1_10012(var_2_1, var_1_10014(iter_2_0, iter_2_1) + arg_2_0)
		end
	end

	return var_2_0
end

function var_0_0.GetAreaCenterPos(arg_3_0)
	math = var_1_10001

	local var_3_0 = var_1_10001.huge

	math = var_1_10002

	local var_3_1 = -var_1_10002.huge

	math = var_1_10003

	local var_3_2 = var_1_10003.huge

	math = var_1_10004

	local var_3_3 = -var_1_10004.huge

	ipairs = var_1_10005

	for iter_3_0, iter_3_1 in var_1_10005(arg_3_0) do
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

	local var_3_4 = (var_3_1 + var_3_0) * 0.5
	local var_3_5 = (var_3_2 + var_3_3) * 0.5

	Vector3 = var_7

	return var_7(var_3_4, 0, var_3_5)
end

function var_0_0.GetCenterScreenPos()
	IslandCameraMgr = var_1_10000

	local var_4_0, var_4_1 = var_1_10000.instance._mainCamera, var_0_0.CameraPosToHitPoint

	IslandConst = var_1_10003

	return (var_4_1(var_4_0, var_1_10003.LAYER_GROUND))
end

function var_0_0.ScreenPostion2MapPosition(arg_5_0)
	IslandCameraMgr = var_1_10001

	local var_5_0, var_5_1 = var_1_10001.instance._mainCamera, var_0_0.ScreenToHitPoint
	local var_5_2 = arg_5_0

	IslandConst = var_1_10005

	if var_5_1(var_5_0, var_5_2, var_1_10005.LAYER_GROUND) then
		return var_0_0.WorldPosition2MapPosition(var_2)
	else
		return nil
	end

	return
end

function var_0_0.WorldPosition2MapPosition(arg_6_0)
	Vector2 = var_1_10001
	math = var_1_10002

	local var_6_0 = var_1_10002.floor(arg_6_0.x + 0.5)

	math = var_3

	return var_1_10001(var_6_0, var_3.floor(arg_6_0.z + 0.5))
end

function var_0_0.WorldPosition2ScreenPosition(arg_7_0)
	IslandCameraMgr = var_1_10001

	local var_7_0 = var_1_10001.instance._mainCamera

	return var_1.WorldToScreenPoint(var_7_0, arg_7_0)
end

function var_0_0.ScreenPosition2LocalPosition(arg_8_0, arg_8_1)
	pg = var_1_10002

	local var_8_0 = var_1_10002.UIMgr.GetInstance().uiCameraComp

	IslandCameraMgr = var_1_10003

	local var_8_1 = var_1_10003.instance._mainCamera
	local var_8_2 = var_3.ScreenToViewportPoint(var_8_1, arg_8_1)
	local var_8_3 = var_8_0:ViewportToScreenPoint(var_8_2)
	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.GetComponent(var_8_4, "RectTransform")

	LuaHelper = var_8_4

	return (var_8_4.ScreenToLocal(var_8_5, var_8_3, var_8_0))
end

function var_0_0.GetCenterMapPos()
	if var_0_0.GetCenterScreenPos() then
		return var_0_0.WorldPosition2MapPosition(var_0)
	else
		return nil
	end

	return
end

function var_0_0.MapPosition2WorldPosition(arg_10_0)
	Vector3 = var_1_10001

	return var_1_10001(arg_10_0.x, 0, arg_10_0.y)
end

function var_0_0.CameraPosToHitPoint(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.transform.position
	local var_11_1 = arg_11_0.transform.forward

	IslandHelper = var_1_10004

	if var_1_10004.Raycast(var_11_0, var_11_1, arg_11_1).w == 1 then
		Vector3 = var_5

		return var_5(var_4.x, var_4.y, var_4.z)
	else
		return nil
	end

	return
end

function var_0_0.ScreenToHitPoint(arg_12_0, arg_12_1, arg_12_2)
	pg = var_1_10003

	local var_12_0 = var_1_10003.UIMgr.GetInstance().uiCameraComp
	local var_12_1 = arg_12_1
	local var_12_2 = var_12_0
	local var_12_3 = var_12_0.ScreenToViewportPoint

	Vector3 = var_1_10007

	local var_12_4 = var_12_3(var_12_2, var_1_10007(var_12_1.x, var_12_1.y, 0))
	local var_12_5 = arg_12_0
	local var_12_6 = arg_12_0.ViewportPointToRay(var_12_5, var_12_4)

	IslandHelper = var_12_5

	if var_12_5.RaycastRay(var_12_6, arg_12_2).w == 1 then
		Vector3 = var_8

		return var_8(var_7.x, var_7.y, var_7.z)
	else
		return nil
	end

	return
end

function var_0_0.GetUniqueId(arg_13_0, arg_13_1)
	return arg_13_0 * 100 + arg_13_1
end

function var_0_0.RevertFormUniqueId(arg_14_0)
	math = var_1_10001

	return var_1_10001.floor(arg_14_0 * 0.01)
end

function var_0_0.DecodeLayer(arg_15_0)
	LuaHelper = var_1_10001

	local var_15_0 = var_1_10001.DecodeAgoraLayerProt(arg_15_0)
	local var_15_1, var_15_2 = var_0_0.GroundPoint2MapPoint(var_15_0[2], var_15_0[3])

	return var_0_0.GetUniqueId(var_15_0[0], 1), var_15_0[1], var_15_1, var_15_2
end

function var_0_0.EncodeLayer(arg_16_0)
	_ = var_1_10001

	return var_1_10001.map(arg_16_0, function(arg_17_0)
		local var_17_0 = var_0_0.RevertFormUniqueId(arg_17_0.id)
		local var_17_1, var_17_2 = var_0_0.MapPoint2GroundPoint(arg_17_0.x, arg_17_0.y)

		LuaHelper = var_4

		return var_4.EncodeAgoraLayerProt(var_17_0, arg_17_0.shapeId, var_17_1, var_17_2)
	end)
end

function var_0_0.GetGroundLeftBottomPoint()
	IslandConst = var_1_10000

	local var_18_0 = var_1_10000.AGORA_LEVEL_2_SIZE

	IslandConst = var_1_10001

	local var_18_1 = var_18_0[#var_1_10001.AGORA_LEVEL_2_SIZE]

	Vector2 = var_1

	local var_18_2 = var_1(var_18_1, var_18_1)

	AgoraCalc = var_2

	local var_18_3 = var_2.GetSizeCoord(var_18_2)

	Vector2 = var_3

	return var_3(var_18_3.x, var_18_3.w)
end

function var_0_0.MapPoint2GroundPoint(arg_19_0, arg_19_1)
	local var_19_0 = var_0_0.GetGroundLeftBottomPoint()

	Vector2 = var_1_10003

	return (var_1_10003(arg_19_0, arg_19_1) - var_19_0).x, var_3.y
end

function var_0_0.GroundPoint2MapPoint(arg_20_0, arg_20_1)
	local var_20_0 = var_0_0.GetGroundLeftBottomPoint()

	Vector2 = var_1_10003

	return (var_1_10003(arg_20_0, arg_20_1) + var_20_0).x, var_3.y
end

function var_0_0.EncodePlaced(arg_21_0)
	_ = var_1_10001

	return var_1_10001.map(arg_21_0, function(arg_22_0)
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
		ipairs = var_2_10002

		for iter_24_0, iter_24_1 in var_2_10002(arg_24_1) do
			if iter_24_1.id == arg_24_0.id then
				return true
			end
		end

		return false
	end

	local function var_23_1(arg_25_0, arg_25_1)
		local var_25_0

		ipairs = var_2_10003

		for iter_25_0, iter_25_1 in var_2_10003(arg_25_1) do
			if iter_25_1.id == arg_25_0.id then
				var_25_0 = iter_25_1

				break
			end
		end

		return not arg_25_0:IsSame(var_25_0)
	end

	_ = var_1_10004

	local var_23_2 = var_1_10004.select(arg_23_0, function(arg_26_0)
		return not var_23_0(arg_26_0, arg_23_1)
	end)

	_ = var_5

	local var_23_3 = var_5.select(arg_23_1, function(arg_27_0)
		return not var_23_0(arg_27_0, arg_23_0)
	end)

	_ = var_6

	return var_6.select(arg_23_0, function(arg_28_0)
		return not var_23_0(arg_28_0, var_23_2) and not var_23_0(arg_28_0, var_23_3) and var_23_1(arg_28_0, arg_23_1)
	end), var_23_3, var_23_2
end

function var_0_0.BuildScreenShootSavePath(arg_29_0)
	Application = var_1_10001

	return var_1_10001.persistentDataPath .. "/screen_scratch/island_theme" .. arg_29_0 .. ".jpg"
end

function var_0_0.GetVirtualInteractUnitId(arg_30_0, arg_30_1)
	return arg_30_0 * 10 + arg_30_1 - 1
end

return var_0_0
