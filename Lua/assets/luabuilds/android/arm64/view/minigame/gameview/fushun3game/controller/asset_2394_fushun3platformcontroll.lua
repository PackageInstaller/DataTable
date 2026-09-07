local Fushun3PlatformControll = class("Fushun3PlatformControll")

function Fushun3PlatformControll:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._tplTf = arg_1_2
	self._content = arg_1_3
	self._event = arg_1_4
	self._platformPool = {}
	self._platforms = {}
	self._sceneTf = arg_1_1
	self._weightTotal = 0
	self.createDatas = nil

	return
end

function Fushun3PlatformControll:start()
	self.moveDistance = 0
	self.fillDistance = 0
	self.level = 0

	for iter_2_0 = #self._platforms, 1, -1 do
		local var_2_0 = table.remove(self._platforms, iter_2_0)

		setActive(var_2_0.tf, false)
		table.insert(self._platformPool, var_2_0)
	end

	self.createDatas = {}
	self._weightTotal = 0

	for iter_2_1 = 1, #Fushun3GameConst.platform_data do
		local var_2_1 = Clone(Fushun3GameConst.platform_data[iter_2_1])

		self._weightTotal = self._weightTotal + var_2_1.weight

		table.insert(self.createDatas, {
			config = var_2_1,
			weight = self._weightTotal
		})
	end

	self.initTimes = false

	self:fillPlatform()

	self.initTimes = true
	self.timeFlag = Fushun3GameVo.GetTimeFlag()

	self:changePlatformShow(false)

	return
end

function Fushun3PlatformControll:updateCreateData()
	self.createDatas = {}
	self._weightTotal = 0

	for iter_3_0 = 1, #Fushun3GameConst.platform_data do
		local var_3_0 = Clone(Fushun3GameConst.platform_data[iter_3_0])

		self._weightTotal = self._weightTotal + var_3_0.weight + var_3_0.diff * self.level

		table.insert(self.createDatas, {
			config = var_3_0,
			weight = self._weightTotal
		})
	end

	return
end

function Fushun3PlatformControll:fillPlatform()
	if self.fillDistance < self.moveDistance + Fushun3GameConst.platform_distance then
		local var_4_0 = self:getPlatform()

		if var_4_0.high then
			setActive(findTF(var_4_0.tf, "high_roof"), true)
		end

		table.insert(self._platforms, var_4_0)

		var_4_0.anchoredX = self.fillDistance
		var_4_0.tf.anchoredPosition = Vector2(self.fillDistance, 0)

		setActive(var_4_0.tf, true)
		GetComponent(var_4_0.tf, typeof(Animator)):SetTrigger(Fushun3GameVo.GetTimeFlag() and "day_no_fade" or "night_no_fade")

		if var_4_0.monster then
			self._event:emit(Fushun3GameEvent.create_monster_call, {
				pos = findTF(var_4_0.tf, "monster").position
			})
		end

		if var_4_0.item then
			local var_4_1 = {
				pos = findTF(var_4_0.tf, "item").position
			}

			var_4_1.id = 0

			self._event:emit(Fushun3GameEvent.create_platform_item_call, var_4_1)
		end

		self.fillDistance = self.fillDistance + var_4_0.distance

		self:fillPlatform()
	end

	return
end

function Fushun3PlatformControll:getPlatform()
	local var_5_0

	if self.powerNum and self.powerNum > 0 then
		self.powerNum = self.powerNum - 1
		var_5_0 = self.powerNum <= 15 and self:getPowerPlatform() or self:getRandomPlatform()
	else
		var_5_0 = self:getRandomPlatform()
	end

	local var_5_1 = var_5_0.name
	local var_5_2 = self:getPlatformFromPool(var_5_0.name)

	if not var_5_2 then
		local var_5_3 = tf(instantiate(findTF(self._tplTf, var_5_1)))

		var_5_3.localScale = Fushun3GameConst.game_scale_v3

		for iter_5_0 = 0, 5 do
			local var_5_4 = findTF(var_5_3, "collider" .. (iter_5_0 == 0 and "" or iter_5_0))

			if var_5_4 then
				var_5_4.gameObject.layer = LayerMask.NameToLayer("Collider")
			end
		end

		local var_5_5 = findTF(var_5_3, "high_roof")

		if var_5_5 then
			var_5_5.gameObject.layer = LayerMask.NameToLayer("Collider")
		end

		setParent(var_5_3, self._content)

		var_5_2 = {
			name = var_5_1,
			tf = var_5_3,
			distance = var_5_0.distance * Fushun3GameConst.game_scale,
			monster = var_5_0.monster,
			high = var_5_0.high,
			item = var_5_0.item
		}
	end

	return var_5_2
end

function Fushun3PlatformControll:getPowerPlatform()
	for iter_6_0 = 1, 10 do
		local var_6_0 = self.initTimes and math.random(1, self._weightTotal) or 1

		for iter_6_1, iter_6_2 in ipairs(self.createDatas) do
			if var_6_0 <= iter_6_2.weight and iter_6_2.config.power then
				return iter_6_2.config
			end
		end
	end

	return self:getRandomPlatform()
end

function Fushun3PlatformControll:getRandomPlatform()
	local var_7_0 = self.initTimes and math.random(1, self._weightTotal) or 1

	for iter_7_0 = 1, #self.createDatas do
		if var_7_0 <= self.createDatas[iter_7_0].weight then
			return self.createDatas[iter_7_0].config
		end
	end

	return
end

function Fushun3PlatformControll:getPlatformFromPool(arg_8_1)
	for iter_8_0 = 1, #self._platformPool do
		if self._platformPool[iter_8_0].name == arg_8_1 then
			return table.remove(self._platformPool, iter_8_0)
		end
	end

	return nil
end

function Fushun3PlatformControll:removePlatform()
	for iter_9_0 = #self._platforms, 1, -1 do
		if self._platforms[iter_9_0].anchoredX < self.moveDistance - Fushun3GameConst.platform_remove then
			setActive(self._platforms[iter_9_0].tf, false)
			table.insert(self._platformPool, table.remove(self._platforms, iter_9_0))
		end
	end

	return
end

function Fushun3PlatformControll:step()
	self.moveDistance = math.abs(self._sceneTf.anchoredPosition.x)

	self:fillPlatform()
	self:removePlatform()

	return
end

function Fushun3PlatformControll:levelUp()
	self.level = self.level + 1

	self:updateCreateData()

	return
end

function Fushun3PlatformControll:updateDayNight()
	if self.timeFlag ~= Fushun3GameVo.GetTimeFlag() then
		self.timeFlag = Fushun3GameVo.GetTimeFlag()

		self:changePlatformShow(true)
	end

	return
end

function Fushun3PlatformControll:changePlatformShow(arg_13_1)
	for iter_13_0 = #self._platforms, 1, -1 do
		local var_13_0 = self._platforms[iter_13_0].tf

		if arg_13_1 then
			GetComponent(var_13_0, typeof(Animator)):SetTrigger(Fushun3GameVo.GetTimeFlag() and "day" or "night")
		else
			GetComponent(findTF(var_13_0, "day"), typeof(CanvasGroup)).alpha = Fushun3GameVo.GetTimeFlag() and 1 or 0
			GetComponent(findTF(var_13_0, "night"), typeof(CanvasGroup)).alpha = Fushun3GameVo.GetTimeFlag() and 0 or 1
		end
	end

	return
end

function Fushun3PlatformControll:onPlayerPower()
	self.powerNum = 20

	return
end

function Fushun3PlatformControll:dipose()
	return
end

return Fushun3PlatformControll
