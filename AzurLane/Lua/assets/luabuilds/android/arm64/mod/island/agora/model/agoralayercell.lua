class = var_0_10000

local var_0_0 = var_0_10000("AgoraLayerCell")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.position = arg_1_1
	arg_1_0.id = 0
	arg_1_0.shapeId = -1

	return
end

function var_0_0.Fill(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.shapeId = arg_2_2

	return
end

function var_0_0.IsEmpty(arg_3_0)
	return arg_3_0.id == 0 or arg_3_0.shapeId < 0
end

function var_0_0.IsSameValue(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0.id == arg_4_1 and arg_4_0.shapeId == arg_4_2
end

function var_0_0.GetPosition(arg_5_0)
	return arg_5_0.position
end

function var_0_0.GetShapeId(arg_6_0)
	return arg_6_0.shapeId
end

function var_0_0.GetID(arg_7_0)
	return arg_7_0.id
end

function var_0_0.GetModel(arg_8_0)
	if arg_8_0:IsEmpty() then
		return ""
	end

	math = var_1

	local var_8_0 = var_1.floor(arg_8_0.id / 100)

	pg = var_1_10002

	return var_1_10002.island_furniture_template[var_8_0].model
end

function var_0_0.Clear(arg_9_0)
	arg_9_0.id = 0
	arg_9_0.shapeId = -1

	return
end

function var_0_0.ToPlacementData(arg_10_0)
	local var_10_0 = arg_10_0:GetPosition()

	return {
		x = var_10_0.x,
		y = var_10_0.y,
		id = arg_10_0.id,
		shapeId = arg_10_0:GetShapeId()
	}
end

function var_0_0.IsSame(arg_11_0, arg_11_1)
	return arg_11_0.id == arg_11_1.id and arg_11_0.shapeId == arg_11_1.shapeId
end

return var_0_0
