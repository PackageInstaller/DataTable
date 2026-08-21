local var_0_0 = class("RollingCircleItem")
local var_0_1 = 73

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.tr = arg_1_1
	arg_1_0._tr = arg_1_1
	arg_1_0.id = arg_1_3

	arg_1_0:SetIndex(arg_1_2)

	return
end

function var_0_0.GetID(arg_2_0)
	return arg_2_0.id
end

function var_0_0.GetIndex(arg_3_0)
	return arg_3_0.index
end

function var_0_0.SetIndex(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1
	arg_4_0.tr.gameObject.name = arg_4_1

	return
end

function var_0_0.IsCenter(arg_5_0, arg_5_1)
	return arg_5_0.index == arg_5_1
end

function var_0_0.SetPrev(arg_6_0, arg_6_1)
	arg_6_0.prev = arg_6_1

	return
end

function var_0_0.SetNext(arg_7_0, arg_7_1)
	arg_7_0.nex = arg_7_1

	return
end

function var_0_0.Init(arg_8_0)
	if not arg_8_0.prev then
		return
	end

	local var_8_0 = arg_8_0.prev:GetLocalposition()

	arg_8_0:UpdateLocalPosition(Vector3(var_8_0.x, var_8_0.y - arg_8_0.prev:GetSpace(), 0))

	return
end

function var_0_0.GetSpace(arg_9_0)
	return var_0_1
end

function var_0_0.GetLocalposition(arg_10_0)
	return arg_10_0.tr.localPosition
end

function var_0_0.UpdateLocalPosition(arg_11_0, arg_11_1)
	arg_11_0.tr.localPosition = arg_11_1

	return
end

function var_0_0.Record(arg_12_0)
	arg_12_0.lastIndex = arg_12_0.index
	arg_12_0.lastLocalPosition = arg_12_0:GetLocalposition()

	return
end

function var_0_0.GetLastPositionAndIndex(arg_13_0)
	return arg_13_0.lastLocalPosition, arg_13_0.lastIndex
end

function var_0_0.GoForward(arg_14_0)
	if arg_14_0.nex then
		local var_14_0, var_14_1 = arg_14_0.nex:GetLastPositionAndIndex()

		arg_14_0:SetIndex(var_14_1)
		arg_14_0:UpdateLocalPosition(var_14_0)
	end

	return
end

function var_0_0.GoBack(arg_15_0)
	if arg_15_0.prev then
		local var_15_0, var_15_1 = arg_15_0.prev:GetLastPositionAndIndex()

		arg_15_0:SetIndex(var_15_1)
		arg_15_0:UpdateLocalPosition(var_15_0)
	end

	return
end

function var_0_0.Dispose(arg_16_0)
	Object.Destroy(arg_16_0.tr.gameObject)

	arg_16_0.prev = nil
	arg_16_0.nex = nil

	return
end

return var_0_0
