local PuzzleConnectPlaying = class("PuzzleConnectPlaying")
local var_0_1 = {
	7,
	5
}

PuzzleConnectPlaying.game_state_puzzle = 1
PuzzleConnectPlaying.game_state_connect = 2

function PuzzleConnectPlaying:Ctor(arg_1_1)
	self._tf = arg_1_1
	self._ad = findTF(self._tf, "ad")

	setActive(self._tf, true)

	self._gridContent = findTF(self._tf, "ad/map")
	self._listContent = findTF(self._tf, "ad/list/content")
	self._dragContent = findTF(self._tf, "ad/dragContent")
	self._arrowIn = findTF(self._tf, "ad/arrow/in")
	self._arrowOut = findTF(self._tf, "ad/arrow/out")
	self.gridTpl = findTF(self._tf, "ad/gridTpl")

	setActive(self.gridTpl, false)

	self.itemTpl = findTF(self._tf, "ad/itemTpl")

	setActive(self.itemTpl, false)

	self._iconTpl = findTF(self._tf, "ad/iconTpl")

	setActive(self._iconTpl, false)

	self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
	self._screenRate = self:getScreentScaleRate()
	self._grids = {}

	for iter_1_0 = 0, var_0_1[1] * var_0_1[2] - 1 do
		table.insert(self._grids, self:createGrid(iter_1_0 % var_0_1[1] + 1, math.floor(iter_1_0 / var_0_1[1]) + 1))
	end

	self._items = {}
	self._moveItem = self:createItem(0, 0)

	self._moveItem:setContent(self._dragContent)
	self._moveItem:setActive(false)
	self._moveItem:setMoveItem(true)

	self._rangeOffset = Vector2(PuzzleConnectConst.item_bound[1] / 2 + PuzzleConnectConst.item_spacing / 2, PuzzleConnectConst.item_bound[2] / 2 + PuzzleConnectConst.item_spacing / 2)
	self._boundData = Vector2(PuzzleConnectConst.item_bound[1] + PuzzleConnectConst.item_spacing, PuzzleConnectConst.item_bound[2] + PuzzleConnectConst.item_spacing)

	return
end

function PuzzleConnectPlaying:addCallback(arg_2_1, arg_2_2)
	self._puzzleCallback = arg_2_1
	self._connectCallback = arg_2_2

	return
end

function PuzzleConnectPlaying:setData(arg_3_1, arg_3_2)
	self:clear()

	self._data = arg_3_1
	self._state = arg_3_2
	self._arrowData = arg_3_1.arrow_in_out
	self._mapId = arg_3_1.map
	self._itemId = arg_3_1.item
	self._lineInOut = arg_3_1.line_in_out
	self._mapData = Clone(PuzzleConnectConst.map_data[self._mapId])
	self._itemData = Clone(arg_3_1.item)
	self._gridCount = 0

	local var_3_0 = findTF(self._tf, "ad/bg/lineTip/text")
	local var_3_1 = findTF(self._tf, "ad/bg/lineTip")

	if self._state == PuzzleConnectPlaying.game_state_connect then
		setText(var_3_0, i18n("tolovegame_puzzle_line_tip"))

		var_3_1.anchoredPosition = Vector2(84, 454)
	else
		setText(var_3_0, i18n("tolovegame_puzzle_puzzle_tip"))

		var_3_1.anchoredPosition = Vector2(156, 454)
	end

	self._arrowIn.anchoredPosition = Vector2((self._arrowData[1][2] - 1) * self._boundData.x, -(self._arrowData[1][1] - 1) * self._boundData.y)
	findTF(self._arrowIn, "ad").localEulerAngles = Vector3(0, 0, self._arrowData[1][3])
	self._arrowOut.anchoredPosition = Vector2((self._arrowData[2][2] - 1) * self._boundData.x, -(self._arrowData[2][1] - 1) * self._boundData.y)
	findTF(self._arrowOut, "ad").localEulerAngles = Vector3(0, 0, self._arrowData[2][3])

	self:updateGrids()

	for iter_3_0 = 1, (#self._itemData > #self._items or nil) and (#self._itemData or #self._items) do
		local var_3_2

		if iter_3_0 > #self._items then
			var_3_2 = self:createItem()

			table.insert(self._items, var_3_2)
		else
			var_3_2 = self._items[iter_3_0]
		end

		if iter_3_0 > #self._itemData then
			var_3_2:setActive(false)
		else
			var_3_2:setData(self._itemData[iter_3_0])
			var_3_2:setActive(true)
		end
	end

	self:updateStateUI()

	return
end

function PuzzleConnectPlaying:updateGrids()
	for iter_4_0 = 1, #self._grids do
		local var_4_0 = self._grids[iter_4_0]:getPoint()

		if self._mapData[var_4_0.v][var_4_0.h] and self._mapData[var_4_0.v][var_4_0.h] > 0 then
			self._gridCount = self._gridCount + 1
		end

		self._grids[iter_4_0]:setIndex(self._mapData[var_4_0.v][var_4_0.h], self._state)

		if self._lineInOut[1][1] == var_4_0.v and self._lineInOut[1][2] == var_4_0.h then
			self._grids[iter_4_0]:setStart(true)
		elseif self._lineInOut[2][1] == var_4_0.v and self._lineInOut[2][2] == var_4_0.h then
			self._grids[iter_4_0]:setEnd(true)
		end

		if self._grids[iter_4_0]:getStart() then
			if self._state == PuzzleConnectPlaying.game_state_connect then
				self._grids[iter_4_0]:setLine({
					v = self._arrowData[1][1],
					h = self._arrowData[1][2]
				}, nil)
			end
		else
			self._grids[iter_4_0]:clearLine()
		end
	end

	return
end

function PuzzleConnectPlaying:updateStateUI()
	if self._state == PuzzleConnectPlaying.game_state_connect then
		setActive(findTF(self._ad, "bg/puzzle"), false)
		setActive(findTF(self._ad, "bg/connect"), true)
		setActive(findTF(self._ad, "list"), false)
		setActive(findTF(self._ad, "dragContent"), false)
		setActive(self._arrowIn, true)
		setActive(self._arrowOut, true)

		self._ad.anchoredPosition = Vector2(255, 0)
	elseif self._state == PuzzleConnectPlaying.game_state_puzzle then
		setActive(findTF(self._ad, "bg/puzzle"), true)
		setActive(findTF(self._ad, "bg/connect"), false)
		setActive(findTF(self._ad, "list"), true)
		setActive(findTF(self._ad, "dragContent"), true)
		setActive(self._arrowIn, false)
		setActive(self._arrowOut, false)

		self._ad.anchoredPosition = Vector2(0, 0)
	end

	return
end

function PuzzleConnectPlaying:createItem()
	local var_6_0 = PuzzleConnectItem.New(tf(instantiate(self.itemTpl)), self._iconTpl)

	var_6_0:setActive(true)
	var_6_0:setContent(self._listContent)

	local var_6_1 = var_6_0:getEventTrigger()

	var_6_1:AddBeginDragFunc(function(arg_7_0, arg_7_1)
		self:onDragBeginFunc(var_6_0, arg_7_0, arg_7_1)

		return
	end)
	var_6_1:AddDragEndFunc(function(arg_8_0, arg_8_1)
		self:onDragEndFunc(var_6_0, arg_8_0, arg_8_1)

		return
	end)
	var_6_1:AddDragFunc(function(arg_9_0, arg_9_1)
		self:onDragFunc(var_6_0, arg_9_0, arg_9_1)

		return
	end)

	return var_6_0
end

function PuzzleConnectPlaying:createGrid(arg_10_1, arg_10_2)
	local var_10_0 = PuzzleConnectGrid.New(tf(instantiate(self.gridTpl)), arg_10_1, arg_10_2, self._iconTpl)

	var_10_0:setContent(self._gridContent)
	var_10_0:setActive(true)

	local var_10_1 = var_10_0:getEventTrigger()

	var_10_1:AddBeginDragFunc(function(arg_11_0, arg_11_1)
		local var_11_0, var_11_1, var_11_2 = var_10_0:getFillItem()

		if var_11_0 then
			self:clearFillItem(var_11_0, var_11_2)
			var_11_0:changeCount(1)
			self:onDragBeginFunc(var_11_0, arg_11_0, arg_11_1, var_11_1)
		end

		return
	end)
	var_10_1:AddDragEndFunc(function(arg_12_0, arg_12_1)
		self:onDragEndFunc(nil, arg_12_0, arg_12_1)

		return
	end)
	var_10_1:AddDragFunc(function(arg_13_0, arg_13_1)
		self:onDragFunc(nil, arg_13_0, arg_13_1)

		return
	end)

	local var_10_2 = var_10_0:getLineTrigger()

	var_10_2:AddPointDownFunc(function()
		self:onGridDown(var_10_0)
		self:onGridEnter(var_10_0)

		return
	end)
	var_10_2:AddPointEnterFunc(function()
		self:onGridEnter(var_10_0)

		return
	end)
	var_10_2:AddPointUpFunc(function()
		self:onGridUp(var_10_0)

		return
	end)

	return var_10_0
end

function PuzzleConnectPlaying:onGridDown(arg_17_1)
	self._gridPointStart = true

	if arg_17_1:getStart() then
		if self._lineGrids and #self._lineGrids > 0 then
			for iter_17_0, iter_17_1 in ipairs(self._lineGrids) do
				iter_17_1:clearLine()
			end
		end

		self._lineGrids = {}

		table.insert(self._lineGrids, arg_17_1)
		arg_17_1:setLine({
			v = self._arrowData[1][1],
			h = self._arrowData[1][2]
		}, nil)
	elseif self._lineGrids and #self._lineGrids > 0 and table.contains(self._lineGrids, arg_17_1) then
		for iter_17_2 = #self._lineGrids, 1, -1 do
			if self._lineGrids[iter_17_2] ~= arg_17_1 then
				self._lineGrids[iter_17_2]:clearLine()
				table.remove(self._lineGrids, iter_17_2)
			elseif self._lineGrids[iter_17_2] == arg_17_1 then
				self._lineGrids[iter_17_2]:clearLine()

				if iter_17_2 > 1 then
					arg_17_1:setLine(self._lineGrids[iter_17_2 - 1]:getPoint(), nil)

					break
				end

				if iter_17_2 == 1 then
					arg_17_1:setLine({
						v = self._arrowData[1][1],
						h = self._arrowData[1][2]
					}, nil)
				end

				break
			end
		end
	end

	return
end

function PuzzleConnectPlaying:onGridEnter(arg_18_1)
	if not self._gridPointStart then
		return
	end

	if not self._lineGrids or #self._lineGrids == 0 then
		return
	end

	if table.contains(self._lineGrids, arg_18_1) then
		if self._lineGrids[#self._lineGrids] ~= arg_18_1 then
			for iter_18_0 = #self._lineGrids, 1, -1 do
				if self._lineGrids[iter_18_0] ~= arg_18_1 then
					self._lineGrids[iter_18_0]:clearLine()
					table.remove(self._lineGrids, iter_18_0)
				elseif self._lineGrids[iter_18_0] == arg_18_1 then
					self._lineGrids[iter_18_0]:clearLine()

					if iter_18_0 > 1 then
						arg_18_1:setLine(self._lineGrids[iter_18_0 - 1]:getPoint(), nil)

						break
					end

					if iter_18_0 == 1 then
						arg_18_1:setLine({
							v = self._arrowData[1][1],
							h = self._arrowData[1][2]
						}, nil)
					end

					break
				end
			end
		end

		return
	end

	if not self:checkGridLineAble(arg_18_1, self._lineGrids[#self._lineGrids]) then
		return
	end

	table.insert(self._lineGrids, arg_18_1)

	if #self._lineGrids > 1 then
		self._lineGrids[#self._lineGrids - 1]:setLine(nil, self._lineGrids[#self._lineGrids]:getPoint())
		self._lineGrids[#self._lineGrids]:setLine(self._lineGrids[#self._lineGrids - 1]:getPoint(), nil)
	end

	return
end

function PuzzleConnectPlaying:onGridUp(arg_19_1)
	self._gridPointStart = false

	if not self._lineGrids then
		return
	end

	if self:checkLineComplete() and self._connectCallback then
		self._connectCallback()
	end

	if #self._lineGrids == self._gridCount then
		for iter_19_0 = 1, #self._grids do
			if self._grids[iter_19_0]:getStart() then
				self._grids[iter_19_0]:clearLine()

				if self._state == PuzzleConnectPlaying.game_state_connect then
					self._grids[iter_19_0]:setLine({
						v = self._arrowData[1][1],
						h = self._arrowData[1][2]
					}, nil)
				end
			else
				self._grids[iter_19_0]:clearLine()
			end
		end

		self._lineGrids = {}
	end

	return
end

function PuzzleConnectPlaying:checkGridLineAble(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:getPoint()
	local var_20_1 = arg_20_2:getPoint()

	if math.abs(var_20_0.h - var_20_1.h) > 1 then
		return false
	end

	if math.abs(var_20_0.v - var_20_1.v) > 1 then
		return false
	end

	return true
end

function PuzzleConnectPlaying:checkLineComplete()
	if self._lineGrids and #self._lineGrids == self._gridCount and self._lineGrids[1]:getStart() and self._lineGrids[#self._lineGrids]:getEnd() then
		return true
	end

	return false
end

function PuzzleConnectPlaying:clearFillItem(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:getId()

	for iter_22_0, iter_22_1 in ipairs(self._grids) do
		local var_22_1, var_22_2, var_22_3 = iter_22_1:getFillItem()

		if var_22_1 and var_22_0 == var_22_1:getId() and arg_22_2 == var_22_3 then
			iter_22_1:clearFillItem()
		end
	end

	return
end

function PuzzleConnectPlaying:onDragBeginFunc(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if self._state ~= PuzzleConnectPlaying.game_state_puzzle then
		return
	end

	if not arg_23_1 then
		return
	end

	if arg_23_1:getCount() == 0 then
		return
	end

	if self._dragItem then
		return
	end

	self._dragItem = arg_23_1

	self._dragItem:setDraging(true)

	local var_23_0
	local var_23_1

	if not arg_23_4 then
		var_23_0 = self._uiCamera:ScreenToWorldPoint(arg_23_3.position)
		var_23_1 = arg_23_3.position
	else
		var_23_0 = self._dragItem:getItemIconWorld(arg_23_4)
		var_23_1 = self._uiCamera:WorldToScreenPoint(var_23_0)
	end

	local var_23_2 = self._dragContent:InverseTransformPoint(var_23_0)
	local var_23_3 = self._listContent:InverseTransformPoint(var_23_0)
	local var_23_4 = arg_23_1:getPosition()

	self._dragItemStartPosition = var_23_1
	self._dragItemContentPosition = var_23_2
	self._dragItemOffsetPosition = Vector2(var_23_3.x - var_23_4.x, var_23_3.y - var_23_4.y)

	self._moveItem:setData(self._dragItem:getData())
	self._moveItem:setActive(true)

	self._movePosition = Vector2(0, 0)

	self:updateMovePosition()

	return
end

function PuzzleConnectPlaying:getFillId()
	self._fillId = self._fillId or 1
	self._fillId = self._fillId + 1

	return self._fillId
end

function PuzzleConnectPlaying:onDragEndFunc(arg_25_1, arg_25_2, arg_25_3)
	if self._dragItem then
		if self._fillAll then
			self._dragItem:changeCount(-1)

			local var_25_0 = self:getFillId()

			for iter_25_0, iter_25_1 in ipairs(self._prepareGrids) do
				iter_25_1:setFillItem(self._dragItem, iter_25_0, var_25_0)
			end
		end

		self._dragItem:setDraging(false)

		self._dragItem = nil

		self._moveItem:setActive(false)
		self:clearGridPrepare()
	end

	local var_25_1 = true

	for iter_25_2, iter_25_3 in ipairs(self._grids) do
		if var_25_1 and iter_25_3:getMapIndex() > 0 and not iter_25_3:getComplete() then
			var_25_1 = false
		end
	end

	if var_25_1 and self._puzzleCallback then
		self._puzzleCallback()
	end

	return
end

function PuzzleConnectPlaying:onDragFunc(arg_26_1, arg_26_2, arg_26_3)
	if self._state ~= PuzzleConnectPlaying.game_state_puzzle then
		return
	end

	if not self._dragItem then
		return
	end

	self:updateMovePosition(arg_26_3.position)
	self:checkMoveItemPuzzle()

	return
end

function PuzzleConnectPlaying:checkMoveItemPuzzle()
	self._gridOffsetX = self._gridOffsetX or PuzzleConnectConst.item_bound[1] / 2

	local var_27_0 = self._moveItem:getPuzzleWorldPos()
	local var_27_1 = self._moveItem:getColor()

	self:clearGridPrepare()

	local var_27_2 = 0
	local var_27_3 = 0

	self._prepareGrids = {}

	for iter_27_0 = 1, #var_27_0 do
		local var_27_4 = self._gridContent:InverseTransformPoint(var_27_0[iter_27_0])

		for iter_27_1, iter_27_2 in ipairs(self._grids) do
			if not iter_27_2:getPrepare() then
				local var_27_5 = iter_27_2:getPosition()
				local var_27_6 = Vector2(math.abs(var_27_4.x + self._gridOffsetX - var_27_5.x), math.abs(var_27_4.y - var_27_5.y))

				if var_27_6.x <= self._rangeOffset.x and var_27_6.y <= self._rangeOffset.y then
					if not iter_27_2:getFill() then
						if iter_27_2:getUnlock() then
							var_27_2 = var_27_2 + 1
						end

						var_27_3 = var_27_3 + 1
					end

					if not iter_27_2:getFill() then
						iter_27_2:setPrepare(var_27_1)
						table.insert(self._prepareGrids, iter_27_2)
					end

					break
				end
			end
		end
	end

	self._fillSuccess = var_27_2 == #var_27_0
	self._fillAll = var_27_3 == #var_27_0

	for iter_27_3 = 1, #self._prepareGrids do
		if self._fillSuccess then
			self._prepareGrids[iter_27_3]:setPrepareAlpha(PuzzleConnectConst.color_green)
		else
			self._prepareGrids[iter_27_3]:setPrepareAlpha(PuzzleConnectConst.color_red)
		end
	end

	return
end

function PuzzleConnectPlaying:clearGridPrepare()
	self._prepareGrids = {}
	self._fillSuccess = false
	self._fillAll = false

	for iter_28_0, iter_28_1 in ipairs(self._grids) do
		iter_28_1:clearPrepare()
	end

	return
end

function PuzzleConnectPlaying:updateMovePosition(arg_29_1)
	if arg_29_1 then
		self._movePosition.x = -self._dragItemOffsetPosition.x + self._dragItemContentPosition.x + (arg_29_1.x - self._dragItemStartPosition.x) * self._screenRate.x
		self._movePosition.y = -self._dragItemOffsetPosition.y + self._dragItemContentPosition.y + (arg_29_1.y - self._dragItemStartPosition.y) * self._screenRate.y
	else
		self._movePosition.x = self._dragItemContentPosition.x
		self._movePosition.y = self._dragItemContentPosition.y
	end

	self._moveItem:setPosition(self._movePosition)

	return
end

function PuzzleConnectPlaying:reset()
	if self._state == PuzzleConnectPlaying.game_state_puzzle then
		self:setData(self._data, self._state)
	else
		for iter_30_0 = 1, #self._grids do
			if self._grids[iter_30_0]:getStart() then
				self._grids[iter_30_0]:clearLine()

				if self._state == PuzzleConnectPlaying.game_state_connect then
					self._grids[iter_30_0]:setLine({
						v = self._arrowData[1][1],
						h = self._arrowData[1][2]
					}, nil)
				end
			else
				self._grids[iter_30_0]:clearLine()
			end
		end

		self._lineGrids = {}
	end

	return
end

function PuzzleConnectPlaying:getPointStr(arg_31_1)
	return "(" .. arg_31_1.x .. ":" .. arg_31_1.y .. ")"
end

function PuzzleConnectPlaying:getScreentScaleRate()
	local var_32_0 = tf(GameObject.Find("UICamera/Canvas"))

	return Vector2(var_32_0.sizeDelta.x / UnityEngine.Screen.width, var_32_0.sizeDelta.y / UnityEngine.Screen.height)
end

function PuzzleConnectPlaying:clear()
	self._dragGrid = nil

	if self._prepareGrids then
		self._prepareGrids = {}
	end

	if self._moveItem then
		self._moveItem:setActive(false)
	end

	if self._dragItem then
		self._dragItem:setDraging(false)

		self._dragItem = nil
	end

	return
end

function PuzzleConnectPlaying:dispose()
	return
end

return PuzzleConnectPlaying
