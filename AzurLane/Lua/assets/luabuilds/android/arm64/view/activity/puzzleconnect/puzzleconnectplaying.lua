local var_0_0 = class("PuzzleConnectPlaying")
local var_0_1 = {
	7,
	5
}

var_0_0.game_state_puzzle = 1
var_0_0.game_state_connect = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0._ad = findTF(arg_1_0._tf, "ad")

	setActive(arg_1_0._tf, true)

	arg_1_0._gridContent = findTF(arg_1_0._tf, "ad/map")
	arg_1_0._listContent = findTF(arg_1_0._tf, "ad/list/content")
	arg_1_0._dragContent = findTF(arg_1_0._tf, "ad/dragContent")
	arg_1_0._arrowIn = findTF(arg_1_0._tf, "ad/arrow/in")
	arg_1_0._arrowOut = findTF(arg_1_0._tf, "ad/arrow/out")
	arg_1_0.gridTpl = findTF(arg_1_0._tf, "ad/gridTpl")

	setActive(arg_1_0.gridTpl, false)

	arg_1_0.itemTpl = findTF(arg_1_0._tf, "ad/itemTpl")

	setActive(arg_1_0.itemTpl, false)

	arg_1_0._iconTpl = findTF(arg_1_0._tf, "ad/iconTpl")

	setActive(arg_1_0._iconTpl, false)

	arg_1_0._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
	arg_1_0._screenRate = arg_1_0:getScreentScaleRate()
	arg_1_0._grids = {}

	for iter_1_0 = 0, var_0_1[1] * var_0_1[2] - 1 do
		table.insert(arg_1_0._grids, arg_1_0:createGrid(iter_1_0 % var_0_1[1] + 1, math.floor(iter_1_0 / var_0_1[1]) + 1))
	end

	arg_1_0._items = {}
	arg_1_0._moveItem = arg_1_0:createItem(0, 0)

	arg_1_0._moveItem:setContent(arg_1_0._dragContent)
	arg_1_0._moveItem:setActive(false)
	arg_1_0._moveItem:setMoveItem(true)

	arg_1_0._rangeOffset = Vector2(PuzzleConnectConst.item_bound[1] / 2 + PuzzleConnectConst.item_spacing / 2, PuzzleConnectConst.item_bound[2] / 2 + PuzzleConnectConst.item_spacing / 2)
	arg_1_0._boundData = Vector2(PuzzleConnectConst.item_bound[1] + PuzzleConnectConst.item_spacing, PuzzleConnectConst.item_bound[2] + PuzzleConnectConst.item_spacing)

	return
end

function var_0_0.addCallback(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._puzzleCallback = arg_2_1
	arg_2_0._connectCallback = arg_2_2

	return
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:clear()

	arg_3_0._data = arg_3_1
	arg_3_0._state = arg_3_2
	arg_3_0._arrowData = arg_3_1.arrow_in_out
	arg_3_0._mapId = arg_3_1.map
	arg_3_0._itemId = arg_3_1.item
	arg_3_0._lineInOut = arg_3_1.line_in_out
	arg_3_0._mapData = Clone(PuzzleConnectConst.map_data[arg_3_0._mapId])
	arg_3_0._itemData = Clone(arg_3_1.item)
	arg_3_0._gridCount = 0

	local var_3_0 = findTF(arg_3_0._tf, "ad/bg/lineTip/text")
	local var_3_1 = findTF(arg_3_0._tf, "ad/bg/lineTip")

	if arg_3_0._state == var_0_0.game_state_connect then
		setText(var_3_0, i18n("tolovegame_puzzle_line_tip"))

		var_3_1.anchoredPosition = Vector2(84, 454)
	else
		setText(var_3_0, i18n("tolovegame_puzzle_puzzle_tip"))

		var_3_1.anchoredPosition = Vector2(156, 454)
	end

	arg_3_0._arrowIn.anchoredPosition = Vector2((arg_3_0._arrowData[1][2] - 1) * arg_3_0._boundData.x, -(arg_3_0._arrowData[1][1] - 1) * arg_3_0._boundData.y)
	findTF(arg_3_0._arrowIn, "ad").localEulerAngles = Vector3(0, 0, arg_3_0._arrowData[1][3])
	arg_3_0._arrowOut.anchoredPosition = Vector2((arg_3_0._arrowData[2][2] - 1) * arg_3_0._boundData.x, -(arg_3_0._arrowData[2][1] - 1) * arg_3_0._boundData.y)
	findTF(arg_3_0._arrowOut, "ad").localEulerAngles = Vector3(0, 0, arg_3_0._arrowData[2][3])

	arg_3_0:updateGrids()

	if #arg_3_0._itemData > #arg_3_0._items then
		local var_3_2 = #arg_3_0._itemData or #arg_3_0._items

		for iter_3_0 = 1, var_3_2 do
			local var_3_3

			if iter_3_0 > #arg_3_0._items then
				var_3_3 = arg_3_0:createItem()

				table.insert(arg_3_0._items, var_3_3)
			else
				var_3_3 = arg_3_0._items[iter_3_0]
			end

			if iter_3_0 > #arg_3_0._itemData then
				var_3_3:setActive(false)
			else
				var_3_3:setData(arg_3_0._itemData[iter_3_0])
				var_3_3:setActive(true)
			end
		end

		arg_3_0:updateStateUI()

		return
	end
end

function var_0_0.updateGrids(arg_4_0)
	for iter_4_0 = 1, #arg_4_0._grids do
		local var_4_0 = arg_4_0._grids[iter_4_0]:getPoint()

		if arg_4_0._mapData[var_4_0.v][var_4_0.h] and arg_4_0._mapData[var_4_0.v][var_4_0.h] > 0 then
			arg_4_0._gridCount = arg_4_0._gridCount + 1
		end

		arg_4_0._grids[iter_4_0]:setIndex(arg_4_0._mapData[var_4_0.v][var_4_0.h], arg_4_0._state)

		if arg_4_0._lineInOut[1][1] == var_4_0.v and arg_4_0._lineInOut[1][2] == var_4_0.h then
			arg_4_0._grids[iter_4_0]:setStart(true)
		elseif arg_4_0._lineInOut[2][1] == var_4_0.v and arg_4_0._lineInOut[2][2] == var_4_0.h then
			arg_4_0._grids[iter_4_0]:setEnd(true)
		end

		if arg_4_0._grids[iter_4_0]:getStart() then
			if arg_4_0._state == var_0_0.game_state_connect then
				arg_4_0._grids[iter_4_0]:setLine({
					v = arg_4_0._arrowData[1][1],
					h = arg_4_0._arrowData[1][2]
				}, nil)
			end
		else
			arg_4_0._grids[iter_4_0]:clearLine()
		end
	end

	return
end

function var_0_0.updateStateUI(arg_5_0)
	if arg_5_0._state == PuzzleConnectPlaying.game_state_connect then
		setActive(findTF(arg_5_0._ad, "bg/puzzle"), false)
		setActive(findTF(arg_5_0._ad, "bg/connect"), true)
		setActive(findTF(arg_5_0._ad, "list"), false)
		setActive(findTF(arg_5_0._ad, "dragContent"), false)
		setActive(arg_5_0._arrowIn, true)
		setActive(arg_5_0._arrowOut, true)

		arg_5_0._ad.anchoredPosition = Vector2(255, 0)
	elseif arg_5_0._state == PuzzleConnectPlaying.game_state_puzzle then
		setActive(findTF(arg_5_0._ad, "bg/puzzle"), true)
		setActive(findTF(arg_5_0._ad, "bg/connect"), false)
		setActive(findTF(arg_5_0._ad, "list"), true)
		setActive(findTF(arg_5_0._ad, "dragContent"), true)
		setActive(arg_5_0._arrowIn, false)
		setActive(arg_5_0._arrowOut, false)

		arg_5_0._ad.anchoredPosition = Vector2(0, 0)
	end

	return
end

function var_0_0.createItem(arg_6_0)
	local var_6_0 = PuzzleConnectItem.New(tf(instantiate(arg_6_0.itemTpl)), arg_6_0._iconTpl)

	var_6_0:setActive(true)
	var_6_0:setContent(arg_6_0._listContent)

	local var_6_1 = var_6_0:getEventTrigger()

	var_6_1:AddBeginDragFunc(function(arg_7_0, arg_7_1)
		arg_6_0:onDragBeginFunc(var_6_0, arg_7_0, arg_7_1)

		return
	end)
	var_6_1:AddDragEndFunc(function(arg_8_0, arg_8_1)
		arg_6_0:onDragEndFunc(var_6_0, arg_8_0, arg_8_1)

		return
	end)
	var_6_1:AddDragFunc(function(arg_9_0, arg_9_1)
		arg_6_0:onDragFunc(var_6_0, arg_9_0, arg_9_1)

		return
	end)

	return var_6_0
end

function var_0_0.createGrid(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = PuzzleConnectGrid.New(tf(instantiate(arg_10_0.gridTpl)), arg_10_1, arg_10_2, arg_10_0._iconTpl)

	var_10_0:setContent(arg_10_0._gridContent)
	var_10_0:setActive(true)

	local var_10_1 = var_10_0:getEventTrigger()

	var_10_1:AddBeginDragFunc(function(arg_11_0, arg_11_1)
		local var_11_0, var_11_1, var_11_2 = var_10_0:getFillItem()

		if var_11_0 then
			arg_10_0:clearFillItem(var_11_0, var_11_2)
			var_11_0:changeCount(1)
			arg_10_0:onDragBeginFunc(var_11_0, arg_11_0, arg_11_1, var_11_1)
		end

		return
	end)
	var_10_1:AddDragEndFunc(function(arg_12_0, arg_12_1)
		arg_10_0:onDragEndFunc(nil, arg_12_0, arg_12_1)

		return
	end)
	var_10_1:AddDragFunc(function(arg_13_0, arg_13_1)
		arg_10_0:onDragFunc(nil, arg_13_0, arg_13_1)

		return
	end)

	local var_10_2 = var_10_0:getLineTrigger()

	var_10_2:AddPointDownFunc(function()
		arg_10_0:onGridDown(var_10_0)
		arg_10_0:onGridEnter(var_10_0)

		return
	end)
	var_10_2:AddPointEnterFunc(function()
		arg_10_0:onGridEnter(var_10_0)

		return
	end)
	var_10_2:AddPointUpFunc(function()
		arg_10_0:onGridUp(var_10_0)

		return
	end)

	return var_10_0
end

function var_0_0.onGridDown(arg_17_0, arg_17_1)
	arg_17_0._gridPointStart = true

	if arg_17_1:getStart() then
		if arg_17_0._lineGrids and #arg_17_0._lineGrids > 0 then
			for iter_17_0, iter_17_1 in ipairs(arg_17_0._lineGrids) do
				iter_17_1:clearLine()
			end
		end

		arg_17_0._lineGrids = {}

		table.insert(arg_17_0._lineGrids, arg_17_1)
		arg_17_1:setLine({
			v = arg_17_0._arrowData[1][1],
			h = arg_17_0._arrowData[1][2]
		}, nil)
	elseif arg_17_0._lineGrids and #arg_17_0._lineGrids > 0 and table.contains(arg_17_0._lineGrids, arg_17_1) then
		for iter_17_2 = #arg_17_0._lineGrids, 1, -1 do
			if arg_17_0._lineGrids[iter_17_2] ~= arg_17_1 then
				arg_17_0._lineGrids[iter_17_2]:clearLine()
				table.remove(arg_17_0._lineGrids, iter_17_2)
			elseif arg_17_0._lineGrids[iter_17_2] == arg_17_1 then
				arg_17_0._lineGrids[iter_17_2]:clearLine()

				if iter_17_2 > 1 then
					arg_17_1:setLine(arg_17_0._lineGrids[iter_17_2 - 1]:getPoint(), nil)

					break
				end

				if iter_17_2 == 1 then
					arg_17_1:setLine({
						v = arg_17_0._arrowData[1][1],
						h = arg_17_0._arrowData[1][2]
					}, nil)
				end

				break
			end
		end
	end

	return
end

function var_0_0.onGridEnter(arg_18_0, arg_18_1)
	if not arg_18_0._gridPointStart then
		return
	end

	if not arg_18_0._lineGrids or #arg_18_0._lineGrids == 0 then
		return
	end

	if table.contains(arg_18_0._lineGrids, arg_18_1) then
		if arg_18_0._lineGrids[#arg_18_0._lineGrids] ~= arg_18_1 then
			for iter_18_0 = #arg_18_0._lineGrids, 1, -1 do
				if arg_18_0._lineGrids[iter_18_0] ~= arg_18_1 then
					arg_18_0._lineGrids[iter_18_0]:clearLine()
					table.remove(arg_18_0._lineGrids, iter_18_0)
				elseif arg_18_0._lineGrids[iter_18_0] == arg_18_1 then
					arg_18_0._lineGrids[iter_18_0]:clearLine()

					if iter_18_0 > 1 then
						arg_18_1:setLine(arg_18_0._lineGrids[iter_18_0 - 1]:getPoint(), nil)

						break
					end

					if iter_18_0 == 1 then
						arg_18_1:setLine({
							v = arg_18_0._arrowData[1][1],
							h = arg_18_0._arrowData[1][2]
						}, nil)
					end

					break
				end
			end
		end

		return
	end

	if not arg_18_0:checkGridLineAble(arg_18_1, arg_18_0._lineGrids[#arg_18_0._lineGrids]) then
		return
	end

	table.insert(arg_18_0._lineGrids, arg_18_1)

	if #arg_18_0._lineGrids > 1 then
		arg_18_0._lineGrids[#arg_18_0._lineGrids - 1]:setLine(nil, arg_18_0._lineGrids[#arg_18_0._lineGrids]:getPoint())
		arg_18_0._lineGrids[#arg_18_0._lineGrids]:setLine(arg_18_0._lineGrids[#arg_18_0._lineGrids - 1]:getPoint(), nil)
	end

	return
end

function var_0_0.onGridUp(arg_19_0, arg_19_1)
	arg_19_0._gridPointStart = false

	if not arg_19_0._lineGrids then
		return
	end

	if arg_19_0:checkLineComplete() and arg_19_0._connectCallback then
		arg_19_0._connectCallback()
	end

	if #arg_19_0._lineGrids == arg_19_0._gridCount then
		for iter_19_0 = 1, #arg_19_0._grids do
			if arg_19_0._grids[iter_19_0]:getStart() then
				arg_19_0._grids[iter_19_0]:clearLine()

				if arg_19_0._state == var_0_0.game_state_connect then
					arg_19_0._grids[iter_19_0]:setLine({
						v = arg_19_0._arrowData[1][1],
						h = arg_19_0._arrowData[1][2]
					}, nil)
				end
			else
				arg_19_0._grids[iter_19_0]:clearLine()
			end
		end

		arg_19_0._lineGrids = {}
	end

	return
end

function var_0_0.checkGridLineAble(arg_20_0, arg_20_1, arg_20_2)
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

function var_0_0.checkLineComplete(arg_21_0)
	if arg_21_0._lineGrids and #arg_21_0._lineGrids == arg_21_0._gridCount and arg_21_0._lineGrids[1]:getStart() and arg_21_0._lineGrids[#arg_21_0._lineGrids]:getEnd() then
		return true
	end

	return false
end

function var_0_0.clearFillItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:getId()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._grids) do
		local var_22_1, var_22_2, var_22_3 = iter_22_1:getFillItem()

		if var_22_1 and var_22_0 == var_22_1:getId() and arg_22_2 == var_22_3 then
			iter_22_1:clearFillItem()
		end
	end

	return
end

function var_0_0.onDragBeginFunc(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_0._state ~= var_0_0.game_state_puzzle then
		return
	end

	if not arg_23_1 then
		return
	end

	if arg_23_1:getCount() == 0 then
		return
	end

	if arg_23_0._dragItem then
		return
	end

	arg_23_0._dragItem = arg_23_1

	arg_23_0._dragItem:setDraging(true)

	local var_23_0
	local var_23_1

	if not arg_23_4 then
		var_23_0 = arg_23_0._uiCamera:ScreenToWorldPoint(arg_23_3.position)
		var_23_1 = arg_23_3.position
	else
		var_23_0 = arg_23_0._dragItem:getItemIconWorld(arg_23_4)
		var_23_1 = arg_23_0._uiCamera:WorldToScreenPoint(var_23_0)
	end

	local var_23_2 = arg_23_0._dragContent:InverseTransformPoint(var_23_0)
	local var_23_3 = arg_23_0._listContent:InverseTransformPoint(var_23_0)
	local var_23_4 = arg_23_1:getPosition()

	arg_23_0._dragItemStartPosition = var_23_1
	arg_23_0._dragItemContentPosition = var_23_2
	arg_23_0._dragItemOffsetPosition = Vector2(var_23_3.x - var_23_4.x, var_23_3.y - var_23_4.y)

	arg_23_0._moveItem:setData(arg_23_0._dragItem:getData())
	arg_23_0._moveItem:setActive(true)

	arg_23_0._movePosition = Vector2(0, 0)

	arg_23_0:updateMovePosition()

	return
end

function var_0_0.getFillId(arg_24_0)
	arg_24_0._fillId = arg_24_0._fillId or 1
	arg_24_0._fillId = arg_24_0._fillId + 1

	return arg_24_0._fillId
end

function var_0_0.onDragEndFunc(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0._dragItem then
		if arg_25_0._fillAll then
			arg_25_0._dragItem:changeCount(-1)

			local var_25_0 = arg_25_0:getFillId()

			for iter_25_0, iter_25_1 in ipairs(arg_25_0._prepareGrids) do
				iter_25_1:setFillItem(arg_25_0._dragItem, iter_25_0, var_25_0)
			end
		end

		arg_25_0._dragItem:setDraging(false)

		arg_25_0._dragItem = nil

		arg_25_0._moveItem:setActive(false)
		arg_25_0:clearGridPrepare()
	end

	local var_25_1 = true

	for iter_25_2, iter_25_3 in ipairs(arg_25_0._grids) do
		if var_25_1 and iter_25_3:getMapIndex() > 0 and not iter_25_3:getComplete() then
			var_25_1 = false
		end
	end

	if var_25_1 and arg_25_0._puzzleCallback then
		arg_25_0._puzzleCallback()
	end

	return
end

function var_0_0.onDragFunc(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_0._state ~= var_0_0.game_state_puzzle then
		return
	end

	if not arg_26_0._dragItem then
		return
	end

	arg_26_0:updateMovePosition(arg_26_3.position)
	arg_26_0:checkMoveItemPuzzle()

	return
end

function var_0_0.checkMoveItemPuzzle(arg_27_0)
	arg_27_0._gridOffsetX = arg_27_0._gridOffsetX or PuzzleConnectConst.item_bound[1] / 2

	local var_27_0 = arg_27_0._moveItem:getPuzzleWorldPos()
	local var_27_1 = arg_27_0._moveItem:getColor()

	arg_27_0:clearGridPrepare()

	local var_27_2 = 0
	local var_27_3 = 0

	arg_27_0._prepareGrids = {}

	for iter_27_0 = 1, #var_27_0 do
		local var_27_4 = arg_27_0._gridContent:InverseTransformPoint(var_27_0[iter_27_0])

		for iter_27_1, iter_27_2 in ipairs(arg_27_0._grids) do
			if not iter_27_2:getPrepare() then
				local var_27_5 = iter_27_2:getPosition()
				local var_27_6 = Vector2(math.abs(var_27_4.x + arg_27_0._gridOffsetX - var_27_5.x), math.abs(var_27_4.y - var_27_5.y))
				local var_27_7 = false

				if var_27_6.x <= arg_27_0._rangeOffset.x and var_27_6.y <= arg_27_0._rangeOffset.y then
					var_27_7 = true
				end

				if var_27_7 then
					if not iter_27_2:getFill() then
						if iter_27_2:getUnlock() then
							var_27_2 = var_27_2 + 1
						end

						var_27_3 = var_27_3 + 1
					end

					if not iter_27_2:getFill() then
						iter_27_2:setPrepare(var_27_1)
						table.insert(arg_27_0._prepareGrids, iter_27_2)
					end

					break
				end
			end
		end
	end

	arg_27_0._fillSuccess = var_27_2 == #var_27_0
	arg_27_0._fillAll = var_27_3 == #var_27_0

	for iter_27_3 = 1, #arg_27_0._prepareGrids do
		if arg_27_0._fillSuccess then
			arg_27_0._prepareGrids[iter_27_3]:setPrepareAlpha(PuzzleConnectConst.color_green)
		else
			arg_27_0._prepareGrids[iter_27_3]:setPrepareAlpha(PuzzleConnectConst.color_red)
		end
	end

	return
end

function var_0_0.clearGridPrepare(arg_28_0)
	arg_28_0._prepareGrids = {}
	arg_28_0._fillSuccess = false
	arg_28_0._fillAll = false

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._grids) do
		iter_28_1:clearPrepare()
	end

	return
end

function var_0_0.updateMovePosition(arg_29_0, arg_29_1)
	if arg_29_1 then
		arg_29_0._movePosition.x = -arg_29_0._dragItemOffsetPosition.x + arg_29_0._dragItemContentPosition.x + (arg_29_1.x - arg_29_0._dragItemStartPosition.x) * arg_29_0._screenRate.x
		arg_29_0._movePosition.y = -arg_29_0._dragItemOffsetPosition.y + arg_29_0._dragItemContentPosition.y + (arg_29_1.y - arg_29_0._dragItemStartPosition.y) * arg_29_0._screenRate.y
	else
		arg_29_0._movePosition.x = arg_29_0._dragItemContentPosition.x
		arg_29_0._movePosition.y = arg_29_0._dragItemContentPosition.y
	end

	arg_29_0._moveItem:setPosition(arg_29_0._movePosition)

	return
end

function var_0_0.reset(arg_30_0)
	if arg_30_0._state == PuzzleConnectPlaying.game_state_puzzle then
		arg_30_0:setData(arg_30_0._data, arg_30_0._state)
	else
		for iter_30_0 = 1, #arg_30_0._grids do
			if arg_30_0._grids[iter_30_0]:getStart() then
				arg_30_0._grids[iter_30_0]:clearLine()

				if arg_30_0._state == var_0_0.game_state_connect then
					arg_30_0._grids[iter_30_0]:setLine({
						v = arg_30_0._arrowData[1][1],
						h = arg_30_0._arrowData[1][2]
					}, nil)
				end
			else
				arg_30_0._grids[iter_30_0]:clearLine()
			end
		end

		arg_30_0._lineGrids = {}
	end

	return
end

function var_0_0.getPointStr(arg_31_0, arg_31_1)
	return "(" .. arg_31_1.x .. ":" .. arg_31_1.y .. ")"
end

function var_0_0.getScreentScaleRate(arg_32_0)
	local var_32_0 = tf(GameObject.Find("UICamera/Canvas"))

	return Vector2(var_32_0.sizeDelta.x / UnityEngine.Screen.width, var_32_0.sizeDelta.y / UnityEngine.Screen.height)
end

function var_0_0.clear(arg_33_0)
	arg_33_0._dragGrid = nil

	if arg_33_0._prepareGrids then
		arg_33_0._prepareGrids = {}
	end

	if arg_33_0._moveItem then
		arg_33_0._moveItem:setActive(false)
	end

	if arg_33_0._dragItem then
		arg_33_0._dragItem:setDraging(false)

		arg_33_0._dragItem = nil
	end

	return
end

function var_0_0.dispose(arg_34_0)
	return
end

return var_0_0
