local BeachGuardLine = class("BeachGuardLine")

function BeachGuardLine:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._lineTf = arg_1_1
	self._gridTpl = arg_1_2
	self._event = arg_1_3
	self.gridPos = findTF(self._lineTf, "grids")
	self.freshPos = findTF(self._lineTf, "")
	self.grids = {}

	for iter_1_0 = 1, BeachGuardConst.grid_num do
		local var_1_0 = tf(instantiate(self._gridTpl))

		setParent(var_1_0, self.gridPos)

		local var_1_1 = BeachGuardGrid.New(var_1_0, self._event)

		var_1_1:setIndex(iter_1_0)
		table.insert(self.grids, var_1_1)
	end

	return
end

function BeachGuardLine:setIndex(arg_2_1)
	self._index = arg_2_1

	for iter_2_0 = 1, #self.grids do
		self.grids[iter_2_0]:setLineIndex(arg_2_1)
	end

	return
end

function BeachGuardLine:getIndex()
	return self._index
end

function BeachGuardLine:active(arg_4_1)
	setActive(self._lineTf, arg_4_1)

	return
end

function BeachGuardLine:getGrids()
	return self.grids
end

function BeachGuardLine:getGridByIndex(arg_6_1)
	for iter_6_0 = 1, #self.grids do
		if self.grids[iter_6_0]:getIndex() == arg_6_1 then
			return self.grids[iter_6_0]
		end
	end

	return nil
end

function BeachGuardLine:getGridWorld(arg_7_1)
	for iter_7_0 = 1, #self.grids do
		if self.grids[iter_7_0]:inGridWorld(arg_7_1) then
			return self.grids[iter_7_0]
		end
	end

	return nil
end

function BeachGuardLine:start()
	for iter_8_0 = 1, #self.grids do
		local var_8_0 = self.grids[iter_8_0]:start()
	end

	return
end

function BeachGuardLine:step(arg_9_1)
	for iter_9_0 = 1, #self.grids do
		local var_9_0 = self.grids[iter_9_0]:step(arg_9_1)
	end

	return
end

function BeachGuardLine:getPosition()
	return self._lineTf.position
end

function BeachGuardLine:clear()
	for iter_11_0 = 1, #self.grids do
		self.grids[iter_11_0]:clear()
	end

	return
end

return BeachGuardLine
