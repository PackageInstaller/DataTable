local PipeMapControl = class("PipeMapControl")
local var_0_1
local var_0_2 = "left"
local var_0_3 = "right"
local var_0_4 = "top"
local var_0_5 = "bottom"
local var_0_6 = 0
local var_0_7 = 0
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = 1
local var_0_11 = 2

PipeMapControl.CLICK_MAP_ITEM = "click map item"

local function var_0_12(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		ctor = function(self)
			self._itemTf = arg_1_0
			self._index = arg_1_1
			self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
			self._canvasGroup = GetComponent(self._itemTf, typeof(CanvasGroup))
			self._animTf = findTF(self._itemTf, "anim")
			self._imgTf = findTF(self._animTf, "img")
			self._imgFullTf = findTF(self._animTf, "imgFull")
			self._animator = GetComponent(findTF(self._itemTf, "anim"), typeof(Animator))
			self._eventCallback = arg_1_2
			self._freeze = false
			self._dftEvent = GetComponent(self._animTf, typeof(DftAniEvent))
			self._clickTf = findTF(self._animTf, "click")
			self._eventTriggerListener = GetOrAddComponent(self._clickTf, typeof(EventTriggerListener))

			self._eventTriggerListener:AddPointDownFunc(function()
				if not self._data and self._eventCallback then
					self._eventCallback(PipeMapControl.CLICK_MAP_ITEM, self)
				end

				return
			end)

			return
		end,
		setData = function(self, arg_4_1)
			self._data = arg_4_1

			if self._data then
				self._animationFlag = false

				self:loadImg(self._data.img, self._data.img_full)
				self:setItemVisible(true)
				self:setAlpha(1)
			else
				self:setItemVisible(false)
			end

			return
		end,
		getData = function(self)
			return self._data
		end,
		setTempData = function(self, arg_6_1)
			if self._data then
				warning("已经存在格子数据，无需设置预览数据")

				return
			end

			self._tempData = arg_6_1

			self:loadImg(self._tempData.img, self._tempData.img_full)
			self:setItemVisible(true)
			self:setAlpha(0.5)

			return
		end,
		getTempData = function(self)
			return self._tempData
		end,
		loadImg = function(self, arg_8_1, arg_8_2)
			setImageSprite(self._imgTf, var_0_1.GetSprite(arg_8_1))
			setImageSprite(self._imgFullTf, var_0_1.GetSprite(arg_8_2))

			return
		end,
		setItemVisible = function(self, arg_9_1)
			setActive(self._imgTf, arg_9_1)
			setActive(self._imgFullTf, arg_9_1)

			return
		end,
		changeTempToReal = function(self)
			if self._tempData then
				self:setData(self._tempData)

				self._tempData = nil
			end

			return
		end,
		setTriggerName = function(self, arg_11_1)
			if self._animationFlag then
				return
			end

			self._animationFlag = true

			if self.animTriggerName then
				self._animator:ResetTrigger(self.animTriggerName)
			end

			self.animTriggerName = arg_11_1

			return
		end,
		playAnim = function(self, arg_12_1)
			self._success = true

			if self.animTriggerName then
				self._animator:SetTrigger(self.animTriggerName)

				if arg_12_1 then
					self._dftEvent:SetEndEvent(function()
						arg_12_1()
						self._dftEvent:SetEndEvent(nil)

						return
					end)
				end
			end

			return
		end,
		getAnimationFlag = function(self)
			return self._animationFlag
		end,
		setVisible = function(self, arg_15_1)
			setActive(self._itemTf, arg_15_1)

			return
		end,
		freeze = function(self, arg_16_1)
			self._freeze = arg_16_1

			self:setVisible(not self._freeze)

			return
		end,
		getFreeze = function(self)
			return self._freeze
		end,
		getSuccess = function(self)
			return self._success
		end,
		setSelect = function(self, arg_19_1)
			self:setTempData(arg_19_1)

			return
		end,
		setAlpha = function(self, arg_20_1)
			self._canvasGroup.alpha = arg_20_1

			return
		end,
		setPosition = function(self, arg_21_1)
			self._itemTf.anchoredPosition = arg_21_1

			return
		end,
		getIndex = function(self)
			return self._index
		end,
		clear = function(self)
			self._data = nil
			self._tempData = nil
			self._success = false

			self:setItemVisible(false)
			self:setAlpha(1)

			return
		end,
		getScreenPos = function(self, arg_24_1)
			if not self._screenPos then
				self:updateScreenPos()
			end

			return self._screenPos
		end,
		updateScreenPos = function(self)
			self._screenPos = self._uiCamera:WorldToScreenPoint(self._itemTf.position)

			return
		end,
		getDirect = function(self)
			return self._data.direct
		end,
		dispose = function(self)
			ClearEventTrigger(self._eventTriggerListener)

			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

function PipeMapControl:Ctor(arg_28_1, arg_28_2)
	var_0_1 = PipeGameVo
	self._mapTf = arg_28_1
	self._eventCallback = arg_28_2
	self._mapItems = {}

	function self.mapItemCallback(arg_29_0, arg_29_1)
		if PipeMapControl.CLICK_MAP_ITEM == arg_29_0 then
			if self._dragTempItem then
				self._dragTempItem:clear()

				self._dragTempItem = nil
			end

			self._eventCallback(PipeGameEvent.STOP_RECT_DRAG)

			if not self._clickTempItem then
				self._clickTempItem = arg_29_1

				self._eventCallback(PipeGameEvent.SET_TOP_RECT)
			elseif self._clickTempItem ~= arg_29_1 then
				self._clickTempItem:clear()

				self._clickTempItem = arg_29_1

				self._eventCallback(PipeGameEvent.SET_TOP_RECT)
			elseif self._clickTempItem:getTempData() then
				self._clickTempItem:changeTempToReal()

				self._clickTempItem = nil

				self._eventCallback(PipeGameEvent.REMOVE_RECT_TOP)

				if self:checkFull() then
					self:startOverAniamtion()
				end
			end
		end

		return
	end

	return
end

function PipeMapControl:setClickTempItem(arg_30_1)
	if self._clickTempItem and not self._clickTempItem:getTempData() then
		self._clickTempItem:setTempData(arg_30_1)
	end

	return
end

function PipeMapControl:start()
	self._overFlag = false
	self._clickTempItem = nil
	self._gameRoundData = PipeGameVo.GetRoundData()
	self._mapBound = self._gameRoundData.map_bound
	self._mapSpacing = self._gameRoundData.item_spacing
	self._inputIndex = self._gameRoundData.input_index
	self._randomId = self._gameRoundData.random_id
	self._randomItemData = PipeGameConst.map_random_data[self._randomId]
	findTF(self._mapTf, "bg").sizeDelta = Vector2(self._mapSpacing[1] * self._mapBound[1], self._mapSpacing[2] * self._mapBound[2])
	self._maxItem = self._mapBound[1] * self._mapBound[2]

	for iter_31_0 = 1, self._maxItem do
		local var_31_0

		if iter_31_0 > #self._mapItems then
			var_31_0 = var_0_12(PipeGameVo.GetTplItemFromPool(PipeGameConst.tpl_map_item, self._mapTf), iter_31_0, self.mapItemCallback)

			var_31_0:setPosition((self:getItemPosByIndex(iter_31_0, self._mapBound[1], self._mapSpacing)))
			table.insert(self._mapItems, var_31_0)
		else
			var_31_0 = self._mapItems[iter_31_0]
		end

		var_31_0:freeze(false)
		var_31_0:clear()
		var_31_0:setData(self:getRandomItemByIndex(iter_31_0))
	end

	for iter_31_1 = self._maxItem + 1, #self._mapItems do
		self._mapItems[iter_31_1]:freeze(true)
	end

	return
end

function PipeMapControl:getRandomItemByIndex(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(self._randomItemData.list) do
		if iter_32_1[1] == arg_32_1 then
			if type(iter_32_1[2]) == "number" then
				return PipeGameConst.map_item_data[iter_32_1[2]]
			elseif type(iter_32_1[2]) == "table" then
				return PipeGameConst.map_item_data[iter_32_1[2][math.random(1, #iter_32_1[2])]]
			end
		end
	end

	return nil
end

function PipeMapControl:step(arg_33_1)
	if var_0_1.draging then
		if self._clickTempItem then
			self._clickTempItem:clear()

			self._clickTempItem = nil
		end

		local var_33_0 = self:getItemByScreenPos(var_0_1.dragScreenPos)

		if var_33_0 and not var_33_0:getData() then
			if self._dragTempItem ~= var_33_0 then
				if self._dragTempItem then
					self._dragTempItem:clear()
				end

				self._dragTempItem = var_33_0

				self._dragTempItem:setTempData(var_0_1.dragItem)
			end
		else
			if self._dragTempItem then
				self._dragTempItem:clear()
			end

			self._dragTempItem = nil
		end

		self._draging = var_0_1.draging
	else
		if self._draging and self._dragTempItem then
			self._dragTempItem:changeTempToReal()

			self._dragTempItem = nil

			self._eventCallback(PipeGameEvent.REMOVE_RECT_TOP)

			if self:checkFull() then
				self:startOverAniamtion()
			end
		end

		self._draging = var_0_1.draging
	end

	if var_0_1.gameDragTime <= 0 then
		self:startOverAniamtion()
	end

	return
end

function PipeMapControl:startOverAniamtion()
	if self._overFlag then
		return
	end

	self._eventCallback(PipeGameEvent.START_SETTLEMENT)

	self._overFlag = true
	self._animationRound = 1

	local var_34_0 = {}
	local var_34_1 = self:getItemByIndex(self._inputIndex)

	if var_34_1:getData() and (var_34_1:getDirect()[2] == 0 or var_34_1:getDirect()[2] == 1) then
		var_34_1:setTriggerName(var_0_4)
		table.insert(var_34_0, var_34_1)
		self:playOverAniamtion(var_34_0, function()
			self._eventCallback(PipeGameEvent.PALY_ANIMATION_COMPLETE)

			return
		end)
	else
		self._eventCallback(PipeGameEvent.PALY_ANIMATION_COMPLETE)
	end

	return
end

function PipeMapControl:getSuccessCount()
	local var_36_0 = 0

	for iter_36_0 = 1, #self._mapItems do
		if self._mapItems[iter_36_0]:getSuccess() and not self._mapItems[iter_36_0]:getFreeze() then
			var_36_0 = var_36_0 + 1
		end
	end

	return var_36_0
end

function PipeMapControl:checkFull()
	local var_37_0 = 0

	for iter_37_0 = 1, #self._mapItems do
		if not self._mapItems[iter_37_0]:getFreeze() and not self._mapItems[iter_37_0]:getData() then
			var_37_0 = var_37_0 + 1
		end
	end

	return var_37_0 == 0
end

function PipeMapControl:playOverAniamtion(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = {}
	local var_38_1 = 0
	local var_38_2 = #arg_38_1
	local var_38_3

	if arg_38_3 then
		var_38_3 = arg_38_3 + 1 or 1
	end

	local function var_38_4()
		var_38_1 = var_38_1 + 1

		if var_38_1 == var_38_2 then
			if #var_38_0 == 0 and arg_38_2 then
				arg_38_2()
			else
				self:playOverAniamtion(var_38_0, arg_38_2, var_38_3)
			end
		end

		return
	end

	for iter_38_0, iter_38_1 in ipairs(arg_38_1) do
		local var_38_5 = self:getItemsByDirect(iter_38_1, var_38_3)

		self:setItemsTriggerName(iter_38_1, var_38_5)

		for iter_38_2, iter_38_3 in ipairs(var_38_5) do
			if not table.contains(var_38_0, iter_38_3) then
				table.insert(var_38_0, iter_38_3)
			end
		end

		iter_38_1:playAnim(var_38_4)
	end

	return
end

function PipeMapControl:setItemsTriggerName(arg_40_1, arg_40_2)
	for iter_40_0, iter_40_1 in ipairs(arg_40_2) do
		local var_40_0 = arg_40_1:getIndex()
		local var_40_1 = iter_40_1:getIndex()
		local var_40_2

		if var_40_1 < var_40_0 then
			var_40_2 = var_40_1 == var_40_0 - 1 and var_0_3 or var_0_5
		elseif var_40_0 < var_40_1 then
			var_40_2 = var_40_1 == var_40_0 + 1 and var_0_2 or var_0_4
		end

		if var_40_2 then
			iter_40_1:setTriggerName(var_40_2)
		end
	end

	return
end

function PipeMapControl:getItemsByDirect(arg_41_1, arg_41_2)
	local var_41_0 = {}
	local var_41_2 = arg_41_1:getDirect()
	local var_41_3 = arg_41_1:getIndex()

	if var_41_2[1] == var_0_6 or var_41_2[1] == var_0_11 then
		table.insert(var_41_0, var_41_3 + 1)
	end

	if var_41_2[1] == var_0_6 or var_41_2[1] == var_0_10 then
		table.insert(var_41_0, var_41_3 - 1)
	end

	if var_41_2[2] == var_0_7 or var_41_2[2] == var_0_8 then
		table.insert(var_41_0, var_41_3 - self._mapBound[1])
	end

	if var_41_2[2] == var_0_7 or var_41_2[2] == var_0_9 then
		table.insert(var_41_0, var_41_3 + self._mapBound[1])
	end

	for iter_41_0 = #var_41_0, 1, -1 do
		local var_41_4 = self:getItemByIndex(var_41_0[iter_41_0])

		if var_41_4 and var_41_4:getData() then
			if not self:checkItemSuccess(var_41_3, var_41_4:getIndex(), var_41_2, var_41_4:getDirect()) then
				table.remove(var_41_0, iter_41_0)
			end
		else
			table.remove(var_41_0, iter_41_0)
		end
	end

	local var_41_5 = {}

	for iter_41_1, iter_41_2 in ipairs(var_41_0) do
		local var_41_6 = self:getItemByIndex(iter_41_2)

		if var_41_6 and not var_41_6:getAnimationFlag() then
			table.insert(var_41_5, var_41_6)
		end
	end

	return var_41_5
end

function PipeMapControl:checkItemSuccess(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = false

	if arg_42_2 - arg_42_1 == 1 then
		if (arg_42_3[1] == var_0_6 or arg_42_3[1] == var_0_11) and (arg_42_4[1] == var_0_6 or arg_42_4[1] == var_0_10) then
			var_42_0 = (arg_42_1 - 1) % self._mapBound[1] ~= self._mapBound[1] - 1
		end
	elseif arg_42_1 - arg_42_2 == 1 then
		if (arg_42_3[1] == var_0_6 or arg_42_3[1] == var_0_10) and (arg_42_4[1] == var_0_6 or arg_42_4[1] == var_0_11) then
			var_42_0 = (arg_42_1 - 1) % self._mapBound[1] ~= 0
		end
	elseif arg_42_2 - arg_42_1 == self._mapBound[1] then
		if (arg_42_3[2] == var_0_7 or arg_42_3[2] == var_0_9) and (arg_42_4[2] == var_0_7 or arg_42_4[2] == var_0_8) then
			var_42_0 = true
		end
	elseif arg_42_1 - arg_42_2 == self._mapBound[1] and (arg_42_3[2] == var_0_7 or arg_42_3[2] == var_0_8) and (arg_42_4[2] == var_0_7 or arg_42_4[2] == var_0_9) then
		var_42_0 = true
	end

	return var_42_0
end

function PipeMapControl:getItemByIndex(arg_43_1)
	return self._mapItems[arg_43_1]
end

function PipeMapControl:getItemByScreenPos(arg_44_1)
	local var_44_0 = self:getScreentScaleRate()

	for iter_44_0 = 1, #self._mapItems do
		local var_44_1 = self._mapItems[iter_44_0]:getScreenPos()

		if arg_44_1.x > var_44_1.x and arg_44_1.x < var_44_1.x + self._mapSpacing[1] / var_44_0.x and arg_44_1.y < var_44_1.y and arg_44_1.y > var_44_1.y - self._mapSpacing[2] / var_44_0.y then
			return self._mapItems[iter_44_0]
		end
	end

	return nil
end

function PipeMapControl:getScreentScaleRate()
	local var_45_0 = tf(GameObject.Find("UICamera/Canvas"))

	return Vector2(var_45_0.sizeDelta.x / UnityEngine.Screen.width, var_45_0.sizeDelta.y / UnityEngine.Screen.height)
end

function PipeMapControl:getItemPosByIndex(arg_46_1, arg_46_2, arg_46_3)
	return Vector2((arg_46_1 - 1) % arg_46_2 * arg_46_3[1], -math.floor((arg_46_1 - 1) / arg_46_2) * arg_46_3[2])
end

function PipeMapControl:stop()
	return
end

function PipeMapControl:clear()
	if self._dragTempItem then
		self._dragTempItem:clear()

		self._dragTempItem = nil
	end

	return
end

function PipeMapControl:dispose()
	return
end

return PipeMapControl
