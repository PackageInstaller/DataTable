ys = ys or {}

local var_0_0 = ys
local var_0_1 = pg.effect_offset

ys.Battle.BattleBuffShieldWall = class("BattleBuffShieldWall", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShieldWall.__name = "BattleBuffShieldWall"

local var_0_2 = ys.Battle.BattleBuffShieldWall

function ys.Battle.BattleBuffShieldWall.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShieldWall:SetArgs(arg_2_1, arg_2_2)
	local var_2_0 = self._tempData.arg_list

	self._buffID = arg_2_2:GetID()
	self._dir = arg_2_1:GetDirection()
	self._count = var_2_0.count
	self._bulletType = var_2_0.bulletType or var_0_0.Battle.BattleConst.BulletType.CANNON
	self._doWhenHit = var_2_0.do_when_hit
	self._unit = arg_2_1
	self._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	self._centerPos = arg_2_1:GetPosition()
	self._startTime = pg.TimeMgr.GetInstance():GetCombatTime()

	local function var_2_1(arg_3_0)
		return self:onWallCld(arg_3_0)
	end

	local var_2_2 = arg_2_1:GetTemplate().scale / 50
	local var_2_3 = var_2_0.cld_list[1].box
	local var_2_4 = Clone(var_2_0.cld_list[1].offset)

	var_2_4[1] = arg_2_1:GetDirection() == var_0_0.Battle.BattleConst.UnitDir.LEFT and -var_2_4[1] * var_2_2 or var_2_4[1] * var_2_2
	self._wall = self._dataProxy:SpawnWall(self, var_2_1, var_2_3, var_2_4)

	local var_2_5

	if var_0_1[var_2_0.effect] then
		local var_2_6 = arg_2_1:GetTemplate().fx_container[var_0_1[var_2_0.effect].container_index]
		local var_2_7 = Vector3(var_2_6[1], var_2_6[2], var_2_6[3])

		var_2_7:Add((Vector3(var_0_1[var_2_0.effect].offset[1], var_0_1[var_2_0.effect].offset[2], var_0_1[var_2_0.effect].offset[3])))

		var_2_5 = var_2_7
	end

	self._centerPosFun = var_2_5 and function(arg_4_0)
		local var_4_0 = var_2_0.centerPosFun(arg_4_0):Add(var_2_5)

		var_4_0.x = (nil).x * self._dir

		return var_4_0
	end or var_2_0.centerPosFun
	self._currentTimeCount = 0

	if var_2_0.effect then
		self._effectIndex = "BattleBuffShieldWall" .. self._buffID .. self._tempData.id

		local var_2_8 = var_2_5 and function(arg_5_0)
			return (var_2_0.centerPosFun(arg_5_0):Add(var_2_5))
		end or var_2_0.centerPosFun

		self._unit = arg_2_1
		self._evtData = {
			effect = var_2_0.effect,
			posFun = var_2_8,
			index = self._effectIndex,
			rotationFun = var_2_0.rotationFun
		}

		arg_2_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, self._evtData))
	end

	return
end

function ys.Battle.BattleBuffShieldWall:onStack(arg_6_1, arg_6_2)
	self._count = self._tempData.arg_list.count

	self._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, self._evtData))

	return
end

function ys.Battle.BattleBuffShieldWall:onUpdate(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1:GetPosition()

	if self._centerPosFun then
		self._currentTimeCount = arg_7_3.timeStamp - self._startTime
		var_7_0 = self._centerPosFun(self._currentTimeCount):Mul(arg_7_1:GetTemplate().scale * 0.02):Add(var_7_0)
	end

	self._centerPos = var_7_0

	return
end

function ys.Battle.BattleBuffShieldWall:onWallCld(arg_8_1)
	if not arg_8_1:GetIgnoreShield() and arg_8_1:GetType() == self._bulletType and self._count > 0 then
		if self._doWhenHit == "intercept" then
			arg_8_1:Intercepted()
			self._dataProxy:RemoveBulletUnit(arg_8_1:GetUniqueID())

			self._count = self._count - 1
		elseif self._doWhenHit == "reflect" and self:GetIFF() ~= arg_8_1:GetIFF() then
			arg_8_1:Reflected()

			self._count = self._count - 1
		end

		if self._count <= 0 then
			self:Deactive()
		end
	end

	return self._count > 0
end

function ys.Battle.BattleBuffShieldWall:GetIFF()
	return self._unit:GetIFF()
end

function ys.Battle.BattleBuffShieldWall:GetPosition()
	return self._centerPos
end

function ys.Battle.BattleBuffShieldWall:IsWallActive()
	return self._count > 0
end

function ys.Battle.BattleBuffShieldWall:Deactive()
	if self._effectIndex then
		self._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.DEACTIVE_EFFECT, {
			index = self._effectIndex
		}))
	end

	if self._unit:IsAlive() then
		self._unit:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_SHIELD_BROKEN, {
			shieldBuffID = self._buffID
		})
	end

	return
end

function ys.Battle.BattleBuffShieldWall:Clear()
	if self._effectIndex then
		self._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
			index = self._effectIndex
		}))
	end

	self._dataProxy:RemoveWall(self._wall:GetUniqueID())

	return
end

return
