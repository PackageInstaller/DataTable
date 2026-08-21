local var_0_0 = class("AgoraPlaceableItem", import("...IslandDispatcher"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.id = arg_1_1.id
	arg_1_0.position = Vector2.zero
	arg_1_0.rotation = Vector3.zero
	arg_1_0.size = arg_1_2 or Vector2.one
	arg_1_0.area = arg_1_0:GenArea()

	return
end

function var_0_0.GetMapType(arg_2_0)
	return IslandConst.AGORA_MAP_TYPE_COMMON
end

function var_0_0.IsSame(arg_3_0, arg_3_1)
	return arg_3_0.position == arg_3_1.position and arg_3_0.rotation == arg_3_1.rotation
end

function var_0_0.Clear(arg_4_0)
	arg_4_0.position = Vector2.zero
	arg_4_0.rotation = Vector3.zero

	return
end

function var_0_0.GetSize(arg_5_0)
	return arg_5_0.size
end

function var_0_0.GetSizeWithRotation(arg_6_0)
	if arg_6_0:IsForward() then
		return arg_6_0:GetSize()
	else
		return Vector2(arg_6_0.size.y, arg_6_0.size.x)
	end

	return
end

function var_0_0.GetRotation(arg_7_0)
	return arg_7_0.rotation
end

function var_0_0.UpdateRotation(arg_8_0, arg_8_1)
	arg_8_0.rotation = arg_8_1

	arg_8_0:DispatchEvent(ISLAND_AGORA_EVT.ITEM_DIR_UPDATE, arg_8_0.rotation)
	arg_8_0:UpdatePosition(arg_8_0.position)

	return
end

function var_0_0.UpdatePosition(arg_9_0, arg_9_1)
	arg_9_0.position = arg_9_1
	arg_9_0.area = arg_9_0:ReGenArea(true)

	arg_9_0:DispatchEvent(ISLAND_AGORA_EVT.ITEM_POSITION_UPDATE, arg_9_0.area)

	return
end

function var_0_0.GetPosition(arg_10_0)
	return arg_10_0.position
end

function var_0_0.IsSquareSize(arg_11_0)
	return arg_11_0.size.x == arg_11_0.size.y
end

function var_0_0.ReGenArea(arg_12_0, arg_12_1)
	if arg_12_0:IsSquareSize() and not arg_12_1 then
		return arg_12_0:GetArea()
	end

	return arg_12_0:GenArea()
end

function var_0_0.IsForward(arg_13_0)
	return arg_13_0.rotation.y == 0 or arg_13_0.rotation.y == 180
end

function var_0_0.Rotation(arg_14_0)
	local var_14_0 = arg_14_0.rotation.y + 90

	if arg_14_0.rotation.y + 90 > 270 then
		var_14_0 = 0
	end

	arg_14_0:UpdateRotation(Vector3(0, var_14_0, 0))

	return
end

function var_0_0.GenArea(arg_15_0)
	return arg_15_0:GenAreaByPosition(arg_15_0.position)
end

function var_0_0.GenAreaByPosition(arg_16_0, arg_16_1)
	if arg_16_0:IsForward() then
		return AgoraCalc.GetArea(arg_16_1, arg_16_0.size)
	else
		return AgoraCalc.GetArea(arg_16_1, Vector2(arg_16_0.size.y, arg_16_0.size.x))
	end

	return
end

function var_0_0.GetNeighborPoints(arg_17_0)
	local var_17_0
	local var_17_1

	if arg_17_0:IsForward() then
		var_17_0 = AgoraCalc.GetSizeCoord(arg_17_0.size)
	else
		var_17_0 = AgoraCalc.GetSizeCoord(Vector2(arg_17_0.size.y, arg_17_0.size.x))
		var_17_1 = {
			arg_17_0.position + Vector2(0, var_17_0.y + 1),
			arg_17_0.position + Vector2(0, var_17_0.w - 1)
		}
	end

	var_17_1[3] = arg_17_0.position + Vector2(var_17_0.x - 1, 0)
	var_17_1[4] = arg_17_0.position + Vector2(var_17_0.z + 1, 0)

	return var_17_1
end

function var_0_0.GetArea(arg_18_0)
	return arg_18_0.area
end

function var_0_0.GetResPath(arg_19_0)
	assert(false)

	return
end

function var_0_0.ToPlacementData(arg_20_0)
	return {
		id = arg_20_0.id,
		x = arg_20_0.position.x,
		y = arg_20_0.position.y,
		dir = arg_20_0.rotation.y / 90
	}
end

function var_0_0.FlushDataFromPlacementData(arg_21_0, arg_21_1)
	arg_21_0:UpdatePosition(arg_21_1.position)
	arg_21_0:UpdateRotation(arg_21_1.rotation)

	return
end

return var_0_0
