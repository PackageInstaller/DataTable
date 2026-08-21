local var_0_0 = class("BeachGuardLine")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._lineTf = arg_1_1
	arg_1_0._gridTpl = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.gridPos = findTF(arg_1_0._lineTf, "grids")
	arg_1_0.freshPos = findTF(arg_1_0._lineTf, "")
	arg_1_0.grids = {}

	for iter_1_0 = 1, BeachGuardConst.grid_num do
		local var_1_0 = tf(instantiate(arg_1_0._gridTpl))

		setParent(var_1_0, arg_1_0.gridPos)

		local var_1_1 = BeachGuardGrid.New(var_1_0, arg_1_0._event)

		var_1_1:setIndex(iter_1_0)
		table.insert(arg_1_0.grids, var_1_1)
	end

	return
end

function var_0_0.setIndex(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1

	for iter_2_0 = 1, #arg_2_0.grids do
		arg_2_0.grids[iter_2_0]:setLineIndex(arg_2_1)
	end

	return
end

function var_0_0.getIndex(arg_3_0)
	return arg_3_0._index
end

function var_0_0.active(arg_4_0, arg_4_1)
	setActive(arg_4_0._lineTf, arg_4_1)

	return
end

function var_0_0.getGrids(arg_5_0)
	return arg_5_0.grids
end

function var_0_0.getGridByIndex(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0.grids do
		if arg_6_0.grids[iter_6_0]:getIndex() == arg_6_1 then
			return arg_6_0.grids[iter_6_0]
		end
	end

	return nil
end

function var_0_0.getGridWorld(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.grids do
		if arg_7_0.grids[iter_7_0]:inGridWorld(arg_7_1) then
			return arg_7_0.grids[iter_7_0]
		end
	end

	return nil
end

function var_0_0.start(arg_8_0)
	for iter_8_0 = 1, #arg_8_0.grids do
		local var_8_0 = arg_8_0.grids[iter_8_0]:start()
	end

	return
end

function var_0_0.step(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_0.grids do
		local var_9_0 = arg_9_0.grids[iter_9_0]:step(arg_9_1)
	end

	return
end

function var_0_0.getPosition(arg_10_0)
	return arg_10_0._lineTf.position
end

function var_0_0.clear(arg_11_0)
	for iter_11_0 = 1, #arg_11_0.grids do
		arg_11_0.grids[iter_11_0]:clear()
	end

	return
end

return var_0_0
