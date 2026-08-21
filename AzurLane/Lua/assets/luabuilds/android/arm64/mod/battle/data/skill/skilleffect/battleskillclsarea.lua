ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleConfig
local var_0_3 = class("BattleSkillCLSArea", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillCLSArea = var_0_3
var_0_3.__name = "BattleSkillCLSArea"
var_0_3.TYPE_BULLET = 1
var_0_3.TYPE_AIRCRAFT = 2
var_0_3.TYPE_MINION = 3

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._range = arg_1_0._tempData.arg_list.range
	arg_1_0._width = arg_1_0._tempData.arg_list.width
	arg_1_0._height = arg_1_0._tempData.arg_list.height
	arg_1_0._minRange = arg_1_0._tempData.arg_list.minRange or 0
	arg_1_0._angle = arg_1_0._tempData.arg_list.angle
	arg_1_0._lifeTime = arg_1_0._tempData.arg_list.life_time
	arg_1_0._fx = arg_1_0._tempData.arg_list.effect
	arg_1_0._moveType = arg_1_0._tempData.arg_list.move_type
	arg_1_0._speed = arg_1_0._tempData.arg_list.speed_x
	arg_1_0._finaleFX = arg_1_0._tempData.arg_list.finale_effect
	arg_1_0._delayCLS = arg_1_0._tempData.arg_list.cld_delay
	arg_1_0._bulletType = arg_1_0._tempData.arg_list.bullet_type_list
	arg_1_0._damageSrcUnitTag = arg_1_0._tempData.arg_list.damage_tag_list
	arg_1_0._damageParamA = arg_1_0._tempData.arg_list.damage_param_a
	arg_1_0._damageParamB = arg_1_0._tempData.arg_list.damage_param_b
	arg_1_0._damageSFX = arg_1_0._tempData.arg_list.damage_sfx or ""
	arg_1_0._damageBuffID = arg_1_0._tempData.arg_list.buff_id
	arg_1_0._damageBuffLV = arg_1_0._tempData.arg_list.buff_lv
	arg_1_0._damageDiveFilter = arg_1_0._tempData.arg_list.diveFilter or {
		2
	}
	arg_1_0._damageDiveDMGRate = arg_1_0._tempData.arg_list.diveDamageRate or {
		1,
		1
	}
	arg_1_0._delayCLSTimerList = {}

	return
end

function var_0_3.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doCLS(arg_2_1)

	return
end

function var_0_3.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doCLS(arg_3_1)

	return
end

function var_0_3.doCLS(arg_4_0, arg_4_1)
	if arg_4_0._angle then
		arg_4_0:cacheSectorData(arg_4_1)
	end

	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()

	arg_4_0._cldArea = arg_4_0:generateArea(arg_4_1, var_0_0.AOEField.BULLET, function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
			local var_5_0 = iter_5_1.UID
			local var_5_1 = var_4_0:GetBulletList()[iter_5_1.UID]

			if var_5_1:GetExist() and arg_4_0:checkBulletType(var_5_1) and not var_5_1:ImmuneCLS() and not var_5_1:ImmuneBombCLS() and not arg_4_0:isEnterBlind(var_5_1) and not arg_4_0:isOutOfAngle(var_5_1) then
				if arg_4_0._delayCLS then
					local var_5_2
					local var_5_3 = pg.TimeMgr.GetInstance()

					arg_4_0._delayCLSTimerList[var_5_3:AddBattleTimer("clsBullet", -1, arg_4_0._delayCLS, function()
						if var_5_1:GetExist() then
							var_4_0:RemoveBulletUnit(var_5_0)
						end

						pg.TimeMgr.GetInstance():RemoveBattleTimer(var_5_2)

						arg_4_0._delayCLSTimerList[var_5_2] = nil

						return
					end, true)] = true
				else
					var_4_0:RemoveBulletUnit(iter_5_1.UID)
				end
			end
		end

		return
	end, function()
		for iter_7_0, iter_7_1 in pairs(arg_4_0._delayCLSTimerList) do
			iter_7_0.func()
			pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_7_0)

			arg_4_0._delayCLSTimerList[iter_7_0] = nil
		end

		arg_4_0._delayCLSTimerList = {}

		if arg_4_0._finaleFX then
			var_4_0:SpawnEffect(arg_4_0._finaleFX, arg_4_0._cldArea:GetPosition(), 1)
		end

		return
	end, arg_4_0._fx)

	if arg_4_0._damageSrcUnitTag then
		local var_4_1 = var_0.Battle.BattleTargetChoise.TargetShipTag(arg_4_1, {
			ship_tag_list = arg_4_0._damageSrcUnitTag
		}, (var_0.Battle.BattleTargetChoise.TargetAllHelp(arg_4_1)))

		if #var_4_1 <= 0 then
			return
		end

		local var_4_2 = 0

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			var_4_2 = var_4_2 + iter_4_1:GetAttrByName("formulaLevel")
		end

		local var_4_3 = arg_4_0._damageParamA + math.floor(var_4_2 / #var_4_1) * arg_4_0._damageParamB

		arg_4_0:generateArea(arg_4_1, var_0_0.AOEField.SURFACE, function(arg_8_0)
			for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
				if iter_8_1.Active then
					local var_8_0 = var_4_0:GetUnitList()[iter_8_1.UID]
					local var_8_1 = math.floor(arg_4_0._damageDiveDMGRate[var_8_0:GetCurrentOxyState()] * var_4_3)

					var_4_0:HandleDirectDamage(var_8_0, var_4_3)
					var_0.Battle.PlayBattleSFX(arg_4_0._damageSFX)

					if arg_4_0._damageBuffID and var_8_0:IsAlive() then
						local var_8_2 = var_0.Battle.BattleBuffUnit.New(arg_4_0._damageBuffID, nil, arg_4_1)
						local var_8_4 = arg_4_0._damageBuffLV or 1

						var_8_2:SetOrb(arg_4_1, var_8_4)
						var_8_0:AddBuff(var_8_2)
					end
				end
			end

			return
		end, function()
			return
		end):SetDiveFilter(arg_4_0._damageDiveFilter)
	end

	return
end

function var_0_3.generateArea(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_11_1 = arg_11_1:GetIFF()
	local var_11_2

	if arg_11_0._range then
		var_11_2 = var_11_0:SpawnLastingColumnArea(arg_11_2, var_11_1, arg_11_1:GetPosition(), arg_11_0._range, arg_11_0._lifeTime, arg_11_3, function()
			return
		end, false, arg_11_5, arg_11_4)
	else
		var_11_2 = var_11_0:SpawnLastingCubeArea(arg_11_2, var_11_1, arg_11_1:GetPosition(), arg_11_0._width, arg_11_0._height, arg_11_0._lifeTime, arg_11_3, function()
			return
		end, false, arg_11_5, arg_11_4)

		if var_11_1 == var_0_1.FRIENDLY_CODE then
			var_11_2:SetAnchorPointAlignment(var_11_2.ALIGNMENT_LEFT)
		elseif var_11_1 == var_0_1.FOE_CODE then
			var_11_2:SetAnchorPointAlignment(var_11_2.ALIGNMENT_RIGHT)
		end
	end

	local var_11_3 = var_0.Battle.BattleAOEMobilizedComponent.New(var_11_2)

	var_11_3:SetReferenceUnit(arg_11_1)
	var_11_3:ConfigData(arg_11_0._moveType, {
		speedX = arg_11_0._speed * var_11_1
	})

	return var_11_2
end

function var_0_3.cacheSectorData(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetIFF()

	arg_13_0._upperEdge = math.deg2Rad * (arg_13_0._angle / 2)
	arg_13_0._lowerEdge = -1 * arg_13_0._upperEdge

	if var_13_0 == var_0_1.FRIENDLY_CODE then
		arg_13_0._normalizeOffset = 0
	elseif var_13_0 == var_0_1.FOE_CODE then
		arg_13_0._normalizeOffset = math.pi
	end

	arg_13_0._wholeCircle = math.pi - arg_13_0._normalizeOffset
	arg_13_0._negativeCircle = -math.pi - arg_13_0._normalizeOffset
	arg_13_0._wholeCircleNormalizeOffset = arg_13_0._normalizeOffset - math.pi * 2
	arg_13_0._negativeCircleNormalizeOffset = arg_13_0._normalizeOffset + math.pi * 2

	return
end

function var_0_3.isOutOfAngle(arg_14_0, arg_14_1)
	if not arg_14_0._angle then
		return false
	end

	local var_14_0 = arg_14_1:GetPosition()
	local var_14_1 = arg_14_0._cldArea:GetPosition()
	local var_14_2 = math.atan2(var_14_0.z - var_14_1.z, var_14_0.x - var_14_1.x)

	var_14_2 = var_14_2 > arg_14_0._wholeCircle and var_14_2 + arg_14_0._wholeCircleNormalizeOffset or var_14_2 < arg_14_0._negativeCircle and var_14_2 + arg_14_0._negativeCircleNormalizeOffset or var_14_2 + arg_14_0._normalizeOffset

	if var_14_2 > arg_14_0._lowerEdge and var_14_2 < arg_14_0._upperEdge then
		return false
	else
		return true
	end

	return
end

function var_0_3.isEnterBlind(arg_15_0, arg_15_1)
	local var_15_0, var_15_1

	if arg_15_0._minRange == 0 then
		do return false end

		var_15_0 = Vector3.BattleDistance
		var_15_1 = arg_15_0._cldArea:GetPosition()
	end

	return var_15_0(var_15_1, (arg_15_1:GetPosition())) < arg_15_0._minRange
end

function var_0_3.checkBulletType(arg_16_0, arg_16_1)
	if not arg_16_0._bulletType then
		return true
	elseif table.contains(arg_16_0._bulletType, (arg_16_1:GetType())) then
		return true
	else
		return false
	end

	return
end

return
