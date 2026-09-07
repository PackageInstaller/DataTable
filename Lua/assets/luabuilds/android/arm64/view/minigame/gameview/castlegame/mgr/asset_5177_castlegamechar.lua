local CastleGameChar = class("CastleGameChar")
local var_0_1 = Vector3(0, 0)
local var_0_2 = "qiye_6_SkeletonData"
local var_0_3 = 3
local var_0_4 = "activity_run"
local var_0_5 = "walk"
local var_0_6 = "activity_wait"
local var_0_7 = "tuozhuai2"
local var_0_8 = "tuozhuai2"
local var_0_9 = "dead"
local var_0_10 = Vector3(0, 0, -1)

function CastleGameChar:Ctor(arg_1_1, arg_1_2)
	self._charTpl = arg_1_1
	self._event = arg_1_2

	self:initChar()

	return
end

function CastleGameChar:initChar()
	if self.char then
		return
	end

	self.charTf = tf(instantiate(self._charTpl))
	self.speed = Vector3(0, 0, 0)
	self.colliderTf = findTF(self.charTf, "zPos/collider")
	self.collider = GetComponent(self.colliderTf, typeof(BoxCollider2D))
	self.zPos = findTF(self.charTf, "zPos")
	self.raycastPoints = {}

	for iter_2_0 = 1, var_0_3 do
		table.insert(self.raycastPoints, Vector3(0, 0, 0))
	end

	CastleGameVo.LoadSkeletonData(var_0_2, function(arg_3_0)
		arg_3_0.transform.localScale = Vector3(1, 1, 1)
		arg_3_0.transform.localPosition = Vector3(0, 0, 0)

		arg_3_0:SetActive(true)
		SetParent(tf(arg_3_0), findTF(self.charTf, "zPos/char"))

		self.graphic = arg_3_0:GetComponent("SkeletonGraphic")
		self.anim = arg_3_0:GetComponent(typeof(SpineAnimUI))
		self.charTf.anchoredPosition = var_0_1
		self.zPos.anchoredPosition = Vector2(0, var_0_1.z)

		return
	end)

	self.char = {
		tf = self.charTf,
		bound = {}
	}

	return
end

function CastleGameChar:setInGround(arg_4_1)
	self.inGround = arg_4_1

	if not self.inGround then
		self.speed = Vector3(0, 0, 0)
	end

	if self.char.floor then
		self:setContent(findTF(self.char.floor.tf, "zPos/top"))
	end

	return
end

function CastleGameChar:setOutLandPoint(arg_5_1)
	self.outlandPoint = arg_5_1
	self.outlandPoint.exlb = Vector2(self.outlandPoint.lb.x + 2, self.outlandPoint.lb.y)
	self.outlandPoint.exlt = Vector2(self.outlandPoint.lt.x, self.outlandPoint.lt.y - 2)
	self.outlandPoint.exrt = Vector2(self.outlandPoint.rt.x - 2, self.outlandPoint.rt.y)
	self.outlandPoint.exrb = Vector2(self.outlandPoint.rb.x, self.outlandPoint.rb.y + 2)

	return
end

function CastleGameChar:step()
	if self.timeToOver and self.timeToOver > 0 then
		self.timeToOver = self.timeToOver - CastleGameVo.deltaTime

		if self.timeToOver <= 0 then
			self.timeToOver = nil

			self._event:emit(CastleGameView.GAME_OVER)
		end
	end

	self:updateSpeed()
	self:updatePosition()
	self:updateAnim()
	self:checkPlayerOutScreen()

	return
end

function CastleGameChar:getPoint()
	if self.charTf then
		return nil
	end

	return self.charTf.anchoredPosition
end

function CastleGameChar:updatePosition()
	self.charTf.anchoredPosition.x = self.charTf.anchoredPosition.x + self.speed.x * CastleGameVo.deltaTime
	self.charTf.anchoredPosition.y = self.charTf.anchoredPosition.y + self.speed.y * CastleGameVo.deltaTime

	local var_8_0, var_8_1 = self:checkOutland(self.charTf.anchoredPosition)

	if var_8_0 and var_8_1 then
		self.charTf.anchoredPosition = var_8_1

		self:updateDirect(var_8_1)
	end

	self.zPos.anchoredPosition.y = self.zPos.anchoredPosition.y + self.speed.z * CastleGameVo.deltaTime
	self.zPos.anchoredPosition = self.zPos.anchoredPosition

	return
end

function CastleGameChar:updateDirect(arg_9_1)
	if arg_9_1.x ~= 0 then
		local var_9_0 = self.speed.x > 0 and 1 or -1

		if self.charTf.localScale.x ~= (self.speed.x > 0 and 1 or -1) then
			self.charTf.localScale = Vector3(var_9_0, 1, 1)
			self.charDirect = var_9_0
		end
	end

	return
end

function CastleGameChar:checkOutland(arg_10_1, arg_10_2)
	if self.outlandPoint then
		if CastleGameVo.PointLeftLine(arg_10_1, self.outlandPoint.lb, self.outlandPoint.lt) then
			local var_10_0, var_10_1 = CastleGameVo.PointFootLine(arg_10_1, self.outlandPoint.exlb, self.outlandPoint.exlt)

			if var_10_1 then
				return self:checkOutland(var_10_0, var_10_1)
			else
				return false
			end
		end

		if CastleGameVo.PointLeftLine(arg_10_1, self.outlandPoint.rb, self.outlandPoint.lb) then
			local var_10_2, var_10_3 = CastleGameVo.PointFootLine(arg_10_1, self.outlandPoint.exrb, self.outlandPoint.exlb)

			if var_10_3 then
				return self:checkOutland(var_10_2)
			else
				return false
			end
		end

		if CastleGameVo.PointLeftLine(arg_10_1, self.outlandPoint.lt, self.outlandPoint.rt) then
			local var_10_4, var_10_5 = CastleGameVo.PointFootLine(arg_10_1, self.outlandPoint.exlt, self.outlandPoint.exrt)

			if var_10_5 then
				return self:checkOutland(var_10_4)
			else
				return false
			end
		end

		if CastleGameVo.PointLeftLine(arg_10_1, self.outlandPoint.rt, self.outlandPoint.rb) then
			local var_10_6, var_10_7 = CastleGameVo.PointFootLine(arg_10_1, self.outlandPoint.exrt, self.outlandPoint.exrb)

			if var_10_7 then
				return self:checkOutland(var_10_6)
			else
				return false
			end
		end
	end

	return true, arg_10_1
end

function CastleGameChar:updateSpeed()
	if self.addSpeedTime and self.addSpeedTime > 0 then
		self.addSpeedTime = self.addSpeedTime - CastleGameVo.deltaTime

		if self.addSpeedTime <= 0 then
			self.addSpeedTime = nil
			self.addSpeed = 0
		end
	end

	if not self.inGround then
		if self.speed.z > -1500 then
			self.speed.z = self.speed.z - 20 or -1500
		end
	elseif self.inBubble then
		self.speed.x = 0
		self.speed.y = 0
		self.speed.z = 0

		print("角色在气泡中，无法移动")
	elseif self.fail then
		self.speed.x = 0
		self.speed.y = 0
		self.speed.z = 0

		print("被车撞了，无法移动")
	elseif CastleGameVo.joyStickData then
		self.speed.x = CastleGameVo.joyStickData.x * (CastleGameVo.char_speed + self.addSpeed)
		self.speed.y = CastleGameVo.joyStickData.y * (CastleGameVo.char_speed + self.addSpeed)
		self.speed.x = math.abs(self.speed.x) < CastleGameVo.char_speed_min and 0 or self.speed.x
		self.speed.y = math.abs(self.speed.y) < CastleGameVo.char_speed_min and 0 or self.speed.y

		self:updateDirect(self.speed)
	else
		self.speed.x = 0
		self.speed.y = 0
	end

	return
end

function CastleGameChar:updateAnim()
	local var_12_0

	if not self.inGround then
		var_12_0 = var_0_7
	elseif self.inBubble then
		var_12_0 = var_0_8
	elseif self.fail then
		var_12_0 = var_0_9
	else
		local var_12_1 = math.max(math.abs(self.speed.x), math.abs(self.speed.y))

		var_12_0 = var_12_1 > 120 and var_0_4 or var_12_1 > 0 and var_0_5 or var_0_6
	end

	if self.action ~= var_12_0 then
		self:changeAnimAction(self.anim, var_12_0, 0)
	end

	return
end

function CastleGameChar:setScore(arg_13_1)
	if arg_13_1.data.speed >= self.addSpeed then
		self.addSpeed = arg_13_1.data.speed
	end

	self.addSpeedTime = arg_13_1.data.time

	return
end

function CastleGameChar:setPlayerFail()
	self.fail = true
	self.timeToOver = 1

	self:playerDead()

	return
end

function CastleGameChar:setContent(arg_15_1, arg_15_2)
	self._content = arg_15_1

	setParent(self.charTf, self._content, true)

	self.charTf.localScale = Vector3(1, 1, 1)

	if arg_15_2 then
		self.charTf.anchoredPosition = arg_15_2
	end

	return
end

function CastleGameChar:getPoint()
	return self.charTf.anchoredPosition
end

function CastleGameChar:start()
	self.charTf.anchoredPosition = var_0_1
	self.zPos.anchoredPosition = Vector2(0, var_0_1.y)

	setActive(self.charTf, true)

	self.inGround = true
	self.inBubble = false
	self.fail = false
	self.timeToOver = nil
	self.speed = Vector3(0, 0, 0)
	self.addSpeed = 0
	self.addSpeedTime = 0

	self:changeAnimAction(self.anim, var_0_6, 0)

	return
end

function CastleGameChar:clear()
	return
end

function CastleGameChar:checkPlayerOutScreen()
	if math.abs(self.zPos.anchoredPosition.y) > 2000 then
		self._event:emit(CastleGameView.GAME_OVER)
	end

	return
end

function CastleGameChar:setInBubble(arg_20_1)
	self.inBubble = arg_20_1

	if arg_20_1 then
		self.lastBubblePos = self.char.tf.anchoredPosition
	else
		self.char.tf.anchoredPosition = self.lastBubblePos
	end

	return
end

function CastleGameChar:getActionAble()
	if not self.inGround then
		return false
	end

	if self.inBubble then
		return false
	end

	if self.fail then
		return false
	end

	return true
end

function CastleGameChar:press(arg_22_1)
	return
end

function CastleGameChar:playerDead()
	self.action = var_0_9

	self.anim:GetAnimationState():SetAnimation(0, var_0_9, false)

	return
end

function CastleGameChar:changeAnimAction(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	self.action = arg_24_2

	arg_24_1:SetActionCallBack(nil)
	arg_24_1:SetAction(arg_24_2, 0)
	arg_24_1:SetActionCallBack(function(arg_25_0)
		if arg_25_0 == "finish" then
			if arg_24_3 == 1 then
				arg_24_1:SetActionCallBack(nil)
			end

			if arg_24_5 then
				arg_24_5()
			end
		end

		return
	end)

	if arg_24_3 ~= 1 and arg_24_5 then
		arg_24_5()
	end

	return
end

function CastleGameChar:getChar()
	return self.char
end

function CastleGameChar:getTfs()
	return {
		self.charTf
	}
end

return CastleGameChar
