class = var_0_10000

local var_0_0 = "CourtYardDepthItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...CourtYardDispatcher"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0:GetDeathType()

	arg_1_0.ob = {
		id = arg_1_2,
		type = var_1_0
	}
	arg_1_0.initSizeX = arg_1_3 or 0
	arg_1_0.initSizeY = arg_1_4 or 0
	arg_1_0.sizeX = arg_1_0.initSizeX
	arg_1_0.sizeY = arg_1_0.initSizeY
	assert = var_6

	var_6(arg_1_0.sizeX > 0 and arg_1_0.sizeY > 0, "size 必须大于0============>" .. arg_1_2)

	arg_1_0.posX = 0
	arg_1_0.posY = 0
	arg_1_0.maxX = 0
	arg_1_0.maxY = 0
	arg_1_0.posZ = 0
	arg_1_0.dir = 1
	arg_1_0.sortedFlag = true
	arg_1_0.dirty = false
	arg_1_0.parent = nil
	arg_1_0.opFlag = false
	arg_1_0.area = {}

	return
end

function var_0_1.GetInitSize(arg_2_0)
	return {
		{
			arg_2_0.sizeX,
			arg_2_0.sizeY
		}
	}
end

function var_0_1.GetInitSizeCnt(arg_3_0)
	return arg_3_0:GetInitSize()[1][1] * var_1[2]
end

function var_0_1.GetObjType(arg_4_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetOffset(arg_5_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.UpdateOpFlag(arg_6_0, arg_6_1)
	arg_6_0.opFlag = arg_6_1

	return
end

function var_0_1.GetOpFlag(arg_7_0)
	return arg_7_0.opFlag
end

function var_0_1.InActivityRange(arg_8_0, arg_8_1)
	return true
end

function var_0_1.GetDeathType(arg_9_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.SetPosition(arg_10_0, arg_10_1)
	arg_10_0:SetDirty()
	arg_10_0:SetPos(arg_10_1.x + 1, arg_10_1.y + 1)
	arg_10_0:ReGenArea()

	return
end

function var_0_1.SetDir(arg_11_0, arg_11_1)
	arg_11_0:SetDirty()

	if arg_11_1 == 2 then
		arg_11_0.sizeX = arg_11_0.initSizeY
		arg_11_0.sizeY = arg_11_0.initSizeX
	else
		arg_11_0.sizeX = arg_11_0.initSizeX
		arg_11_0.sizeY = arg_11_0.initSizeY
	end

	arg_11_0.dir = arg_11_1

	arg_11_0:SetPosition(arg_11_0:GetPosition())

	return
end

function var_0_1.GetDirection(arg_12_0)
	return arg_12_0.dir
end

function var_0_1.GetNormalDirection(arg_13_0)
	if arg_13_0.dir == 1 then
		return 1
	end

	if arg_13_0.dir == 2 then
		return -1
	end

	return
end

function var_0_1.ReGenArea(arg_14_0)
	table = var_1_10001

	var_1_10001.clear(arg_14_0.area)

	local var_14_0 = arg_14_0:GetPosition()

	arg_14_0.area = arg_14_0:GetAreaByPosition(var_14_0)

	return
end

function var_0_1.GetPosition(arg_15_0)
	Vector2 = var_1_10001

	return var_1_10001(arg_15_0.posX - 1, arg_15_0.posY - 1)
end

function var_0_1.SetPos(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.posX = arg_16_1
	arg_16_0.posY = arg_16_2
	arg_16_0.maxX = arg_16_1 + arg_16_0.sizeX - 1
	arg_16_0.maxY = arg_16_2 + arg_16_0.sizeY - 1

	return
end

function var_0_1.SetDepth(arg_17_0, arg_17_1)
	arg_17_0.posZ = arg_17_1

	return
end

function var_0_1.GetArea(arg_18_0)
	return arg_18_0.area
end

function var_0_1.GetAreaByPosition(arg_19_0, arg_19_1)
	local var_19_0 = {}

	for iter_19_0 = arg_19_1.x, arg_19_1.x + arg_19_0.sizeX - 1 do
		for iter_19_1 = arg_19_1.y, arg_19_1.y + arg_19_0.sizeY - 1 do
			table = var_1_10011
			var_1_10011 = var_1_10011.insert

			local var_19_1 = var_19_0

			Vector2 = var_1_10013

			var_1_10011(var_19_1, var_1_10013(iter_19_0, iter_19_1))
		end
	end

	return var_19_0
end

function var_0_1._GetRotatePositions(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.sizeY
	local var_20_1 = arg_20_0.sizeX
	local var_20_2 = {}

	for iter_20_0 = arg_20_1.x, arg_20_1.x + var_20_0 - 1 do
		for iter_20_1 = arg_20_1.y, arg_20_1.y + var_20_1 - 1 do
			table = var_1_10013
			var_1_10013 = var_1_10013.insert

			local var_20_3 = var_20_2

			Vector2 = var_1_10015

			var_1_10013(var_20_3, var_1_10015(iter_20_0, iter_20_1))
		end
	end

	return var_20_2
end

function var_0_1.GetRotatePositions(arg_21_0)
	local var_21_0 = arg_21_0:GetPosition()

	return arg_21_0:_GetRotatePositions(var_21_0)
end

function var_0_1.SetDirty(arg_22_0)
	arg_22_0.dirty = true

	return
end

function var_0_1.UnDirty(arg_23_0)
	arg_23_0.dirty = false

	return
end

function var_0_1.IsDirty(arg_24_0)
	return arg_24_0.dirty
end

function var_0_1.Interaction(arg_25_0, arg_25_1)
	return
end

function var_0_1.ClearInteraction(arg_26_0, arg_26_1)
	return
end

function var_0_1.SetParent(arg_27_0, arg_27_1)
	arg_27_0:SetDirty()

	arg_27_0.parent = arg_27_1

	return
end

function var_0_1.HasParent(arg_28_0)
	return arg_28_0.parent ~= nil
end

function var_0_1.GetParent(arg_29_0)
	return arg_29_0.parent
end

function var_0_1.GetAroundPositions(arg_30_0)
	local var_30_0 = arg_30_0:GetPosition()
	local var_30_1 = {}

	Vector2 = var_1_10003
	var_30_1[1] = var_1_10003(var_30_0.x + 1, var_30_0.y)
	Vector2 = var_3
	var_30_1[2] = var_3(var_30_0.x, var_30_0.y + 1)
	Vector2 = var_3
	var_30_1[3] = var_3(var_30_0.x - 1, var_30_0.y)
	Vector2 = var_3
	var_30_1[4] = var_3(var_30_0.x, var_30_0.y - 1)

	return var_30_1
end

function var_0_1.MarkPosition(arg_31_0, arg_31_1)
	arg_31_0.markPosition = arg_31_1

	return
end

function var_0_1.GetMarkPosition(arg_32_0)
	return arg_32_0.markPosition
end

function var_0_1.ClearMarkPosition(arg_33_0)
	arg_33_0.markPosition = nil

	return
end

function var_0_1.GetOffset(arg_34_0)
	if arg_34_0:HasParent() then
		local var_34_0 = arg_34_0.parent

		return var_1.RawGetOffset(var_34_0)
	else
		Vector3 = var_1

		return var_1.zero
	end

	return
end

function var_0_1.UnClear(arg_35_0, arg_35_1)
	arg_35_0.unClear = arg_35_1

	return
end

function var_0_1.IsUnClear(arg_36_0)
	return arg_36_0.unClear
end

function var_0_1.RawGetOffset(arg_37_0)
	Vector3 = var_1_10001

	return var_1_10001.zero
end

function var_0_1.IsDifferentDirection(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:GetPosition()
	local var_38_1 = (arg_38_1.x < var_38_0.x and arg_38_1.y == var_38_0.y or arg_38_1.x == var_38_0.x and arg_38_1.y > var_38_0.y) and 2 or 1

	return arg_38_0.dir ~= var_38_1
end

function var_0_1.Dispose(arg_39_0)
	arg_39_0:ClearListeners()

	return
end

return var_0_1
