local var_0_0 = class("CutFruitGameGridController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._data = arg_1_3
	arg_1_0._gridTpl = findTF(arg_1_1, "grids/grid_tpl")

	setActive(arg_1_0._gridTpl, false)

	arg_1_0._grids = {}

	return
end

function var_0_0.Prepare(arg_2_0)
	arg_2_0.boundsData = arg_2_0._data:GetBoundsData(arg_2_0._data:GetChapterConfig("bound"))

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
