local PuzzleConnectGrid = class("PuzzleConnectGrid")

function PuzzleConnectGrid:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._tf = arg_1_1
	self._h, self._v = arg_1_2, arg_1_3
	self._eventTrigger = GetComponent(self._tf, typeof(EventTriggerListener))
	self._unLockTf = findTF(self._tf, "unlock")
	self._iconContent = findTF(self._tf, "iconContent")
	self._iconTf = tf(instantiate(arg_1_4))

	setActive(self._iconTf, true)
	setParent(self._iconTf, self._iconContent)

	self._iconTf.anchoredPosition = Vector2(0, 0)
	self._iconCanvasGroup = GetComponent(self._iconContent, typeof(CanvasGroup))

	self:setChildVisible(self._iconTf, false)
	setActive(self._unLockTf, false)

	self._lineTf = findTF(self._iconTf, "line")

	setActive(self._lineTf, false)
	self:setChildVisible(self._lineTf, false)

	self._lineEventTrigger = GetComponent(findTF(self._iconTf, "lineBound"), typeof(EventTriggerListener))

	return
end

function PuzzleConnectGrid:getLineTrigger()
	return self._lineEventTrigger
end

function PuzzleConnectGrid:setActive(arg_3_1)
	setActive(self._tf, arg_3_1)

	return
end

function PuzzleConnectGrid:setContent(arg_4_1)
	setParent(self._tf, arg_4_1)

	return
end

function PuzzleConnectGrid:getPosition()
	return self._tf.anchoredPosition
end

function PuzzleConnectGrid:setPrepare(arg_6_1)
	if self._fillItem then
		return
	end

	self._prepareColor = arg_6_1
	self._iconCanvasGroup.alpha = 0.5

	self:setChildVisible(self._iconTf, false)
	setActive(findTF(self._iconTf, tostring(arg_6_1)), true)

	return
end

function PuzzleConnectGrid:getPrepare()
	return self._prepareColor and self._prepareColor > 0
end

function PuzzleConnectGrid:clearPrepare()
	if self._prepareColor and self._prepareColor > 0 then
		GetComponent(findTF(self._iconTf, self._prepareColor), typeof(Image)).color = Color.New(1, 1, 1, 1)
		self._prepareColor = nil
		self._iconCanvasGroup.alpha = 1

		self:setChildVisible(self._iconTf, false)
	end

	return
end

function PuzzleConnectGrid:setLine(arg_9_1, arg_9_2)
	if arg_9_1 then
		local var_9_0 = self:getLineStrByGrid(arg_9_1)

		if var_9_0 then
			setActive(findTF(self._lineTf, var_9_0), true)
		end
	end

	if arg_9_2 then
		local var_9_1 = self:getLineStrByGrid(arg_9_2)

		if var_9_1 then
			setActive(findTF(self._lineTf, var_9_1), true)
		end
	end

	return
end

function PuzzleConnectGrid:getLineStrByGrid(arg_10_1)
	local var_10_0

	if self._h - arg_10_1.h == 1 then
		if self._v - arg_10_1.v == 1 then
			var_10_0 = "LT"
		elseif self._v - arg_10_1.v == 0 then
			var_10_0 = "L"
		elseif self._v - arg_10_1.v == -1 then
			var_10_0 = "LB"
		end
	elseif self._h - arg_10_1.h == 0 then
		if self._v - arg_10_1.v == 1 then
			var_10_0 = "T"
		elseif self._v - arg_10_1.v == -1 then
			var_10_0 = "B"
		end
	elseif self._h - arg_10_1.h == -1 then
		if self._v - arg_10_1.v == 1 then
			var_10_0 = "RT"
		elseif self._v - arg_10_1.v == 0 then
			var_10_0 = "R"
		elseif self._v - arg_10_1.v == -1 then
			var_10_0 = "RB"
		end
	end

	return var_10_0
end

function PuzzleConnectGrid:clearLine()
	self:setChildVisible(self._lineTf, false)

	return
end

function PuzzleConnectGrid:setChildVisible(arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		setActive(arg_12_1:GetChild(iter_12_0 - 1), arg_12_2)
	end

	return
end

function PuzzleConnectGrid:setIndex(arg_13_1, arg_13_2)
	self:clear()

	self._mapIndex = arg_13_1
	self._state = arg_13_2

	self:updateGrid()

	return
end

function PuzzleConnectGrid:updateGrid()
	setActive(self._unLockTf, false)

	if self._state == PuzzleConnectPlaying.game_state_puzzle then
		setActive(self._lineTf, false)

		if self._mapIndex and self._mapIndex > 0 then
			setActive(self._unLockTf, true)
		end

		setActive(findTF(self._iconTf, "lineBound"), false)
		setActive(findTF(self._unLockTf, "whiteImg"), false)
	elseif self._state == PuzzleConnectPlaying.game_state_connect then
		setActive(self._lineTf, true)

		if self._mapIndex and self._mapIndex > 0 then
			setActive(findTF(self._iconTf, self._mapIndex), true)
			setActive(findTF(self._iconTf, "lineBound"), true)
			setActive(self._unLockTf, true)
			setActive(findTF(self._unLockTf, "whiteImg"), true)
		end
	end

	return
end

function PuzzleConnectGrid:setStart(arg_15_1)
	self._startFlag = arg_15_1

	return
end

function PuzzleConnectGrid:getStart()
	return self._startFlag
end

function PuzzleConnectGrid:setEnd(arg_17_1)
	self._endFlag = arg_17_1

	return
end

function PuzzleConnectGrid:getEnd()
	return self._endFlag
end

function PuzzleConnectGrid:getUnlock()
	return self._mapIndex and self._mapIndex > 0
end

function PuzzleConnectGrid:setFillItem(arg_20_1, arg_20_2, arg_20_3)
	self._fillItem = arg_20_1
	self._fillIndex = arg_20_2
	self._fillCount = arg_20_3

	self:clearPrepare()
	setActive(findTF(self._iconTf, tostring((self._fillItem:getColor()))), true)

	if self._mapIndex and self._mapIndex > 0 then
		setActive(findTF(self._unLockTf, "whiteImg"), true)
	else
		setActive(findTF(self._unLockTf, "whiteImg"), false)
	end

	return
end

function PuzzleConnectGrid:getFillItem()
	return self._fillItem, self._fillIndex, self._fillCount
end

function PuzzleConnectGrid:clearFillItem()
	if self._fillItem then
		self._fillItem = nil
		self._iconCanvasGroup.alpha = 1
	end

	self:setChildVisible(self._iconTf, false)

	if self._mapIndex and self._mapIndex > 0 then
		setActive(findTF(self._unLockTf, "whiteImg"), false)
	end

	return
end

function PuzzleConnectGrid:getFill()
	return not not self._fillItem
end

function PuzzleConnectGrid:setPrepareAlpha(arg_24_1)
	if self._prepareColor and self._prepareColor > 0 then
		GetComponent(findTF(self._iconTf, self._prepareColor), typeof(Image)).color = arg_24_1
	end

	return
end

function PuzzleConnectGrid:setState(arg_25_1)
	self._state = arg_25_1

	return
end

function PuzzleConnectGrid:getPoint()
	return {
		h = self._h,
		v = self._v
	}
end

function PuzzleConnectGrid:getEventTrigger()
	return self._eventTrigger
end

function PuzzleConnectGrid:getName()
	self._gridName = self._gridName or self._h .. "-" .. self._v

	return self._gridName
end

function PuzzleConnectGrid:getMapIndex()
	return self._mapIndex
end

function PuzzleConnectGrid:getComplete()
	if self._mapIndex > 0 and self._fillItem then
		return true
	end

	return false
end

function PuzzleConnectGrid:clear()
	self:setStart(false)
	self:setEnd(false)
	self:clearPrepare()
	self:clearFillItem()

	return
end

function PuzzleConnectGrid:dispose()
	if self._eventTrigger then
		ClearEventTrigger(self._eventTrigger)
	end

	return
end

return PuzzleConnectGrid
