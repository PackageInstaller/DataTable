local var_0_0 = class("CourtYardCanPutFurniture", import(".CourtYardFurniture"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.childs = {}
	arg_1_0.placeableArea = CourtYardFurniturePlaceableArea.New(arg_1_1, arg_1_0, Vector4(35, 35, 0, 0))

	return
end

function var_0_0.GetPlaceableArea(arg_2_0)
	return arg_2_0.placeableArea
end

function var_0_0.GetChilds(arg_3_0)
	return arg_3_0.childs
end

function var_0_0.AnyNotRotateChilds(arg_4_0)
	if #arg_4_0.childs > 0 then
		return _.any(arg_4_0.childs, function(arg_5_0)
			return isa(arg_5_0, CourtYardFurniture) and arg_5_0:DisableRotation()
		end)
	end

	return false
end

function var_0_0.GetCanputonPosition(arg_6_0)
	local var_6_0 = arg_6_0:GetPosition()

	if arg_6_0:GetDirection() == 1 then
		return _.map(arg_6_0.config.canputonGrid, function(arg_7_0)
			return Vector2(arg_7_0[1], arg_7_0[2]) + var_6_0
		end)
	else
		return _.map(arg_6_0.config.canputonGrid, function(arg_8_0)
			return Vector2(arg_8_0[2], arg_8_0[1]) + var_6_0
		end)
	end

	return
end

function var_0_0.CanPutChildInPosition(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:GetLevel() < arg_9_1:GetLevel()

	return table.contains(arg_9_0:AllowDepthType(), arg_9_1:GetDeathType()) and var_9_0 and _.all(arg_9_1:GetAreaByPosition(arg_9_2), function(arg_10_0)
		return arg_9_0.placeableArea:LegalPosition(arg_10_0)
	end)
end

function var_0_0.AllowDepthType(arg_11_0)
	return {
		CourtYardConst.DEPTH_TYPE_MAT,
		CourtYardConst.DEPTH_TYPE_FURNITURE
	}
end

function var_0_0.AddChild(arg_12_0, arg_12_1)
	arg_12_0:SetDirty()
	arg_12_1:SetParent(arg_12_0)
	table.insert(arg_12_0.childs, arg_12_1)
	arg_12_0.placeableArea:AddItem(arg_12_1)
	arg_12_1:SetPosition(arg_12_1:GetPosition())

	return
end

function var_0_0.RemoveChild(arg_13_0, arg_13_1)
	arg_13_0:SetDirty()
	arg_13_1:SetParent(nil)
	table.removebyvalue(arg_13_0.childs, arg_13_1)
	arg_13_0.placeableArea:RemoveItem(arg_13_1)

	return
end

function var_0_0.AreaWithInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	return arg_14_0.placeableArea:AreaWithInfo(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
end

function var_0_0.SetPosition(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetPosition()

	var_0_0.super.SetPosition(arg_15_0, arg_15_1)

	for iter_15_0 = #arg_15_0.childs, 1, -1 do
		local var_15_1 = arg_15_0.childs[iter_15_0]:GetPosition() - var_15_0

		arg_15_0:RemoveChild(arg_15_0.childs[iter_15_0])
		table.insert({}, {
			arg_15_0.childs[iter_15_0],
			arg_15_1 + var_15_1
		})
	end

	for iter_15_1, iter_15_2 in ipairs({}) do
		iter_15_2[1]:SetPosition(iter_15_2[2])
		arg_15_0:AddChild(iter_15_2[1])
	end

	return
end

function var_0_0.Rotate(arg_16_0)
	local var_16_0 = arg_16_0:GetPosition()

	var_0_0.super.Rotate(arg_16_0)

	local var_16_1 = arg_16_0:GetPosition()

	for iter_16_0 = #arg_16_0.childs, 1, -1 do
		local var_16_2 = arg_16_0.childs[iter_16_0]:GetPosition() - var_16_0

		arg_16_0:RemoveChild(arg_16_0.childs[iter_16_0])
		table.insert({}, {
			arg_16_0.childs[iter_16_0],
			var_16_1 + Vector2(var_16_2.y, var_16_2.x)
		})
	end

	for iter_16_1, iter_16_2 in ipairs({}) do
		iter_16_2[1]:SetPosition(iter_16_2[2])
		iter_16_2[1]:Rotate()
		arg_16_0:AddChild(iter_16_2[1])
	end

	return
end

function var_0_0.CanRotateChild(arg_17_0, arg_17_1)
	local var_17_0 = false

	arg_17_0:RemoveChild(arg_17_1)

	if _.all(arg_17_1:GetRotatePositions(), function(arg_18_0)
		return arg_17_0.placeableArea:LegalPosition(arg_18_0)
	end) then
		var_17_0 = true
	end

	arg_17_0:AddChild(arg_17_1)

	return var_17_0
end

function var_0_0.ToTable(arg_19_0)
	local var_19_0 = var_0_0.super.ToTable(arg_19_0)
	local var_19_1 = arg_19_0:GetPosition()

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.childs) do
		({})[iter_19_1.id] = iter_19_1:GetPosition() - var_19_1
	end

	var_19_0.child = {}

	return var_19_0
end

return var_0_0
