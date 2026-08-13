class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGameGridController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._data = arg_1_3
	findTF = var_1_10004
	arg_1_0._gridTpl = var_1_10004(arg_1_1, "grids/grid_tpl")
	setActive = var_4

	var_4(arg_1_0._gridTpl, false)

	arg_1_0._grids = {}

	return
end

function var_0_0.Prepare(arg_2_0)
	local var_2_0 = arg_2_0._data
	local var_2_1 = var_1.GetBoundsData
	local var_2_2 = arg_2_0._data

	arg_2_0.boundsData = var_2_1(var_2_0, var_3.GetChapterConfig(var_2_2, "bound"))

	return
end

function var_0_0.Start(arg_3_0)
	return
end

function var_0_0.Step(arg_4_0)
	return
end

function var_0_0.Stop(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
