class = var_0_10000

local var_0_0 = var_0_10000("BeachGuardLine")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._lineTf = arg_1_1
	arg_1_0._gridTpl = arg_1_2
	arg_1_0._event = arg_1_3
	findTF = var_1_10004
	arg_1_0.gridPos = var_1_10004(arg_1_0._lineTf, "grids")
	findTF = var_4
	arg_1_0.freshPos = var_4(arg_1_0._lineTf, "")
	arg_1_0.grids = {}

	local var_1_0 = 1

	BeachGuardConst = var_5

	for iter_1_0 = var_1_0, var_5.grid_num do
		tf = var_1_10008
		instantiate = var_1_10009
		var_1_10008 = var_1_10008(var_1_10009(arg_1_0._gridTpl))
		setParent = var_1_10009

		var_1_10009(var_1_10008, arg_1_0.gridPos)

		BeachGuardGrid = var_1_10009

		local var_1_1 = var_1_10009.New(var_1_10008, arg_1_0._event)

		var_1_10009.setIndex(var_1_1, iter_1_0)

		table = var_10

		var_10.insert(arg_1_0.grids, var_1_10009)
	end

	return
end

function var_0_0.setIndex(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1

	for iter_2_0 = 1, #arg_2_0.grids do
		local var_2_0 = arg_2_0.grids[iter_2_0]

		var_6.setLineIndex(var_2_0, arg_2_1)
	end

	return
end

function var_0_0.getIndex(arg_3_0)
	return arg_3_0._index
end

function var_0_0.active(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0._lineTf, arg_4_1)

	return
end

function var_0_0.getGrids(arg_5_0)
	return arg_5_0.grids
end

function var_0_0.getGridByIndex(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0.grids do
		local var_6_0 = arg_6_0.grids[iter_6_0]

		if var_6.getIndex(var_6_0) == arg_6_1 then
			return var_6
		end
	end

	return nil
end

function var_0_0.getGridWorld(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.grids do
		local var_7_0 = arg_7_0.grids[iter_7_0]

		if var_6.inGridWorld(var_7_0, arg_7_1) then
			return var_6
		end
	end

	return nil
end

function var_0_0.start(arg_8_0)
	for iter_8_0 = 1, #arg_8_0.grids do
		local var_8_0 = arg_8_0.grids[iter_8_0]
		local var_8_1 = var_5.start(var_8_0)
	end

	return
end

function var_0_0.step(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_0.grids do
		local var_9_0 = arg_9_0.grids[iter_9_0]
		local var_9_1 = var_6.step(var_9_0, arg_9_1)
	end

	return
end

function var_0_0.getPosition(arg_10_0)
	return arg_10_0._lineTf.position
end

function var_0_0.clear(arg_11_0)
	for iter_11_0 = 1, #arg_11_0.grids do
		local var_11_0 = arg_11_0.grids[iter_11_0]

		var_5.clear(var_11_0)
	end

	return
end

return var_0_0
