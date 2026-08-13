class = var_0_10000

local var_0_0 = var_0_10000("CourtYardFurniturePlaceareaDebug")
local var_0_1 = true

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.furniture = arg_1_1
	arg_1_0.mapGrids = {}

	arg_1_0:Flush()

	return
end

function var_0_0.GetView(arg_2_0)
	local var_2_0 = arg_2_0.furniture
	local var_2_1 = var_1.GetHost(var_2_0)
	local var_2_2 = var_1.GetBridge(var_2_1)

	return var_1.GetView(var_2_2)
end

function var_0_0.Flush(arg_3_0)
	arg_3_0:Clear()

	local var_3_0 = arg_3_0:GetView()
	local var_3_1 = var_1.GetRect(var_3_0)
	local var_3_2 = var_1.Find(var_3_1, "grids")

	if var_0_1 then
		local var_3_3 = arg_3_0.furniture
		local var_3_4

		if not var_3_4.RawGetOffset(var_3_3) then
			Vector3 = var_3_4
			var_3_4 = var_3_4.zero
		end

		local var_3_5 = arg_3_0.furniture
		local var_3_6 = var_3.GetCanputonPosition(var_3_5)

		ipairs = var_3_5

		for iter_3_0, iter_3_1 in var_3_5(var_3_6) do
			local var_3_7 = arg_3_0:GetView().poolMgr
			local var_3_8 = var_9.GetGridPool(var_3_7)
			local var_3_9 = var_9.Dequeue(var_3_8)

			setParent = var_3_8

			var_3_8(var_3_9, var_3_2)

			tf = var_3_8

			local var_3_10 = var_3_8(var_3_9)

			Vector3 = var_11
			var_3_10.localScale = var_11.one
			tf = var_3_10

			local var_3_11 = var_3_10(var_3_9)

			CourtYardCalcUtil = var_11
			var_3_11.localPosition = var_11.Map2Local(iter_3_1) + var_3_4

			local var_3_12 = var_3_9
			local var_3_13 = var_3_9.GetComponent

			typeof = var_12
			Image = var_1_10013

			local var_3_14 = var_3_13(var_3_12, var_12(var_1_10013))

			Color = var_3_12
			var_3_14.color = var_3_12.New(0, 0, 1, 1)
			table = var_11

			var_11.insert(arg_3_0.mapGrids, var_3_9)
		end

		return
	end
end

function var_0_0.Clear(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.mapGrids) do
		local var_4_0 = iter_4_1
		local var_4_1 = iter_4_1.GetComponent

		typeof = var_1_10008
		Image = var_1_10009

		local var_4_2 = var_4_1(var_4_0, var_1_10008(var_1_10009))

		Color = var_4_0
		var_4_2.color = var_4_0.New(1, 1, 1, 1)

		local var_4_3 = arg_4_0:GetView().poolMgr
		local var_4_4 = var_6.GetGridPool(var_4_3)

		var_6.Enqueue(var_4_4, iter_4_1)
	end

	arg_4_0.mapGrids = {}

	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:Clear()

	return
end

return var_0_0
