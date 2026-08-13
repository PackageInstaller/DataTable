class = var_0_10000

local var_0_0 = "CourtYardGridAgent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardAgent"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.grids = {}

	return
end

function var_0_1.Reset(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.clear(arg_2_0.grids)

	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1) do
		local var_2_0 = arg_2_0:GetPool()
		local var_2_1 = var_7.Dequeue(var_2_0).transform

		var_8.SetParent(var_2_1, arg_2_0.selectedModule.gridsTF)

		local var_2_2 = var_7.transform

		Vector3 = var_2_1
		var_2_2.localScale = var_2_1(1, 1, 1)
		table = var_2_2

		var_2_2.insert(arg_2_0.grids, var_7)
		arg_2_0:UpdatePositionAndColor(var_7, iter_2_1)
	end

	return
end

function var_0_1.Flush(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_1) do
		local var_3_0 = arg_3_0.grids[iter_3_0]

		assert = var_1_10008

		var_1_10008(var_3_0)
		arg_3_0:UpdatePositionAndColor(var_3_0, iter_3_1)
	end

	return
end

function var_0_1.UpdatePositionAndColor(arg_4_0, arg_4_1, arg_4_2)
	CourtYardCalcUtil = var_1_10003

	local var_4_0 = var_1_10003.Map2Local(arg_4_2.position) + arg_4_2.offset
	local var_4_1 = arg_4_1.transform

	CourtYardCalcUtil = var_1_10005

	local var_4_2 = var_1_10005.TrPosition2LocalPos
	local var_4_3 = arg_4_0.gridsTF
	local var_4_4 = arg_4_1.transform.parent

	Vector3 = var_1_10008
	var_4_1.localPosition = var_4_2(var_4_3, var_4_4, var_1_10008(var_4_0.x, var_4_0.y, 0))

	local var_4_5 = arg_4_0:GetColor(arg_4_2.flag)
	local var_4_6 = arg_4_1
	local var_4_7 = arg_4_1.GetComponent

	typeof = var_4_4
	Image = var_8
	var_4_7(var_4_6, var_4_4(var_8)).color = var_4_5

	return
end

function var_0_1.Clear(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.grids) do
		local var_5_0 = iter_5_1.transform

		Vector3 = var_1_10007
		var_5_0.localScale = var_1_10007(1, 1, 1)

		local var_5_1 = iter_5_1.transform

		Vector3 = var_1_10007
		var_5_1.eulerAngles = var_1_10007.zero
		var_1_10007 = iter_5_1

		local var_5_2 = iter_5_1.GetComponent

		typeof = var_8
		Image = var_9

		local var_5_3 = var_5_2(var_1_10007, var_8(var_9))

		Color = var_1_10007
		var_5_3.color = var_1_10007.New(1, 1, 1, 1)
		var_1_10007 = arg_5_0
		var_1_10007 = arg_5_0.GetPool(var_1_10007)

		var_6.Enqueue(var_1_10007, iter_5_1)
	end

	arg_5_0.grids = {}

	return
end

function var_0_1.GetPool(arg_6_0)
	local var_6_0 = arg_6_0:GetView().poolMgr

	return var_1.GetGridPool(var_6_0)
end

function var_0_1.GetColor(arg_7_0, arg_7_1)
	local var_7_0 = {}

	CourtYardConst = var_1_10003
	var_7_0[1] = var_1_10003.BACKYARD_GREEN
	CourtYardConst = var_3
	var_7_0[2] = var_3.BACKYARD_RED
	CourtYardConst = var_3
	var_7_0[3] = var_3.BACKYARD_BLUE

	return var_7_0[arg_7_1]
end

function var_0_1.Dispose(arg_8_0)
	var_0_1.super.Dispose(arg_8_0)
	arg_8_0:Clear()

	return
end

return var_0_1
