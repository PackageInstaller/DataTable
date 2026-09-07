ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleConfig
local BattleSkillCLSArea = class("BattleSkillCLSArea", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillCLSArea = BattleSkillCLSArea
BattleSkillCLSArea.__name = "BattleSkillCLSArea"
BattleSkillCLSArea.TYPE_BULLET = 1
BattleSkillCLSArea.TYPE_AIRCRAFT = 2
BattleSkillCLSArea.TYPE_MINION = 3

function BattleSkillCLSArea:Ctor(arg_1_1)
	BattleSkillCLSArea.super.Ctor(self, arg_1_1, lv)

	self._range = self._tempData.arg_list.range
	self._width = self._tempData.arg_list.width
	self._height = self._tempData.arg_list.height
	self._minRange = self._tempData.arg_list.minRange or 0
	self._angle = self._tempData.arg_list.angle
	self._lifeTime = self._tempData.arg_list.life_time
	self._fx = self._tempData.arg_list.effect
	self._moveType = self._tempData.arg_list.move_type
	self._speed = self._tempData.arg_list.speed_x
	self._finaleFX = self._tempData.arg_list.finale_effect
	self._delayCLS = self._tempData.arg_list.cld_delay
	self._bulletType = self._tempData.arg_list.bullet_type_list
	self._damageSrcUnitTag = self._tempData.arg_list.damage_tag_list
	self._damageParamA = self._tempData.arg_list.damage_param_a
	self._damageParamB = self._tempData.arg_list.damage_param_b
	self._damageSFX = self._tempData.arg_list.damage_sfx or ""
	self._damageBuffID = self._tempData.arg_list.buff_id
	self._damageBuffLV = self._tempData.arg_list.buff_lv
	self._damageDiveFilter = self._tempData.arg_list.diveFilter or {
		2
	}
	self._damageDiveDMGRate = self._tempData.arg_list.diveDamageRate or {
		1,
		1
	}
	self._delayCLSTimerList = {}

	return
end

function BattleSkillCLSArea:DoDataEffect(arg_2_1)
	self:doCLS(arg_2_1)

	return
end

function BattleSkillCLSArea:DoDataEffectWithoutTarget(arg_3_1)
	self:doCLS(arg_3_1)

	return
end

function BattleSkillCLSArea:doCLS(arg_4_1)
	if self._angle then
		self:cacheSectorData(arg_4_1)
	end

	local var_4_0 = var_0_0.Battle.BattleDataProxy.GetInstance()

	self._cldArea = self:generateArea(arg_4_1, var_0_1.AOEField.BULLET, function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
			local var_5_0 = iter_5_1.UID
			local var_5_1 = var_4_0:GetBulletList()[iter_5_1.UID]

			if var_5_1:GetExist() and self:checkBulletType(var_5_1) and not var_5_1:ImmuneCLS() and not var_5_1:ImmuneBombCLS() and not self:isEnterBlind(var_5_1) and not self:isOutOfAngle(var_5_1) then
				if self._delayCLS then
					local var_5_2

					var_5_2 = pg.TimeMgr.GetInstance():AddBattleTimer("clsBullet", -1, self._delayCLS, function()
						if var_5_1:GetExist() then
							var_4_0:RemoveBulletUnit(var_5_0)
						end

						pg.TimeMgr.GetInstance():RemoveBattleTimer(var_5_2)

						self._delayCLSTimerList[var_5_2] = nil

						return
					end, true)
					self._delayCLSTimerList[nil] = true
				else
					var_4_0:RemoveBulletUnit(iter_5_1.UID)
				end
			end
		end

		return
	end, function()
		for iter_7_0, iter_7_1 in pairs(self._delayCLSTimerList) do
			iter_7_0.func()
			pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_7_0)

			self._delayCLSTimerList[iter_7_0] = nil
		end

		self._delayCLSTimerList = {}

		if self._finaleFX then
			var_4_0:SpawnEffect(self._finaleFX, self._cldArea:GetPosition(), 1)
		end

		return
	end, self._fx)

	if self._damageSrcUnitTag then
		local var_4_1 = var_0_0.Battle.BattleTargetChoise.TargetShipTag(arg_4_1, {
			ship_tag_list = self._damageSrcUnitTag
		}, (var_0_0.Battle.BattleTargetChoise.TargetAllHelp(arg_4_1)))

		if #var_4_1 <= 0 then
			return
		end

		local var_4_2 = 0

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			var_4_2 = var_4_2 + iter_4_1:GetAttrByName("formulaLevel")
		end

		local var_4_3 = self._damageParamA + math.floor(var_4_2 / #var_4_1) * self._damageParamB

		self:generateArea(arg_4_1, var_0_1.AOEField.SURFACE, function(arg_8_0)
			for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
				if iter_8_1.Active then
					local var_8_0 = var_4_0:GetUnitList()[iter_8_1.UID]
					local var_8_1 = math.floor(self._damageDiveDMGRate[var_8_0:GetCurrentOxyState()] * var_4_3)

					var_4_0:HandleDirectDamage(var_8_0, var_4_3)
					var_0_0.Battle.PlayBattleSFX(self._damageSFX)

					if self._damageBuffID and var_8_0:IsAlive() then
						local var_8_2 = var_0_0.Battle.BattleBuffUnit.New(self._damageBuffID, nil, arg_4_1)

						var_8_2:SetOrb(arg_4_1, self._damageBuffLV or 1)
						var_8_0:AddBuff(var_8_2)
					end
				end
			end

			return
		end, function()
			return
		end):SetDiveFilter(self._damageDiveFilter)
	end

	return
end

function BattleSkillCLSArea:generateArea(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local function var_11_0()
		return
	end

	local var_11_1 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_11_2 = arg_11_1:GetIFF()
	local var_11_3

	if self._range then
		var_11_3 = var_11_1:SpawnLastingColumnArea(arg_11_2, var_11_2, arg_11_1:GetPosition(), self._range, self._lifeTime, arg_11_3, var_11_0, false, arg_11_5, arg_11_4)
	else
		var_11_3 = var_11_1:SpawnLastingCubeArea(arg_11_2, var_11_2, arg_11_1:GetPosition(), self._width, self._height, self._lifeTime, arg_11_3, var_11_0, false, arg_11_5, arg_11_4)

		if var_11_2 == var_0_2.FRIENDLY_CODE then
			var_11_3:SetAnchorPointAlignment(var_11_3.ALIGNMENT_LEFT)
		elseif var_11_2 == var_0_2.FOE_CODE then
			var_11_3:SetAnchorPointAlignment(var_11_3.ALIGNMENT_RIGHT)
		end
	end

	local var_11_4 = var_0_0.Battle.BattleAOEMobilizedComponent.New(var_11_3)

	var_11_4:SetReferenceUnit(arg_11_1)
	var_11_4:ConfigData(self._moveType, {
		speedX = self._speed * var_11_2
	})

	return var_11_3
end

function BattleSkillCLSArea:cacheSectorData(arg_13_1)
	local var_13_0 = arg_13_1:GetIFF()

	self._upperEdge = math.deg2Rad * (self._angle / 2)
	self._lowerEdge = -1 * self._upperEdge

	if var_13_0 == var_0_2.FRIENDLY_CODE then
		self._normalizeOffset = 0
	elseif var_13_0 == var_0_2.FOE_CODE then
		self._normalizeOffset = math.pi
	end

	self._wholeCircle = math.pi - self._normalizeOffset
	self._negativeCircle = -math.pi - self._normalizeOffset
	self._wholeCircleNormalizeOffset = self._normalizeOffset - math.pi * 2
	self._negativeCircleNormalizeOffset = self._normalizeOffset + math.pi * 2

	return
end

function BattleSkillCLSArea:isOutOfAngle(arg_14_1)
	if not self._angle then
		return false
	end

	local var_14_0 = arg_14_1:GetPosition()
	local var_14_1 = self._cldArea:GetPosition()
	local var_14_2 = math.atan2(var_14_0.z - var_14_1.z, var_14_0.x - var_14_1.x)

	var_14_2 = var_14_2 > self._wholeCircle and var_14_2 + self._wholeCircleNormalizeOffset or var_14_2 < self._negativeCircle and var_14_2 + self._negativeCircleNormalizeOffset or var_14_2 + self._normalizeOffset

	if var_14_2 > self._lowerEdge and var_14_2 < self._upperEdge then
		return false
	else
		return true
	end

	return
end

function BattleSkillCLSArea:isEnterBlind(arg_15_1)
	local var_15_0

	if self._minRange == 0 then
		do return false end

		var_15_0 = self._cldArea:GetPosition()
	end

	return Vector3.BattleDistance(var_15_0, (arg_15_1:GetPosition())) < self._minRange
end

function BattleSkillCLSArea:checkBulletType(arg_16_1)
	if not self._bulletType then
		return true
	elseif table.contains(self._bulletType, (arg_16_1:GetType())) then
		return true
	else
		return false
	end

	return
end

return
