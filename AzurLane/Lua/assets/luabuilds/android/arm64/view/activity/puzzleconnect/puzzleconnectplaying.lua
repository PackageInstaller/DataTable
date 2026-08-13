class = var_0_10000

local var_0_0 = var_0_10000("PuzzleConnectPlaying")
local var_0_1 = {
	7,
	5
}
local var_0_2 = {
	2,
	5
}

var_0_0.game_state_puzzle = 1
var_0_0.game_state_connect = 2

local var_0_3 = 7

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	findTF = var_1_10002
	arg_1_0._ad = var_1_10002(arg_1_0._tf, "ad")
	setActive = var_2

	var_2(arg_1_0._tf, true)

	findTF = var_2
	arg_1_0._gridContent = var_2(arg_1_0._tf, "ad/map")
	findTF = var_2
	arg_1_0._listContent = var_2(arg_1_0._tf, "ad/list/content")
	findTF = var_2
	arg_1_0._dragContent = var_2(arg_1_0._tf, "ad/dragContent")
	findTF = var_2
	arg_1_0._arrowIn = var_2(arg_1_0._tf, "ad/arrow/in")
	findTF = var_2
	arg_1_0._arrowOut = var_2(arg_1_0._tf, "ad/arrow/out")
	findTF = var_2
	arg_1_0.gridTpl = var_2(arg_1_0._tf, "ad/gridTpl")
	setActive = var_2

	var_2(arg_1_0.gridTpl, false)

	findTF = var_2
	arg_1_0.itemTpl = var_2(arg_1_0._tf, "ad/itemTpl")
	setActive = var_2

	var_2(arg_1_0.itemTpl, false)

	findTF = var_2
	arg_1_0._iconTpl = var_2(arg_1_0._tf, "ad/iconTpl")
	setActive = var_2

	var_2(arg_1_0._iconTpl, false)

	GameObject = var_2

	local var_1_0 = var_2.Find("UICamera")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Camera = var_1_10007
	arg_1_0._uiCamera = var_1_1(var_1_0, var_5(var_1_10007))
	arg_1_0._screenRate = arg_1_0:getScreentScaleRate()
	arg_1_0._grids = {}

	local var_1_2 = var_0_1[1] * var_0_1[2]
	local var_1_3 = var_0_1[1]

	for iter_1_0 = 0, var_1_2 - 1 do
		local var_1_4 = iter_1_0 % var_1_3 + 1

		math = var_1_10009
		var_1_10009 = var_1_10009.floor(iter_1_0 / var_1_3) + 1
		table = var_1_10010

		var_1_10010.insert(arg_1_0._grids, arg_1_0:createGrid(var_1_4, var_1_10009))
	end

	arg_1_0._items = {}
	arg_1_0._moveItem = arg_1_0:createItem(0, 0)

	local var_1_5 = arg_1_0._moveItem

	var_4.setContent(var_1_5, arg_1_0._dragContent)

	local var_1_6 = arg_1_0._moveItem

	var_4.setActive(var_1_6, false)

	local var_1_7 = arg_1_0._moveItem

	var_4.setMoveItem(var_1_7, true)

	Vector2 = var_4
	PuzzleConnectConst = var_1_7

	local var_1_8 = var_1_7.item_bound[1] / 2

	PuzzleConnectConst = var_7

	local var_1_9 = var_1_8 + var_7.item_spacing / 2

	PuzzleConnectConst = var_7

	local var_1_10 = var_7.item_bound[2] / 2

	PuzzleConnectConst = var_8
	arg_1_0._rangeOffset = var_4(var_1_9, var_1_10 + var_8.item_spacing / 2)
	Vector2 = var_4
	PuzzleConnectConst = var_1_9

	local var_1_11 = var_1_9.item_bound[1]

	PuzzleConnectConst = var_7

	local var_1_12 = var_1_11 + var_7.item_spacing

	PuzzleConnectConst = var_7

	local var_1_13 = var_7.item_bound[2]

	PuzzleConnectConst = var_8
	arg_1_0._boundData = var_4(var_1_12, var_1_13 + var_8.item_spacing)

	return
end

function var_0_0.addCallback(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._puzzleCallback = arg_2_1
	arg_2_0._connectCallback = arg_2_2

	return
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0

	arg_3_0.clear(var_3_0)

	arg_3_0._data = arg_3_1
	arg_3_0._state = arg_3_2
	arg_3_0._arrowData = arg_3_1.arrow_in_out
	arg_3_0._mapId = arg_3_1.map
	arg_3_0._itemId = arg_3_1.item
	arg_3_0._lineInOut = arg_3_1.line_in_out
	Clone = var_3
	PuzzleConnectConst = var_3_0
	arg_3_0._mapData = var_3(var_3_0.map_data[arg_3_0._mapId])
	Clone = var_3
	arg_3_0._itemData = var_3(arg_3_1.item)
	arg_3_0._gridCount = 0
	findTF = var_3

	local var_3_1 = var_3(arg_3_0._tf, "ad/bg/lineTip/text")

	findTF = var_1_10004

	local var_3_2 = var_1_10004(arg_3_0._tf, "ad/bg/lineTip")

	if arg_3_0._state == var_0_0.game_state_connect then
		setText = var_5

		local var_3_3 = var_3_1

		i18n = var_1_10008

		var_5(var_3_3, var_1_10008("tolovegame_puzzle_line_tip"))

		Vector2 = var_5
		var_3_2.anchoredPosition = var_5(84, 454)
	else
		setText = var_5

		local var_3_4 = var_3_1

		i18n = var_1_10008

		var_5(var_3_4, var_1_10008("tolovegame_puzzle_puzzle_tip"))

		Vector2 = var_5
		var_3_2.anchoredPosition = var_5(156, 454)
	end

	local var_3_5 = arg_3_0._arrowIn

	Vector2 = var_6
	var_3_5.anchoredPosition = var_6((arg_3_0._arrowData[1][2] - 1) * arg_3_0._boundData.x, -(arg_3_0._arrowData[1][1] - 1) * arg_3_0._boundData.y)
	findTF = var_3_5

	local var_3_6 = var_3_5(arg_3_0._arrowIn, "ad")

	Vector3 = var_6
	var_3_6.localEulerAngles = var_6(0, 0, arg_3_0._arrowData[1][3])

	local var_3_7 = arg_3_0._arrowOut

	Vector2 = var_6
	var_3_7.anchoredPosition = var_6((arg_3_0._arrowData[2][2] - 1) * arg_3_0._boundData.x, -(arg_3_0._arrowData[2][1] - 1) * arg_3_0._boundData.y)
	findTF = var_3_7

	local var_3_8 = var_3_7(arg_3_0._arrowOut, "ad")

	Vector3 = var_6
	var_3_8.localEulerAngles = var_6(0, 0, arg_3_0._arrowData[2][3])

	arg_3_0:updateGrids()

	local var_3_9

	if not (#arg_3_0._itemData > #arg_3_0._items) or not #arg_3_0._itemData then
		var_3_9 = #arg_3_0._items
	end

	for iter_3_0 = 1, var_3_9 do
		local var_3_10

		if iter_3_0 > #arg_3_0._items then
			var_3_10 = arg_3_0:createItem()
			table = var_11

			var_11.insert(arg_3_0._items, var_3_10)
		else
			var_3_10 = arg_3_0._items[iter_3_0]
		end

		if iter_3_0 > #arg_3_0._itemData then
			var_3_10:setActive(false)
		else
			var_3_10:setData(arg_3_0._itemData[iter_3_0])
			var_3_10:setActive(true)
		end
	end

	arg_3_0:updateStateUI()

	return
end

function var_0_0.updateGrids(arg_4_0)
	local var_4_0 = arg_4_0._lineInOut[1]
	local var_4_1 = arg_4_0._lineInOut[2]

	for iter_4_0 = 1, #arg_4_0._grids do
		local var_4_2 = arg_4_0._grids[iter_4_0]
		local var_4_3 = var_7.getPoint(var_4_2)

		if arg_4_0._mapData[var_4_3.v][var_4_3.h] and var_8 > 0 then
			arg_4_0._gridCount = arg_4_0._gridCount + 1
		end

		local var_4_4 = arg_4_0._grids[iter_4_0]

		var_9.setIndex(var_4_4, var_8, arg_4_0._state)

		if var_4_0[1] == var_4_3.v and var_4_0[2] == var_4_3.h then
			local var_4_5 = arg_4_0._grids[iter_4_0]

			var_9.setStart(var_4_5, true)
		elseif var_4_1[1] == var_4_3.v and var_4_1[2] == var_4_3.h then
			local var_4_6 = arg_4_0._grids[iter_4_0]

			var_9.setEnd(var_4_6, true)
		end

		local var_4_7 = arg_4_0._grids[iter_4_0]

		if var_9.getStart(var_4_7) then
			if arg_4_0._state == var_0_0.game_state_connect then
				local var_4_8 = arg_4_0._grids[iter_4_0]

				var_9.setLine(var_4_8, {
					v = arg_4_0._arrowData[1][1],
					h = arg_4_0._arrowData[1][2]
				}, nil)
			end
		else
			local var_4_9 = arg_4_0._grids[iter_4_0]

			var_9.clearLine(var_4_9)
		end
	end

	return
end

function var_0_0.updateStateUI(arg_5_0)
	local var_5_0 = arg_5_0._state

	PuzzleConnectPlaying = var_1_10002

	if var_5_0 == var_1_10002.game_state_connect then
		setActive = var_5_0
		findTF = var_1_10003

		var_5_0(var_1_10003(arg_5_0._ad, "bg/puzzle"), false)

		setActive = var_5_0
		findTF = var_1_10003

		var_5_0(var_1_10003(arg_5_0._ad, "bg/connect"), true)

		setActive = var_5_0
		findTF = var_1_10003

		var_5_0(var_1_10003(arg_5_0._ad, "list"), false)

		setActive = var_5_0
		findTF = var_1_10003

		var_5_0(var_1_10003(arg_5_0._ad, "dragContent"), false)

		setActive = var_5_0

		var_5_0(arg_5_0._arrowIn, true)

		setActive = var_5_0

		var_5_0(arg_5_0._arrowOut, true)

		local var_5_1 = arg_5_0._ad

		Vector2 = var_2
		var_5_1.anchoredPosition = var_2(255, 0)
	else
		local var_5_2 = arg_5_0._state

		PuzzleConnectPlaying = var_2

		if var_5_2 == var_2.game_state_puzzle then
			setActive = var_5_2
			findTF = var_1_10003

			var_5_2(var_1_10003(arg_5_0._ad, "bg/puzzle"), true)

			setActive = var_5_2
			findTF = var_3

			var_5_2(var_3(arg_5_0._ad, "bg/connect"), false)

			setActive = var_5_2
			findTF = var_3

			var_5_2(var_3(arg_5_0._ad, "list"), true)

			setActive = var_5_2
			findTF = var_3

			var_5_2(var_3(arg_5_0._ad, "dragContent"), true)

			setActive = var_5_2

			var_5_2(arg_5_0._arrowIn, false)

			setActive = var_5_2

			var_5_2(arg_5_0._arrowOut, false)

			local var_5_3 = arg_5_0._ad

			Vector2 = var_2
			var_5_3.anchoredPosition = var_2(0, 0)
		end
	end

	return
end

function var_0_0.createItem(arg_6_0)
	tf = var_1_10001
	instantiate = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003(arg_6_0.itemTpl))

	PuzzleConnectItem = var_1_10002

	local var_6_1 = var_1_10002.New(var_6_0, arg_6_0._iconTpl)

	var_2.setActive(var_6_1, true)
	var_2:setContent(arg_6_0._listContent)

	local var_6_2 = var_2:getEventTrigger()

	var_3.AddBeginDragFunc(var_6_2, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_6_0

		var_2.onDragBeginFunc(var_7_0, var_0, arg_7_0, arg_7_1)

		return
	end)
	var_3:AddDragEndFunc(function(arg_8_0, arg_8_1)
		local var_8_0 = arg_6_0

		var_2.onDragEndFunc(var_8_0, var_0, arg_8_0, arg_8_1)

		return
	end)
	var_3:AddDragFunc(function(arg_9_0, arg_9_1)
		local var_9_0 = arg_6_0

		var_2.onDragFunc(var_9_0, var_0, arg_9_0, arg_9_1)

		return
	end)

	return var_2
end

function var_0_0.createGrid(arg_10_0, arg_10_1, arg_10_2)
	tf = var_1_10003
	instantiate = var_1_10005

	local var_10_0 = var_1_10003(var_1_10005(arg_10_0.gridTpl))

	PuzzleConnectGrid = var_1_10004

	local var_10_1 = var_1_10004.New(var_10_0, arg_10_1, arg_10_2, arg_10_0._iconTpl)

	var_4.setContent(var_10_1, arg_10_0._gridContent)
	var_4:setActive(true)

	local var_10_2 = var_4:getEventTrigger()

	var_5.AddBeginDragFunc(var_10_2, function(arg_11_0, arg_11_1)
		local var_11_0 = var_0
		local var_11_1, var_11_2, var_11_3 = var_2.getFillItem(var_11_0)

		if var_11_1 then
			local var_11_4 = arg_10_0

			var_5.clearFillItem(var_11_4, var_11_1, var_11_3)
			var_11_1:changeCount(1)

			local var_11_5 = arg_10_0

			var_5.onDragBeginFunc(var_11_5, var_11_1, arg_11_0, arg_11_1, var_11_2)
		end

		return
	end)
	var_5:AddDragEndFunc(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_10_0

		var_2.onDragEndFunc(var_12_0, nil, arg_12_0, arg_12_1)

		return
	end)
	var_5:AddDragFunc(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_10_0

		var_2.onDragFunc(var_13_0, nil, arg_13_0, arg_13_1)

		return
	end)

	local var_10_3 = var_4:getLineTrigger()

	var_6.AddPointDownFunc(var_10_3, function()
		local var_14_0 = arg_10_0

		var_0.onGridDown(var_14_0, var_0)

		local var_14_1 = arg_10_0

		var_0.onGridEnter(var_14_1, var_0)

		return
	end)
	var_6:AddPointEnterFunc(function()
		local var_15_0 = arg_10_0

		var_0.onGridEnter(var_15_0, var_0)

		return
	end)
	var_6:AddPointUpFunc(function()
		local var_16_0 = arg_10_0

		var_0.onGridUp(var_16_0, var_0)

		return
	end)

	return var_4
end

function var_0_0.onGridDown(arg_17_0, arg_17_1)
	arg_17_0._gridPointStart = true

	if arg_17_1:getStart() then
		if arg_17_0._lineGrids and #arg_17_0._lineGrids > 0 then
			ipairs = var_2

			for iter_17_0, iter_17_1 in var_2(arg_17_0._lineGrids) do
				iter_17_1:clearLine()
			end
		end

		arg_17_0._lineGrids = {}
		table = var_2

		var_2.insert(arg_17_0._lineGrids, arg_17_1)
		arg_17_1:setLine({
			v = arg_17_0._arrowData[1][1],
			h = arg_17_0._arrowData[1][2]
		}, nil)
	elseif arg_17_0._lineGrids and #arg_17_0._lineGrids > 0 then
		table = var_2

		if var_2.contains(arg_17_0._lineGrids, arg_17_1) then
			for iter_17_2 = #arg_17_0._lineGrids, 1, -1 do
				if arg_17_0._lineGrids[iter_17_2] ~= arg_17_1 then
					local var_17_0 = arg_17_0._lineGrids[iter_17_2]

					var_6.clearLine(var_17_0)

					table = var_6

					var_6.remove(arg_17_0._lineGrids, iter_17_2)
				elseif arg_17_0._lineGrids[iter_17_2] == arg_17_1 then
					local var_17_1 = arg_17_0._lineGrids[iter_17_2]

					var_6.clearLine(var_17_1)

					if iter_17_2 > 1 then
						local var_17_2 = arg_17_1
						local var_17_3 = arg_17_1.setLine
						local var_17_4 = arg_17_0._lineGrids[iter_17_2 - 1]

						var_17_3(var_17_2, var_9.getPoint(var_17_4), nil)

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

	table = var_2

	if var_2.contains(arg_18_0._lineGrids, arg_18_1) then
		if arg_18_0._lineGrids[#arg_18_0._lineGrids] ~= arg_18_1 then
			for iter_18_0 = #arg_18_0._lineGrids, 1, -1 do
				if arg_18_0._lineGrids[iter_18_0] ~= arg_18_1 then
					local var_18_0 = arg_18_0._lineGrids[iter_18_0]

					var_6.clearLine(var_18_0)

					table = var_6

					var_6.remove(arg_18_0._lineGrids, iter_18_0)
				elseif arg_18_0._lineGrids[iter_18_0] == arg_18_1 then
					local var_18_1 = arg_18_0._lineGrids[iter_18_0]

					var_6.clearLine(var_18_1)

					if iter_18_0 > 1 then
						local var_18_2 = arg_18_1
						local var_18_3 = arg_18_1.setLine
						local var_18_4 = arg_18_0._lineGrids[iter_18_0 - 1]

						var_18_3(var_18_2, var_9.getPoint(var_18_4), nil)

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

	local var_18_5 = arg_18_0._lineGrids[#arg_18_0._lineGrids]

	if not arg_18_0:checkGridLineAble(arg_18_1, var_18_5) then
		return
	end

	table = var_3

	var_3.insert(arg_18_0._lineGrids, arg_18_1)

	if #arg_18_0._lineGrids > 1 then
		local var_18_6 = arg_18_0._lineGrids[#arg_18_0._lineGrids - 1]
		local var_18_7 = arg_18_0._lineGrids[#arg_18_0._lineGrids]

		var_18_6:setLine(nil, var_18_7:getPoint())
		var_18_7:setLine(var_18_6:getPoint(), nil)
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
			local var_19_0 = arg_19_0._grids[iter_19_0]

			if var_6.getStart(var_19_0) then
				local var_19_1 = arg_19_0._grids[iter_19_0]

				var_6.clearLine(var_19_1)

				if arg_19_0._state == var_0_0.game_state_connect then
					local var_19_2 = arg_19_0._grids[iter_19_0]

					var_6.setLine(var_19_2, {
						v = arg_19_0._arrowData[1][1],
						h = arg_19_0._arrowData[1][2]
					}, nil)
				end
			else
				local var_19_3 = arg_19_0._grids[iter_19_0]

				var_6.clearLine(var_19_3)
			end
		end

		arg_19_0._lineGrids = {}
	end

	return
end

function var_0_0.checkGridLineAble(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1
	local var_20_1 = arg_20_1.getPoint(var_20_0)
	local var_20_2 = arg_20_2:getPoint()

	math = var_20_0

	if var_20_0.abs(var_20_1.h - var_20_2.h) > 1 then
		return false
	end

	math = var_5

	if var_5.abs(var_20_1.v - var_20_2.v) > 1 then
		return false
	end

	return true
end

function var_0_0.checkLineComplete(arg_21_0)
	if arg_21_0._lineGrids and #arg_21_0._lineGrids == arg_21_0._gridCount then
		local var_21_0 = arg_21_0._lineGrids[1]

		if var_1.getStart(var_21_0) then
			local var_21_1 = arg_21_0._lineGrids[#arg_21_0._lineGrids]

			if var_1.getEnd(var_21_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.clearFillItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:getId()

	ipairs = var_1_10004

	for iter_22_0, iter_22_1 in var_1_10004(arg_22_0._grids) do
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

	local var_23_0 = arg_23_0._dragItem

	var_5.setDraging(var_23_0, true)

	local var_23_1
	local var_23_2

	if not arg_23_4 then
		local var_23_3 = arg_23_0._uiCamera

		var_23_1 = var_7.ScreenToWorldPoint(var_23_3, arg_23_3.position)
		var_23_2 = arg_23_3.position
	else
		local var_23_4 = arg_23_0._dragItem

		var_23_1 = var_7.getItemIconWorld(var_23_4, arg_23_4)

		local var_23_5 = arg_23_0._uiCamera

		var_23_2 = var_7.WorldToScreenPoint(var_23_5, var_23_1)
	end

	local var_23_6 = arg_23_0._dragContent
	local var_23_7 = var_7.InverseTransformPoint(var_23_6, var_23_1)
	local var_23_8 = arg_23_0._listContent
	local var_23_9 = var_8.InverseTransformPoint(var_23_8, var_23_1)
	local var_23_10 = arg_23_1:getPosition()

	arg_23_0._dragItemStartPosition = var_23_2
	arg_23_0._dragItemContentPosition = var_23_7
	Vector2 = var_23_8
	arg_23_0._dragItemOffsetPosition = var_23_8(var_23_9.x - var_23_10.x, var_23_9.y - var_23_10.y)

	local var_23_11 = arg_23_0._moveItem
	local var_23_12 = var_10.setData
	local var_23_13 = arg_23_0._dragItem

	var_23_12(var_23_11, var_13.getData(var_23_13))

	local var_23_14 = arg_23_0._moveItem

	var_10.setActive(var_23_14, true)

	Vector2 = var_10
	arg_23_0._movePosition = var_10(0, 0)

	arg_23_0:updateMovePosition()

	return
end

function var_0_0.getFillId(arg_24_0)
	if not arg_24_0._fillId then
		arg_24_0._fillId = 1
	end

	arg_24_0._fillId = arg_24_0._fillId + 1

	return arg_24_0._fillId
end

function var_0_0.onDragEndFunc(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0._dragItem then
		if arg_25_0._fillAll then
			local var_25_0 = arg_25_0._dragItem

			var_4.changeCount(var_25_0, -1)

			local var_25_1 = arg_25_0:getFillId()

			ipairs = var_1_10005

			for iter_25_0, iter_25_1 in var_1_10005(arg_25_0._prepareGrids) do
				iter_25_1:setFillItem(arg_25_0._dragItem, iter_25_0, var_25_1)
			end
		end

		local var_25_2 = arg_25_0._dragItem

		var_4.setDraging(var_25_2, false)

		arg_25_0._dragItem = nil

		local var_25_3 = arg_25_0._moveItem

		var_4.setActive(var_25_3, false)
		arg_25_0:clearGridPrepare()
	end

	local var_25_4 = true

	ipairs = var_1_10005

	for iter_25_2, iter_25_3 in var_1_10005(arg_25_0._grids) do
		if var_25_4 and iter_25_3:getMapIndex() > 0 and not iter_25_3:getComplete() then
			var_25_4 = false
		end
	end

	if var_25_4 and arg_25_0._puzzleCallback then
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
	if not arg_27_0._gridOffsetX then
		PuzzleConnectConst = var_1
		arg_27_0._gridOffsetX = var_1.item_bound[1] / 2
	end

	local var_27_0 = arg_27_0._moveItem
	local var_27_1 = var_1.getPuzzleWorldPos(var_27_0)
	local var_27_2 = arg_27_0._moveItem
	local var_27_3 = var_2.getColor(var_27_2)

	arg_27_0:clearGridPrepare()

	local var_27_4 = 0
	local var_27_5 = 0

	arg_27_0._prepareGrids = {}

	for iter_27_0 = 1, #var_27_1 do
		local var_27_6 = arg_27_0._gridContent
		local var_27_7 = var_9.InverseTransformPoint(var_27_6, var_27_1[iter_27_0])

		ipairs = var_1_10010

		for iter_27_1, iter_27_2 in var_1_10010(arg_27_0._grids) do
			if not iter_27_2:getPrepare() then
				local var_27_8 = iter_27_2:getPosition()

				Vector2 = var_1_10016
				math = var_1_10018
				var_1_10018 = var_1_10018.abs(var_27_7.x + arg_27_0._gridOffsetX - var_27_8.x)
				math = var_1_10019
				var_1_10016 = var_1_10016(var_1_10018, var_1_10019.abs(var_27_7.y - var_27_8.y))

				local var_27_9 = false

				if var_1_10016.x <= arg_27_0._rangeOffset.x and var_1_10016.y <= arg_27_0._rangeOffset.y then
					var_27_9 = true
				end

				if var_27_9 then
					if not iter_27_2:getFill() then
						if iter_27_2:getUnlock() then
							var_27_4 = var_27_4 + 1
						end

						var_27_5 = var_27_5 + 1
					end

					if not iter_27_2:getFill() then
						iter_27_2:setPrepare(var_27_3)

						table = var_1_10018

						var_1_10018.insert(arg_27_0._prepareGrids, iter_27_2)
					end

					break
				end
			end
		end
	end

	if var_27_4 == #var_27_1 then
		arg_27_0._fillSuccess = true
	else
		arg_27_0._fillSuccess = false
	end

	if var_27_5 == #var_27_1 then
		arg_27_0._fillAll = true
	else
		arg_27_0._fillAll = false
	end

	for iter_27_3 = 1, #arg_27_0._prepareGrids do
		if arg_27_0._fillSuccess then
			local var_27_10 = arg_27_0._prepareGrids[iter_27_3]
			local var_27_11 = var_9.setPrepareAlpha

			PuzzleConnectConst = var_1_10012

			var_27_11(var_27_10, var_1_10012.color_green)
		else
			local var_27_12 = arg_27_0._prepareGrids[iter_27_3]
			local var_27_13 = var_9.setPrepareAlpha

			PuzzleConnectConst = var_1_10012

			var_27_13(var_27_12, var_1_10012.color_red)
		end
	end

	return
end

function var_0_0.clearGridPrepare(arg_28_0)
	arg_28_0._prepareGrids = {}
	arg_28_0._fillSuccess = false
	arg_28_0._fillAll = false
	ipairs = var_1

	for iter_28_0, iter_28_1 in var_1(arg_28_0._grids) do
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

	local var_29_0 = arg_29_0._moveItem

	var_2.setPosition(var_29_0, arg_29_0._movePosition)

	return
end

function var_0_0.reset(arg_30_0)
	local var_30_0 = arg_30_0._state

	PuzzleConnectPlaying = var_1_10002

	if var_30_0 == var_1_10002.game_state_puzzle then
		arg_30_0:setData(arg_30_0._data, arg_30_0._state)
	else
		for iter_30_0 = 1, #arg_30_0._grids do
			local var_30_1 = arg_30_0._grids[iter_30_0]

			if var_5.getStart(var_30_1) then
				local var_30_2 = arg_30_0._grids[iter_30_0]

				var_5.clearLine(var_30_2)

				if arg_30_0._state == var_0_0.game_state_connect then
					local var_30_3 = arg_30_0._grids[iter_30_0]

					var_5.setLine(var_30_3, {
						v = arg_30_0._arrowData[1][1],
						h = arg_30_0._arrowData[1][2]
					}, nil)
				end
			else
				local var_30_4 = arg_30_0._grids[iter_30_0]

				var_5.clearLine(var_30_4)
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
	UnityEngine = var_1_10001

	local var_32_0 = var_1_10001.Screen.width

	UnityEngine = var_1_10002

	local var_32_1 = var_1_10002.Screen.height

	tf = var_1_10003
	GameObject = var_1_10005

	local var_32_2 = var_1_10003(var_1_10005.Find("UICamera/Canvas")).sizeDelta.x
	local var_32_3 = var_3.sizeDelta.y

	Vector2 = var_1_10006

	return var_1_10006(var_32_2 / var_32_0, var_32_3 / var_32_1)
end

function var_0_0.clear(arg_33_0)
	arg_33_0._dragGrid = nil

	if arg_33_0._prepareGrids then
		arg_33_0._prepareGrids = {}
	end

	if arg_33_0._moveItem then
		local var_33_0 = arg_33_0._moveItem

		var_1.setActive(var_33_0, false)
	end

	if arg_33_0._dragItem then
		local var_33_1 = arg_33_0._dragItem

		var_1.setDraging(var_33_1, false)

		arg_33_0._dragItem = nil
	end

	return
end

function var_0_0.dispose(arg_34_0)
	return
end

return var_0_0
