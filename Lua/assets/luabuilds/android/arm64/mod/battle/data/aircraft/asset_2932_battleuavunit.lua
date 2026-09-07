ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig

ys.Battle.BattelUAVUnit = class("BattelUAVUnit", ys.Battle.BattleAircraftUnit)
ys.Battle.BattelUAVUnit.__name = "BattelUAVUnit"

local var_0_4 = ys.Battle.BattelUAVUnit

ys.Battle.BattelUAVUnit.MOVE_STATE = "MOVE_STATE"
ys.Battle.BattelUAVUnit.HOVER_STATE = "HOVER_STATE"

function ys.Battle.BattelUAVUnit.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._dir = var_0_0.Battle.BattleConst.UnitDir.LEFT
	arg_1_0._type = var_0_0.Battle.BattleConst.UnitType.UAV_UNIT

	return
end

function ys.Battle.BattelUAVUnit:Update(arg_2_1)
	self:updatePatrol(arg_2_1)

	return
end

function ys.Battle.BattelUAVUnit:SetTemplate(arg_3_1)
	var_0_4.super.SetTemplate(self, arg_3_1)

	self._centerPos = BuildVector3((var_0_0.Battle.BattleDataProxy.GetInstance():GetVanguardBornCoordinate(self:GetIFF()))) + Vector3(arg_3_1.funnel_behavior.offsetX * self:GetIFF(), 0, arg_3_1.funnel_behavior.offsetZ)
	self._range = arg_3_1.funnel_behavior.hover_range

	return
end

function ys.Battle.BattelUAVUnit:changePartolState(arg_4_1)
	if arg_4_1 == var_0_4.MOVE_STATE then
		self:changeToMoveState()
	elseif arg_4_1 == var_0_4.HOVER_STATE then
		self:changeToHoverState()
	end

	self._portalState = arg_4_1

	return
end

function ys.Battle.BattelUAVUnit:AddCreateTimer(arg_5_1, arg_5_2)
	self._currentState = self.STATE_CREATE
	self._speedDir = arg_5_1
	self._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(20)
	arg_5_2 = arg_5_2 or 1.5
	self.updatePatrol = self._updateCreate
	self._createTimer = pg.TimeMgr.GetInstance():AddBattleTimer("AddCreateTimer", 0, arg_5_2, function()
		self._existStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		self._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(self._tmpData.speed)

		self:changePartolState(var_0_4.MOVE_STATE)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._createTimer)

		self._createTimer = nil

		return
	end)

	return
end

function ys.Battle.BattelUAVUnit:_updateCreate()
	self:UpdateSpeed()

	self._pos = self._pos + self._speed

	return
end

function ys.Battle.BattelUAVUnit:changeToMoveState()
	self._cruiseLimit = self._centerPos.x
	self.updatePatrol = self._updateMove

	return
end

function ys.Battle.BattelUAVUnit:_updateMove(arg_9_1)
	self:UpdateSpeed()

	self._pos = self._pos + self._speed

	if self._IFF == var_0_1.FRIENDLY_CODE then
		if self._pos.x > self._cruiseLimit then
			self:changePartolState(var_0_4.HOVER_STATE)
		end
	elseif self._IFF == var_0_1.FOE_CODE and self._pos.x < self._cruiseLimit then
		self:changePartolState(var_0_4.HOVER_STATE)
	end

	return
end

function ys.Battle.BattelUAVUnit:changeToHoverState()
	self._hoverStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	self.updatePatrol = self._updateHover

	return
end

function ys.Battle.BattelUAVUnit:_updateHover(arg_11_1)
	self._pos = Vector3(math.sin(arg_11_1 - self._hoverStartTime) * self._range, 15, math.cos(arg_11_1 - self._hoverStartTime) * self._range):Add(self._centerPos)

	return
end

function ys.Battle.BattelUAVUnit:GetSize()
	if self._portalState == var_0_4.HOVER_STATE then
		local var_12_0 = math.cos(pg.TimeMgr.GetInstance():GetCombatTime() - self._hoverStartTime)

		if var_12_0 > 0 and var_12_0 < 0.2 then
			var_12_0 = 0.2
		elseif var_12_0 <= 0 and var_12_0 > -0.2 then
			var_12_0 = -0.2
		end

		return var_12_0
	else
		var_0_4.super.GetSize(self)
	end

	return
end

return
