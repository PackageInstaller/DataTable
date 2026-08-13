class = var_0_10000

local var_0_0 = "CourtYardCanPutFurniture"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardFurniture"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.childs = {}
	CourtYardFurniturePlaceableArea = var_3

	local var_1_0 = var_3.New
	local var_1_1 = arg_1_1
	local var_1_2 = arg_1_0

	Vector4 = var_6
	arg_1_0.placeableArea = var_1_0(var_1_1, var_1_2, var_6(35, 35, 0, 0))

	return
end

function var_0_1.GetPlaceableArea(arg_2_0)
	return arg_2_0.placeableArea
end

function var_0_1.GetChilds(arg_3_0)
	return arg_3_0.childs
end

function var_0_1.AnyNotRotateChilds(arg_4_0)
	if #arg_4_0.childs > 0 then
		_ = var_1

		return var_1.any(arg_4_0.childs, function(arg_5_0)
			isa = var_2_10001

			local var_5_0 = arg_5_0

			CourtYardFurniture = var_2_10003

			local var_5_1

			if var_2_10001(var_5_0, var_2_10003) then
				var_5_1 = arg_5_0:DisableRotation()
			end

			return var_5_1
		end)
	end

	return false
end

function var_0_1.GetCanputonPosition(arg_6_0)
	local var_6_0 = arg_6_0:GetPosition()

	if arg_6_0:GetDirection() == 1 then
		_ = var_2

		return var_2.map(arg_6_0.config.canputonGrid, function(arg_7_0)
			Vector2 = var_2_10001

			return var_2_10001(arg_7_0[1], arg_7_0[2]) + var_6_0
		end)
	else
		_ = var_2

		return var_2.map(arg_6_0.config.canputonGrid, function(arg_8_0)
			Vector2 = var_2_10001

			return var_2_10001(arg_8_0[2], arg_8_0[1]) + var_6_0
		end)
	end

	return
end

function var_0_1.CanPutChildInPosition(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:GetLevel() < arg_9_1:GetLevel()
	local var_9_1 = arg_9_0
	local var_9_2 = arg_9_0.AllowDepthType(var_9_1)

	table = var_9_1

	local var_9_3 = var_9_1.contains(var_9_2, arg_9_1:GetDeathType())
	local var_9_4 = arg_9_1
	local var_9_5 = arg_9_1.GetAreaByPosition(var_9_4, arg_9_2)

	if var_9_3 and var_9_0 then
		::label_9_1::

		_ = var_9_4
		var_9_4 = var_9_4.all(var_9_5, function(arg_10_0)
			local var_10_0 = arg_9_0.placeableArea

			return var_1.LegalPosition(var_10_0, arg_10_0)
		end)
	end

	return var_9_4
end

function var_0_1.AllowDepthType(arg_11_0)
	local var_11_0 = {}

	CourtYardConst = var_1_10002
	var_11_0[1] = var_1_10002.DEPTH_TYPE_MAT
	CourtYardConst = var_2
	var_11_0[2] = var_2.DEPTH_TYPE_FURNITURE

	return var_11_0
end

function var_0_1.AddChild(arg_12_0, arg_12_1)
	arg_12_0:SetDirty()
	arg_12_1:SetParent(arg_12_0)

	table = var_2

	var_2.insert(arg_12_0.childs, arg_12_1)

	local var_12_0 = arg_12_0.placeableArea

	var_2.AddItem(var_12_0, arg_12_1)
	arg_12_1:SetPosition(arg_12_1:GetPosition())

	return
end

function var_0_1.RemoveChild(arg_13_0, arg_13_1)
	arg_13_0:SetDirty()
	arg_13_1:SetParent(nil)

	table = var_2

	var_2.removebyvalue(arg_13_0.childs, arg_13_1)

	local var_13_0 = arg_13_0.placeableArea

	var_2.RemoveItem(var_13_0, arg_13_1)

	return
end

function var_0_1.AreaWithInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_0.placeableArea

	return var_5.AreaWithInfo(var_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
end

function var_0_1.SetPosition(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetPosition()

	var_0_1.super.SetPosition(arg_15_0, arg_15_1)

	local var_15_1 = {}

	for iter_15_0 = #arg_15_0.childs, 1, -1 do
		local var_15_2 = arg_15_0.childs[iter_15_0]
		local var_15_3 = var_8.GetPosition(var_15_2) - var_15_0

		arg_15_0:RemoveChild(var_8)

		table = var_10

		var_10.insert(var_15_1, {
			var_8,
			arg_15_1 + var_15_3
		})
	end

	ipairs = var_4

	for iter_15_1, iter_15_2 in var_4(var_15_1) do
		local var_15_4 = iter_15_2[1]

		var_9.SetPosition(var_15_4, iter_15_2[2])
		arg_15_0:AddChild(iter_15_2[1])
	end

	return
end

function var_0_1.Rotate(arg_16_0)
	local var_16_0 = arg_16_0:GetPosition()

	var_0_1.super.Rotate(arg_16_0)

	local var_16_1 = arg_16_0:GetPosition()
	local var_16_2 = {}

	for iter_16_0 = #arg_16_0.childs, 1, -1 do
		local var_16_3 = arg_16_0.childs[iter_16_0]
		local var_16_4 = var_8.GetPosition(var_16_3) - var_16_0

		arg_16_0:RemoveChild(var_8)

		table = var_10

		local var_16_5 = var_10.insert
		local var_16_6 = var_16_2
		local var_16_7 = {
			var_8
		}

		Vector2 = var_1_10013
		var_16_7[2] = var_16_1 + var_1_10013(var_16_4.y, var_16_4.x)

		var_16_5(var_16_6, var_16_7)
	end

	ipairs = var_4

	for iter_16_1, iter_16_2 in var_4(var_16_2) do
		local var_16_8 = iter_16_2[1]

		var_9.SetPosition(var_16_8, iter_16_2[2])

		local var_16_9 = iter_16_2[1]

		var_9.Rotate(var_16_9)
		arg_16_0:AddChild(iter_16_2[1])
	end

	return
end

function var_0_1.CanRotateChild(arg_17_0, arg_17_1)
	local var_17_0 = false

	arg_17_0:RemoveChild(arg_17_1)

	_ = var_3

	if var_3.all(arg_17_1:GetRotatePositions(), function(arg_18_0)
		local var_18_0 = arg_17_0.placeableArea

		return var_1.LegalPosition(var_18_0, arg_18_0)
	end) then
		var_17_0 = true
	end

	arg_17_0:AddChild(arg_17_1)

	return var_17_0
end

function var_0_1.ToTable(arg_19_0)
	local var_19_0 = var_0_1.super.ToTable(arg_19_0)
	local var_19_1 = {}
	local var_19_2 = arg_19_0
	local var_19_3 = arg_19_0.GetPosition(var_19_2)

	ipairs = var_19_2

	for iter_19_0, iter_19_1 in var_19_2(arg_19_0.childs) do
		var_19_1[iter_19_1.id] = iter_19_1:GetPosition() - var_19_3
	end

	var_19_0.child = var_19_1

	return var_19_0
end

return var_0_1
