local PipeRectControll = class("PipeRectControll")
local var_0_1
local var_0_2 = 140
local var_0_3 = 4
local var_0_4 = Vector2(0, 90)

local function var_0_5(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		ctor = function(self)
			self._rectItem = arg_1_0
			self._dragContent = arg_1_1
			self._rectImg = findTF(self._rectItem, "img")
			self._rectSelect = findTF(self._rectItem, "select")
			self._rectParent = self._rectItem.parent
			self._eventCallback = arg_1_2
			self._eventTrigger = GetOrAddComponent(self._rectItem, typeof(EventTriggerListener))
			self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
			self._dragPos = Vector2(0, 0)
			self._draging = false

			self._eventTrigger:AddBeginDragFunc(function(arg_3_0, arg_3_1, arg_3_2)
				if var_0_1.startSettlement then
					return
				end

				if self._index == 1 and not self:isTweening() then
					self._screenScaleRate = self:getScreentScaleRate()
					self._draging = true
					var_0_1.draging = true
					var_0_1.dragItem = self._itemData
					var_0_1.dragScreenPos = arg_3_1.position
					self._startDragPos = arg_3_1.position
					self._startTfPos = self._rectImg.anchoredPosition

					local var_3_0 = self._rectImg:InverseTransformPoint((self._uiCamera:ScreenToWorldPoint(arg_3_1.position)))

					var_3_0.x = var_3_0.x - var_0_2 / 2
					var_3_0.y = var_3_0.y + var_0_4.y
					self._startOffsetPos = var_3_0

					setParent(self._rectImg, self._dragContent, false)
				end

				return
			end)
			self._eventTrigger:AddDragFunc(function(arg_4_0, arg_4_1, arg_4_2)
				if not self._draging then
					return
				end

				if var_0_1.startSettlement then
					self:stopDrag()

					return
				end

				var_0_1.dragScreenPos = Vector2(arg_4_1.position.x, arg_4_1.position.y + var_0_4.y)
				self._dragPos.x = self._startOffsetPos.x + (arg_4_1.position.x - self._startDragPos.x) * self._screenScaleRate.x
				self._dragPos.y = self._startOffsetPos.y + (arg_4_1.position.y - self._startDragPos.y) * self._screenScaleRate.y
				self._rectImg.anchoredPosition = self._dragPos

				return
			end)
			self._eventTrigger:AddDragEndFunc(function(arg_5_0, arg_5_1, arg_5_2)
				if var_0_1.startSettlement then
					return
				end

				if self._index == 1 then
					self:stopDrag()
				end

				return
			end)
			self:setActive(false)

			return
		end,
		stopDrag = function(self)
			if self._draging then
				self._draging = false
				var_0_1.draging = false
				var_0_1.dragItem = nil
				var_0_1.dragScreenPos = nil

				SetParent(self._rectImg, self._rectItem, false)

				if self._startTfPos then
					self._rectImg.anchoredPosition = Vector2(0, 0)
				end
			end

			return
		end,
		getScreentScaleRate = function(arg_7_0)
			local var_7_0 = tf(GameObject.Find("UICamera/Canvas"))

			return Vector2(var_7_0.sizeDelta.x / UnityEngine.Screen.width, var_7_0.sizeDelta.y / UnityEngine.Screen.height)
		end,
		setItem = function(self, arg_8_1)
			self._itemData = arg_8_1

			if self._itemData then
				self:setImg(self._itemData.img)
				self:setActive(true)
			else
				self:setActive(false)
			end

			return
		end,
		isTweening = function(self)
			return LeanTween.isTweening(go(self._rectItem))
		end,
		getItem = function(self)
			return self._itemData
		end,
		setActive = function(self, arg_11_1)
			setActive(self._rectItem, arg_11_1)

			return
		end,
		setIndex = function(self, arg_12_1, arg_12_2)
			if not arg_12_2 then
				self:setPostionByIndex(arg_12_1)
			else
				self:fadeTo(arg_12_1)
			end

			self._index = arg_12_1

			setActive(self._rectSelect, arg_12_1 == 1)

			return
		end,
		setImg = function(self, arg_13_1)
			setImageSprite(self._rectImg, var_0_1.GetSprite(arg_13_1))

			return
		end,
		fadeTo = function(self, arg_14_1)
			self:clearTween()

			local var_14_0 = Vector2(0, self._rectItem.anchoredPosition.y)

			LeanTween.value(go(self._rectItem), self._rectItem.anchoredPosition.x, self:getIndexPosition(arg_14_1).x, 0.1):setOnUpdate(System.Action_float(function(arg_15_0)
				var_14_0.x = arg_15_0
				self._rectItem.anchoredPosition = var_14_0

				return
			end)):setOnComplete(System.Action(function()
				return
			end))

			return
		end,
		getIndexPosition = function(arg_17_0, arg_17_1)
			return Vector2(-(arg_17_1 - 1) * var_0_2, 0)
		end,
		setPostionByIndex = function(self, arg_18_1)
			self._rectItem.anchoredPosition = self:getIndexPosition(arg_18_1)

			return
		end,
		getIndex = function(self)
			return self._index
		end,
		isDraging = function(self)
			return self._draging
		end,
		getDragScreenPos = function(self)
			return self._dragScreenPos
		end,
		clearTween = function(self)
			if LeanTween.isTweening(go(self._rectItem)) then
				LeanTween.cancel(go(self._rectItem))
			end

			return
		end,
		setVisible = function(self, arg_23_1)
			setActive(self._rectItem, arg_23_1)

			return
		end,
		clear = function(self)
			self._index = nil
			self._itemData = nil

			self:clearTween()
			self:setVisible(false)

			return
		end,
		dispose = function(self)
			ClearEventTrigger(self._eventTrigger)

			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

function PipeRectControll:Ctor(arg_26_1, arg_26_2, arg_26_3)
	var_0_1 = PipeGameVo
	self._rectTf = arg_26_1
	self._dragPos = arg_26_2
	self._content = findTF(self._rectTf, "pos")
	self._event = arg_26_3
	self.rectItems = {}

	local function var_26_0()
		self:onRectEventCall()

		return
	end

	for iter_26_0 = 1, var_0_3 do
		table.insert(self.rectItems, (var_0_5(PipeGameVo.GetTplItemFromPool(PipeGameConst.tpl_rect_item, self._content), self._dragPos, var_26_0)))
	end

	return
end

function PipeRectControll:start()
	self.rectDatas = self:getRandomRectDatas()

	self:fillRectItem()

	return
end

function PipeRectControll:step(arg_29_1)
	return
end

function PipeRectControll:stop()
	return
end

function PipeRectControll:clear()
	self.rectDatas = {}

	for iter_31_0 = 1, #self.rectItems do
		self.rectItems[iter_31_0]:clear()
	end

	self._draging = false

	return
end

function PipeRectControll:fillRectItem()
	if #self.rectDatas >= 0 then
		for iter_32_0 = 1, #self.rectItems do
			self.rectItems[iter_32_0]:setIndex(iter_32_0)

			if self.rectItems[iter_32_0]:getItem() == nil then
				self.rectItems[iter_32_0]:setItem(PipeGameConst.map_item_data[table.remove(self.rectDatas, 1)])
			end
		end
	end

	return
end

function PipeRectControll:onRectEventCall(arg_33_1, arg_33_2)
	return
end

function PipeRectControll:stopTopDrag()
	self.rectItems[1]:stopDrag()

	return
end

function PipeRectControll:getTopData()
	return self.rectItems[1]:getItem()
end

function PipeRectControll:removeTopRectData()
	local var_36_0 = table.remove(self.rectItems, 1)

	table.insert(self.rectItems, var_36_0)
	var_36_0:setPostionByIndex(var_0_3 + 1, false)
	var_36_0:setItem(PipeGameConst.map_item_data[table.remove(self.rectDatas, 1)])

	for iter_36_0 = 1, #self.rectItems do
		self.rectItems[iter_36_0]:setIndex(iter_36_0, true)
	end

	return
end

function PipeRectControll:getRandomRectDatas()
	local var_37_0 = {}
	local var_37_2 = PipeGameConst.map_rect_data[var_0_1.GetRoundData().id].list

	for iter_37_0, iter_37_1 in ipairs(PipeGameConst.map_rect_list[var_37_2[math.random(1, #var_37_2)]]) do
		for iter_37_2 = 1, iter_37_1[2] do
			table.insert(var_37_0, iter_37_1[1])
		end
	end

	return self:shuffleArray(var_37_0)
end

function PipeRectControll:shuffleArray(arg_38_1)
	for iter_38_0 = #arg_38_1, 2, -1 do
		local var_38_0 = math.random(iter_38_0)

		arg_38_1[iter_38_0], arg_38_1[var_38_0] = arg_38_1[var_38_0], arg_38_1[iter_38_0]
	end

	return arg_38_1
end

function PipeRectControll:dispose()
	for iter_39_0 = 1, #self.rectItems do
		self.rectItems[iter_39_0]:dispose()
	end

	return
end

return PipeRectControll
