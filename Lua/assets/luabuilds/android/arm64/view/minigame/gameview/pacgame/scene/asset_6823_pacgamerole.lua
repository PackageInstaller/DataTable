local PacGameRole = class("PacGameRole")

function PacGameRole:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._roleData = arg_1_2
	self._tf.name = arg_1_2.name
	self._autoState = arg_1_2.auto_state
	self._enemyFlag = arg_1_2.enemy
	self._bound = arg_1_2.bound

	if arg_1_2.rate then
		self._rate = arg_1_2.rate or 0
	end

	self._rateCount = 0
	self._halfBound = {
		self._bound[1] / 2,
		self._bound[2] / 2
	}
	self._spineAnimUI = GetComponent(findTF(self._tf, "spine"), "SpineAnimUI")
	self._direct = {
		0,
		0
	}
	self._rushState = false
	self._rushTime = nil
	self._position = Vector2(0, 0)
	self._speed = arg_1_2.speed
	self._rushSpeed = arg_1_2.rush_speed
	self._anchoredPosition = self._tf.anchoredPosition
	self._roads = {}
	self._targetHistory = {}
	self._targetHistoryCount = 0
	self._isPlayer = false
	self._animator = GetComponent(self._tf, typeof(Animator))
	self._directArrowTf = findTF(self._tf, "player_arrow")

	self:setActionNormal()

	return
end

function PacGameRole:SetPlayer(arg_2_1)
	self._isPlayer = arg_2_1

	return
end

function PacGameRole:Step(arg_3_1)
	self._deltaTime = arg_3_1

	local var_3_0 = false

	if self._rushTime and self._rushTime >= 0 then
		if self._rushTime <= 3 then
			var_3_0 = true
		end

		self._rushTime = self._rushTime - arg_3_1

		if self._rushTime < 0 then
			self:SetRush(false, nil)

			self._rushTime = nil
		end
	end

	if self._animator:GetBool("flash") ~= var_3_0 then
		self._animator:SetBool("flash", var_3_0)
	end

	if self._backStartStepTime and self._backStartStepTime >= 0 then
		self._backStartStepTime = self._backStartStepTime - arg_3_1

		if self._backStartStepTime < 0 then
			self:SetAction("normal", 0)
			self:SetBackStart(false)

			self._backStartStepTime = nil
		end
	end

	return
end

function PacGameRole:GetSpeed()
	if self._rushState then
		return self._rushSpeed
	elseif self:GetBackStart() then
		return self._speed * 4
	end

	if self._isPlayer then
		return self._speed
	end

	return (self._speed + self._rate * self._rateCount >= PacGameConst.enemy_max_speed or nil) and (PacGameConst.enemy_max_speed or self._speed + self._rate * self._rateCount)
end

function PacGameRole:SetRateAdd()
	self._rateCount = self._rateCount + 1

	return
end

function PacGameRole:SetStartIndex(arg_6_1)
	self._startIndex = arg_6_1

	return
end

function PacGameRole:GetStartIndex()
	return self._startIndex
end

function PacGameRole:SetParent(arg_8_1)
	setParent(self._tf, arg_8_1)

	return
end

function PacGameRole:GetParent()
	return self._tf.parent
end

function PacGameRole:SetPosition(arg_10_1)
	self._tf.anchoredPosition = arg_10_1
	self._anchoredPosition = self._tf.anchoredPosition

	return
end

function PacGameRole:SetScale(arg_11_1)
	self._tf.localScale = arg_11_1

	return
end

function PacGameRole:SetGridIndex(arg_12_1)
	self._gridIndex = arg_12_1

	if self:GetBackStart() and self._gridIndex == self._startIndex then
		self._backStartStepTime = 5
	end

	return
end

function PacGameRole:GetGridIndex()
	return self._gridIndex
end

function PacGameRole:GetGridIndexNext()
	if self:HasTarget() then
		local var_14_0 = math.abs(self._target.x - self._tf.anchoredPosition.x)
		local var_14_1 = math.abs(self._target.y - self._tf.anchoredPosition.y)

		if var_14_0 + var_14_1 >= self._halfBound[1] then
			return self._gridIndex
		elseif var_14_0 >= self._halfBound[1] then
			return self._gridIndex
		elseif var_14_1 >= self._halfBound[2] then
			return self._gridIndex
		end

		return self._targetIndex
	end

	return self._gridIndex
end

function PacGameRole:HasTarget()
	return self._target ~= nil
end

function PacGameRole:SetBackStart(arg_16_1)
	self._setBackToStart = arg_16_1

	return
end

function PacGameRole:GetBackStart()
	return self._setBackToStart
end

function PacGameRole:MoveTo(arg_18_1)
	self._targetHistoryCount = self._targetHistoryCount + 1

	table.insert(self._targetHistory, arg_18_1)
	self:SetPosition(arg_18_1)

	return
end

function PacGameRole:GetMove()
	return self._move
end

function PacGameRole:GetTarget()
	return self._target
end

function PacGameRole:SetRoads(arg_21_1)
	self._roads = arg_21_1

	return
end

function PacGameRole:GetRoads()
	return self._roads
end

function PacGameRole:PopRoad()
	if #self._roads >= 0 then
		return table.remove(self._roads, 1)
	end

	return nil
end

function PacGameRole:SetRoadBack(arg_24_1)
	self._roadBack = arg_24_1

	return
end

function PacGameRole:GetRoadBack()
	return self._roadBack
end

function PacGameRole:SetTarget(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_1 then
		self._target = arg_26_1
		self._targetIndex = arg_26_2
		self._move = arg_26_3
		self._targetDirect = arg_26_4
		self._targetHistory = {}
		self._targetHistoryCount = 0

		self:setActionByDirect(arg_26_4)

		if self._isPlayer then
			self:setDirectArrow(arg_26_4)
		end
	else
		self._target = nil
		self._targetIndex = nil
		self._move = nil
		self._targetDirect = nil
		self._targetHistory = {}
		self._targetHistoryCount = 0

		self:setActionByDirect(self._direct)
	end

	return
end

function PacGameRole:GetTargetHistoryCount()
	return self._targetHistoryCount
end

function PacGameRole:GetTargetDirect()
	return self._targetDirect
end

function PacGameRole:GetTargetIndex()
	return self._targetIndex
end

function PacGameRole:GetAutoState()
	return self._autoState
end

function PacGameRole:SetActive(arg_31_1)
	setActive(self._tf, arg_31_1)

	return
end

function PacGameRole:SetAction(arg_32_1, arg_32_2)
	if self._playingAction == arg_32_1 then
		return
	end

	self._playingAction = arg_32_1

	self._spineAnimUI:SetAction(arg_32_1, arg_32_2)

	return
end

function PacGameRole:SetActionCallBack(arg_33_1)
	self._spineAnimUI:SetActionCallBack(arg_33_1)

	return
end

function PacGameRole:SetRush(arg_34_1, arg_34_2)
	print("角色开始冲刺")

	self._rushState = arg_34_1
	self._rushTime = arg_34_2

	self:reflashAniamtion()

	return
end

function PacGameRole:GetRush()
	return self._rushState
end

function PacGameRole:GetPosition()
	return self._anchoredPosition
end

function PacGameRole:SetDirect(arg_37_1)
	arg_37_1 = arg_37_1 or {
		0,
		0
	}
	self._direct = arg_37_1

	if not self:HasTarget() then
		self:setActionByDirect(self._direct)
	end

	return
end

function PacGameRole:GetDirect()
	return self._direct
end

function PacGameRole:SetAsLastSibling()
	if self._tf then
		self._tf:SetAsLastSibling()
	end

	return
end

function PacGameRole:Dispose()
	if self._tf then
		destroy(self._tf)

		self._tf = nil
	end

	self._roleData = nil
	self._playingAction = nil

	if self._spineAnimUI then
		self._spineAnimUI:SetActionCallBack(nil)

		self._spineAnimUI = nil
	end

	self._target = nil
	self._roads = {}

	return
end

function PacGameRole:setDirectArrow(arg_41_1)
	setActive(findTF(self._tf, "bg/L"), false)
	setActive(findTF(self._tf, "bg/R"), false)
	setActive(findTF(self._tf, "bg/T"), false)
	setActive(findTF(self._tf, "bg/B"), false)

	if arg_41_1[1] == 1 then
		setActive(findTF(self._tf, "bg/R"), true)
	elseif arg_41_1[1] == -1 then
		setActive(findTF(self._tf, "bg/L"), true)
	elseif arg_41_1[2] == 1 then
		setActive(findTF(self._tf, "bg/T"), true)
	elseif arg_41_1[2] == -1 then
		setActive(findTF(self._tf, "bg/B"), true)
	end

	return
end

function PacGameRole:reflashAniamtion()
	if self._targetDirect then
		self:setActionByDirect(self._targetDirect)
	elseif self._direct then
		self:setActionByDirect(self._direct)
	end

	return
end

function PacGameRole:setActionByDirect(arg_43_1)
	local var_43_0 = self:getDirectActionName(arg_43_1)
	local var_43_1

	if self:GetBackStart() then
		var_43_1 = "hang"
	elseif var_43_0 then
		self._idleAction = "idle_" .. var_43_0
		var_43_1 = self._rushState and "rush_" .. var_43_0 or "run_" .. var_43_0
	end

	if var_43_1 then
		if var_43_1 and var_43_1 ~= self._playingAction then
			self:SetAction(var_43_1, 0)
		end
	elseif self._isPlayer and self._idleAction and self._idleAction ~= self._playingAction then
		self:SetAction(self._idleAction, 0)
	end

	return
end

function PacGameRole:SetHangAction()
	self:SetAction("hang", 0)

	return
end

function PacGameRole:getDirectActionName(arg_45_1)
	local var_45_0

	if arg_45_1[1] ~= 0 then
		var_45_0 = arg_45_1[1] > 0 and "right" or "left"
	elseif arg_45_1[2] ~= 0 then
		var_45_0 = arg_45_1[2] > 0 and "up" or "down"
	end

	return var_45_0
end

function PacGameRole:setActionNormal()
	self:SetAction("normal", 0)

	return
end

function PacGameRole:GetEnemyFlag()
	return self._enemyFlag
end

return PacGameRole
