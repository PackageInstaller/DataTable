local var_0_0 = class("CourtYardFurniturePlaceareaDebug")
local var_0_1 = true

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.furniture = arg_1_1
	arg_1_0.mapGrids = {}

	arg_1_0:Flush()

	return
end

function var_0_0.GetView(arg_2_0)
	return arg_2_0.furniture:GetHost():GetBridge():GetView()
end

function var_0_0.Flush(arg_3_0)
	arg_3_0:Clear()

	local var_3_0 = arg_3_0:GetView():GetRect():Find("grids")
	local var_3_1 = var_0_1 and arg_3_0.furniture:RawGetOffset() or Vector3.zero

	for iter_3_0, iter_3_1 in ipairs((arg_3_0.furniture:GetCanputonPosition())) do
		local var_3_2 = arg_3_0:GetView().poolMgr:GetGridPool():Dequeue()

		setParent(var_3_2, var_3_0)

		tf(var_3_2).localScale = Vector3.one
		tf(var_3_2).localPosition = CourtYardCalcUtil.Map2Local(iter_3_1) + var_3_1
		var_3_2:GetComponent(typeof(Image)).color = Color.New(0, 0, 1, 1)

		table.insert(arg_3_0.mapGrids, var_3_2)
	end

	return
end

function var_0_0.Clear(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.mapGrids) do
		iter_4_1:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)

		arg_4_0:GetView().poolMgr:GetGridPool():Enqueue(iter_4_1)
	end

	arg_4_0.mapGrids = {}

	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:Clear()

	return
end

return var_0_0
