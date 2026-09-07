local TouchCakeTowerController = class("TouchCakeTowerController")
local var_0_1

function TouchCakeTowerController:Ctor(arg_1_1, arg_1_2)
	var_0_1 = TouchCakeGameVo
	self._content = arg_1_1
	self._event = arg_1_2
	self._cakeContainer = findTF(self._content, "container")
	self.cakeItems = {}

	for iter_1_0 = 1, TouchCakeGameConst.max_cake_count do
		table.insert(self.cakeItems, (TouchCakeItem.New(var_0_1.GetTplItemFromPool("CakeTpl", self._cakeContainer), self._event)))
	end

	self._cakeContainerPool = findTF(self._content, "containerPool")
	self.cakeItemPool = {}

	return
end

function TouchCakeTowerController:start()
	self.touchAble = true
	self._moveBottomCallback = nil
	self._cakeBottomPos = Vector2(TouchCakeGameConst.cake_init_pos[1], TouchCakeGameConst.cake_init_pos[2])
	self._cakeContainer.anchoredPosition = self._cakeBottomPos
	self._cakeTargetHeight = self._cakeBottomPos.y
	self._cakeDownHeight = 0
	self.removeTimeTick = nil
	self.removeTimeTickCallback = nil

	for iter_2_0 = #self.cakeItemPool, 1, -1 do
		local var_2_0 = self:getItemFromPool()

		if var_2_0 then
			table.insert(self.cakeItems, var_2_0)
		end
	end

	self.weightTotal = nil

	self:randomCakeData()
	self:updateCakePos()

	return
end

function TouchCakeTowerController:step()
	if self.removeTimeTick and self.removeTimeTick >= 0 then
		self.removeTimeTick = self.removeTimeTick - var_0_1.deltaTime

		if self.removeTimeTick <= 0 then
			self.removeTimeTick = nil

			if self.removeTimeTickCallback then
				self.removeTimeTickCallback()
			end
		end
	end

	if self._cakeBottomPos.y ~= self._cakeTargetHeight then
		self._cakeBottomPos.y = self._cakeBottomPos.y - TouchCakeGameConst.cake_down_speed * var_0_1.deltaTime * math.sign(self._cakeBottomPos.y - self._cakeTargetHeight)

		if math.sign(self._cakeBottomPos.y - self._cakeTargetHeight) ~= math.sign(self._cakeBottomPos.y - self._cakeTargetHeight) then
			self._cakeBottomPos.y = self._cakeTargetHeight
		end

		self._cakeContainer.anchoredPosition = self._cakeBottomPos
	end

	if self._moveBottomCallback and self._cakeBottomPos.y == self._cakeTargetHeight then
		self._moveBottomCallback()

		self._moveBottomCallback = nil
	end

	return
end

function TouchCakeTowerController:randomCakeData()
	for iter_4_0 = 1, #self.cakeItems do
		local var_4_0 = self:getRandCakeData()
		local var_4_1
		local var_4_2

		if iter_4_0 ~= 1 then
			var_4_1, var_4_2 = self:getRandPropDataByRate()
		end

		self.cakeItems[iter_4_0]:setData(var_4_0, var_4_1, var_4_2)
	end

	return
end

function TouchCakeTowerController:getRandCakeData()
	return Clone(TouchCakeGameConst.cake_data[TouchCakeGameConst.cake_data.all[math.random(1, #TouchCakeGameConst.cake_data.all)]])
end

function TouchCakeTowerController:getItemFromPool()
	if #self.cakeItemPool > 0 then
		local var_6_0 = table.remove(self.cakeItemPool, 1)

		var_6_0:setParent(self._cakeContainer)
		print("从pool中拿取item, pool长度 =" .. #self.cakeItemPool)

		return var_6_0
	end

	return nil
end

function TouchCakeTowerController:addItemPool(arg_7_1)
	table.insert(self.cakeItemPool, arg_7_1)
	arg_7_1:setParent(self._cakeContainerPool)
	print("item放入pool  pool长度 =" .. #self.cakeItemPool)

	return
end

function TouchCakeTowerController:getRandPropDataByRate()
	if not self.weightTotal then
		self.weightTotal = 0
		self.weightData = {}

		for iter_8_0, iter_8_1 in ipairs(TouchCakeGameConst.prop_rate) do
			self.weightTotal = self.weightTotal + iter_8_1.weight

			table.insert(self.weightData, {
				weight = self.weightTotal,
				id = iter_8_1.id,
				times = (TouchCakeGameConst.prop_times and TouchCakeGameConst.prop_times[iter_8_1.id] or nil) and TouchCakeGameConst.prop_times[iter_8_1.id].times
			})
		end
	end

	if not self.propDirectPool or #self.propDirectPool == 0 then
		self.propDirectPool = Clone(TouchCakeGameConst.prop_random_direct[math.random(1, #TouchCakeGameConst.prop_random_direct)])
	end

	local var_8_1 = table.remove(self.propDirectPool, 1)

	if var_8_1 == 0 then
		return nil
	end

	local var_8_2 = math.random(1, self.weightTotal)
	local var_8_3

	for iter_8_2, iter_8_3 in ipairs(self.weightData) do
		if not var_8_3 and var_8_2 <= iter_8_3.weight then
			if iter_8_3.times < 1000 then
				iter_8_3.times = iter_8_3.times - 1
			end

			if iter_8_3.times < 0 then
				print("道具id " .. iter_8_3.id .. "次数用尽")

				break
			end

			var_8_3 = iter_8_3.id

			break
		end
	end

	if var_8_3 and var_8_3 ~= 0 then
		return Clone(TouchCakeGameConst.prop_data[var_8_3]), var_8_1
	end

	return nil
end

function TouchCakeTowerController:updateCakePos()
	local var_9_0 = Vector2(0, 0)

	for iter_9_0 = 1, #self.cakeItems do
		self.cakeItems[iter_9_0]:setPosition(var_9_0)

		var_9_0 = self.cakeItems[iter_9_0]:getTopPos()
	end

	for iter_9_1 = 1, #self.cakeItems do
		self.cakeItems[iter_9_1]:setLayerFirst()
	end

	return
end

function TouchCakeTowerController:touchBottomCake(arg_10_1, arg_10_2)
	if not self:getTouchAble() then
		return
	end

	self.touchAble = false

	seriesAsync({
		function(arg_11_0)
			self:removeBottomCake(arg_10_1, arg_11_0)

			self.removeTimeTick = TouchCakeGameConst.remove_time
			self.removeTimeTickCallback = arg_11_0

			return
		end,
		function(arg_12_0)
			self:activeCakeProp(arg_12_0)

			return
		end,
		function(arg_13_0)
			self:moveCakeToBottom(arg_13_0)

			return
		end
	}, function()
		self.touchAble = true

		return
	end)

	return
end

function TouchCakeTowerController:getTouchAble()
	return self.touchAble
end

function TouchCakeTowerController:removeBottomCake(arg_16_1, arg_16_2)
	local var_16_0 = table.remove(self.cakeItems, 1)

	self:addItemPool(var_16_0)
	var_16_0:touchAction(arg_16_1, function()
		self:addCakeToTop()

		return
	end)

	self._cakeDownHeight = self._cakeDownHeight - var_16_0:getCakeConfig("height")

	return
end

function TouchCakeTowerController:moveCakeToBottom(arg_18_1)
	self._cakeTargetHeight = self._cakeDownHeight
	self._moveBottomCallback = arg_18_1

	return
end

function TouchCakeTowerController:addCakeToTop()
	local var_19_0 = self:getItemFromPool()

	if var_19_0 then
		local var_19_1 = self.cakeItems[#self.cakeItems]:getPropDirect()

		var_19_0:setPosition((self.cakeItems[#self.cakeItems]:getTopPos()))

		local var_19_2, var_19_3 = self:getRandPropDataByRate()

		var_19_0:setData(self:getRandCakeData(), var_19_2, var_19_3)
		table.insert(self.cakeItems, var_19_0)

		for iter_19_0 = 1, #self.cakeItems do
			self.cakeItems[iter_19_0]:setLayerFirst()
		end
	end

	return
end

function TouchCakeTowerController:activeCakeProp(arg_20_1)
	local var_20_0 = self.cakeItems[1]:propAction()

	if arg_20_1 then
		arg_20_1()
	end

	return
end

function TouchCakeTowerController:onKeyCode()
	return
end

function TouchCakeTowerController:stop()
	for iter_22_0 = 1, #self.cakeItems do
		self.cakeItems[iter_22_0]:stop()
	end

	for iter_22_1 = 1, #self.cakeItemPool do
		self.cakeItemPool[iter_22_1]:stop()
	end

	return
end

function TouchCakeTowerController:resume()
	for iter_23_0 = 1, #self.cakeItems do
		self.cakeItems[iter_23_0]:resume()
	end

	for iter_23_1 = 1, #self.cakeItemPool do
		self.cakeItemPool[iter_23_1]:resume()
	end

	return
end

function TouchCakeTowerController:clear()
	return
end

function TouchCakeTowerController:dispose()
	return
end

return TouchCakeTowerController
