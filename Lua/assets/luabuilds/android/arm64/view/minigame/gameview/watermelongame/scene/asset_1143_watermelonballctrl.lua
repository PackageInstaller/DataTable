local WatermelonBallCtrl = class("WatermelonBallCtrl")

function WatermelonBallCtrl:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._content = arg_1_1
	self._contextData = arg_1_2
	self._event = arg_1_3
	self._startPos = findTF(self._content, "start_pos")
	self._rayTf = findTF(self._startPos, "ray")
	self._left = findTF(self._content, "left")
	self._right = findTF(self._content, "right")
	self._container = findTF(self._content, "container")
	self._megerEffect = findTF(self._content, "meger_effect")

	if self._megerEffect then
		setActive(self._megerEffect, false)
	end

	self._tempRect = findTF(self._container, "temp_rect")
	self.leftPos = self._left.anchoredPosition.x
	self.rightPos = self._right.anchoredPosition.x
	self._balls = {}
	self._layerMask = LayerMask.GetMask("UI")

	print("log ball ctrl init complete")

	return
end

function WatermelonBallCtrl:setGameVo(arg_2_1)
	self._gameVo = arg_2_1

	return
end

function WatermelonBallCtrl:start()
	self:clear()

	self.createBallCd = 0
	self.nextBallId = nil

	return
end

function WatermelonBallCtrl:step(arg_4_1)
	if not self.nextBallId then
		self.nextBallId = self:getRandomIdByWeight()

		self._event:emit(WatermelonGameEvent.UPDATE_NEXT_BALL, self.nextBallId)
	end

	if not self.readyBall then
		if not self.createBallCd then
			self:setCreateCd()
		end

		if self.createBallCd and self.createBallCd >= 0 then
			self.createBallCd = self.createBallCd - self._gameVo.deltaTime

			if self.createBallCd <= 0 then
				self.createBallCd = nil

				self:createReadyBall()
			end
		end
	else
		self.readyBall.tf.anchoredPosition = self._startPos.anchoredPosition

		local var_4_0 = Physics2D.Raycast(self._startPos.position, Vector2(0, -1))

		if var_4_0 and var_4_0.transform then
			self._rayTf.sizeDelta = Vector2(self._rayTf.sizeDelta.x, math.abs(self._startPos:InverseTransformPoint(Vector2(var_4_0.point.x, var_4_0.point.y, 0)).y))
		end
	end

	if isActive(self._rayTf) ~= not not self.readyBall then
		setActive(self._rayTf, not not self.readyBall)
	end

	if self.tickToOver then
		self.tickToOver = self.tickToOver - arg_4_1

		if self.tickToOver and self.tickToOver <= 0 then
			self._event:emit(WatermelonGameEvent.GAME_OVER, true)

			self.tickToOver = nil
		end
	end

	return
end

function WatermelonBallCtrl:clear()
	self.countId = WatermelonGameConst.ball_count_id
	self.tickToOver = nil

	if self._megerEffect then
		setActive(self._megerEffect, false)
	end

	self:clearBallContainer()

	return
end

function WatermelonBallCtrl:stop()
	return
end

function WatermelonBallCtrl:resume()
	return
end

function WatermelonBallCtrl:dispose()
	return
end

function WatermelonBallCtrl:moveWorld(arg_9_1)
	if self.readyBall then
		local var_9_0 = self._content:InverseTransformPoint(arg_9_1.pos)

		if var_9_0.x < self.leftPos + self.readyBall.size then
			var_9_0.x = self.leftPos + self.readyBall.size
		elseif var_9_0.x > self.rightPos - self.readyBall.size then
			var_9_0.x = self.rightPos - self.readyBall.size
		end

		self._startPos.anchoredPosition = Vector2(var_9_0.x, self._startPos.anchoredPosition.y)

		if arg_9_1.callback then
			arg_9_1.callback(true)
		end
	elseif arg_9_1.callback then
		arg_9_1.callback(false)
	end

	return
end

function WatermelonBallCtrl:move(arg_10_1)
	if not self.readyBall then
		return
	end

	local var_10_0 = self._startPos.anchoredPosition

	if arg_10_1 > 0 then
		var_10_0.x = var_10_0.x + self._gameVo.deltaTime * 300
	elseif arg_10_1 < 0 then
		var_10_0.x = var_10_0.x - self._gameVo.deltaTime * 300
	end

	if var_10_0.x < self.leftPos + self.readyBall.size then
		var_10_0.x = self.leftPos + self.readyBall.size
	elseif var_10_0.x > self.rightPos - self.readyBall.size then
		var_10_0.x = self.rightPos - self.readyBall.size
	end

	self._startPos.anchoredPosition = var_10_0

	return
end

function WatermelonBallCtrl:dropBall()
	if self.readyBall then
		self:setBallPhysics(self.readyBall, true)
		table.insert(self._balls, self.readyBall)

		self.readyBall = nil

		self:setCreateCd()
	end

	return
end

function WatermelonBallCtrl:createReadyBall()
	local var_12_0, var_12_1 = self._gameVo:getTplItemFromPool("ball", self._container)

	self._startPos.anchoredPosition = Vector2(0, self._startPos.anchoredPosition.y)
	var_12_0.anchoredPosition = self._startPos.anchoredPosition

	local var_12_2 = self:initBallData(var_12_0, self.nextBallId)

	self.nextBallId = nil
	self.readyBall = var_12_2

	self:setBallEvent(var_12_2)
	self:setBallPhysics(self.readyBall, false)

	return
end

function WatermelonBallCtrl:createMegerBall(arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = self._gameVo:getTplItemFromPool("ball", self._container)

	var_13_0.position = Vector3(arg_13_2.x, arg_13_2.y, 0)

	if self._megerEffect then
		self._megerEffect.position = var_13_0.position

		setActive(self._megerEffect, false)
		setActive(self._megerEffect, true)
	end

	local var_13_2 = self:initBallData(var_13_0, arg_13_1)

	self:setBallEvent(var_13_2)
	table.insert(self._balls, var_13_2)

	return
end

function WatermelonBallCtrl:setBallEvent(arg_14_1)
	self.physics2DItem = GetComponent(arg_14_1.tf, "Physics2DItem")

	self.physics2DItem.CollisionEnter:AddListener(function(arg_15_0)
		self:checkCollisionBall(arg_15_0)

		return
	end)
	self.physics2DItem.TriggerEnter:AddListener(function(arg_16_0)
		self:checkCollisionTop(arg_16_0, true)

		return
	end)
	self.physics2DItem.TriggerExit:AddListener(function(arg_17_0)
		self:checkCollisionTop(arg_17_0, false)

		return
	end)

	return
end

function WatermelonBallCtrl:checkCollisionBall(arg_18_1)
	local var_18_0 = self:getBallByTf(arg_18_1.collider.transform)
	local var_18_1 = self:getBallByTf(arg_18_1.otherCollider.transform)
	local var_18_2 = self:checkColliderBall(var_18_0, var_18_1)

	if var_18_2 then
		self:removeBall(var_18_0)
		self:removeBall(var_18_1)
		self:createMegerBall(var_18_0.next, arg_18_1:GetContact(0).point)
		self._event:emit(WatermelonGameEvent.ADD_SCORE, {
			num = WatermelonGameConst.ball_data[var_18_0.next].score
		})
	elseif not var_18_2 then
		-- block empty
	end

	return
end

function WatermelonBallCtrl:checkCollisionTop(arg_19_1, arg_19_2)
	print(arg_19_1.transform.name)

	if arg_19_1.transform.name == "top" then
		self.tickToOver = arg_19_2 and (self.tickToOver or WatermelonGameConst.enter_top_over_time) or nil
	end

	return
end

function WatermelonBallCtrl:setBallPhysics(arg_20_1, arg_20_2)
	GetComponent(arg_20_1.tf, "Rigidbody2D").simulated = arg_20_2

	return
end

function WatermelonBallCtrl:removeBall(arg_21_1)
	for iter_21_0 = #self._balls, 1, -1 do
		if self._balls[iter_21_0] == arg_21_1 then
			local var_21_0 = table.remove(self._balls, iter_21_0)

			GetComponent(arg_21_1.tf, "Physics2DItem").CollisionEnter:RemoveAllListeners()
			Destroy(var_21_0.tf)

			return true
		end
	end

	warning("移除ball失败 name = " .. arg_21_1.name)

	return false
end

function WatermelonBallCtrl:checkColliderBall(arg_22_1, arg_22_2)
	if arg_22_1 and arg_22_2 then
		if arg_22_1.id == arg_22_2.id then
			if arg_22_1.next > 0 and arg_22_2.next > 0 and arg_22_1.next == arg_22_2.next then
				return true
			else
				return false
			end
		else
			return false
		end
	end

	return false
end

function WatermelonBallCtrl:getBallByTf(arg_23_1)
	for iter_23_0 = 1, #self._balls do
		if self._balls[iter_23_0].tf == arg_23_1 then
			return self._balls[iter_23_0]
		end
	end

	return nil
end

function WatermelonBallCtrl:getBallByName(arg_24_1)
	for iter_24_0 = 1, #self._balls do
		if self._balls[iter_24_0].name == arg_24_1 then
			return self._balls[iter_24_0]
		end
	end

	return nil
end

function WatermelonBallCtrl:clearBallContainer()
	for iter_25_0 = 1, #self._balls do
		GetComponent(self._balls[iter_25_0].tf, "Physics2DItem").CollisionEnter:RemoveAllListeners()
		Destroy(self._balls[iter_25_0].tf)
	end

	self._balls = {}

	return
end

function WatermelonBallCtrl:setCreateCd()
	self.createBallCd = self._gameVo.createBallCd

	return
end

function WatermelonBallCtrl:initBallData(arg_27_1, arg_27_2)
	setActive(arg_27_1, true)

	local var_27_0 = arg_27_2 and arg_27_2 or self:getRandomIdByWeight()
	local var_27_1 = WatermelonGameConst.ball_data[var_27_0]

	GetComponent(arg_27_1, typeof(UnityEngine.CircleCollider2D)).radius = WatermelonGameConst.ball_data[var_27_0].size

	self:setChildVisible(findTF(arg_27_1, "size_image"), false)
	setActive(findTF(arg_27_1, "size_image/" .. var_27_0), true)

	self.countId = self.countId + 1
	arg_27_1.name = "ball_" .. self.countId

	return {
		id = var_27_1.id,
		tf = arg_27_1,
		rigidbody = GetComponent(arg_27_1, "Rigidbody2D"),
		count = self.countId,
		name = arg_27_1.name,
		next = var_27_1.next_id,
		size = var_27_1.size
	}
end

function WatermelonBallCtrl:getRandomIdByWeight()
	if not self.weightTotal then
		self.weightTotal = 0
		self.weightList = {}
		self.weightIdList = {}

		for iter_28_0 = 1, #WatermelonGameConst.drop_ball_ids do
			self.weightTotal = self.weightTotal + WatermelonGameConst.drop_ball_ids[iter_28_0].weight

			table.insert(self.weightList, self.weightTotal)
			table.insert(self.weightIdList, WatermelonGameConst.drop_ball_ids[iter_28_0].id)
		end
	end

	local var_28_0 = math.random(1, self.weightTotal)

	for iter_28_1 = 1, #self.weightList do
		if var_28_0 <= self.weightList[iter_28_1] or iter_28_1 == #self.weightList then
			return self.weightIdList[iter_28_1]
		end
	end

	return nil
end

function WatermelonBallCtrl:setChildVisible(arg_29_1, arg_29_2)
	for iter_29_0 = 1, arg_29_1.childCount do
		setActive(arg_29_1:GetChild(iter_29_0 - 1), arg_29_2)
	end

	return
end

function WatermelonBallCtrl:dispose()
	return
end

return WatermelonBallCtrl
