local GameRoomHalloweenView = class("GameRoomHalloweenView", import("..BaseMiniGameView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 1
local var_0_8 = 2
local var_0_9 = {
	{
		3,
		5
	},
	{
		2,
		3
	},
	{
		1.5,
		3
	},
	{
		1,
		2.5
	},
	{
		1,
		2
	},
	{
		0.8,
		1.4
	}
}
local var_0_10 = {
	30,
	80,
	120,
	160,
	180
}
local var_0_11 = {
	4,
	6
}
local var_0_12 = {
	0,
	30
}
local var_0_13 = 0.5
local var_0_14 = {
	{
		10,
		13
	},
	{
		7,
		10
	}
}
local var_0_15 = {
	30
}
local var_0_16 = {
	0,
	3
}
local var_0_17 = {
	1,
	2
}
local var_0_18 = {
	100,
	100,
	100,
	100
}
local var_0_19 = {
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
local var_0_20 = {
	3,
	3.5,
	4,
	4.8,
	5.6,
	6.6,
	8.4
}
local var_0_21 = {
	30,
	80,
	120,
	140,
	160,
	180
}
local var_0_22 = {
	3,
	3.5,
	4,
	4.5,
	4.7,
	5
}
local var_0_23 = {
	30,
	80,
	120,
	160,
	180
}
local var_0_24 = 3
local var_0_25 = {
	110,
	193,
	1170,
	193
}
local var_0_26 = {
	117,
	848,
	1167,
	848
}
local var_0_27 = Vector2(90, 244)
local var_0_28 = 200
local var_0_29 = 5
local var_0_30 = 0
local var_0_31 = 1000000
local var_0_32 = 50000
local var_0_33 = "event:/ui/getcandy"
local var_0_34 = "event:/ui/jackboom"
local var_0_35 = "event:/ui/ddldaoshu2"

local function var_0_36(arg_1_0)
	return
end

function GameRoomHalloweenView:getUIName()
	return "GameRoomHalloweenUI"
end

function GameRoomHalloweenView:getBGM()
	return "backyard"
end

local function var_0_37(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}
	local var_4_1 = {
		{
			0,
			4
		},
		{
			4,
			6
		}
	}
	local var_4_2 = 1
	local var_4_3 = -1

	var_4_0.charactorTf = arg_4_0
	var_4_0.moveRanges = arg_4_1
	var_4_0.scene = arg_4_2
	var_4_0.speedX = 0
	var_4_0.direct = 0
	var_4_0.moveRightFlag = false
	var_4_0.moveLeftFlag = false
	var_4_0.charactorIdleCallback = false

	function var_4_0:ctor()
		self.collider = findTF(self.charactorTf, "collider")
		self.follow = findTF(self.charactorTf, "follow")
		self.charAnimator = GetComponent(findTF(self.charactorTf, "char"), typeof(Animator))
		self.posLight = findTF(self.charactorTf, "posLight")
		self.lightCharAnimator = GetComponent(findTF(self.posLight, "char"), typeof(Animator))
		self.lightCharDft = GetComponent(findTF(self.posLight, "char"), typeof(DftAniEvent))
		self.lightEffectAnimator = GetComponent(findTF(self.posLight, "light"), typeof(Animator))
		self.charactorDft = GetComponent(findTF(self.charactorTf, "char"), typeof(DftAniEvent))

		self.charactorDft:SetEndEvent(function(arg_6_0)
			self:onAnimationEnd()

			return
		end)
		self:clearData()

		return
	end

	function var_4_0:clearData()
		self.inAction = false
		self.direct = 0
		self.directType = var_4_2
		self.currentDirectType = nil
		self.ghostFlag = false
		self.ghostPlayFlag = false
		self.speedRangeIndex = 1
		self.maxSpeed = var_0_11[self.speedRangeIndex]
		self.playLightFlag = false
		self.moveLeftFlag = false
		self.moveRightFlag = false
		self.speedX = 0

		return
	end

	function var_4_0:setGhostFlag(arg_8_1, arg_8_2)
		if arg_8_1 and (self.ghostFlag or self.ghostPlayFlag) then
			return
		end

		self:ghostAniCallback(true)

		function self.aniCallback(arg_9_0)
			self.ghostFlag = not arg_9_0 and arg_8_1 or false

			if arg_8_2 then
				arg_8_2()
			end

			return
		end

		if arg_8_1 then
			self:playGhostDrump()
		else
			self:hideDrumpGhost()

			self.ghostPlayFlag = false
			self.ghostFlag = false
		end

		return
	end

	function var_4_0:playLight(arg_10_1, arg_10_2)
		if self.playLightFlag or self.inAction then
			if arg_10_1 then
				arg_10_1(false)
			end

			return
		end

		self.playLightFlag = true

		setActive(self.posLight, true)
		self.lightCharDft:SetEndEvent(function()
			self.playLightFlag = false

			return
		end)
		self.lightCharDft:SetTriggerEvent(function()
			if arg_10_1 then
				arg_10_1(true)
			end

			return
		end)

		if arg_10_2 == var_0_3 then
			self.lightCharAnimator:Play("charLight", -1, 0)
			self.lightEffectAnimator:Play("lightOn", -1, 0)
		elseif arg_10_2 == var_0_4 then
			self.lightCharAnimator:Play("charUnLight", -1, 0)
			self.lightEffectAnimator:Play("lightOff", -1, 0)
		end

		return
	end

	function var_4_0:ghostAniCallback(arg_13_1)
		if self.aniCallback then
			self.aniCallback(arg_13_1)

			self.aniCallback = nil
		end

		return
	end

	function var_4_0:hideDrumpGhost()
		setActive(findTF(self.charactorTf, "ghostContainer/posGhost"), false)

		return
	end

	function var_4_0:getGhostFlag()
		return self.ghostFlag or self.ghostPlayFlag
	end

	function var_4_0:getActionFlag()
		return self.inAction
	end

	function var_4_0:playGhostDrump()
		self.ghostPlayFlag = true

		local var_17_0 = findTF(self.charactorTf, "ghostContainer/posGhost")

		setActive(var_17_0, true)
		GetComponent(var_17_0, typeof(DftAniEvent)):SetEndEvent(function()
			self:ghostAniCallback()
			setActive(var_17_0, false)

			self.ghostPlayFlag = false

			if self.inSpecial then
				self.currentDirectType = nil

				self:checkPlayerAnimation(true)

				self.inSpecial = false
			end

			return
		end)
		GetComponent(var_17_0, typeof(Animator)):Play("drump", -1, 0)

		local var_17_1 = GetComponent(findTF(var_17_0, "drumpGhost/char"), typeof(Animator))

		var_17_1:SetInteger("state_type", 0)
		var_17_1:SetInteger("state_type", 3)

		return
	end

	function var_4_0:boom()
		if self.inAction then
			return
		end

		local var_19_0 = "boom"

		var_19_0 = self.currentDirectType == var_0_1 and var_19_0 .. "_left" or var_19_0 .. "_right"

		if self.ghostFlag then
			var_19_0 = var_19_0 .. "_ghost"
		end

		self:PlayAniamtion(var_19_0, function()
			self:checkPlayerAnimation(true)

			self.inAction = false

			return
		end)

		self.inAction = true

		return
	end

	function var_4_0:fail(arg_21_1)
		if self.inAction then
			return
		end

		local var_21_0 = "fail"

		var_21_0 = self.currentDirectType == var_0_1 and var_21_0 .. "_left" or var_21_0 .. "_right"

		if arg_21_1 == var_0_7 then
			var_21_0 = var_21_0 .. "_miss"
		elseif arg_21_1 == var_0_8 then
			var_21_0 = var_21_0 .. "_boom"
		end

		if self.ghostFlag then
			var_21_0 = var_21_0 .. "_ghost"
		end

		self:PlayAniamtion(var_21_0, function()
			self.inAction = false

			return
		end)

		self.inAction = true

		return
	end

	function var_4_0:gameOver()
		self.moveFlag = false

		if self.charactorIdleCallback then
			self.charactorIdleCallback(false)
		end

		return
	end

	function var_4_0:start()
		self.moveFlag = true
		self.startTime = var_0_30

		self:clearData()

		return
	end

	function var_4_0:step()
		if not self.moveFlag then
			return
		end

		if not self.inAction then
			if self.direct ~= 0 then
				if self.maxSpeed - math.abs(self.speedX) < var_0_13 then
					self.speedX = self.maxSpeed * self.direct
				else
					local var_25_0

					if math.abs(self.speedX) ~= self.maxSpeed then
						self.speedX = (math.abs(self.speedX) + var_0_13) * self.direct
						var_25_0 = self.charactorTf.localPosition.x
					end
				end

				local var_25_1 = var_25_0 + self.speedX * (self.ghostFlag and 0.5 or 1)

				if var_25_0 + self.speedX * (self.ghostFlag and 0.5 or 1) < self.moveRanges[1] then
					var_25_1 = self.moveRanges[1]
				end

				if var_25_1 > self.moveRanges[3] then
					var_25_1 = self.moveRanges[3]
				end

				self.charactorTf.localPosition = Vector3(var_25_1, self.charactorTf.localPosition.y, self.charactorTf.localPosition.z)
			end

			self:checkPlayerAnimation()
		end

		if self.speedRangeIndex < #var_0_12 then
			for iter_25_0 = #var_0_12, 1, -1 do
				if var_0_30 - self.startTime > var_0_12[iter_25_0] and self.speedRangeIndex ~= iter_25_0 then
					var_0_36("角色速度提升")

					self.speedRangeIndex = iter_25_0
					self.maxSpeed = var_0_11[self.speedRangeIndex]

					break
				end
			end
		end

		if self.speedX == 0 and not self.ghostFlag and not self.inAction then
			if self.specialTime then
				if var_0_30 - self.specialTime >= 7 then
					self.specialTime = nil
					self.inSpecial = true

					self:PlayAniamtion("special", function()
						self.currentDirectType = nil

						self:checkPlayerAnimation(true)

						self.inSpecial = false

						return
					end)
				end
			else
				self.specialTime = var_0_30
			end
		else
			self.specialTime = nil
		end

		if self.speedX == 0 and not self.inAction then
			if self.idleTime then
				if var_0_30 - self.idleTime >= 5 then
					self.idleTime = nil

					if self.charactorIdleCallback then
						self.charactorIdleCallback(true)
					end
				end
			else
				self.idleTime = var_0_30
			end
		else
			self.idleTime = nil

			if self.charactorIdleCallback then
				self.charactorIdleCallback(false)
			end
		end

		return
	end

	function var_4_0:checkPlayerAnimation(arg_27_1)
		if self.currentDirectType ~= self.directType or arg_27_1 then
			self.currentDirectType = self.directType

			if self.currentDirectType == var_0_2 then
				self:PlayAniamtion("idle_right")
			else
				self:PlayAniamtion("idle_left")
			end
		end

		local var_27_0

		if self.speedX == 0 then
			var_27_0 = 0
		else
			for iter_27_0 = 1, #var_4_1 do
				if math.abs(self.speedX) ~= 0 and self.maxSpeed > var_4_1[iter_27_0][1] and self.maxSpeed <= var_4_1[iter_27_0][2] then
					var_27_0 = iter_27_0
				end
			end
		end

		if self.charAnimator:GetInteger("speed_type") ~= var_27_0 then
			self.charAnimator:SetInteger("speed_type", var_27_0)
		end

		if self.charAnimator:GetBool("ghost") ~= self.ghostFlag then
			self.charAnimator:SetBool("ghost", self.ghostFlag)
		end

		return
	end

	function var_4_0:PlayAniamtion(arg_28_1, arg_28_2)
		var_0_36("开始播放动作:" .. arg_28_1)
		self.charAnimator:Play(arg_28_1, -1, 0)

		if self.onAniCallback then
			var_0_36(self.onAniamtionName .. "的animation被" .. arg_28_1 .. "中断")
		end

		self.onAniamtionName = arg_28_1
		self.onAniCallback = arg_28_2

		return
	end

	function var_4_0:onAnimationEnd()
		var_0_36("动作播放结束:" .. self.onAniamtionName)

		if self.onAniCallback then
			self.onAniCallback = nil

			self.onAniCallback()
		end

		return
	end

	function var_4_0:onDirectChange(arg_30_1, arg_30_2)
		if not self.moveFlag then
			return
		end

		if self.inSpecial then
			self.currentDirectType = nil

			self:checkPlayerAnimation(true)

			self.inSpecial = false
		end

		if arg_30_1 == var_0_1 then
			self.moveLeftFlag = arg_30_2
		elseif arg_30_1 == var_0_2 then
			self.moveRightFlag = arg_30_2
		end

		local var_30_0 = arg_30_2 and (arg_30_1 == var_0_1 and var_4_3 or var_4_2) or self.moveRightFlag and 1 or self.moveLeftFlag and -1 or 0

		if self.direct ~= var_30_0 or var_30_0 == 0 then
			self.speedX = 0
		end

		self.direct = var_30_0

		if self.direct ~= 0 then
			if self.direct == var_4_3 then
				self.directType = var_0_1 or var_0_2
			end
		end

		return
	end

	function var_4_0:getCollider()
		if not self.collider then
			-- block empty
		end

		local var_31_0 = self.collider.sizeDelta.x
		local var_31_1 = self.scene:InverseTransformPoint(self.collider.position.x, self.collider.position.y, 0)

		var_31_1.x = var_31_1.x - self.collider.sizeDelta.x / 2

		return {
			pos = var_31_1,
			width = var_31_0,
			height = self.collider.sizeDelta.y
		}
	end

	function var_4_0:getFollowPos()
		return self.follow.position
	end

	function var_4_0:getLeavePos()
		local var_33_0

		if self.ghostPlayFlag then
			var_33_0 = findTF(self.charactorTf, "ghostContainer/posGhost").position

			var_0_36("播放动画中，获取幽灵当前位置")
		else
			self.leavePos = self.leavePos or findTF(self.charactorTf, "posGhostLeave")
			var_33_0 = self.leavePos.position

			var_0_36("播放动画结束，获取头顶位置")
		end

		return var_33_0
	end

	function var_4_0.clearDirect(arg_34_0)
		arg_34_0.direct = 0
		arg_34_0.speedX = 0

		return
	end

	var_4_0:ctor()

	return var_4_0
end

local function var_0_38(arg_35_0, arg_35_1)
	local var_35_0 = {
		moveTf = arg_35_0,
		useLightTf = arg_35_1
	}

	var_35_0.initFlag = false
	var_35_0.direct = 0
	var_35_0.pointChangeCallback = nil
	var_35_0.pointUpCallback = nil
	var_35_0.pointLightCallback = nil
	var_35_0.lightTime = nil

	function var_35_0:Ctor()
		self.buttonDelegate = GetOrAddComponent(self.useLightTf, "EventTriggerListener")

		self.buttonDelegate:AddPointDownFunc(function(arg_37_0, arg_37_1)
			local var_37_0

			if not self.lightTime or var_0_30 - self.lightTime > var_0_29 then
				var_37_0 = var_0_3
				self.lightTime = var_0_30
			else
				var_37_0 = var_0_4
			end

			if self.pointLightCallback then
				self.pointLightCallback(var_37_0)
			end

			return
		end)

		self.delegateLeft = GetOrAddComponent(findTF(self.moveTf, "left"), "EventTriggerListener")
		self.delegateRight = GetOrAddComponent(findTF(self.moveTf, "right"), "EventTriggerListener")

		self.delegateLeft:AddPointDownFunc(function(arg_38_0, arg_38_1)
			if self.pointChangeCallback then
				self.pointChangeCallback(var_0_1)
			end

			return
		end)
		self.delegateRight:AddPointDownFunc(function(arg_39_0, arg_39_1)
			if self.pointChangeCallback then
				self.pointChangeCallback(var_0_2)
			end

			return
		end)
		self.delegateLeft:AddPointUpFunc(function(arg_40_0, arg_40_1)
			if self.pointUpCallback then
				self.pointUpCallback(var_0_1)
			end

			return
		end)
		self.delegateRight:AddPointUpFunc(function(arg_41_0, arg_41_1)
			if self.pointUpCallback then
				self.pointUpCallback(var_0_2)
			end

			return
		end)

		self.initFlag = true

		return
	end

	function var_35_0:callbackDirect(arg_42_1, arg_42_2)
		if not arg_42_2 then
			return
		end

		local var_42_0 = self:getPointFromEventData(arg_42_1)

		var_0_36(var_42_0.x .. "  " .. var_42_0.y)
		arg_42_2((self:getDirect(var_42_0)))

		return
	end

	function var_35_0:getPointFromEventData(arg_43_1)
		self.uiCam = self.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")

		return (self.moveTf:InverseTransformPoint((self.uiCam:ScreenToWorldPoint(arg_43_1.position))))
	end

	function var_35_0.getDirect(arg_44_0, arg_44_1)
		if arg_44_1.x >= 0 then
			return var_0_2
		else
			return var_0_1
		end

		return
	end

	function var_35_0:changeRemind(arg_45_1)
		self.remindFlag = arg_45_1

		local var_45_0 = GetComponent(self.useLightTf, typeof(Animator))

		if arg_45_1 and isActive(findTF(self.useLightTf, "light")) then
			var_45_0:Play("useLightRemind", -1, 0)
		else
			var_45_0:Play("useLightIdle", -1, 0)
		end

		return
	end

	function var_35_0:start()
		setActive(findTF(self.useLightTf, "light"), true)

		self.lightTime = nil

		return
	end

	function var_35_0:step()
		if not self.lightTime or var_0_30 - self.lightTime > var_0_29 then
			if not isActive(findTF(self.useLightTf, "light")) then
				setActive(findTF(self.useLightTf, "light"), true)
				self:changeRemind(self.remindFlag)
			end
		elseif isActive(findTF(self.useLightTf, "light")) then
			setActive(findTF(self.useLightTf, "light"), false)
		end

		return
	end

	function var_35_0:gameOver()
		setActive(findTF(self.useLightTf, "light"), false)

		return
	end

	function var_35_0:destroy()
		if self.delegateLeft then
			ClearEventTrigger(self.delegateLeft)
		end

		if self.delegateRight then
			ClearEventTrigger(self.delegateRight)
		end

		return
	end

	var_35_0:Ctor()

	return var_35_0
end

local function var_0_39(arg_50_0, arg_50_1)
	local var_50_0 = {
		_tf = arg_50_0,
		moveRange = arg_50_1
	}

	var_50_0.targetX = nil
	var_50_0.speedX = 1
	var_50_0.dropCallback = nil
	var_50_0.dropNum = 0

	function var_50_0:Ctor()
		self.bodyAnimator = GetComponent(findTF(self._tf, "char/body"), typeof(Animator))
		self.bodyDft = GetComponent(findTF(self._tf, "char/body"), typeof(DftAniEvent))

		self.bodyDft:SetEndEvent(function()
			self:dropEnd()

			return
		end)
		self.bodyDft:SetTriggerEvent(function()
			self:dropItem()

			return
		end)

		return
	end

	function var_50_0.start(arg_54_0)
		arg_54_0.moveFlag = true
		arg_54_0.speedLevel = 1

		return
	end

	function var_50_0.gameOver(arg_55_0)
		arg_55_0.moveFlag = false

		return
	end

	function var_50_0:step()
		if not self.moveFlag then
			return
		end

		if self.targetX then
			if self.targetX ~= self._tf.localPosition.x then
				self._tf.localPosition = self.targetX > self._tf.localPosition.x and Vector3(self._tf.localPosition.x + self:getSpeed(), self._tf.localPosition.y, self._tf.localPosition.z) or Vector3(self._tf.localPosition.x - self:getSpeed(), self._tf.localPosition.y, self._tf.localPosition.z)
			end

			if math.abs(self.targetX - self._tf.localPosition.x) <= self:getSpeed() then
				self.targetX = nil
			end
		end

		if not self.targetX then
			self:setNextTarget()
		end

		if self.speedLevel < #var_0_22 and var_0_23[self.speedLevel] < var_0_30 then
			self.speedLevel = self.speedLevel + 1
		end

		return
	end

	function var_50_0:getSpeed()
		return var_0_22[self.speedLevel]
	end

	function var_50_0:dropItem()
		if self.dropCallback then
			self.dropCallback()
		end

		return
	end

	function var_50_0:dropEnd()
		if self.dropNum > 0 then
			self.dropNum = self.dropNum - 1
		end

		self.bodyAnimator:SetInteger("dropNums", self.dropNum)

		return
	end

	function var_50_0:addDropNum()
		self.dropNum = self.dropNum + 1

		self.bodyAnimator:SetInteger("dropNums", self.dropNum)

		return
	end

	function var_50_0:setNextTarget()
		self.targetX = self.targetX or self._tf.localPosition.x < self.moveRange[3] / 3 and math.random(self.moveRange[3] * 2 / 3, self.moveRange[3]) or math.random(self.moveRange[1], self.moveRange[3] / 3)
		self._tf.localScale = self._tf.localPosition.x > self.targetX and Vector3(-1, 1, 1) or Vector3(1, 1, 1)

		return
	end

	function var_50_0:getDropWorldPos()
		self.posDrop = self.posDrop or findTF(self._tf, "char/posDrop")

		return self.posDrop.position
	end

	function var_50_0.clear(arg_63_0)
		arg_63_0.dropNum = 0
		arg_63_0.dropCallback = nil

		return
	end

	var_50_0:Ctor()

	return var_50_0
end

local function var_0_40()
	local var_64_0 = {}

	var_64_0.speedLevel = 1
	var_64_0.dropRequestCallback = nil

	function var_64_0.start(arg_65_0)
		arg_65_0.startFlag = true
		arg_65_0.speedLevel = 1
		arg_65_0.startTime = var_0_30

		return
	end

	function var_64_0.gameOver(arg_66_0)
		arg_66_0.startFlag = false
		arg_66_0.stepTime = nil
		arg_66_0.speedLevel = nil

		return
	end

	function var_64_0:step()
		if not self.startFlag then
			return
		end

		if not self.stepTime then
			self.stepTime = self.startTime + math.random() * (var_0_9[self.speedLevel][1] - var_0_9[self.speedLevel][2]) + var_0_9[self.speedLevel][1]
		elseif var_0_30 >= self.stepTime then
			self.stepTime = var_0_30 + math.random(var_0_9[self.speedLevel][1], var_0_9[self.speedLevel][2])

			if self.dropRequestCallback then
				self.dropRequestCallback()
			end
		end

		if self.speedLevel <= #var_0_10 then
			self.nextSpeedUpTime = self.nextSpeedUpTime or self.startTime + var_0_10[self.speedLevel]

			if var_0_30 >= self.nextSpeedUpTime then
				self.speedLevel = self.speedLevel + 1

				if self.speedLevel <= #var_0_10 then
					self.nextSpeedUpTime = var_0_30 + var_0_10[self.speedLevel] or nil
				end
			end
		end

		return
	end

	return var_64_0
end

local function var_0_41(arg_68_0, arg_68_1)
	local var_68_0 = {
		flyer = arg_68_0,
		scene = arg_68_1,
		dropItems = {}
	}

	var_68_0.lostCallback = nil
	var_68_0.boomCallback = nil
	var_68_0.dropSpeedUpCallback = nil

	function var_68_0.start(arg_69_0)
		arg_69_0.startFlag = true
		arg_69_0.speedLevel = 1
		arg_69_0.nextSpeedUpTime = nil
		arg_69_0.startTime = var_0_30

		return
	end

	function var_68_0:gameOver()
		self.startFlag = false

		for iter_70_0 = #self.dropItems, 1, -1 do
			self:returnDropItem((table.remove(self.dropItems, iter_70_0)))
		end

		return
	end

	function var_68_0:createDropItem()
		local var_71_0 = self:getDropItem()

		var_71_0.tf.localPosition = self.scene:InverseTransformPoint((self.flyer:getDropWorldPos()))
		self.dropItems = self.dropItems or {}

		table.insert(self.dropItems, var_71_0)

		return
	end

	function var_68_0:getDropItem()
		self.dropItemPool = self.dropItemPool or {}

		local var_72_0

		if #self.dropItemPool > 0 then
			var_72_0 = table.remove(self.dropItemPool, 1)
		else
			local var_72_1 = tf(instantiate(findTF(self.scene, "tplItem")))

			SetParent(var_72_1, self.scene, false)

			var_72_0 = {
				tf = var_72_1
			}
		end

		local var_72_2

		if math.random(var_0_17[1], var_0_17[2]) <= var_0_17[1] then
			var_72_2 = var_0_6 or var_0_5
		end

		var_72_0.type = var_72_2
		var_72_0.speed = var_0_20[self.speedLevel]

		setActive(var_72_0.tf, true)
		self:setItemData(var_72_0, var_72_2)

		return var_72_0
	end

	function var_68_0.setItemData(arg_73_0, arg_73_1, arg_73_2)
		local var_73_0 = findTF(arg_73_1.tf, "candy")
		local var_73_1 = findTF(arg_73_1.tf, "boom")

		arg_73_1.score = 0

		if arg_73_2 == var_0_5 then
			setActive(var_73_0, true)
			setActive(var_73_1, false)

			local var_73_2 = math.random(var_0_16[1], var_0_16[2])
			local var_73_3 = GetComponent(findTF(var_73_0, "img"), typeof(Animator))

			var_73_3:SetInteger("type", var_73_2)
			var_73_3:Play("candyIdle", -1, 0)

			arg_73_1.score = var_0_18[var_73_2 + 1]
		else
			setActive(var_73_0, false)
			setActive(var_73_1, true)
		end

		return
	end

	function var_68_0:returnDropItem(arg_74_1)
		setActive(arg_74_1.tf, false)
		table.insert(self.dropItemPool, arg_74_1)

		return
	end

	function var_68_0:step()
		if not self.startFlag then
			return
		end

		if self.speedLevel <= #var_0_21 then
			self.nextSpeedUpTime = self.nextSpeedUpTime or self.startTime + var_0_21[self.speedLevel]

			if var_0_30 >= self.nextSpeedUpTime then
				self.speedLevel = self.speedLevel + 1

				if self.speedLevel <= #var_0_21 then
					self.nextSpeedUpTime = self.startTime + var_0_21[self.speedLevel] or nil
				end

				if self.dropSpeedUpCallback then
					self.dropSpeedUpCallback()
				end
			end
		end

		if self.dropItems and #self.dropItems > 0 then
			for iter_75_0 = #self.dropItems, 1, -1 do
				self.dropItems[iter_75_0].speed = self.dropItems[iter_75_0].speed + var_0_19[self.speedLevel]

				if self.dropItems[iter_75_0].tf.localPosition.y <= var_0_28 then
					local var_75_0 = table.remove(self.dropItems, iter_75_0)

					if var_75_0.type == var_0_5 and self.lostCallback then
						self:playItemLost(var_75_0)
						self.lostCallback()
					else
						self:returnDropItem(var_75_0)
					end
				else
					self.dropItems[iter_75_0].tf.localPosition = Vector3(self.dropItems[iter_75_0].tf.localPosition.x, self.dropItems[iter_75_0].tf.localPosition.y - (self.dropItems[iter_75_0].speed + var_0_19[self.speedLevel]), self.dropItems[iter_75_0].tf.localPosition.z)
				end
			end
		end

		return
	end

	function var_68_0:dropItemCollider(arg_76_1)
		for iter_76_0 = #self.dropItems, 1, -1 do
			if table.contains(arg_76_1, iter_76_0) then
				self:playItemEffect((table.remove(self.dropItems, iter_76_0)))
			end
		end

		return
	end

	function var_68_0.playItemEffect(arg_77_0, arg_77_1)
		if arg_77_1.type == var_0_5 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_33)
			GetComponent(findTF(arg_77_1.tf, "candy/img"), typeof(DftAniEvent)):SetEndEvent(function()
				arg_77_0:returnDropItem(arg_77_1)

				return
			end)
			GetComponent(findTF(arg_77_1.tf, "candy/img"), typeof(Animator)):SetTrigger("effect")
		elseif arg_77_1.type == var_0_6 then
			local var_77_0 = GetComponent(findTF(arg_77_1.tf, "boom/img"), typeof(DftAniEvent))

			var_77_0:SetEndEvent(function()
				arg_77_0:returnDropItem(arg_77_1)

				return
			end)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_34)
			var_77_0:SetTriggerEvent(function()
				if arg_77_0.boomCallback then
					arg_77_0.boomCallback()
				end

				return
			end)
			GetComponent(findTF(arg_77_1.tf, "boom/img"), typeof(Animator)):SetTrigger("effect")
		end

		return
	end

	function var_68_0.playItemLost(arg_81_0, arg_81_1)
		if arg_81_1.type == var_0_5 then
			local var_81_0 = GetComponent(findTF(arg_81_1.tf, "candy/img"), typeof(Animator))
			local var_81_1 = findTF(arg_81_1.tf, "candy/candy_glow")
			local var_81_2 = GetComponent(findTF(arg_81_1.tf, "candy/img"), typeof(DftAniEvent))

			var_81_2:SetEndEvent(function()
				setActive(var_81_1, false)
				arg_81_0:returnDropItem(arg_81_1)

				return
			end)
			var_81_2:SetTriggerEvent(function()
				setActive(var_81_1, true)

				return
			end)
			var_81_0:Play("candyLost", var_81_0:GetLayerIndex("newLayer"), 0)
		end

		return
	end

	function var_68_0:getDropItemsCollider()
		if not self.dropItems then
			return
		end

		local var_84_0 = {}

		for iter_84_0 = 1, #self.dropItems do
			local var_84_1 = findTF(self.dropItems[iter_84_0].tf, "collider")

			table.insert(var_84_0, {
				x = var_84_1.position.x,
				y = var_84_1.position.y,
				width = var_84_1.sizeDelta.x,
				height = var_84_1.sizeDelta.y,
				index = iter_84_0,
				type = self.dropItems[iter_84_0].type,
				score = self.dropItems[iter_84_0].score
			})
		end

		return var_84_0
	end

	return var_68_0
end

local function var_0_42(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = {
		charactor = arg_85_0,
		dropItemController = arg_85_1,
		scene = arg_85_2
	}

	var_85_0.colliderDropItemCallback = nil

	function var_85_0.start(arg_86_0)
		arg_86_0.startFlag = true

		return
	end

	function var_85_0.gameOver(arg_87_0)
		arg_87_0.startFlag = false

		return
	end

	function var_85_0:step()
		if not self.startFlag then
			return
		end

		self:checkCollider()

		return
	end

	function var_85_0:checkCollider()
		local var_89_0 = {}
		local var_89_1 = self.dropItemController:getDropItemsCollider()
		local var_89_2 = self.charactor:getCollider()

		if var_89_1 and #var_89_1 > 0 then
			for iter_89_0 = 1, #var_89_1 do
				if self:checkRectCollider(var_89_2.pos, self.scene:InverseTransformPoint(var_89_1[iter_89_0].x, var_89_1[iter_89_0].y, 0), var_89_2, var_89_1[iter_89_0]) then
					table.insert(var_89_0, var_89_1[iter_89_0].index)

					if self.colliderDropItemCallback then
						self.colliderDropItemCallback(var_89_1[iter_89_0])
					end
				end
			end
		end

		if #var_89_0 > 0 then
			self.dropItemController:dropItemCollider(var_89_0)
		end

		return
	end

	function var_85_0.checkRectCollider(arg_90_0, arg_90_1, arg_90_2, arg_90_3, arg_90_4)
		if arg_90_2.x <= arg_90_1.x and arg_90_1.x >= arg_90_2.x + arg_90_4.width then
			return false
		elseif arg_90_1.x <= arg_90_2.x and arg_90_2.x >= arg_90_1.x + arg_90_3.width then
			return false
		elseif arg_90_2.y <= arg_90_1.y and arg_90_1.y >= arg_90_2.y + arg_90_4.height then
			return false
		elseif arg_90_1.y <= arg_90_2.y and arg_90_2.y >= arg_90_1.y + arg_90_3.height then
			return false
		else
			return true
		end

		return
	end

	return var_85_0
end

local function var_0_43(arg_91_0)
	local var_91_0 = {
		_tf = arg_91_0
	}

	var_91_0.speedLevel = 1
	var_91_0.createGhostCallback = nil
	var_91_0.ghostSpeedUpCallback = nil

	function var_91_0:start()
		self.startFlag = true
		self.speedLevel = 1
		self.startTime = var_0_30
		self.bossAnimator = GetComponent(findTF(self._tf, "char"), typeof(Animator))
		self.tip = findTF(self._tf, "tip")

		return
	end

	function var_91_0:gameOver()
		self.startFlag = false
		self.stepTime = nil

		setActive(self.tip, false)
		self.bossAnimator:SetInteger("state_type", 0)

		return
	end

	function var_91_0:step()
		if not self.startFlag then
			return
		end

		if not self.stepTime then
			self.stepTime = self.startTime + math.random(var_0_14[self.speedLevel][1], var_0_14[self.speedLevel][2])
		elseif var_0_30 >= self.stepTime then
			self.stepTime = var_0_30 + math.random(var_0_14[self.speedLevel][1], var_0_14[self.speedLevel][2])

			if self.createGhostCallback then
				self.createGhostCallback()
			end
		end

		if self.speedLevel <= #var_0_15 then
			self.nextSpeedUpTime = self.nextSpeedUpTime or self.startTime + var_0_15[self.speedLevel]

			if var_0_30 >= self.nextSpeedUpTime then
				self.speedLevel = self.speedLevel + 1

				if self.speedLevel <= #var_0_15 then
					self.nextSpeedUpTime = self.nextSpeedUpTime + var_0_15[self.speedLevel] or nil
				end

				if self.ghostSpeedUpCallback then
					self.ghostSpeedUpCallback()
				end

				var_0_36("幽灵生成速度提升" .. (self.nextSpeedUpTime or "(已经达到最高速度)"))
			end
		end

		return
	end

	function var_91_0:showTip(arg_95_1)
		if LeanTween.isTweening(go(self.tip)) then
			LeanTween.cancel(go(self.tip))
		end

		setActive(findTF(self.tip, "img1"), false)
		setActive(findTF(self.tip, "img2"), false)
		setActive(findTF(self.tip, "img" .. arg_95_1), true)
		setActive(self.tip, true)
		LeanTween.delayedCall(go(self.tip), 10, System.Action(function()
			setActive(self.tip, false)

			return
		end))

		return
	end

	function var_91_0:onCreate()
		self.bossAnimator:SetInteger("state_type", 3)

		return
	end

	function var_91_0:onCatch()
		self.bossAnimator:SetInteger("state_type", 2)

		return
	end

	function var_91_0:onGhostDestroy()
		self.bossAnimator:SetInteger("state_type", 1)

		self.stepTime = var_0_30 + math.random(var_0_14[self.speedLevel][1], var_0_14[self.speedLevel][2])

		return
	end

	function var_91_0:destory()
		if LeanTween.isTweening(go(self.tip)) then
			LeanTween.cancel(go(self.tip))
		end

		return
	end

	return var_91_0
end

local function var_0_44(arg_101_0, arg_101_1, arg_101_2)
	local var_101_0 = {}
	local var_101_1 = 4

	var_101_0.tplGhost = arg_101_0
	var_101_0.charactor = arg_101_1
	var_101_0.scene = arg_101_2
	var_101_0.catchCharactorCallback = nil

	function var_101_0.start(arg_102_0)
		arg_102_0.startFlag = true

		return
	end

	function var_101_0:gameOver()
		self.startFlag = false

		if not self.ghostChilds then
			return
		end

		for iter_103_0 = #self.ghostChilds, 1, -1 do
			self:removeChild(self.ghostChilds[iter_103_0])
		end

		return
	end

	function var_101_0:step()
		if not self.startFlag or not self.ghostChilds then
			return
		end

		local var_104_0 = self.scene:InverseTransformPoint((self.charactor:getFollowPos()))

		for iter_104_0 = #self.ghostChilds, 1, -1 do
			local var_104_1 = self.ghostChilds[iter_104_0]

			if isActive(self.ghostChilds[iter_104_0]) then
				local var_104_2 = var_104_1.anchoredPosition
				local var_104_3 = 0
				local var_104_4 = 0
				local var_104_5 = false
				local var_104_6 = false

				if math.abs(var_104_0.x - var_104_1.anchoredPosition.x) > 10 then
					var_104_3 = var_101_1 * (var_104_0.x > var_104_2.x and 1 or -1)
				else
					var_104_5 = true
				end

				if math.abs(var_104_0.y - var_104_2.y) > 10 then
					var_104_4 = var_101_1 * (var_104_0.y > var_104_2.y and 1 or -1)
				else
					var_104_6 = true
				end

				if not self.charactor:getGhostFlag() and not self.charactor:getActionFlag() and var_104_6 and var_104_5 then
					setActive(var_104_1, false)

					if self.catchCharactorCallback then
						self.catchCharactorCallback(var_104_1)
					end

					return
				end

				var_104_2.x = var_104_2.x + var_104_3
				var_104_2.y = var_104_2.y + var_104_4
				self.ghostChilds[iter_104_0].anchoredPosition = var_104_2
			end
		end

		return
	end

	function var_101_0:removeChild(arg_105_1)
		for iter_105_0 = 1, #self.ghostChilds do
			if arg_105_1 == self.ghostChilds[iter_105_0] then
				self:returnGhost((table.remove(self.ghostChilds, iter_105_0)))

				return
			end
		end

		return
	end

	function var_101_0:createGhost()
		self.ghostChilds = self.ghostChilds or {}

		if #self.ghostChilds > 0 or arg_101_1:getGhostFlag() then
			return false
		end

		local var_106_0 = self:getGhostChild()

		var_106_0.anchoredPosition = var_0_27

		GetComponent(findTF(var_106_0, "char"), typeof(Animator)):SetInteger("state_type", 1)
		table.insert(self.ghostChilds, var_106_0)

		return true
	end

	function var_101_0:getGhostChild()
		self.ghostPool = self.ghostPool or {}

		local var_107_0

		if #self.ghostPool > 0 then
			var_107_0 = table.remove(self.ghostPool, #self.ghostPool)
		else
			var_107_0 = tf(instantiate(self.tplGhost))

			SetParent(var_107_0, self.scene, false)
		end

		setActive(var_107_0, true)

		return var_107_0
	end

	function var_101_0:returnGhost(arg_108_1)
		setActive(arg_108_1, false)
		table.insert(self.ghostPool, arg_108_1)

		return
	end

	function var_101_0:createGhostLight(arg_109_1)
		if not self.lightGhost then
			self.lightGhost = tf(instantiate(self.tplGhost))
			self.lightGhost.name = "lightGhost"
			self.lightAnimator = GetComponent(findTF(self.lightGhost, "char"), typeof(Animator))

			GetComponent(findTF(self.lightGhost, "char"), typeof(DftAniEvent)):SetEndEvent(function()
				setActive(self.lightGhost, false)

				return
			end)
			setParent(self.lightGhost, self.scene)
		end

		if self.charactor:getGhostFlag() then
			self.lightGhost.anchoredPosition = self.scene:InverseTransformPoint(self.charactor:getLeavePos())

			setActive(self.lightGhost, true)
			self.lightAnimator:SetInteger("state_type", 0)
			self.lightAnimator:SetInteger("state_type", 2)
			arg_109_1(true)
		else
			arg_109_1(false)
		end

		return
	end

	return var_101_0
end

local function var_0_45(arg_111_0, arg_111_1)
	local var_111_0 = {
		eyeTf = arg_111_0
	}
	local var_111_1 = 3

	function var_111_0.changeEyeShow(arg_112_0, arg_112_1)
		return
	end

	function var_111_0:start()
		if not self.eyes then
			self.eyes = {}

			for iter_113_0 = 1, 3 do
				table.insert(self.eyes, findTF(self.eyeTf, "eye" .. iter_113_0))
			end
		end

		self.centerX = (var_0_25[3] - var_0_25[1]) / 2
		self.halfRnage = (var_0_25[3] - var_0_25[1]) / 2

		self:changeEyeShow(true)

		return
	end

	function var_111_0:step()
		for iter_114_0 = 1, #self.eyes do
			setAnchoredPosition(findTF(self.eyes[iter_114_0], "img"), Vector3((arg_111_1.anchoredPosition.x - var_0_25[1] - self.centerX) / self.halfRnage * var_111_1, 0, 0))
		end

		return
	end

	function var_111_0.gameOver(arg_115_0)
		return
	end

	return var_111_0
end

function GameRoomHalloweenView:init()
	self:initUI()
	self:initData()

	return
end

function GameRoomHalloweenView:initUI()
	onButton(self, findTF(self._tf, "conLeft/btnClose"), function()
		if not self.gameStartFlag then
			self:closeView()
		else
			setActive(self.leaveUI, true)
			self:timerStop()

			self.gameStartFlag = false
		end

		return
	end, SFX_CANCEL)

	self.playerIdleTip = findTF(self._tf, "idleTip")

	setActive(self.playerIdleTip, false)

	self.hearts = {}

	for iter_117_0 = 1, var_0_24 do
		table.insert(self.hearts, findTF(self._tf, "conRight/heart/heart" .. iter_117_0))
	end

	self.wanshengjie = findTF(self._tf, "wanshengjie")

	setActive(self.wanshengjie, false)

	self.scoreText = findTF(self._tf, "conRight/score/text")
	self.scene = findTF(self._tf, "scene")
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		self:clearUI()

		return
	end, SFX_CANCEL)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		setActive(self.leaveUI, false)
		self:gameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		setActive(self.leaveUI, false)
		self:timerStart()

		self.gameStartFlag = true

		return
	end, SFX_CANCEL)

	self.menuUI = findTF(self._tf, "pop/MenuUI")

	setActive(self.menuUI, true)
	onButton(self, findTF(self.menuUI, "ad/btnStart"), function()
		setActive(self.menuUI, false)
		self:openCoinLayer(false)
		self:gameReadyStart()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "ad/btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "ad/btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:getGameRoomData().game_help
		})

		return
	end, SFX_CANCEL)

	return
end

function GameRoomHalloweenView:initData()
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 0.016666666666666666, -1)
	self.charactor = var_0_37(findTF(self.scene, "charactor"), var_0_25, self.scene)

	function self.charactor.charactorIdleCallback(arg_127_0)
		setActive(self.playerIdleTip, arg_127_0)

		return
	end

	self.flyer = var_0_39(findTF(self.scene, "flyCharactor"), var_0_26)

	function self.flyer.dropCallback()
		self:onCreateDropItem()

		return
	end

	self.controllerUI = var_0_38(findTF(self._tf, "controller"), findTF(self._tf, "conRight/useLight"))

	function self.controllerUI.pointChangeCallback(arg_129_0)
		self:onControllerDirectChange(arg_129_0)

		return
	end

	function self.controllerUI.pointUpCallback(arg_130_0)
		self:onControllerDirectUp(arg_130_0)

		return
	end

	function self.controllerUI.pointLightCallback(arg_131_0)
		self:onUseLight(arg_131_0)

		return
	end

	self.dropControl = var_0_40()

	function self.dropControl.dropRequestCallback()
		self:onRequestDrop()

		return
	end

	self.dropItemController = var_0_41(self.flyer, self.scene)

	function self.dropItemController.lostCallback()
		self:lostCandy()

		return
	end

	function self.dropItemController.boomCallback()
		self:touchBoom()

		return
	end

	function self.dropItemController.dropSpeedUpCallback()
		self:dropSpeedUp()

		return
	end

	self.dropColliderControll = var_0_42(self.charactor, self.dropItemController, self.scene)

	function self.dropColliderControll:colliderDropItemCallback()
		self:addScore(self.score)

		return
	end

	self.ghostBossController = var_0_43(findTF(self._tf, "ghostBoss"))

	function self.ghostBossController.createGhostCallback()
		self:createGhost()

		return
	end

	function self.ghostBossController.ghostSpeedUpCallback()
		if self.eyesController then
			self.eyesController:changeEyeShow(false)
		end

		return
	end

	self.ghostChildController = var_0_44(findTF(self.scene, "tplGhost"), self.charactor, self.scene)

	function self.ghostChildController.catchCharactorCallback(arg_139_0)
		self:onGhostCatch(arg_139_0)

		return
	end

	self.eyesController = var_0_45(findTF(self._tf, "bg/eyes"), findTF(self.scene, "charactor"))
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)

	return
end

function GameRoomHalloweenView:gameReadyStart()
	setActive(self.menuUI, false)
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_35)

	return
end

function GameRoomHalloweenView:gameStart()
	self.heartNum = var_0_24
	self.scoreNum = 0
	self.gameStartFlag = true
	var_0_30 = 0

	setActive(self.scene, true)
	self:updateUI()
	self.charactor:start()
	self.flyer:start()
	self.dropControl:start()
	self.dropItemController:start()
	self.dropColliderControll:start()
	self.ghostBossController:start()
	self.ghostChildController:start()
	self.controllerUI:start()
	self.eyesController:start()
	self:timerStart()

	return
end

function GameRoomHalloweenView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	setActive(self.wanshengjie, true)

	return
end

function GameRoomHalloweenView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	setActive(self.wanshengjie, false)

	return
end

function GameRoomHalloweenView:getGameTimes()
	return self:GetMGHubData().count
end

function GameRoomHalloweenView:getSoundData(arg_147_1)
	CueData.GetCueData().channelName = pg.CriMgr.C_GALLERY_MUSIC
	self.cueData.cueSheetName = arg_147_1
	self.cueData.cueName = ""

	return
end

function GameRoomHalloweenView:onTimer()
	var_0_30 = var_0_30 + self.timer.duration

	self.charactor:step()
	self.flyer:step()
	self.dropControl:step()
	self.dropItemController:step()
	self.dropColliderControll:step()
	self.ghostBossController:step()
	self.ghostChildController:step()
	self.controllerUI:step()
	self.eyesController:step()

	return
end

function GameRoomHalloweenView:updateUI()
	for iter_149_0 = 1, #self.hearts do
		if iter_149_0 <= self.heartNum then
			setActive(findTF(self.hearts[iter_149_0], "img"), true)
		else
			setActive(findTF(self.hearts[iter_149_0], "img"), false)
		end
	end

	if not self.showOverTip and (self.scoreNum >= var_0_31 or var_0_30 * 1000 >= var_0_32) and self.ghostBossController then
		self.showOverTip = true

		self.ghostBossController:showTip(2)
	end

	setText(self.scoreText, self.scoreNum)

	return
end

function GameRoomHalloweenView:dropSpeedUp()
	if self.ghostBossController then
		self.ghostBossController:showTip(1)
	end

	return
end

function GameRoomHalloweenView:loseHeart(arg_151_1)
	if self.heartNum and self.heartNum > 0 then
		self.heartNum = self.heartNum - 1

		self:updateUI()

		if self.heartNum == 0 then
			local var_151_0

			if arg_151_1 == var_0_5 then
				var_151_0 = var_0_7 or var_0_8
			end

			self.charactor:fail(var_151_0)

			if var_151_0 == var_0_8 then
				self.ghostChildController:createGhostLight(function(arg_152_0)
					if arg_152_0 then
						self.ghostBossController:onGhostDestroy()
					end

					return
				end)
				self.charactor:setGhostFlag(false)
			end

			self.gameStartFlag = false

			self:timerStop()
			LeanTween.delayedCall(go(self._tf), 3, System.Action(function()
				self:gameOver()

				return
			end))
		elseif arg_151_1 == var_0_6 then
			self.charactor:boom()
		end
	end

	return
end

function GameRoomHalloweenView:addScore(arg_154_1)
	self.scoreNum = self.scoreNum + arg_154_1

	self:updateUI()

	return
end

function GameRoomHalloweenView:gameOver()
	self.charactor:gameOver()
	self.flyer:gameOver()
	self.dropControl:gameOver()
	self.dropItemController:gameOver()
	self.dropColliderControll:gameOver()
	self.ghostBossController:gameOver()
	self.ghostChildController:gameOver()
	self.controllerUI:gameOver()
	self.eyesController:gameOver()
	self:SendSuccess(self.scoreNum)
	self:showSettlement()

	return
end

function GameRoomHalloweenView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_156_0 = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)

	if var_156_0 <= self.scoreNum then
		var_156_0 = self.scoreNum

		self:StoreDataToServer({
			self.scoreNum
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_156_0)
	setText(findTF(self.settlementUI, "ad/currentText"), self.scoreNum)

	return
end

function GameRoomHalloweenView:lostCandy()
	self:loseHeart(var_0_5)

	return
end

function GameRoomHalloweenView:touchBoom()
	self:loseHeart(var_0_6)

	return
end

function GameRoomHalloweenView:createGhost()
	if self.ghostChildController and self.ghostChildController:createGhost() then
		self.ghostBossController:onCreate()
	end

	return
end

function GameRoomHalloweenView:onCreateDropItem()
	if self.dropItemController then
		self.dropItemController:createDropItem()
	end

	return
end

function GameRoomHalloweenView:onRequestDrop()
	if self.flyer then
		self.flyer:addDropNum()
	end

	return
end

function GameRoomHalloweenView:onGhostCatch(arg_162_1)
	if not self.charactor:getGhostFlag() then
		self.charactor:setGhostFlag(true, function()
			self.ghostChildController:removeChild(arg_162_1)

			return
		end)
		self.controllerUI:changeRemind(true)
		self.ghostBossController:onCatch()
	end

	return
end

function GameRoomHalloweenView:onUseLight(arg_164_1)
	if not self.gameStartFlag then
		return
	end

	self.charactor:playLight(function(arg_165_0)
		if arg_165_0 and arg_164_1 == var_0_3 then
			self.ghostChildController:createGhostLight(function(arg_166_0)
				if arg_166_0 then
					self.ghostBossController:onGhostDestroy()
					self.controllerUI:changeRemind(false)
				end

				return
			end)
			self.charactor:setGhostFlag(false)
		end

		return
	end, arg_164_1)

	return
end

function GameRoomHalloweenView:onColliderItem(arg_167_1)
	var_0_36("碰撞到了物品，数量:" .. #arg_167_1)

	return
end

function GameRoomHalloweenView:onControllerDirectChange(arg_168_1)
	self:changeDirect(arg_168_1, true)

	return
end

function GameRoomHalloweenView:onControllerDirectUp(arg_169_1)
	self:changeDirect(arg_169_1, false)

	return
end

function GameRoomHalloweenView:changeDirect(arg_170_1, arg_170_2)
	if self.gameStartFlag then
		self.charactor:onDirectChange(arg_170_1, arg_170_2)
	end

	return
end

function GameRoomHalloweenView:Update()
	self:AddDebugInput()

	return
end

function GameRoomHalloweenView:AddDebugInput()
	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			self:changeDirect(var_0_1, true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			self:changeDirect(var_0_1, false)
		end

		if Input.GetKeyDown(KeyCode.D) then
			self:changeDirect(var_0_2, true)
		end

		if Input.GetKeyUp(KeyCode.D) then
			self:changeDirect(var_0_2, false)
		end
	end

	return
end

function GameRoomHalloweenView:clearUI()
	setActive(self.scene, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, true)
	self:openCoinLayer(true)

	return
end

function GameRoomHalloweenView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(GameRoomHalloweenView.ON_BACK_PRESSED)
	else
		setActive(self.leaveUI, true)
		self:timerStop()

		self.gameStartFlag = false
	end

	return
end

function GameRoomHalloweenView:willExit()
	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	if LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	return
end

return GameRoomHalloweenView
