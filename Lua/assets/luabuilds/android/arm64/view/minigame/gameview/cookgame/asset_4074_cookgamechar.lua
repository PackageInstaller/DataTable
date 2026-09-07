local CookGameChar = class("CookGameChar")
local var_0_1 = 20
local var_0_2 = 3

function CookGameChar:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._gameData = arg_1_2
	self._event = arg_1_3
	self._animTf = findTF(self._tf, "mask/anim")
	self._animator = GetComponent(findTF(self._tf, "mask/anim"), typeof(Animator))
	self._animImage = GetComponent(findTF(self._tf, "mask/anim"), typeof(Image))
	self._dftEvent = GetComponent(findTF(self._tf, "mask/anim"), typeof(DftAniEvent))

	self._dftEvent:SetStartEvent(function(arg_2_0)
		if self._serveFunc then
			self._serveFunc()

			self._serveFunc = nil

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_serve)
		end

		return
	end)
	self._dftEvent:SetEndEvent(function(arg_3_0)
		self:endEventHandle()

		return
	end)

	return
end

function CookGameChar:endEventHandle()
	if self.activing then
		self.activing = false
		self.activingTime = nil
	end

	if self.timeToEventHandle and self.timeToEventHandle > 0 then
		self.timeToEventHandle = nil
	end

	if self._serveSpeed then
		if self.directX == -1 then
			setActive(findTF(self._tf, "effectW"), false)
			setActive(findTF(self._tf, "effectW"), true)
		else
			setActive(findTF(self._tf, "effectE"), false)
			setActive(findTF(self._tf, "effectE"), true)
		end

		self._serveSpeed = false
	end

	if self._serveFresh then
		self._serveFresh = false
		self.cakeNum = self.cakeNum - 1

		if self.cakeNum < 0 then
			self.cakeNum = 0
		end

		self:clearJudge()
		self:updateCharAniamtor()
		self:updateAnimatorParame()
	elseif self.sendExtend then
		self.sendExtend = false

		self._event:emit(CookGameView.EXTEND_EVENT)
	end

	self:setTrigger("clear", true)

	self.clearing = true

	return
end

function CookGameChar:changeSpeed(arg_5_1)
	self._animator.speed = arg_5_1

	return
end

function CookGameChar:setData(arg_6_1)
	if not arg_6_1 then
		self:setCharActive(false)

		return
	end

	self:setCharActive(true)

	self._charData = arg_6_1
	self._doubleAble = arg_6_1.battleData.double_able
	self._speedAble = arg_6_1.battleData.speed_able
	self._speedMax = arg_6_1.battleData.speed_max
	self._acAble = arg_6_1.battleData.ac_able
	self._skills = arg_6_1.battleData.skills
	self._baseSpeed = arg_6_1.battleData.base_speed
	self._scoreAdded = arg_6_1.battleData.score_added
	self._name = arg_6_1.battleData.name
	self._animDatas = arg_6_1.animDatas
	self._randomScore = arg_6_1.battleData.random_score
	self._doubleIndex = 1
	self._offset = arg_6_1.battleData.offset or Vector2(0, 0)
	self.extendFlag = false

	if self._charData.battleData.extend and (self._isPlayer or self._isPartner) then
		self.extendFlag = true
	end

	return
end

function CookGameChar:readyStart()
	self:clear()

	if self._isActive then
		self:updateCharAniamtor()
	end

	return
end

function CookGameChar:start()
	return
end

function CookGameChar:step(arg_9_1)
	self.deltaTime = arg_9_1

	if self._velocity then
		self:move()
	end

	if self.timeToEventHandle then
		self.timeToEventHandle = self.timeToEventHandle - arg_9_1

		if self.timeToEventHandle <= 0 then
			self.timeToEventHandle = nil

			self:endEventHandle()
		end
	end

	if self.activingTime and self.activingTime > 0 then
		self.activingTime = self.activingTime - self.deltaTime

		if self.activingTime <= 0 then
			self.activingTime = 0

			if self.activing then
				self.activing = false

				if self._serveFresh then
					self._serveFresh = false
					self.cakeNum = self.cakeNum - 1

					if self.cakeNum < 0 then
						self.cakeNum = 0
					end

					self:clearJudge()
					self:updateCharAniamtor()
					self:updateAnimatorParame()
				end

				self:setTrigger("clear", true)
			end
		end
	end

	if self._gameData.gameTime < self._gameData.time_up and self.extendFlag then
		self:extend()
	end

	self.clearing = false

	return
end

function CookGameChar:updateCharAniamtor()
	local var_10_0 = self:getAnimatorName(self._name, self.leftCakeId, self.rightCakeId, self.speedNum, self._doubleAble, self._speedAble)

	if self._activeAniamtorName ~= var_10_0 then
		self.chacheSprite = self._animImage.sprite

		local var_10_1

		for iter_10_0 = 1, #self._animDatas do
			if self._animDatas[iter_10_0].name == var_10_0 then
				var_10_1 = self._animDatas[iter_10_0].runtimeAnimator
			end
		end

		if var_10_1 then
			self._activeAniamtorName = var_10_0
			self._animator.runtimeAnimatorController = var_10_1

			setActive(self._animTf, false)

			if self.chacheSprite then
				self._animImage.sprite = self.chacheSprite
			end

			setActive(self._animTf, true)
		else
			print("警告 找不到aniamtor ：" .. var_10_0)
		end
	end

	return
end

function CookGameChar:getAnimatorName(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	return arg_11_5 and arg_11_1 .. "_L" .. arg_11_2 .. "_R" .. arg_11_3 or arg_11_6 and arg_11_1 .. "_" .. "L" .. arg_11_2 .. "_" .. arg_11_4 or arg_11_1 .. "_" .. "L" .. arg_11_2
end

function CookGameChar:setCake(arg_12_1)
	self._cakeData = arg_12_1

	self:clearJudge()
	self:clearTargetPos()

	return
end

function CookGameChar:getCake()
	return self._cakeData
end

function CookGameChar:clearCake()
	if self._cakeData then
		setActive(findTF(self._cakeData.tf, "select"), false)

		self._cakeData = nil
	end

	return
end

function CookGameChar:setJudge(arg_15_1)
	self._judgeData = arg_15_1

	self:clearCake()
	self:clearTargetPos()

	return
end

function CookGameChar:clearJudge()
	if self._judgeData then
		setActive(findTF(self._judgeData.tf, "select"), false)

		self._judgeData = nil
	end

	return
end

function CookGameChar:getJudgeData()
	return self._judgeData
end

function CookGameChar:setTargetPos(arg_18_1)
	self._targetPos = arg_18_1

	self:clearVelocity()

	return
end

function CookGameChar:stopMove()
	self:clearTargetPos()
	self:clearVelocity()
	self:updateAnimatorParame()

	if not self.activing then
		if self._cakeData then
			self:pickupCake()
		elseif self._judgeData then
			self:readyServeCake()
		end
	else
		self:clearCake()
		self:clearJudge()
	end

	return
end

function CookGameChar:getJudge()
	if self._judgeData then
		return self._judgeData.judge
	end

	return nil
end

function CookGameChar:pickupCake()
	if self._cakeData then
		local var_21_0 = self._cakeData.id

		if self._tf.parent:InverseTransformPoint(self._cakeData.tf.position).x < self._tf.anchoredPosition.x then
			self.directX = -1
			self.directY = -1
		else
			self.directX = 1
			self.directY = -1
		end

		if self._doubleAble then
			if self.cakeNum == 0 then
				self.leftCakeId = var_21_0
				self.rightCakeId = 0
				self.cakeNum = 1
				self.useL = true
				self.useR = false
			elseif self.cakeNum == 1 then
				self.cakeNum = 2
				self.rightCakeId = var_21_0
				self.useL = false
				self.useR = true
			elseif self.cakeNum == 2 then
				if self._doubleIndex % 2 == 0 then
					self.leftCakeId = var_21_0
					self.useL = true
					self.useR = false
				else
					self.rightCakeId = var_21_0
					self.useL = false
					self.useR = true
				end

				self._doubleIndex = self._doubleIndex + 1
			end
		else
			self.leftCakeId = var_21_0
			self.cakeNum = 1
		end

		if self._pickupFull and self:isFullCakes() then
			self:setPickupFull(false)
		end

		self:updateCharAniamtor()
		self:updateAnimatorParame()
		self:clearCake()
		self:pickup()
	end

	return
end

function CookGameChar:readyServeCake()
	local var_22_0 = self._judgeData.judge

	if self._judgeData.judge:isInServe() or var_22_0:isInTrigger() or self.cakeNum == 0 then
		self:clearJudge()

		return
	end

	if self._tf.parent:InverseTransformPoint(self._judgeData.tf.position).x < self._tf.anchoredPosition.x then
		self.directX = -1
		self.directY = -1
	else
		self.directX = 1
		self.directY = -1
	end

	local var_22_1 = var_22_0:getWantedCake()
	local var_22_2 = self.leftCakeId

	self.serveRight = false

	if self._doubleAble then
		if self.leftCakeId == var_22_1 then
			self.useL = true
			self.useR = false
			var_22_2 = self.leftCakeId
			self.leftCakeId = self.rightCakeId
			self.rightCakeId = 0
			self.serveRight = true
		elseif self.rightCakeId == var_22_1 then
			self.useL = false
			self.useR = true
			var_22_2 = self.rightCakeId
			self.rightCakeId = 0
			self.serveRight = true
		else
			self.useL = true
			self.useR = false
			var_22_2 = self.leftCakeId
			self.leftCakeId = self.rightCakeId
			self.rightCakeId = 0
		end

		if var_22_2 == var_22_1 then
			self.rightCakeIndex = self.rightCakeIndex + 1
		end
	elseif self._speedAble then
		if var_22_1 == self.leftCakeId then
			if self.speedNum < self._speedMax then
				self.speedNum = self.speedNum + 1
			end

			self.serveRight = true
			self.serveWrong = false
		else
			self.serveRight = false
			self.serveWrong = true
			self.speedNum = 0
		end

		self.directX = -1 * self.directX
		self.leftCakeId = 0
	elseif self._scoreAdded or self._randomScore then
		if var_22_1 == self.leftCakeId then
			self.serveRight = true
			self.serveWrong = false
		else
			self.serveRight = false
			self.serveWrong = true
		end

		self.leftCakeId = 0
	else
		if var_22_1 == self.leftCakeId then
			self.serveRight = true
		end

		self.leftCakeId = 0
	end

	if not self.serveRight and self._charData.battleData.cake_allow then
		self.serveRight = true
	end

	if not self._charData.battleData.weight then
		-- block empty
	end

	local var_22_4 = var_22_0:getPuzzleCamp()

	self.puzzleDouble = false
	self.puzzleReject = false

	if var_22_4 then
		if self._camp == var_22_4 then
			self.serveRight = true
			self.puzzleDouble = true
			self.serveWrong = false
		else
			self.serveRight = false
			self.serveWrong = true
			self.puzzleReject = true
		end
	end

	if self._speedAble and self.serveRight then
		self._serveSpeed = true

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_speed_up)
	end

	if self.serveRight then
		self.rightCakeIndex = self.rightCakeIndex + 1
		self.seriesRightIndex = self.seriesRightIndex + 1

		if self.seriesRightIndex > CookGameConst.added_max then
			self.seriesRightIndex = CookGameConst.added_max
		end
	else
		self.seriesRightIndex = 0
	end

	self.triggerPuzzle = false

	if self._charData.battleData.puzzle and self.serveRight then
		self.triggerPuzzle = math.random(1, 100) <= CookGameConst.puzzle_rate
	end

	self:checkEffectInServe()

	self.serveCakeId = var_22_2
	self._serveFresh = true

	var_22_0:readyServe({
		parameter = self:getParameter(),
		battleData = self._charData.battleData,
		judgeData = self._judgeData
	})

	if self._acAble then
		local var_22_5 = self:getAcCakeData(var_22_0)

		function self._serveFunc()
			self._event:emit(CookGameView.AC_CAKE_EVENT, var_22_5)

			return
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_ac)
	else
		function self._serveFunc()
			var_22_0:serve()

			return
		end
	end

	self:updateAnimatorParame()
	self:startServeCake()

	return
end

function CookGameChar:getAcCakeData(arg_25_1)
	local var_25_0 = self._tf.parent:InverseTransformPoint(arg_25_1:getAcTargetTf().position)

	var_25_0.y = self.serveRight and var_25_0.y or var_25_0.y + 50

	local var_25_1

	if self.directX == 1 then
		var_25_1 = self._tf.parent:InverseTransformPoint(findTF(self._tf, "acR").position)
	end

	local var_25_2

	do
		var_25_1 = self._tf.parent:InverseTransformPoint(findTF(self._tf, "acL").position)
		var_25_2 = {
			cakeId = self.serveCakeId,
			startPos = var_25_1,
			targetPos = var_25_0
		}
	end

	function var_25_2.callback()
		arg_25_1:serve()

		return
	end

	return var_25_2
end

function CookGameChar:getParameter()
	local var_27_0 = self._charData.battleData.weight or 0

	return {
		cakeId = self.serveCakeId,
		right_index = self.rightCakeIndex,
		series_right_index = self.seriesRightIndex,
		camp = self._camp,
		puzzle_double = self.puzzleDouble,
		puzzleReject = self.puzzleReject,
		puzzle = self.triggerPuzzle,
		weight = var_27_0,
		right_flag = self.serveRight
	}
end

function CookGameChar:checkEffectInServe()
	local var_28_0 = self._charData.battleData.effect
	local var_28_1
	local var_28_2 = Vector3(1, 1, 1)

	if self._scoreAdded and self.serveRight then
		var_28_1 = var_28_0[self.seriesRightIndex == 0 and 1 or self.seriesRightIndex > #var_28_0 and #var_28_0 or self.seriesRightIndex]
	elseif self.triggerPuzzle then
		var_28_1 = var_28_0[1]
		var_28_2 = (self._isPartner or self._isPlayer) and Vector3(1, 1, 1) or Vector3(-1, 1, 1)
	end

	self._effectContent = self._effectContent or findTF(self._tf, "effect")

	if var_28_1 then
		local var_28_4 = findTF(self._effectContent, var_28_1)

		var_28_4.localScale = var_28_2

		GetComponent(findTF(var_28_4, "anim"), typeof(DftAniEvent)):SetEndEvent(function(arg_29_0)
			setActive(var_28_4, false)

			return
		end)
		setActive(var_28_4, true)
	end

	return
end

function CookGameChar:getId()
	return self._charData.battleData.id
end

function CookGameChar:getDoubleAble()
	return self._doubleAble
end

function CookGameChar:setPetFlag(arg_32_1)
	self._isPet = arg_32_1

	return
end

function CookGameChar:getpetFlag()
	return self._isPet
end

function CookGameChar:setCharActive(arg_34_1)
	self._isActive = arg_34_1

	setActive(self._tf, self._isActive)

	return
end

function CookGameChar:getCharActive()
	return self._isActive
end

function CookGameChar:isFullCakes()
	if self._doubleAble and self.cakeNum == 2 then
		return true
	elseif not self._doubleAble and self.cakeNum == 1 then
		return true
	end

	return false
end

function CookGameChar:getPickupFull()
	return self._pickupFull
end

function CookGameChar:setPickupFull(arg_38_1)
	self._pickupFull = arg_38_1

	return
end

function CookGameChar:getTargetPos()
	return self._targetPos
end

function CookGameChar:clearTargetPos()
	self._targetPos = nil

	return
end

function CookGameChar:setVelocity(arg_41_1, arg_41_2, arg_41_3)
	self._velocity = Vector2(arg_41_1 * self._baseSpeed * (1 + self.speedNum / 3), arg_41_2 * self._baseSpeed * (1 + self.speedNum / 3))

	if not self._isPlayer and not self._isPartner then
		self._velocity = Vector2(self._velocity.x * 0.9, self._velocity.y * 0.9)
	end

	local var_41_0 = math.rad2Deg * arg_41_3
	local var_41_1 = arg_41_1 > 0 and 1 or -1
	local var_41_2 = arg_41_2 > 0 and 1 or -1

	if math.abs(math.rad2Deg * arg_41_3) <= var_0_1 then
		var_41_2 = 0
	elseif var_41_0 > var_0_1 and 90 - math.abs(var_41_0) <= var_0_1 then
		var_41_1 = 0
	end

	self.directX = var_41_1
	self.directY = var_41_2
	self.run = true
	self.idle = false

	self:updateAnimatorParame()

	return
end

function CookGameChar:updateAnimatorParame()
	self:setInteger("x", self.directX)
	self:setInteger("y", self.directY)
	self:setBool("run", self.run)
	self:setBool("idle", self.idle)
	self:setInteger("num", self.cakeNum)

	if self._doubleAble then
		self:setBool("L", self.useL)
		self:setBool("R", self.useR)
	end

	if self._speedAble then
		self:setInteger("speed_lv", self.speedNum)
		self:setTrigger("serve_right", self.serveRight)
		self:setTrigger("serve_wrong", self.serveWrong)
	end

	if self._randomScore then
		self:setTrigger("serve_right", self.serveRight)
		self:setTrigger("serve_wrong", self.serveWrong)
	end

	if self._scoreAdded then
		self:setTrigger("serve_right", self.serveRight == true)
		self:setTrigger("serve_wrong", self.serveWrong == true)
		self:setBool("server_a", self.seriesRightIndex <= 2)
		self:setBool("server_b", self.seriesRightIndex > 2)
	end

	return
end

function CookGameChar:getVelocity()
	return self._velocity
end

function CookGameChar:clearVelocity()
	self._velocity = nil
	self.run = false
	self.idle = true

	return
end

function CookGameChar:move()
	if self:isActiving() then
		return
	end

	if self._velocity then
		if self._targetPos then
			local var_45_0 = self:getPos()
			local var_45_1 = self._targetPos.x - var_45_0.x >= 0 and 1 or -1
			local var_45_2 = self._targetPos.y - var_45_0.y >= 0 and 1 or -1
			local var_45_3 = self:getPos()

			var_45_3.x = var_45_3.x + self._velocity.x * self.deltaTime
			var_45_3.y = var_45_3.y + self._velocity.y * self.deltaTime

			local var_45_4 = self._targetPos.x - var_45_3.x >= 0 and 1 or -1
			local var_45_5 = self._targetPos.y - var_45_3.y >= 0 and 1 or -1
			local var_45_6 = self:getPos()

			var_45_6.x = var_45_1 == (self._targetPos.x - var_45_3.x >= 0 and 1 or -1) and var_45_6.x + self._velocity.x * self.deltaTime or self._targetPos.x
			var_45_6.y = var_45_2 == var_45_5 and var_45_6.y + self._velocity.y * self.deltaTime or self._targetPos.y

			if self._acAble and self._judgeData and math.sqrt(math.pow(self._targetPos.x - var_45_6.x, 2) + math.pow(self._targetPos.y - var_45_6.y, 2)) <= CookGameConst.ac_dictance then
				self:stopMove()
				self:clearJudge()

				return
			end

			self._tf.anchoredPosition = var_45_6

			if var_45_1 ~= var_45_4 and var_45_1 ~= var_45_4 then
				self:stopMove()
			elseif math.abs(self._targetPos.x - var_45_6.x) < 5 and math.abs(self._targetPos.y - var_45_6.y) < 5 then
				self:stopMove()
			end
		else
			local var_45_7 = self:getPos()

			self._tf.anchoredPosition.x = self._tf.anchoredPosition.x + self._velocity.x * self.deltaTime
			self._tf.anchoredPosition.y = self._tf.anchoredPosition.y + self._velocity.y * self.deltaTime
			self._tf.anchoredPosition = self._tf.anchoredPosition
		end
	end

	return
end

function CookGameChar:extend()
	if not self.activing and not self.clearing then
		self.extendFlag = false
		self.activing = true
		self.sendExtend = true

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_marcopolo_skill)
		self:setTrigger("Extend", true)

		self.timeToEventHandle = var_0_2
	end

	return
end

function CookGameChar:isActiving()
	return self.activing
end

function CookGameChar:getPos()
	return self._tf.anchoredPosition
end

function CookGameChar:startServeCake()
	if self.activing then
		return
	end

	self.activing = true
	self.activingTime = 3

	self:setTrigger("server", true)

	return
end

function CookGameChar:pickup()
	if self.activing then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_pickup)
	self:setTrigger("pickup", true)

	self.activing = true

	return
end

function CookGameChar:setParent(arg_51_1, arg_51_2)
	self._tf.anchoredPosition = arg_51_2.init_pos
	self._tf.name = arg_51_2.tf_name

	setParent(self._tf, (findTF(arg_51_1, arg_51_2.parent)))
	setActive(self._tf, true)

	self.initPos = arg_51_2.init_pos
	self._bound = findTF(arg_51_1, "scene_background/" .. arg_51_2.bound)

	return
end

function CookGameChar:getTf()
	return self._tf
end

function CookGameChar:getOffset()
	return self._offset
end

function CookGameChar:getCakeIds()
	local var_54_0 = {}

	if self.leftCakeId > 0 then
		table.insert(var_54_0, self.leftCakeId)
	end

	if self.rightCakeId > 0 then
		table.insert(var_54_0, self.rightCakeId)
	end

	return var_54_0
end

function CookGameChar:isPlayer(arg_55_1)
	setActive(findTF(self._tf, "player"), arg_55_1)

	self._isPlayer = arg_55_1
	self._camp = self._isPlayer and CookGameConst.camp_player or CookGameConst.camp_enemy

	return
end

function CookGameChar:isPartner(arg_56_1)
	self._isPartner = arg_56_1
	self._camp = self._isPartner and CookGameConst.camp_player or CookGameConst.camp_enemy

	return
end

function CookGameChar:getCamp()
	return self._camp
end

function CookGameChar:setBool(arg_58_1, arg_58_2)
	self._animator:SetBool(arg_58_1, arg_58_2)

	return
end

function CookGameChar:setTrigger(arg_59_1, arg_59_2)
	if arg_59_2 then
		self._animator:SetTrigger(arg_59_1)
	else
		self._animator:ResetTrigger(arg_59_1)
	end

	return
end

function CookGameChar:setInteger(arg_60_1, arg_60_2)
	self._animator:SetInteger(arg_60_1, arg_60_2)

	return
end

function CookGameChar:clear()
	self.leftCakeId = 0
	self.rightCakeId = 0
	self._serveSpeed = false
	self.cakeNum = 0
	self.speedNum = 1
	self._speedRate = 1
	self.directX = 0
	self.directY = -1
	self.activing = false
	self.scoreAdded = false
	self._tf.anchoredPosition = self.initPos
	self.useL = true
	self.useR = false
	self.rightCakeIndex = 0
	self.seriesRightIndex = 0

	self:clearCake()
	self:clearJudge()
	self:clearTargetPos()
	self:clearVelocity()
	setActive(findTF(self._tf, "effectW"), false)
	setActive(findTF(self._tf, "effectE"), false)

	if self._animator and self._animator.runtimeAnimatorController then
		self:setInteger("x", 0)
		self:setInteger("y", -1)
		self:setInteger("num", 0)
		self:setBool("idle", true)
		self:setBool("run", false)
		self:setBool("L", false)
		self:setBool("R", false)
		self:setTrigger("server", false)
		self:setTrigger("pickup", false)
		self:setTrigger("serve_right", false)
		self:setTrigger("serve_wrong", false)
		self:setInteger("speed_lv", 0)
	end

	self._pickupFull = false

	return
end

return CookGameChar
