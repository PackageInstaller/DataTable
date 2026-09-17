local TableViewEx = class("TableViewEx", function()
	return cc.Layer:create()
end)

function TableViewEx:ctor(arg_2_1)
	self._tableView = nil
	self._data = nil
end

function TableViewEx:create(arg_3_1)
	local var_3_0 = TableViewEx.new()

	if var_3_0 and var_3_0:Init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function TableViewEx:Init(arg_4_1)
	if not arg_4_1.size or not arg_4_1.cellSizeForTable or not arg_4_1.tableCellAtIndex or not arg_4_1.numberOfCellsInTableView then
		return nil
	end

	self._data = arg_4_1
	self._tableView = cc.TableView:create(self._data.size or cc.size(100, 66))

	self:addChild(self._tableView)
	self._tableView:setDirection(self._data.direction or cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self:setVerticalFillOrder(self._data.verticalFillOrder or cc.TABLEVIEW_FILL_TOPDOWN)
	self._tableView:setDelegate()
	self:registerScriptHandler()

	return true
end

function TableViewEx:registerScriptHandler()
	self._tableView:registerScriptHandler(self._data.scrollViewDidScroll or self.scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self._tableView:registerScriptHandler(self._data.cellSizeForTable or self.cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	self._tableView:registerScriptHandler(self._data.tableCellAtIndex or self.tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	self._tableView:registerScriptHandler(self._data.numberOfCellsInTableView or self.numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self._tableView:registerScriptHandler(self._data.tableCellTouched or self.tableCellTouched, cc.TABLECELL_TOUCHED)
	self._tableView:reloadData()
end

function TableViewEx:scrollViewDidScroll(arg_6_1)
	return
end

function TableViewEx:cellSizeForTable(arg_7_1, arg_7_2)
	return 100, 66
end

function TableViewEx:numberOfCellsInTableView(arg_8_1)
	return 1
end

function TableViewEx:tableCellTouched(arg_9_1)
	return
end

function TableViewEx:tableCellAtIndex(arg_10_1, arg_10_2)
	local var_10_1 = arg_10_1:dequeueCell()

	if not var_10_1 then
		var_10_1 = cc.TableViewCell:new()
	else
		var_10_1:removeAllChildren()
	end

	return var_10_1
end

function TableViewEx:cellAtIndex(arg_11_1)
	return self._tableView:cellAtIndex(arg_11_1)
end

function TableViewEx:removeCellAtIndex(arg_12_1)
	self._tableView:removeCellAtIndex(arg_12_1)
end

function TableViewEx:reloadData()
	self._tableView:reloadData()
end

function TableViewEx:getContentSize()
	return self._tableView:getContentSize()
end

function TableViewEx:getContentOffset()
	return self._tableView:getContentOffset()
end

function TableViewEx:setContentOffset(arg_16_1, arg_16_2)
	return self._tableView:setContentOffset(arg_16_1, arg_16_2)
end

function TableViewEx:getViewSize()
	return self._tableView:getViewSize()
end

function TableViewEx:scrollToCell(arg_18_1, arg_18_2)
	local var_18_0 = self._tableView:cellAtIndex(arg_18_1)
	local var_18_1 = self._tableView:getContentOffset()
	local var_18_2 = cc.size(self._data.cellSizeForTable(self, arg_18_1))

	if self._tableView:getDirection() == cc.SCROLLVIEW_DIRECTION_HORIZONTAL then
		if var_18_1.x < self:getViewSize().width then
			return
		end

		var_18_1.x = -((arg_18_1 - 1) * var_18_2.width)
	else
		if var_18_1.y > 0 then
			return
		end

		arg_18_1 = self._data.numberOfCellsInTableView() - arg_18_1
		var_18_1.y = -((arg_18_1 - 1) * var_18_2.height)
	end

	local var_18_3 = self._tableView:maxContainerOffset()
	local var_18_4 = self._tableView:minContainerOffset()

	var_18_1.x = cc.clampf(var_18_1.y, var_18_4.x, var_18_3.x)
	var_18_1.y = cc.clampf(var_18_1.y, var_18_4.y, var_18_3.y)

	self:setContentOffset(var_18_1, arg_18_2)
end

function TableViewEx:SetBackColor(arg_19_1)
	arg_19_1 = arg_19_1 or cc.c4b(200, 200, 200, 255)

	if self._backColor then
		self._backColor:removeSelf()
	end

	self._backColor = cc.LayerColor:create(arg_19_1)

	self._backColor:setContentSize(self._data.size)
	self:addChild(self._backColor, -1)
end

function TableViewEx:setVerticalFillOrder(arg_20_1)
	if arg_20_1 == cc.TABLEVIEW_FILL_BOTTOMUP or arg_20_1 == cc.TABLEVIEW_FILL_TOPDOWN then
		self._tableView:setVerticalFillOrder(arg_20_1)
	end
end

function TableViewEx:scrollToPercent(arg_21_1, arg_21_2, arg_21_3)
	self._tableView:scrollToPercent(arg_21_1, arg_21_2, arg_21_3)
end

function TableViewEx:updateCellAtIndex(arg_22_1)
	self._tableView:updateCellAtIndex(arg_22_1)
end

function TableViewEx:setViewSize(arg_23_1)
	self._tableView:setViewSize(arg_23_1)
end

return TableViewEx
