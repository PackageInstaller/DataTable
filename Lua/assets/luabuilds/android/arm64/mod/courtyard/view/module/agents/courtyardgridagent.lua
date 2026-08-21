local var_0_0 = class("CourtYardGridAgent", import(".CourtYardAgent"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.grids = {}

	return
end

function var_0_0.Reset(arg_2_0, arg_2_1)
	table.clear(arg_2_0.grids)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = arg_2_0:GetPool():Dequeue()

		var_2_0.transform:SetParent(arg_2_0.selectedModule.gridsTF)

		var_2_0.transform.localScale = Vector3(1, 1, 1)

		table.insert(arg_2_0.grids, var_2_0)
		arg_2_0:UpdatePositionAndColor(var_2_0, iter_2_1)
	end

	return
end

function var_0_0.Flush(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		assert(arg_3_0.grids[iter_3_0])
		arg_3_0:UpdatePositionAndColor(arg_3_0.grids[iter_3_0], iter_3_1)
	end

	return
end

function var_0_0.UpdatePositionAndColor(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = CourtYardCalcUtil.Map2Local(arg_4_2.position) + arg_4_2.offset

	arg_4_1.transform.localPosition = CourtYardCalcUtil.TrPosition2LocalPos(arg_4_0.gridsTF, arg_4_1.transform.parent, Vector3(var_4_0.x, var_4_0.y, 0))
	arg_4_1:GetComponent(typeof(Image)).color = arg_4_0:GetColor(arg_4_2.flag)

	return
end

function var_0_0.Clear(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.grids) do
		iter_5_1.transform.localScale = Vector3(1, 1, 1)
		iter_5_1.transform.eulerAngles = Vector3.zero
		iter_5_1:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)

		arg_5_0:GetPool():Enqueue(iter_5_1)
	end

	arg_5_0.grids = {}

	return
end

function var_0_0.GetPool(arg_6_0)
	return arg_6_0:GetView().poolMgr:GetGridPool()
end

function var_0_0.GetColor(arg_7_0, arg_7_1)
	return ({
		CourtYardConst.BACKYARD_GREEN,
		CourtYardConst.BACKYARD_RED,
		CourtYardConst.BACKYARD_BLUE
	})[arg_7_1]
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	arg_8_0:Clear()

	return
end

return var_0_0
