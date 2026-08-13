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

		ipairs = var_3_3

		for iter_3_0, iter_3_1 in var_3_3(var_3_6) do
			local var_3_7 = arg_3_0:GetView().poolMgr
			local var_3_8 = var_9.GetGridPool(var_3_7)
			local var_3_9 = var_9.Dequeue(var_3_8)

			setParent = var_1_10010

			var_1_10010(var_3_9, var_3_2)

			tf = var_1_10010
			var_1_10010 = var_1_10010(var_3_9)
			Vector3 = var_3_8
			var_1_10010.localScale = var_3_8.one
			tf = var_1_10010
			var_1_10010 = var_1_10010(var_3_9)
			CourtYardCalcUtil = var_11
			var_1_10010.localPosition = var_11.Map2Local(iter_3_1) + var_3_4

			local var_3_10 = var_3_9

			var_1_10010 = var_3_9.GetComponent
			typeof = var_13
			Image = var_1_10015
			var_1_10010 = var_1_10010(var_3_10, var_13(var_1_10015))
			Color = var_11
			var_1_10010.color = var_11.New(0, 0, 1, 1)
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

		typeof = var_1_10009
		Image = var_1_10011

		local var_4_2 = var_4_1(var_4_0, var_1_10009(var_1_10011))

		Color = var_1_10007
		var_4_2.color = var_1_10007.New(1, 1, 1, 1)

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
