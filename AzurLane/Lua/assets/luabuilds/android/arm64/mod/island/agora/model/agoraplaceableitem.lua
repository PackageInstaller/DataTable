class = var_0_10000

local var_0_0 = "AgoraPlaceableItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...IslandDispatcher"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.id = arg_1_1.id
	Vector2 = var_3
	arg_1_0.position = var_3.zero
	Vector3 = var_3
	arg_1_0.rotation = var_3.zero

	local var_1_0

	if not arg_1_2 then
		::label_1_0::

		Vector2 = var_1_0
		var_1_0 = var_1_0.one
	end

	arg_1_0.size = var_1_0
	arg_1_0.area = arg_1_0:GenArea()

	return
end

function var_0_1.GetMapType(arg_2_0)
	IslandConst = var_1_10001

	return var_1_10001.AGORA_MAP_TYPE_COMMON
end

function var_0_1.IsSame(arg_3_0, arg_3_1)
	return arg_3_0.position == arg_3_1.position and arg_3_0.rotation == arg_3_1.rotation
end

function var_0_1.Clear(arg_4_0)
	Vector2 = var_1_10001
	arg_4_0.position = var_1_10001.zero
	Vector3 = var_1
	arg_4_0.rotation = var_1.zero

	return
end

function var_0_1.GetSize(arg_5_0)
	return arg_5_0.size
end

function var_0_1.GetSizeWithRotation(arg_6_0)
	if arg_6_0:IsForward() then
		return arg_6_0:GetSize()
	else
		Vector2 = var_1

		return var_1(arg_6_0.size.y, arg_6_0.size.x)
	end

	return
end

function var_0_1.GetRotation(arg_7_0)
	return arg_7_0.rotation
end

function var_0_1.UpdateRotation(arg_8_0, arg_8_1)
	arg_8_0.rotation = arg_8_1

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.DispatchEvent

	ISLAND_AGORA_EVT = var_1_10005

	var_8_1(var_8_0, var_1_10005.ITEM_DIR_UPDATE, arg_8_0.rotation)
	arg_8_0:UpdatePosition(arg_8_0.position)

	return
end

function var_0_1.UpdatePosition(arg_9_0, arg_9_1)
	arg_9_0.position = arg_9_1
	arg_9_0.area = arg_9_0:ReGenArea(true)

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.DispatchEvent

	ISLAND_AGORA_EVT = var_5

	var_9_1(var_9_0, var_5.ITEM_POSITION_UPDATE, arg_9_0.area)

	return
end

function var_0_1.GetPosition(arg_10_0)
	return arg_10_0.position
end

function var_0_1.IsSquareSize(arg_11_0)
	return arg_11_0.size.x == arg_11_0.size.y
end

function var_0_1.ReGenArea(arg_12_0, arg_12_1)
	if arg_12_0:IsSquareSize() and not arg_12_1 then
		return arg_12_0:GetArea()
	end

	return arg_12_0:GenArea()
end

function var_0_1.IsForward(arg_13_0)
	return arg_13_0.rotation.y == 0 or arg_13_0.rotation.y == 180
end

function var_0_1.Rotation(arg_14_0)
	local var_14_0

	if arg_14_0.rotation.y + 90 > 270 then
		var_14_0 = 0
	end

	local var_14_1 = arg_14_0
	local var_14_2 = arg_14_0.UpdateRotation

	Vector3 = var_1_10005

	var_14_2(var_14_1, var_1_10005(0, var_14_0, 0))

	return
end

function var_0_1.GenArea(arg_15_0)
	return arg_15_0:GenAreaByPosition(arg_15_0.position)
end

function var_0_1.GenAreaByPosition(arg_16_0, arg_16_1)
	if arg_16_0:IsForward() then
		AgoraCalc = var_2

		return var_2.GetArea(arg_16_1, arg_16_0.size)
	else
		AgoraCalc = var_2

		local var_16_0 = var_2.GetArea
		local var_16_1 = arg_16_1

		Vector2 = var_1_10005

		return var_16_0(var_16_1, var_1_10005(arg_16_0.size.y, arg_16_0.size.x))
	end

	return
end

function var_0_1.GetNeighborPoints(arg_17_0)
	local var_17_0
	local var_17_1 = arg_17_0

	if arg_17_0.IsForward(var_17_1) then
		AgoraCalc = var_2
		var_17_0 = var_2.GetSizeCoord(arg_17_0.size)
	else
		AgoraCalc = var_2

		local var_17_2 = var_2.GetSizeCoord

		Vector2 = var_17_1
		var_17_0 = var_17_2(var_17_1(arg_17_0.size.y, arg_17_0.size.x))
	end

	local var_17_3 = var_17_0.x
	local var_17_4 = var_17_0.y
	local var_17_5 = var_17_0.z
	local var_17_6 = var_17_0.w
	local var_17_7 = {}
	local var_17_8 = arg_17_0.position

	Vector2 = var_1_10008
	var_17_7[1] = var_17_8 + var_1_10008(0, var_17_4 + 1)

	local var_17_9 = arg_17_0.position

	Vector2 = var_8
	var_17_7[2] = var_17_9 + var_8(0, var_17_6 - 1)

	local var_17_10 = arg_17_0.position

	Vector2 = var_8
	var_17_7[3] = var_17_10 + var_8(var_17_3 - 1, 0)

	local var_17_11 = arg_17_0.position

	Vector2 = var_8
	var_17_7[4] = var_17_11 + var_8(var_17_5 + 1, 0)

	return var_17_7
end

function var_0_1.GetArea(arg_18_0)
	return arg_18_0.area
end

function var_0_1.GetResPath(arg_19_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.ToPlacementData(arg_20_0)
	return {
		id = arg_20_0.id,
		x = arg_20_0.position.x,
		y = arg_20_0.position.y,
		dir = arg_20_0.rotation.y / 90
	}
end

function var_0_1.FlushDataFromPlacementData(arg_21_0, arg_21_1)
	arg_21_0:UpdatePosition(arg_21_1.position)
	arg_21_0:UpdateRotation(arg_21_1.rotation)

	return
end

return var_0_1
