local CookGameJudge = class("CookGameJudge")

function CookGameJudge:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self._tf = arg_1_1
	self._judgeDatas = arg_1_3
	self._gameData = arg_1_4
	self._event = arg_1_5
	self._index = arg_1_2
	self.wantedTf = findTF(self._tf, "wanted")
	self.smokeTf = findTF(self._tf, "wanted/smoke")
	self.dftEvent = GetComponent(findTF(self._tf, "mask/anim"), typeof(DftAniEvent))

	self.dftEvent:SetEndEvent(function(arg_2_0)
		self:onAniEnd()

		return
	end)

	self.animator = GetComponent(findTF(self._tf, "mask/anim"), typeof(Animator))

	onButton(self._event, findTF(self._tf, "collider"), function()
		if self.clickCallback then
			self.clickCallback()
		end

		return
	end, SFX_CANCEL)

	return
end

function CookGameJudge:clear()
	self._puzzleTime = nil
	self._puzzleWeight = nil
	self._puzzleCamp = nil
	self.cakeId = 1
	self.inTrigger = false
	self.serveData = nil
	self.serveCallback = nil

	self:updateWanted(nil)
	self:showCard(nil)
	setActive(self.wantedTf, false)
	setActive(self._tf, false)

	self.animator.runtimeAnimatorController = self:getAnimData(self.cakeId).runtimeAnimator

	self:select(false)

	return
end

function CookGameJudge:start()
	self:clear()
	setActive(self._tf, true)
	self:updateWanted(math.random(1, self._gameData.cake_num))

	return
end

function CookGameJudge:step(arg_6_1)
	if self.wantedCakeTime and self.wantedCakeTime > 0 then
		self.wantedCakeTime = self.wantedCakeTime - arg_6_1

		if self.wantedCakeTime <= 0 then
			self.wantedCakeTime = nil

			self:updateWanted(math.random(1, self._gameData.cake_num))
		end
	end

	if self._puzzleTime then
		self._puzzleTime = self._puzzleTime - arg_6_1

		if self._puzzleTime <= 0 then
			self._puzzleTime = nil
			self._puzzleCamp = nil
			self._puzzleWeight = nil

			self:showCard(false)
		end
	end

	if self.readyServeTime and self.readyServeTime > 0 then
		self.readyServeTime = self.readyServeTime - arg_6_1

		if self.readyServeTime <= 0 then
			self.readyServeTime = nil
			self.serveData = nil
			self.serveCallback = nil
		end
	end

	return
end

function CookGameJudge:destroy()
	return
end

function CookGameJudge:changeSpeed(arg_8_1)
	self.animator.speed = arg_8_1

	return
end

function CookGameJudge:onAniEnd()
	self.inTrigger = false

	if self.freshWanted then
		self.freshWanted = false
		self.wantedCakeTime = nil

		self:updateWanted(math.random(1, self._gameData.cake_num))
	end

	return
end

function CookGameJudge:getIndex()
	return self._index
end

function CookGameJudge:getTf()
	return self._tf
end

function CookGameJudge:trigger(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if self.inTrigger then
		print("评委已有状态")

		return
	end

	local var_12_0 = Vector3(1, 1, 1)

	self.inTrigger = true

	if self.cakeId ~= arg_12_1 then
		self.cakeId = arg_12_1
		self.animator.runtimeAnimatorController = self:getAnimData(self.cakeId).runtimeAnimator
	end

	self.animator:SetBool("AC", arg_12_3 or false)
	self.animator:SetBool("right", arg_12_2 or false)
	self.animator:SetBool("bk", arg_12_4 or false)
	self.animator:SetBool("reject", self._puzzleCamp and true or false)

	if self._puzzleCamp and not arg_12_2 then
		findTF(self._tf, "mask").localScale = self._puzzleCamp == CookGameConst.camp_player and Vector3(-1, 1, 1) or Vector3(1, 1, 1)
	end

	self.animator:SetTrigger("trigger")

	if arg_12_2 then
		self:updateWanted()

		self.freshWanted = true
		self.wantedCakeTime = 3
	end

	return
end

function CookGameJudge:readyServe(arg_13_1, arg_13_2)
	if self.serveCallback then
		self.serveCallback(false)
	end

	self.serveData = arg_13_1
	self.readyServeTime = 4
	self.serveCallback = arg_13_2

	if self.serveData.battleData.cake_allow and self.wantedCake ~= self.serveData.parameter.cakeId then
		if not self._puzzleTime then
			setActive(self.smokeTf, false)
			setActive(self.smokeTf, true)

			self.wantedCake = self.serveData.parameter.cakeId

			self:showCake(self.wantedCake)
		elseif self._puzzleCamp ~= self.serveData.parameter.camp and self.serveData.parameter.weight > self._puzzleWeight then
			setActive(self.smokeTf, false)
			setActive(self.smokeTf, true)

			self.wantedCake = self.serveData.parameter.cakeId

			self:showCake(self.wantedCake)
		end
	end

	return
end

function CookGameJudge:setWantedImg()
	return
end

function CookGameJudge:serve()
	if not self.serveData then
		return
	end

	if (not self.wantedCake or self.inTrigger) and self.serveCallback then
		self.serveCallback(false)
	end

	local var_15_0 = self.serveData.parameter.cakeId
	local var_15_1 = self.serveData.battleData.ac_able
	local var_15_2 = self.serveData.judgeData.acPos
	local var_15_5 = self.serveData.parameter.right_flag

	if not self.serveData.parameter.cakeId then
		print("cakeId 不能为nil")

		return
	end

	local var_15_8 = not not var_15_1
	local var_15_9 = false

	if not not var_15_1 then
		if var_15_2.y > self._tf.anchoredPosition.y then
			var_15_9 = true
		end
	end

	local var_15_11 = 1

	if self._puzzleCamp and self.serveData.parameter.camp == self._puzzleCamp then
		var_15_11 = 2
	elseif self._puzzleCamp and self.serveData.parameter.camp ~= self._puzzleCamp then
		var_15_11 = 0
	end

	if self.serveData.parameter.puzzle then
		self:setPuzzle(self.serveData.parameter.camp, self.serveData.battleData.weight)
	end

	local var_15_12 = self._puzzleWeight or 0

	self:trigger(var_15_0, var_15_5, var_15_8, var_15_9)
	self._event:emit(CookGameView.SERVE_EVENT, {
		serveData = self.serveData,
		pos = self._tf.position,
		right = var_15_5,
		rate = var_15_11,
		weight = var_15_12
	})

	self.serveData = nil
	self.serveCallback = nil
	self.readyServeTime = nil

	return
end

function CookGameJudge:setPuzzle(arg_16_1, arg_16_2)
	self._puzzleCamp = arg_16_1
	self._puzzleWeight = arg_16_2
	self._puzzleTime = CookGameConst.puzzle_time

	self:showCard(true)

	return
end

function CookGameJudge:showCard(arg_17_1)
	setActive(findTF(self.wantedTf, "Card"), arg_17_1)
	self:showCake(nil)

	return
end

function CookGameJudge:isInServe()
	return self.serveData
end

function CookGameJudge:isInTrigger()
	return self.inTrigger
end

function CookGameJudge:getPuzzleCamp()
	return self._puzzleCamp
end

function CookGameJudge:getWantedCake()
	return self.wantedCake
end

function CookGameJudge:updateWanted(arg_22_1)
	if self.wantedCake ~= arg_22_1 and arg_22_1 then
		self:showCake(arg_22_1)
	end

	if arg_22_1 and arg_22_1 > 0 then
		setActive(self.wantedTf, true)

		self.wantedCake = arg_22_1
		self.wantedCakeTime = nil
	else
		setActive(self.wantedTf, false)
	end

	return
end

function CookGameJudge:showCake(arg_23_1)
	arg_23_1 = arg_23_1 or self.wantedCake

	for iter_23_0 = 1, self._gameData.cake_num do
		setActive(findTF(self.wantedTf, "cake_" .. iter_23_0), not self._puzzleTime and iter_23_0 == arg_23_1)
	end

	return
end

function CookGameJudge:setFrontContainer(arg_24_1)
	self._frontTf = arg_24_1

	if self._frontTf then
		SetParent(self.wantedTf, self._frontTf, true)
	end

	return
end

function CookGameJudge:getPos()
	return self._tf.anchoredPosition()
end

function CookGameJudge:getLeftTf()
	return findTF(self._tf, "leftPos")
end

function CookGameJudge:getRightTf()
	return findTF(self._tf, "rightPos")
end

function CookGameJudge:select(arg_28_1)
	setActive(findTF(self._tf, "select"), arg_28_1)

	return
end

function CookGameJudge:setClickCallback(arg_29_1)
	self.clickCallback = arg_29_1

	return
end

function CookGameJudge:getAcTargetTf()
	return findTF(self._tf, "acTarget")
end

function CookGameJudge:getAnimData(arg_31_1)
	for iter_31_0 = 1, #self._judgeDatas do
		if self._judgeDatas[iter_31_0].data.cake_id == arg_31_1 then
			return self._judgeDatas[iter_31_0]
		end
	end

	return nil
end

return CookGameJudge
