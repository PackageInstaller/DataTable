class = var_0_10000

local var_0_0 = var_0_10000("CourtYardMapDebug")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.map = arg_1_1
	arg_1_0.mapGrids = {}

	local var_1_0

	if not arg_1_2 or not arg_1_2.r then
		var_1_0 = 0
	end

	arg_1_0.r = var_1_0

	local var_1_1

	if not arg_1_2 or not arg_1_2.g then
		var_1_1 = 0
	end

	arg_1_0.g = var_1_1

	local var_1_2

	if not arg_1_2 or not arg_1_2.b then
		var_1_2 = 0
	end

	arg_1_0.b = var_1_2

	arg_1_0:Init()

	return
end

function var_0_0.GetView(arg_2_0)
	local var_2_0 = arg_2_0.map
	local var_2_1 = var_1.GetHost(var_2_0)
	local var_2_2 = var_1.GetBridge(var_2_1)

	return var_1.GetView(var_2_2)
end

function var_0_0.Init(arg_3_0)
	local var_3_0 = arg_3_0:GetView()
	local var_3_1 = var_1.GetRect(var_3_0)
	local var_3_2 = var_1.Find(var_3_1, "grids")
	local var_3_3 = arg_3_0.map.minSizeX
	local var_3_4 = arg_3_0.map.minSizeY
	local var_3_5 = arg_3_0.map.sizeX
	local var_3_6 = arg_3_0.map.sizeY

	for iter_3_0 = var_3_3, var_3_5 do
		local var_3_7 = {}

		for iter_3_1 = var_3_4, var_3_6 do
			local var_3_8 = arg_3_0:GetView().poolMgr
			local var_3_9 = var_15.GetGridPool(var_3_8)
			local var_3_10 = var_15.Dequeue(var_3_9)

			setParent = var_3_9

			var_3_9(var_3_10, var_3_2)

			tf = var_3_9

			local var_3_11 = var_3_9(var_3_10)

			Vector3 = var_17
			var_3_11.localScale = var_17.one
			tf = var_3_11

			local var_3_12 = var_3_11(var_3_10)

			CourtYardCalcUtil = var_17

			local var_3_13 = var_17.Map2Local

			Vector2 = var_18
			var_3_12.localPosition = var_3_13(var_18(iter_3_0, iter_3_1))

			local var_3_14 = var_3_10
			local var_3_15 = var_3_10.GetComponent

			typeof = var_18
			Image = var_19

			local var_3_16 = var_3_15(var_3_14, var_18(var_19))

			if iter_3_1 == var_3_6 or iter_3_0 == var_3_5 then
				Color = var_3_14

				if not var_3_14.New(1, 1, 0, 0.5) then
					Color = var_3_14
					var_3_14 = var_3_14.New(0, 1, 0, 1)
				end

				var_3_16.color = var_3_14
				var_3_7[iter_3_1] = var_3_10
			end
		end

		arg_3_0.mapGrids[iter_3_0] = var_3_7
	end

	arg_3_0:Flush()

	return
end

function var_0_0.Flush(arg_4_0)
	local var_4_0 = arg_4_0.map.sizeX
	local var_4_1 = arg_4_0.map.sizeY

	pairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.mapGrids) do
		pairs = var_1_10008

		for iter_4_2, iter_4_3 in var_1_10008(iter_4_1) do
			local var_4_2 = arg_4_0.map
			local var_4_3 = var_13.IsEmptyPosition

			Vector2 = var_1_10015

			local var_4_4 = var_4_3(var_4_2, var_1_10015(iter_4_0, iter_4_2))

			var_1_10015 = iter_4_3

			local var_4_5 = iter_4_3.GetComponent

			typeof = var_16
			Image = var_17

			local var_4_6 = var_4_5(var_1_10015, var_16(var_17))

			var_1_10015 = nil

			if var_4_4 then
				if iter_4_2 == var_4_1 or iter_4_0 == var_4_0 then
					Color = var_16

					if not var_16.New(1, 1, 0, 0.5) then
						::label_4_0::

						Color = var_16
						var_1_10015 = var_16.New(0, 1, 0, 1)
					end

					if false then
						Color = var_16
						var_1_10015 = var_16.New(arg_4_0.r, arg_4_0.g, arg_4_0.b, var_4_6.color.a)
					end

					var_4_6.color = var_1_10015
				end
			end
		end
	end

	return
end

function var_0_0.Clear(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.mapGrids) do
		pairs = var_1_10006

		for iter_5_2, iter_5_3 in var_1_10006(iter_5_1) do
			local var_5_0 = iter_5_3
			local var_5_1 = iter_5_3.GetComponent

			typeof = var_1_10013
			Image = var_1_10014

			local var_5_2 = var_5_1(var_5_0, var_1_10013(var_1_10014))

			Color = var_5_0
			var_5_2.color = var_5_0.New(0, 1, 0, 1)

			local var_5_3 = arg_5_0:GetView().poolMgr
			local var_5_4 = var_11.GetGridPool(var_5_3)

			var_11.Enqueue(var_5_4, iter_5_3)
		end
	end

	arg_5_0.mapGrids = {}

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:Clear()

	return
end

return var_0_0
