ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleAirFighterUnit = class("BattleAirFighterUnit", ys.Battle.BattleAircraftUnit)
ys.Battle.BattleAirFighterUnit.__name = "BattleAirFighterUnit"

local var_0_3 = ys.Battle.BattleAirFighterUnit

ys.Battle.BattleAirFighterUnit.AIRFIGHTER_ENTER_POINT = Vector3(Screen.width * -0.5, Screen.height * 0.5, 15)
ys.Battle.BattleAirFighterUnit.SPEED_FLY = Vector3(3, 0, 0)
ys.Battle.BattleAirFighterUnit.BACK_X = 100
ys.Battle.BattleAirFighterUnit.DOWN_X = 30
ys.Battle.BattleAirFighterUnit.ATTACK_X = -23
ys.Battle.BattleAirFighterUnit.UP_X = -70
ys.Battle.BattleAirFighterUnit.FREE_X = -75
ys.Battle.BattleAirFighterUnit.HEIGHT = ys.Battle.BattleConfig.AirFighterHeight
ys.Battle.BattleAirFighterUnit.STRIKE_STATE_FLY = 0
ys.Battle.BattleAirFighterUnit.STRIKE_STATE_BACK = 1
ys.Battle.BattleAirFighterUnit.STRIKE_STATE_DOWN = 2
ys.Battle.BattleAirFighterUnit.STRIKE_STATE_ATTACK = 3
ys.Battle.BattleAirFighterUnit.STRIKE_STATE_UP = 4
ys.Battle.BattleAirFighterUnit.STRIKE_STATE_FREE = 5
ys.Battle.BattleAirFighterUnit.STRIKE_STATE_BACKWARD = 6
ys.Battle.BattleAirFighterUnit.STRIKE_STATE_RECYCLE = 7

function ys.Battle.BattleAirFighterUnit:Ctor(arg_1_1)
	var_0_3.super.Ctor(self, arg_1_1)

	self._dir = var_0_0.Battle.BattleConst.UnitDir.LEFT
	self._type = var_0_0.Battle.BattleConst.UnitType.AIRFIGHTER_UNIT

	self:changeState(var_0_3.STRIKE_STATE_FLY)
	self:calcYShakeMin()
	self:calcYShakeMax()

	self._speedDir = Vector3(1, 0, 0)
	self._backwardWeaponID = {}

	return
end

function ys.Battle.BattleAirFighterUnit:Update(arg_2_1)
	self:UpdateSpeed()
	self:updateStrike()

	return
end

function ys.Battle.BattleAirFighterUnit:UpdateWeapon()
	for iter_3_0, iter_3_1 in ipairs(self:GetWeapon()) do
		local var_3_0 = table.contains(self._backwardWeaponID, (iter_3_1:GetWeaponId()))
		local var_3_1 = iter_3_1:GetCurrentState()

		iter_3_1:Update()

		local var_3_2 = iter_3_1:GetCurrentState()

		if var_3_0 and var_3_1 == iter_3_1.STATE_READY and (var_3_2 == iter_3_1.STATE_ATTACK or var_3_2 == iter_3_1.STATE_OVER_HEAT) then
			self:changeState(var_0_3.STRIKE_STATE_BACKWARD)
		end
	end

	return
end

function ys.Battle.BattleAirFighterUnit:CreateWeapon()
	local var_4_0 = {}

	if type(self._weaponTemplateID) == "table" then
		for iter_4_0, iter_4_1 in ipairs(self._weaponTemplateID) do
			var_4_0[iter_4_0] = var_0_0.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(iter_4_1, self, iter_4_0)
		end
	else
		var_4_0[1] = var_0_0.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(self._weaponTemplateID, self, 1)
	end

	if self._backwardWeaponID then
		for iter_4_2, iter_4_3 in ipairs(self._backwardWeaponID) do
			var_4_0[iter_4_2] = var_0_0.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(iter_4_3, self, iter_4_2)
		end
	end

	return var_4_0
end

function ys.Battle.BattleAirFighterUnit.SetWeaponTemplateID(arg_5_0, arg_5_1)
	arg_5_0._weaponTemplateID = arg_5_1

	return
end

function ys.Battle.BattleAirFighterUnit.SetBackwardWeaponID(arg_6_0, arg_6_1)
	arg_6_0._backwardWeaponID = arg_6_1

	return
end

function ys.Battle.BattleAirFighterUnit:SetTemplate(arg_7_1)
	self:SetAttr(arg_7_1)
	var_0_3.super.SetTemplate(self, arg_7_1)

	return
end

function ys.Battle.BattleAirFighterUnit:SetAttr(arg_8_1)
	var_0_0.Battle.BattleAttr.SetAirFighterAttr(self, arg_8_1)
	self:SetIFF(-1)

	return
end

function ys.Battle.BattleAirFighterUnit:UpdateSpeed()
	self._speed:Copy(self._speedDir)
	self._speed:Mul(self._velocity * self:GetSpeedRatio())

	return
end

function ys.Battle.BattleAirFighterUnit:Free()
	self._undefeated = true

	self:LiveCallBack()

	self._aliveState = false

	return
end

function ys.Battle.BattleAirFighterUnit:recycle()
	self:LiveCallBack()

	self._aliveState = false

	return
end

function ys.Battle.BattleAirFighterUnit:onDead()
	self._currentState = self.STATE_DESTORY

	self:DeadCallBack()

	self._aliveState = false

	return
end

function ys.Battle.BattleAirFighterUnit:GetPosition()
	return self._viewPos
end

function ys.Battle.BattleAirFighterUnit:SetFormationIndex(arg_14_1)
	self._formationIndex = arg_14_1
	self._flyStateScale = 12 / (arg_14_1 + 3) + 1

	self:DispatchStrikeStateChange()

	return
end

function ys.Battle.BattleAirFighterUnit:GetFormationIndex()
	return self._formationIndex
end

function ys.Battle.BattleAirFighterUnit.SetFormationOffset(arg_16_0, arg_16_1)
	arg_16_0._formationOffset = Vector3(arg_16_1.x, arg_16_1.y, arg_16_1.z)
	arg_16_0._formationOffsetOppo = Vector3(arg_16_1.x * -1, arg_16_1.y, arg_16_1.z)

	return
end

function ys.Battle.BattleAirFighterUnit.SetDeadCallBack(arg_17_0, arg_17_1)
	arg_17_0._deadCallBack = arg_17_1

	return
end

function ys.Battle.BattleAirFighterUnit:DeadCallBack()
	self._deadCallBack()

	return
end

function ys.Battle.BattleAirFighterUnit.SetLiveCallBack(arg_19_0, arg_19_1)
	arg_19_0._liveCallBack = arg_19_1

	return
end

function ys.Battle.BattleAirFighterUnit:LiveCallBack()
	self._liveCallBack()

	return
end

function ys.Battle.BattleAirFighterUnit:getYShake()
	self._YShakeDir = self._YShakeDir or 1

	local var_21_1 = (self._YShakeCurrent or 0) + (0.04 * math.random() + 0.01) * self._YShakeDir

	if var_21_1 > self._YShakeMax then
		self._YShakeDir = -1

		self:calcYShakeMin()
	elseif var_21_1 < self._YShakeMin then
		self._YShakeDir = 1

		self:calcYShakeMax()
	end

	self._YShakeCurrent = var_21_1

	return var_21_1
end

function ys.Battle.BattleAirFighterUnit.calcYShakeMin(arg_22_0)
	arg_22_0._YShakeMin = -0.5 - math.random()

	return
end

function ys.Battle.BattleAirFighterUnit.calcYShakeMax(arg_23_0)
	arg_23_0._YShakeMax = 0.5 + math.random()

	return
end

function ys.Battle.BattleAirFighterUnit:DispatchStrikeStateChange()
	self:DispatchEvent(var_0_0.Event.New(var_0_2.AIR_STRIKE_STATE_CHANGE, {}))

	return
end

function ys.Battle.BattleAirFighterUnit:GetStrikeState()
	return self._strikeState
end

function ys.Battle.BattleAirFighterUnit:GetSize()
	return self._scale
end

function ys.Battle.BattleAirFighterUnit:changeState(arg_27_1)
	if self._strikeState == arg_27_1 then
		return
	end

	self._strikeState = arg_27_1

	if arg_27_1 == var_0_3.STRIKE_STATE_FLY then
		self:changeToFlyState()

		self.updateStrike = var_0_3._updatePosFly
	elseif arg_27_1 == var_0_3.STRIKE_STATE_BACK then
		self.updateStrike = var_0_3._updatePosBack

		self:changeToBackState()
	elseif arg_27_1 == var_0_3.STRIKE_STATE_DOWN then
		self.updateStrike = var_0_3._updatePosDown

		self:changeToDownState()
	elseif arg_27_1 == var_0_3.STRIKE_STATE_ATTACK then
		self.updateStrike = var_0_3._updatePosAttack

		self:changeToAttackState()
	elseif arg_27_1 == var_0_3.STRIKE_STATE_UP then
		self.updateStrike = var_0_3._updatePosUp

		self:changeToUpState()
	elseif arg_27_1 == var_0_3.STRIKE_STATE_BACKWARD then
		self.updateStrike = var_0_3._updateBackward

		self:changeToBackwardState()
	elseif arg_27_1 == var_0_3.STRIKE_STATE_FREE then
		self.updateStrike = var_0_3._updateFree
	elseif arg_27_1 == var_0_3.STRIKE_STATE_RECYCLE then
		self.updateStrike = var_0_3._updateRecycle
	end

	self:DispatchStrikeStateChange()

	return
end

function ys.Battle.BattleAirFighterUnit:changeToFlyState()
	self._pos = var_0_0.Battle.BattleCameraUtil.GetInstance():GetS2WPoint(var_0_3.AIRFIGHTER_ENTER_POINT)
	self._viewPos = self._pos

	var_0_0.Battle.PlayBattleSFX("battle/plane")

	return
end

function ys.Battle.BattleAirFighterUnit:_updatePosFly()
	self._pos:Add(var_0_3.SPEED_FLY)

	self._viewPos = Vector3(self._formationOffset.x * self._flyStateScale, (self._formationOffset.z / 1.7 + self:getYShake()) * self._flyStateScale, 0):Add(self._pos)

	if self._pos.x > var_0_3.BACK_X then
		self:changeState(var_0_3.STRIKE_STATE_BACK)
	end

	return
end

function ys.Battle.BattleAirFighterUnit:changeToBackState()
	local var_30_1 = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(var_0_1.FRIENDLY_CODE):GetMotion()

	self._pos = Vector3(self._pos.x, 15, var_30_1 and var_30_1:GetPos().z or 45)

	return
end

function ys.Battle.BattleAirFighterUnit:_updatePosBack()
	self._pos:Sub(self._speed)
	self._viewPos:Copy(self._pos)
	self._viewPos:Sub(self._formationOffset)

	if self._pos.x < var_0_3.DOWN_X then
		self:changeState(var_0_3.STRIKE_STATE_DOWN)
	end

	return
end

function ys.Battle.BattleAirFighterUnit:changeToDownState()
	self._ySpeed = 0.5

	self:SetVisitable()

	return
end

function ys.Battle.BattleAirFighterUnit:_updatePosDown()
	self._pos:Sub(self._speed)

	self._pos.y = math.max(var_0_3.HEIGHT, self._pos.y - self._ySpeed)
	self._viewPos = self._pos + self._formationOffsetOppo
	self._ySpeed = math.max(0.02, self._ySpeed - 0.005)

	if self._pos.x < var_0_3.ATTACK_X then
		self:changeState(var_0_3.STRIKE_STATE_ATTACK)
	end

	return
end

function ys.Battle.BattleAirFighterUnit.changeToAttackState(arg_34_0)
	var_0_0.Battle.PlayBattleSFX("battle/air-atk")

	return
end

function ys.Battle.BattleAirFighterUnit:_updatePosAttack()
	self._pos:Sub(self._speed)

	self._pos.y = math.max(var_0_3.HEIGHT, self._pos.y - 0.04)
	self._formationOffsetOppo.y = self:getYShake()
	self._viewPos = self._pos + self._formationOffsetOppo

	self:UpdateWeapon()

	if self._pos.x < var_0_3.UP_X then
		self:changeState(var_0_3.STRIKE_STATE_UP)
	end

	return
end

function ys.Battle.BattleAirFighterUnit.changeToUpState(arg_36_0)
	arg_36_0._ySpeed = 0.1

	return
end

function ys.Battle.BattleAirFighterUnit:_updatePosUp()
	self._pos:Sub(self._speed)

	self._pos.y = self._pos.y + self._ySpeed
	self._ySpeed = math.min(0.7, self._ySpeed + 0.02)
	self._viewPos = self._pos + self._formationOffsetOppo

	if self._pos.x < var_0_3.FREE_X then
		self:changeState(var_0_3.STRIKE_STATE_FREE)
	end

	return
end

function ys.Battle.BattleAirFighterUnit:_updateFree()
	self:Free()

	return
end

function ys.Battle.BattleAirFighterUnit.changeToBackwardState(arg_39_0)
	return
end

function ys.Battle.BattleAirFighterUnit:_updateBackward()
	self._pos:Add(self._speed)

	self._pos.y = math.max(var_0_3.HEIGHT, self._pos.y - 0.04)
	self._viewPos = self._pos + self._formationOffsetOppo

	if self._pos.x > var_0_3.DOWN_X then
		self:changeState(var_0_3.STRIKE_STATE_RECYCLE)
	end

	return
end

function ys.Battle.BattleAirFighterUnit:_updateRecycle()
	self:recycle()

	return
end

return
