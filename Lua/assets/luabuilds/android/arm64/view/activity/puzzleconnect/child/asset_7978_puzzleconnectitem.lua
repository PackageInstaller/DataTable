local PuzzleConnectItem = class("PuzzleConnectItem")

function PuzzleConnectItem:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._canvasGroup = GetComponent(self._tf, typeof(CanvasGroup))
	self._iconContent = findTF(self._tf, "icons")
	self._eventTrigger = GetComponent(findTF(self._tf, "icons"), typeof(EventTriggerListener))
	self._iconTpl = arg_1_2
	self._iconTfs = {}
	self._textTf = findTF(self._tf, "text")
	self._bgTf = findTF(self._tf, "bg")
	self._boundData = Vector2(PuzzleConnectConst.item_bound[1] + PuzzleConnectConst.item_spacing, PuzzleConnectConst.item_bound[2] + PuzzleConnectConst.item_spacing)

	return
end

function PuzzleConnectItem:setData(arg_2_1)
	self:clear()

	self._itemData = arg_2_1
	self._id = arg_2_1.id
	self._count = arg_2_1.count
	self._color = arg_2_1.color
	self._itemMap = Clone(PuzzleConnectConst.item_data[self._id])

	self:updateIcon()
	self:updateAlpha()
	setGray(self._tf, false, true)

	return
end

function PuzzleConnectItem:updateIcon()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(self._itemMap) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			if iter_3_3 > 0 then
				var_3_0 = var_3_0 + 1

				if var_3_0 > #self._iconTfs then
					local var_3_1 = tf(instantiate(self._iconTpl))

					setActive(var_3_1, true)
					setParent(var_3_1, self._iconContent)
					setActive(findTF(var_3_1, "line"), false)
					setActive(findTF(var_3_1, "lineBound"), false)
					table.insert(self._iconTfs, var_3_1)
				end

				setActive(self._iconTfs[var_3_0], true)

				self._iconTfs[var_3_0].anchoredPosition = Vector2((iter_3_2 - 1) * self._boundData.x, -(iter_3_0 - 1) * self._boundData.y)
			end
		end
	end

	for iter_3_4 = var_3_0, #self._iconTfs do
		if iter_3_4 > #self._iconTfs then
			setActive(self.iconTfs[iter_3_4], false)
		end
	end

	for iter_3_5, iter_3_6 in ipairs(self._iconTfs) do
		for iter_3_7 = 1, PuzzleConnectConst.color_count do
			setActive(findTF(iter_3_6, iter_3_7), iter_3_7 == self._color)
		end
	end

	self:updateCount()

	return
end

function PuzzleConnectItem:updateCount()
	setText(self._textTf, "X" .. self._count)

	return
end

function PuzzleConnectItem:getId()
	return self._id
end

function PuzzleConnectItem:getCount()
	return self._count
end

function PuzzleConnectItem:getData()
	return self._itemData
end

function PuzzleConnectItem:setActive(arg_8_1)
	setActive(self._tf, arg_8_1)

	return
end

function PuzzleConnectItem:setContent(arg_9_1)
	setParent(self._tf, arg_9_1)

	return
end

function PuzzleConnectItem:setState(arg_10_1)
	self._state = arg_10_1

	return
end

function PuzzleConnectItem:getEventTrigger()
	return self._eventTrigger
end

function PuzzleConnectItem:setPosition(arg_12_1)
	self._tf.anchoredPosition = arg_12_1

	return
end

function PuzzleConnectItem:getName()
	self._gridName = self._gridName or self._h .. "-" .. self._v

	return self._gridName
end

function PuzzleConnectItem:setMoveItem(arg_14_1)
	if arg_14_1 then
		self._iconContent.localScale = Vector3(1, 1, 1)

		setActive(self._textTf, false)
		setActive(self._bgTf, false)
	end

	return
end

function PuzzleConnectItem:changeCount(arg_15_1)
	self._count = self._count + arg_15_1

	self:updateCount()

	return
end

function PuzzleConnectItem:getPosition()
	return self._tf.anchoredPosition
end

function PuzzleConnectItem:getColor()
	return self._color
end

function PuzzleConnectItem:getItemIconWorld(arg_18_1)
	return self._iconTfs[arg_18_1].position
end

function PuzzleConnectItem:getPuzzleWorldPos()
	local var_19_0 = {}

	for iter_19_0 = 1, #self._iconTfs do
		if isActive(self._iconTfs[iter_19_0]) then
			table.insert(var_19_0, self._iconTfs[iter_19_0].position)
		end
	end

	return var_19_0
end

function PuzzleConnectItem:setDraging(arg_20_1)
	self._draging = arg_20_1

	self:updateAlpha()

	return
end

function PuzzleConnectItem:updateAlpha()
	self._canvasGroup.alpha = (self._draging or self._count == 0) and 0.5 or 1

	if self._count == 0 then
		setGray(self._tf, true, true)
	else
		setGray(self._tf, false, true)
	end

	return
end

function PuzzleConnectItem:clear()
	for iter_22_0 = 1, #self._iconTfs do
		setActive(self._iconTfs[iter_22_0], false)
	end

	return
end

function PuzzleConnectItem:dispose()
	if self._eventTrigger then
		ClearEventTrigger(self._eventTrigger)
	end

	return
end

return PuzzleConnectItem
