local GameRoomCurlingView = class("GameRoomCurlingView", import("..BaseMiniGameView"))
local var_0_1 = "event:/ui/ddldaoshu2"
local var_0_2 = "event:/ui/taosheng"
local var_0_3 = "event:/ui/minigame_hitcake"
local var_0_4 = "event:/ui/zhengque"
local var_0_5 = "event:/ui/shibai"
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 3
local var_0_9 = {
	20,
	40,
	60
}
local var_0_10 = 4
local var_0_11 = Vector2(-720, 0)
local var_0_12 = {
	-250,
	250
}
local var_0_13 = Vector2(-250, -42)
local var_0_14 = {
	1,
	10,
	30
}
local var_0_15 = 0.2
local var_0_16 = false
local var_0_17 = {
	cube = 0.2,
	miner = 0.2,
	walker = 0.1,
	oil = 0.2,
	wall = 0
}
local var_0_18 = {
	cube = 2,
	miner = 2,
	walker = 2,
	oil = 2,
	wall = 0
}
local var_0_19 = {
	0.5,
	5,
	10
}
local var_0_20 = {
	0.5,
	5,
	10
}
local var_0_21 = Vector2(400, -600)
local var_0_22 = Vector2(400, 500)
local var_0_23 = 1
local var_0_24 = 2
local var_0_25 = 3
local var_0_26 = 4
local var_0_27 = Vector2(617, -108)
local var_0_28 = 0.7
local var_0_29 = {
	111,
	222,
	333
}
local var_0_30 = {
	3000,
	2000,
	1000
}
local var_0_34 = 4
local var_0_35 = {
	cube = 300,
	miner = 300,
	walker = 900,
	oil = 300,
	wall = 100
}
local var_0_36 = 1
local var_0_37 = {
	oil = {
		{
			appear = 0.8,
			num = 1
		},
		{
			appear = 0.1,
			num = 1
		}
	},
	cube = {
		{
			appear = 0.8,
			num = 1
		},
		{
			appear = 0.1,
			num = 1
		}
	},
	miner = {
		{
			appear = 1,
			num = 1
		},
		{
			appear = 0.1,
			num = 1
		}
	}
}
local var_0_38 = {
	appear = 1
}
local var_0_39 = {}

var_0_39[1] = 1
var_0_39[2] = 2
var_0_39[3] = 3
var_0_39[4] = 4
var_0_38.path = var_0_39
var_0_37.walker = var_0_38

local var_0_40 = {
	miner = 3.5,
	cube = 3.5,
	walker = 4.5,
	oil = 3.5
}
local var_0_41 = true
local var_0_42 = "event_push"
local var_0_43 = "event_speed"
local var_0_44 = "event_hit"
local var_0_45 = "event_result"
local var_0_46 = "event_next"
local var_0_47 = "event_game_pause"
local var_0_48 = "event_game_resume"
local var_0_49 = "event_add_score"

local function var_0_50(arg_1_0, arg_1_1)
	local var_1_0 = {
		Ctor = function(self)
			self._tf = arg_1_0
			self._event = arg_1_1
			self.powerTF = findTF(self._tf, "power")
			self.powerSlider = GetComponent(self.powerTF, typeof(Slider))

			self:InitPowerSlider()

			self.animator = GetComponent(self._tf, typeof(Animator))
			self.aniDft = GetComponent(self._tf, typeof(DftAniEvent))

			self.aniDft:SetTriggerEvent(function()
				self:Push()

				return
			end)

			self.dragTrigger = GetOrAddComponent(self._tf, "EventTriggerListener")

			self.dragTrigger:AddPointDownFunc(function(arg_4_0, arg_4_1)
				if not self.canClick then
					return
				end

				self.canClick = false
				self.charging = true
				self.originScreenY = arg_4_1.position.y
				self.originY = self._tf.anchoredPosition.y

				self:Charge()

				return
			end)
			self.dragTrigger:AddDragFunc(function(arg_5_0, arg_5_1)
				if not self.charging then
					return
				end

				local var_5_0 = arg_5_1.position.y - self.originScreenY + self.originY

				var_5_0 = arg_5_1.position.y - self.originScreenY + self.originY >= var_0_12[1] and var_5_0 or var_0_12[1]
				var_5_0 = var_5_0 <= var_0_12[2] and var_5_0 or var_0_12[2]

				setLocalPosition(self._tf, Vector2(self._tf.anchoredPosition.x, var_5_0))

				return
			end)
			self.dragTrigger:AddPointUpFunc(function(arg_6_0, arg_6_1)
				if not self.charging then
					return
				end

				self.charging = false

				self.animator:SetInteger("Throw", self.phase)
				self.animator:SetInteger("Charge", 0)

				return
			end)
			self._event:bind(var_0_45, function(arg_7_0, arg_7_1, arg_7_2)
				self.animator:SetInteger("Result", arg_7_1.result)

				return
			end)
			self._event:bind(var_0_46, function(arg_8_0, arg_8_1, arg_8_2)
				self:Reset()
				self:Start()

				return
			end)
			self:Reset()

			return
		end,
		Start = function(arg_9_0)
			arg_9_0.canClick = true

			return
		end,
		Reset = function(self)
			setActive(self.powerTF, false)
			setLocalPosition(self._tf, var_0_11)
			self.animator:SetInteger("Charge", 0)
			self.animator:SetInteger("Throw", 0)
			self.animator:SetInteger("Result", 0)
			self.animator:Play("WaitA")

			self.power = 0
			self.phase = 0
			self.charging = false
			self.canClick = false
			self.powerSlider.value = 0

			return
		end,
		InitPowerSlider = function(self)
			findTF(self.powerTF, "progress/green").sizeDelta = Vector2(var_0_9[1] / var_0_9[3] * 162, 24)
			findTF(self.powerTF, "progress/green/yellow").sizeDelta = Vector2((var_0_9[2] - var_0_9[1]) / var_0_9[3] * 162, 24)
			findTF(self.powerTF, "progress/green/yellow/red").sizeDelta = Vector2((var_0_9[3] - var_0_9[2]) / var_0_9[3] * 162, 24)

			return
		end,
		Charge = function(self)
			setActive(self.powerTF, true)
			setActive(findTF(self.powerTF, "binghu_huoyan"), false)

			self.phase = var_0_6

			self.animator:SetInteger("Charge", self.phase)
			LeanTween.value(go(self._tf), self.power, var_0_9[3], var_0_10):setOnUpdate(System.Action_float(function(arg_13_0)
				self.power = arg_13_0
				self.powerSlider.value = self.power / var_0_9[3]

				if self.phase == var_0_6 and self.power >= var_0_9[1] then
					self.phase = var_0_7

					self.animator:SetInteger("Charge", self.phase)
				elseif self.phase == var_0_7 and self.power >= var_0_9[2] then
					self.phase = var_0_8

					self.animator:SetInteger("Charge", self.phase)
					setActive(findTF(self.powerTF, "binghu_huoyan"), true)
				end

				if not self.charging then
					LeanTween.cancel(go(self._tf))
				end

				return
			end))

			return
		end,
		Push = function(self)
			self._event:emit(var_0_42, {
				power = self.power
			})
			setActive(self.powerTF, false)

			return
		end
	}

	var_1_0:Ctor()

	return var_1_0
end

local function var_0_51(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {
		Ctor = function(self)
			self.tpls = arg_15_0
			self._event = arg_15_2
			self.player = arg_15_1
			self.scene = self.player.parent

			self._event:bind(var_0_42, function(arg_17_0, arg_17_1, arg_17_2)
				if self.isPush then
					return
				end

				self:Push(arg_17_1.power)

				return
			end)
			self._event:bind(var_0_46, function(arg_18_0, arg_18_1, arg_18_2)
				self:Reset()
				self:Start()

				return
			end)
			self._event:bind(var_0_47, function(arg_19_0, arg_19_1, arg_19_2)
				self:Pause()

				return
			end)
			self._event:bind(var_0_48, function(arg_20_0, arg_20_1, arg_20_2)
				self:Resume()

				return
			end)
			self:Reset()

			return
		end,
		Start = function(arg_21_0)
			return
		end,
		RandomRole = function(self)
			if self._tf then
				self._tf:SetParent(self.tpls, false)
				setActive(self._tf, false)
			end

			self._tf = self.tpls:GetChild(math.random(1, 4) - 1)

			setActive(self._tf, true)

			self.speedTF = findTF(self._tf, "speed")

			setActive(self.speedTF, var_0_16)

			self.animator = GetComponent(self._tf, typeof(Animator))
			self.rigbody = GetComponent(self._tf, "Rigidbody2D")
			self.rigbody.velocity = Vector2.zero
			self.phyItem = GetComponent(self._tf, "Physics2DItem")

			self.phyItem.CollisionEnter:RemoveAllListeners()
			self.phyItem.CollisionEnter:AddListener(function(arg_23_0)
				self:OnCollision(arg_23_0)

				return
			end)

			return
		end,
		Reset = function(self)
			self:RandomRole()

			self.rigbody.velocity = Vector2.zero

			self._tf:SetParent(findTF(self.player, "chargePos"), false)
			setText(self.speedTF, 0)
			setLocalPosition(self._tf, Vector2.zero)
			setLocalScale(self._tf, Vector2.one)
			self.animator:Play("Neutral")
			self.animator:SetBool("Stop", false)
			self.animator:SetInteger("Result", 0)
			self.animator:SetInteger("SpeedPhase", 0)

			self.isPush = false
			self.isStop = true
			self.phase = 0

			return
		end,
		Step = function(self)
			if var_0_16 then
				setText(self.speedTF, self.rigbody.velocity:Magnitude())
			end

			if not self.isPush or self.isStop then
				return
			end

			local var_25_0 = self:GetSpeed()

			self._event:emit(var_0_43, {
				speed = var_25_0
			})

			if var_25_0 > var_0_14[1] then
				self.animator:SetInteger("SpeedPhase", 1)
			elseif var_25_0 > var_0_14[2] then
				self.animator:SetInteger("SpeedPhase", 2)
			elseif var_25_0 > var_0_14[3] then
				self.animator:SetInteger("SpeedPhase", 3)
			end

			if var_25_0 < var_0_15 then
				self.animator:SetBool("Stop", true)

				self.isStop = true

				self:Result()
			end

			return
		end,
		Push = function(self, arg_26_1)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

			self.isPush = true
			self.isStop = false

			self._tf:SetParent(self.scene, true)

			self.rigbody.velocity = Vector2(var_0_13.x - self._tf.anchoredPosition.x, var_0_13.y - self._tf.anchoredPosition.y):Normalize():Mul(arg_26_1)

			self:Slip()

			return
		end,
		Slip = function(self)
			self.animator:SetBool("Stop", false)

			self.isStop = false

			return
		end,
		OnCollision = function(self, arg_28_1)
			self.animator:SetTrigger("Hit")
			self._event:emit(var_0_44)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

			local var_28_0 = 0
			local var_28_1 = Vector2(1, 0)
			local var_28_2 = Vector2(self.rigbody.velocity.x, self.rigbody.velocity.y)

			if arg_28_1.collider.gameObject.name == "wall" then
				var_28_2:Mul(var_0_17.wall)

				var_28_0 = var_0_35.wall

				var_28_1:Mul(var_0_18.wall)
			elseif arg_28_1.collider.gameObject.name == "oil" then
				var_28_2:Mul(var_0_17.oil)

				var_28_0 = var_0_35.oil

				var_28_1:Mul(var_0_18.oil)
			elseif arg_28_1.collider.gameObject.name == "cube" then
				var_28_2:Mul(var_0_17.cube)

				var_28_0 = var_0_35.cube

				var_28_1:Mul(var_0_18.cube)
			elseif arg_28_1.collider.gameObject.name == "miner" then
				var_28_2:Mul(var_0_17.miner)

				var_28_0 = var_0_35.miner

				var_28_1:Mul(var_0_18.miner)
			elseif arg_28_1.collider.gameObject.name == "walker" then
				var_28_2:Mul(var_0_17.walker)

				var_28_0 = var_0_35.walker

				var_28_1:Mul(var_0_18.walker)
			end

			self.rigbody.velocity = self.rigbody.velocity:Sub(var_28_2)
			self.rigbody.velocity = self.rigbody.velocity:Add(var_28_1)

			self._event:emit(var_0_49, {
				score = var_28_0,
				pos = self._tf.anchoredPosition
			})

			return
		end,
		Result = function(self)
			local var_29_0 = Vector2.Distance(var_0_27, (Vector2(self._tf.anchoredPosition.x, self._tf.anchoredPosition.y / var_0_28)))
			local var_29_2 = var_29_0 <= var_0_29[1] and 1 or var_29_0 <= var_0_29[2] and 2 or var_29_0 <= var_0_29[3] and 3 or 4

			self.animator:SetInteger("Result", var_29_0 <= var_0_29[1] and 1 or var_29_0 <= var_0_29[2] and 2 or var_29_0 <= var_0_29[3] and 3 or 4)
			self._event:emit(var_0_45, {
				result = var_29_2
			})

			if var_29_2 == 0 or var_29_2 == 4 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			return
		end,
		Pause = function(self)
			self.speedRecord = self.rigbody.velocity
			self.rigbody.velocity = Vector2.zero
			self.animator.speed = 0

			return
		end,
		Resume = function(self)
			self.rigbody.velocity = self.speedRecord
			self.animator.speed = 1

			return
		end,
		GetSpeed = function(self)
			return self.rigbody.velocity:Magnitude()
		end
	}

	var_15_0:Ctor()

	return var_15_0
end

local function var_0_52(arg_33_0, arg_33_1)
	local var_33_0 = {
		Ctor = function(self)
			self._tf = arg_33_0
			self._event = arg_33_1
			self.animator = GetComponent(self._tf, typeof(Animator))

			self._event:bind(var_0_42, function(arg_35_0, arg_35_1, arg_35_2)
				self:TurnLeft()

				return
			end)
			self._event:bind(var_0_44, function(arg_36_0, arg_36_1, arg_36_2)
				self:Hit()

				return
			end)
			self._event:bind(var_0_45, function(arg_37_0, arg_37_1, arg_37_2)
				self:Result(arg_37_1.result)

				return
			end)
			self._event:bind(var_0_46, function(arg_38_0, arg_38_1, arg_38_2)
				self:Reset()
				self:Start()

				return
			end)

			return
		end,
		Start = function(arg_39_0)
			return
		end,
		Reset = function(self)
			self.animator:SetInteger("Result", 0)
			self.animator:Play("WaitA")

			return
		end,
		TurnLeft = function(self)
			self.animator:SetTrigger("TurnLeft")

			return
		end,
		Result = function(self, arg_42_1)
			self.animator:SetInteger("Result", arg_42_1)

			return
		end,
		Hit = function(self)
			self.animator:SetTrigger("Hit")

			return
		end
	}

	var_33_0:Ctor()

	return var_33_0
end

local function var_0_53(arg_44_0, arg_44_1)
	local var_44_0 = {
		Ctor = function(self)
			self._tf = arg_44_0
			self._event = arg_44_1
			self.animator = GetComponent(self._tf, typeof(Animator))

			self._event:bind(var_0_46, function(arg_46_0, arg_46_1, arg_46_2)
				self:NextRound()

				return
			end)
			self:Reset()

			return
		end,
		Start = function(self)
			self:NextRound()

			return
		end,
		Reset = function(self)
			self.animator:SetInteger("Round", 0)
			self.animator:Play("IdleA")

			self.roundNum = 1

			return
		end,
		NextRound = function(self)
			self.animator:SetInteger("Round", self.roundNum)

			self.roundNum = self.roundNum == 3 and 1 or self.roundNum + 1

			return
		end
	}

	var_44_0:Ctor()

	return var_44_0
end

local function var_0_54(arg_50_0, arg_50_1)
	local var_50_0 = {
		Ctor = function(self)
			self._tf = arg_50_0
			self._event = arg_50_1
			self.config = var_0_37.miner
			self.animator = GetComponent(self._tf, typeof(Animator))
			self.phyItem = GetComponent(self._tf, "Physics2DItem")

			self.phyItem.CollisionEnter:AddListener(function(arg_52_0)
				self:OnCollision()

				return
			end)

			self.phyGrazeItem = GetComponent(findTF(self._tf, "GrazeCollider"), "Physics2DItem")

			self.phyGrazeItem.TriggerEnter:AddListener(function(arg_53_0)
				self:OnGrazeTrigger(arg_53_0)

				return
			end)
			self._event:bind(var_0_43, function(arg_54_0, arg_54_1, arg_54_2)
				self.hitSpeed = arg_54_1.speed

				return
			end)
			self:Reset()

			return
		end,
		Start = function(arg_55_0)
			return
		end,
		Reset = function(arg_56_0)
			arg_56_0.isClash = false
			arg_56_0.hitSpeed = 0

			return
		end,
		OnCollision = function(self)
			self.isClash = true

			local var_57_0 = 0

			if self.hitSpeed > var_0_19[3] then
				var_57_0 = 3
			elseif self.hitSpeed > var_0_19[2] then
				var_57_0 = 2
			elseif self.hitSpeed > var_0_19[1] then
				var_57_0 = 1
			end

			self.animator:SetInteger("Speed", var_57_0)
			self.animator:SetTrigger("Clash")

			return
		end,
		OnGrazeTrigger = function(arg_58_0, arg_58_1)
			if arg_58_1.gameObject.name ~= "Ayanami" then
				return
			end

			onDelayTick(function()
				if arg_58_0.isClash then
					return
				end

				arg_58_0.animator:SetTrigger("Graze")

				return
			end, 0.3)

			return
		end
	}

	var_50_0:Ctor()

	return var_50_0
end

local function var_0_55(arg_60_0, arg_60_1)
	local var_60_0 = {}
	local var_60_1 = 1000

	function var_60_0:Ctor()
		self._tf = arg_60_0
		self._event = arg_60_1
		self.config = var_0_37.walker
		self.obstacleTF = self._tf.parent
		self.bgFrontTF = findTF(self.obstacleTF.parent.parent, "bg_front")
		self.animator = GetComponent(self._tf, typeof(Animator))
		self.rigbody = GetComponent(self._tf, "Rigidbody2D")
		self.phyItem = GetComponent(self._tf, "Physics2DItem")

		self.phyItem.CollisionEnter:AddListener(function(arg_62_0)
			self:OnCollision(arg_62_0)

			return
		end)
		self._event:bind(var_0_43, function(arg_63_0, arg_63_1, arg_63_2)
			self.hitSpeed = arg_63_1.speed

			return
		end)
		self._event:bind(var_0_47, function(arg_64_0, arg_64_1, arg_64_2)
			self:Pause()

			return
		end)
		self._event:bind(var_0_48, function(arg_65_0, arg_65_1, arg_65_2)
			self:Resume()

			return
		end)

		return
	end

	function var_60_0.SetPath(arg_66_0, arg_66_1)
		arg_66_0.pathType = arg_66_1

		return
	end

	function var_60_0:Start()
		self:WalkPath()

		return
	end

	function var_60_0:Reset()
		setActive(self._tf, false)
		setLocalPosition(self._tf, Vector2(-1400, 0))

		self.rigbody.velocity = Vector2.zero
		self.isJumpDown = false
		self.isJumpUp = false
		self.isForwardNorth = false
		self.isForwardSouth = false
		self.hitSpeed = 0
		self.pathType = 0

		return
	end

	function var_60_0:OnCollision(arg_69_1)
		self.animator:SetTrigger("Clash")

		local var_69_0 = 0

		if self.hitSpeed > var_0_20[3] then
			var_69_0 = 3
		elseif self.hitSpeed > var_0_20[2] then
			var_69_0 = 2
		elseif self.hitSpeed > var_0_20[1] then
			var_69_0 = 1
		end

		self.animator:SetInteger("Speed", var_69_0)

		self.rigbody.velocity = Vector2.zero

		return
	end

	function var_60_0:WalkPath()
		if self.pathType == var_0_25 or self.pathType == var_0_26 then
			setLocalPosition(self._tf, var_0_21)
			self._tf:SetParent(self.bgFrontTF, false)

			self.isForwardNorth = true

			self.animator:SetBool("IsNorth", true)
			self:WalkNorth()
		elseif self.pathType == var_0_23 or self.pathType == var_0_24 then
			setLocalPosition(self._tf, var_0_22)
			self._tf:SetParent(self.obstacleTF, false)

			self.isForwardSouth = true

			self.animator:SetBool("IsSouth", true)
			self:WalkSouth()
		end

		return
	end

	function var_60_0:WalkNorth()
		self.animator:SetTrigger("WalkN")

		self.rigbody.velocity = Vector2(0, 1.5)

		return
	end

	function var_60_0:JumpNorth()
		self.animator:SetTrigger("JumpN")

		if self.isJumpUp then
			self:WalkNorth()
		elseif self.pathType == var_0_26 then
			self:WalkNorthwest()
		else
			self:WalkNorth()
		end

		return
	end

	function var_60_0:WalkNorthwest()
		self.animator:SetTrigger("WalkNW")

		self.rigbody.velocity = Vector2(-1.5, 1.5)

		return
	end

	function var_60_0:WalkSouth()
		self.animator:SetTrigger("WalkS")

		self.rigbody.velocity = Vector2(0, -1.5)

		return
	end

	function var_60_0:JumpSouth()
		self.animator:SetTrigger("JumpS")

		if self.isJumpDown then
			self:WalkSouth()
		elseif self.pathType == var_0_24 then
			self:WalkSouthwest()
		else
			self:WalkSouth()
		end

		return
	end

	function var_60_0:WalkSouthwest()
		self.animator:SetTrigger("WalkSW")

		self.rigbody.velocity = Vector2(-1.5, -1.5)

		return
	end

	function var_60_0:Step()
		if self._tf.anchoredPosition.y > var_60_1 or self._tf.anchoredPosition.y < -var_60_1 then
			self.rigbody.velocity = Vector2.zero

			return
		end

		if self.isForwardNorth then
			if not self.isJumpDown and self._tf.anchoredPosition.y >= -470 then
				self.isJumpDown = true

				self:JumpNorth()
				onDelayTick(function()
					self._tf:SetParent(self.obstacleTF, false)

					return
				end, 0.3)
			end

			if not self.isJumpUp and self._tf.anchoredPosition.y >= 310 then
				self.isJumpUp = true

				self:JumpNorth()
			end
		end

		if self.isForwardSouth then
			if not self.isJumpUp and self._tf.anchoredPosition.y <= 370 then
				self.isJumpUp = true

				self:JumpSouth()
			end

			if not self.isJumpDown and self._tf.anchoredPosition.y <= -420 then
				self.isJumpDown = true

				self:JumpSouth()
				onDelayTick(function()
					self._tf:SetParent(self.bgFrontTF, false)

					return
				end, 0.3)
			end
		end

		return
	end

	function var_60_0:Pause()
		self.speedRecord = self.rigbody.velocity
		self.rigbody.velocity = Vector2.zero
		self.animator.speed = 0

		return
	end

	function var_60_0:Resume()
		self.rigbody.velocity = self.speedRecord
		self.animator.speed = 1

		return
	end

	var_60_0:Ctor()

	return var_60_0
end

function GameRoomCurlingView:getUIName()
	return "GameRoomCurlingUI"
end

function GameRoomCurlingView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:initController()
	self:updateMainUI()
	self:openMainUI()
	self:AutoFitScreen()

	return
end

function GameRoomCurlingView:AutoFitScreen()
	local var_84_0 = 1.7777777777777777 <= Screen.width / Screen.height and math.clamp(1080 * (Screen.width / Screen.height) / 2331, 1, 2) or math.clamp(0 / (Screen.width / Screen.height) / self._tf:Find("bg_back").rect.height, 1, 2)

	setLocalScale(self._tf, {
		x = var_84_0,
		y = var_84_0,
		z = var_84_0
	})

	return
end

function GameRoomCurlingView:initEvent()
	self:bind(var_0_45, function(arg_86_0, arg_86_1, arg_86_2)
		if arg_86_1.result ~= var_0_34 then
			self:addScore(var_0_30[arg_86_1.result])
		end

		self:obsFadeOut()
		onDelayTick(function()
			self:nextRoundGame()

			return
		end, var_0_36)

		return
	end)
	self:bind(var_0_49, function(arg_88_0, arg_88_1, arg_88_2)
		if arg_88_1.score and arg_88_1.score ~= 0 then
			self:addScore(arg_88_1.score, arg_88_1.pos)
		end

		return
	end)

	return
end

function GameRoomCurlingView:initData()
	local var_89_0 = Application.targetFrameRate or 60

	if var_89_0 > 60 then
		var_89_0 = 60
	end

	self.needManualSimulate = true
	self.timer = Timer.New(function()
		self:onTimer()

		if self.needManualSimulate then
			Physics2D.Simulate(1 / var_89_0)
		end

		return
	end, 1 / var_89_0, -1)

	return
end

function GameRoomCurlingView:initUI()
	self.clickMask = self._tf:Find("ui/click_mask")
	self.mainUI = self._tf:Find("ui/main_ui")
	self.listScrollRect = GetComponent(findTF(self.mainUI, "item_list"), typeof(ScrollRect))

	onButton(self, self.mainUI:Find("skin_btn"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP, {
			skinId = pg.mini_game[self:GetMGData().id].simple_config_data.skin_shop_id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("return_btn"), function()
		self:emit(GameRoomCurlingView.ON_BACK_PRESSED)

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("main_btn"), function()
		self:emit(GameRoomCurlingView.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("help_btn"), function()
		local var_95_0 = self:getGameRoomData().game_help

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:getGameRoomData().game_help
		})

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("start_btn"), function()
		self:readyStart()

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("rank_btn"), function()
		return
	end, SFX_PANEL)

	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.listScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, self.mainUI:Find("right_panel/arrows_up"), function()
		scrollTo(self.listScrollRect, 0, (self.listScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("right_panel/arrows_down"), function()
		scrollTo(self.listScrollRect, 0, (self.listScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_PANEL)

	self.countUI = self._tf:Find("ui/count_ui")
	self.countAnimator = GetComponent(self.countUI:Find("count"), typeof(Animator))
	self.countDft = GetOrAddComponent(self.countUI:Find("count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:startGame()

		return
	end)

	self.pauseUI = self._tf:Find("ui/pause_ui")

	onButton(self, self.pauseUI:Find("ad/panel/sure_btn"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_PANEL)

	self.returnUI = self._tf:Find("ui/return_ui")

	onButton(self, self.returnUI:Find("ad/panel/sure_btn"), function()
		setActive(self.returnUI, false)
		self:resumeGame()
		self:endGame()

		return
	end, SFX_PANEL)
	onButton(self, self.returnUI:Find("ad/panel/cancel_btn"), function()
		setActive(self.returnUI, false)
		self:resumeGame()

		return
	end, SFX_PANEL)

	self.endUI = self._tf:Find("ui/end_ui")

	onButton(self, self.endUI:Find("ad/panel/end_btn"), function()
		setActive(self.endUI, false)
		self:openMainUI()

		return
	end, SFX_PANEL)

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function GameRoomCurlingView:initGameUI()
	self.gameUI = self._tf:Find("ui/game_ui")
	self.roundTF = self.gameUI:Find("score_panel/round_text")
	self.scoreTF = self.gameUI:Find("score_panel/score_text")

	onButton(self, self.gameUI:Find("pause_btn"), function()
		self:pauseGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, self.gameUI:Find("return_btn"), function()
		self:pauseGame()
		setActive(self.returnUI, true)

		return
	end)

	self.scoreGroup = self.gameUI:Find("score_group")

	setActive(self._tf:Find("bg_front/wall"), var_0_41)

	return
end

function GameRoomCurlingView:initController()
	self.scene = self._tf:Find("scene")
	self.gridTF = self._tf:Find("ui/grid")
	self.player = var_0_50(self.scene:Find("player"), self)
	self.phy = self.scene:Find("Ayanami_phy")
	self.drawDot = self.scene:Find("draw_dot")
	self.curlingTpls = self.scene:Find("curling_Tpl")
	self.curling = var_0_51(self.curlingTpls, self.player._tf, self)
	self.ofunya = var_0_52(self._tf:Find("bg_back/07_Ofunya"), self)
	self.manjuu = var_0_53(self._tf:Find("bg_back/08_Manjuu"), self)
	self.walker = var_0_55(self.scene:Find("obstacle/walker"), self)
	self.obsTF = self._tf:Find("scene/obstacle")
	self.obsCanvas = GetComponent(self.obsTF, typeof(CanvasGroup))
	self.obsTpl = self._tf:Find("scene/obstacle_Tpl")
	self.minerGroups = self.obsTF:Find("miner_groups")
	self.oilGroups = self.obsTF:Find("oil_groups")
	self.cubeGroups = self.obsTF:Find("cube_groups")

	return
end

function GameRoomCurlingView:updateMainUI()
	local var_110_0 = self:getGameUsedTimes()
	local var_110_1 = self:getGameTimes()

	self.totalTimes = self:getGameTotalTime()

	local var_110_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_110_2 > 1 then
		var_110_2 = 1
	end

	scrollTo(self.listScrollRect, 0, var_110_2)

	return
end

function GameRoomCurlingView:openMainUI()
	setActive(self.gameUI, false)
	setActive(self.mainUI, true)
	self:openCoinLayer(true)
	self:updateMainUI()

	return
end

function GameRoomCurlingView:readyStart()
	setActive(self.mainUI, false)
	setActive(self.countUI, true)
	self:openCoinLayer(false)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1)
	self:resetGame()

	return
end

function GameRoomCurlingView:resetGame()
	self.gameStartFlag = false
	self.gamePause = false
	self.gameEndFlag = false
	self.scoreNum = 0
	self.roundNum = 1

	self.player:Reset()
	self.curling:Reset()
	self.ofunya:Reset()
	self.manjuu:Reset()
	self.walker:Reset()

	return
end

function GameRoomCurlingView:startGame()
	setActive(self.gameUI, true)
	self:CoordinateGrid(self.gridTF)

	self.gameStartFlag = true

	self.player:Start()
	self.curling:Start()
	self.ofunya:Start()
	self.manjuu:Start()
	self:staticObsStart()
	self:updateGameUI()
	self:timerStart()

	return
end

function GameRoomCurlingView:staticObsStart()
	setActive(self.obsTF, true)

	self.obsCanvas.alpha = 1

	self.walker:Reset()

	if math.random() <= var_0_37.walker.appear then
		setActive(self.walker._tf, true)
		setLocalScale(self.walker._tf, Vector2(var_0_40.walker, var_0_40.walker))

		local var_115_0 = var_0_37.walker.path[math.random(1, #var_0_37.walker.path)]

		self.walker:SetPath(var_115_0)

		local var_115_1 = {}

		if var_115_0 == var_0_26 then
			var_115_1 = {
				8,
				11,
				12,
				14,
				15,
				18,
				17,
				21
			}
		elseif var_115_0 == var_0_24 then
			var_115_1 = {
				5,
				9,
				10,
				14,
				15,
				19,
				20,
				24
			}
		end

		local function var_115_2(arg_116_0)
			for iter_116_0, iter_116_1 in ipairs(var_115_1) do
				if arg_116_0 == iter_116_1 then
					return true
				end
			end

			return false
		end

		local var_115_3 = {}

		for iter_115_0, iter_115_1 in ipairs(self.grids) do
			if not var_115_2(iter_115_0) then
				table.insert(var_115_3, iter_115_1)
			end
		end

		self.grids = var_115_3

		self.walker:Start()
	end

	removeAllChildren(self.oilGroups)

	for iter_115_2, iter_115_3 in ipairs(var_0_37.oil) do
		if math.random() <= iter_115_3.appear then
			for iter_115_4 = 1, iter_115_3.num do
				local var_115_4 = cloneTplTo(self.obsTpl:Find("oil_Tpl"), self.oilGroups, "oil")

				setActive(var_115_4, true)

				local var_115_5 = math.random(1, #self.grids)

				setLocalPosition(var_115_4, Vector2(self.grids[var_115_5].x, self.grids[var_115_5].y))
				setLocalScale(var_115_4, Vector2(var_0_40.oil, var_0_40.oil))
				table.remove(self.grids, var_115_5)
			end
		end
	end

	removeAllChildren(self.cubeGroups)

	for iter_115_5, iter_115_6 in ipairs(var_0_37.cube) do
		if math.random() <= iter_115_6.appear then
			for iter_115_7 = 1, iter_115_6.num do
				local var_115_6 = cloneTplTo(self.obsTpl:Find("cube_Tpl"), self.cubeGroups, "cube")

				setActive(var_115_6, true)

				local var_115_7 = math.random(1, #self.grids)

				setLocalPosition(var_115_6, Vector2(self.grids[var_115_7].x, self.grids[var_115_7].y))
				setLocalScale(var_115_6, Vector2(var_0_40.cube, var_0_40.cube))
				table.remove(self.grids, var_115_7)
			end
		end
	end

	removeAllChildren(self.minerGroups)

	self.minerControls = {}

	for iter_115_8, iter_115_9 in ipairs(var_0_37.miner) do
		if math.random() <= iter_115_9.appear then
			for iter_115_10 = 1, iter_115_9.num do
				local var_115_8 = cloneTplTo(self.obsTpl:Find("miner_Tpl"), self.minerGroups, "miner")

				setActive(var_115_8, true)
				table.insert(self.minerControls, (var_0_54(var_115_8, self)))

				local var_115_9 = math.random(1, #self.grids)

				setLocalPosition(var_115_8, Vector2(self.grids[var_115_9].x, self.grids[var_115_9].y))
				setLocalScale(var_115_8, Vector2(var_0_40.miner, var_0_40.miner))
				table.remove(self.grids, var_115_9)
			end
		end
	end

	return
end

function GameRoomCurlingView:obsFadeOut()
	self:managedTween(LeanTween.value, function()
		setActive(self.obsTF, false)

		return
	end, go(self.obsTF), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_119_0)
		self.obsCanvas.alpha = arg_119_0

		return
	end))

	return
end

function GameRoomCurlingView:Update()
	self:AddDebugInput()

	return
end

function GameRoomCurlingView:AddDebugInput()
	if self.gamePause or self.gameEndFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function GameRoomCurlingView:changeSpeed(arg_122_1)
	return
end

function GameRoomCurlingView:onTimer()
	self.curling:Step()
	self.walker:Step()
	self:updateGameUI()

	return
end

function GameRoomCurlingView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GameRoomCurlingView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function GameRoomCurlingView:updateGameUI()
	setText(self.scoreTF, self.scoreNum)
	setText(self.roundTF, "Round " .. self.roundNum)

	return
end

function GameRoomCurlingView:addScore(arg_127_1, arg_127_2)
	local var_127_0 = cloneTplTo(self.gameUI:Find("score_tf"), self.scoreGroup)

	if arg_127_2 then
		setLocalPosition(var_127_0, arg_127_2)
	else
		setLocalPosition(var_127_0, Vector2(432, 144))
	end

	setActive(var_127_0, false)
	setActive(var_127_0, true)
	setText(var_127_0, "+" .. arg_127_1)

	self.scoreNum = self.scoreNum + arg_127_1

	return
end

function GameRoomCurlingView:pauseGame()
	self.gamePause = true

	self:timerStop()
	self:changeSpeed(0)
	self:pauseManagedTween()
	self:emit(var_0_47)

	return
end

function GameRoomCurlingView:resumeGame()
	self.gamePause = false

	self:changeSpeed(1)
	self:timerStart()
	self:resumeManagedTween()
	self:emit(var_0_48)

	return
end

function GameRoomCurlingView:nextRoundGame()
	removeAllChildren(self.scoreGroup)

	if self.roundNum == 3 then
		self:endGame()
	else
		self.roundNum = self.roundNum + 1

		self:CoordinateGrid(self.gridTF)
		self:staticObsStart()
		self:emit(var_0_46)
	end

	return
end

function GameRoomCurlingView:endGame()
	if self.gameEndFlag then
		return
	end

	self:timerStop()

	self.gameEndFlag = true

	setActive(self.clickMask, true)
	self:managedTween(LeanTween.delayedCall, function()
		self.gameEndFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showEndUI()

		return
	end, 0.1, nil)

	return
end

function GameRoomCurlingView:showEndUI()
	setActive(self.endUI, true)

	local var_133_0 = self.scoreNum
	local var_133_1 = getProxy(MiniGameProxy):GetHighScore(self:GetMGData().id)
	local var_133_2

	if var_133_1 and #var_133_1 > 0 then
		var_133_2 = var_133_1[1] or 0

		if not var_133_1 or #var_133_1 <= 1 or not var_133_1[2] then
			-- block empty
		end
	end

	setActive(self.endUI:Find("ad/panel/cur_score/new"), var_133_2 < var_133_0)

	if var_133_2 <= var_133_0 then
		var_133_2 = var_133_0

		self:StoreDataToServer({
			var_133_0
		})
	end

	setText(self.endUI:Find("ad/panel/highest_score"), var_133_2)
	setText(self.endUI:Find("ad/panel/cur_score"), var_133_0)
	self:SendSuccess(var_133_0 or 0)

	return
end

function GameRoomCurlingView:CoordinateGrid(arg_134_1)
	local var_134_0 = Vector2(150, 150)
	local var_134_1 = Vector2(arg_134_1.anchoredPosition.x - arg_134_1.rect.width / 2, arg_134_1.anchoredPosition.y - arg_134_1.rect.height / 2)
	local var_134_2 = math.modf(arg_134_1.rect.height / var_134_0.y)
	local var_134_3 = math.modf(arg_134_1.rect.width / var_134_0.x)

	self.grids = {}

	for iter_134_0 = 1, var_134_3 do
		for iter_134_1 = 1, var_134_2 do
			table.insert(self.grids, Vector2(var_134_1.x + iter_134_0 * (arg_134_1.rect.width % var_134_0.x / (var_134_3 + 1) + var_134_0.x) - var_134_0.x / 2, var_134_1.y + iter_134_1 * (arg_134_1.rect.height % var_134_0.y / (var_134_2 + 1) + var_134_0.y) - var_134_0.y / 2))
		end
	end

	return
end

function GameRoomCurlingView:getGameTimes()
	return self:GetMGHubData().count
end

function GameRoomCurlingView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function GameRoomCurlingView:getUltimate()
	return self:GetMGHubData().ultimate
end

function GameRoomCurlingView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function GameRoomCurlingView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(GameRoomCurlingView.ON_BACK_PRESSED)
	else
		if self.gameEndFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:pauseGame()
		setActive(self.returnUI, true)
	end

	return
end

function GameRoomCurlingView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	self:cleanManagedTween()

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

return GameRoomCurlingView
