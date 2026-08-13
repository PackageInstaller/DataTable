ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleEvent

class = var_0_10004

local var_0_4 = var_0_10004("BattleSkillCLSArea", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillCLSArea = var_0_4
var_0_4.__name = "BattleSkillCLSArea"
var_0_4.TYPE_BULLET = 1
var_0_4.TYPE_AIRCRAFT = 2
var_0_4.TYPE_MINION = 3

function var_0_4.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_4.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10005

	var_1_0(var_1_1, var_1_2, var_1_10005)

	arg_1_0._range = arg_1_0._tempData.arg_list.range
	arg_1_0._width = arg_1_0._tempData.arg_list.width
	arg_1_0._height = arg_1_0._tempData.arg_list.height

	local var_1_3

	if not arg_1_0._tempData.arg_list.minRange then
		var_1_3 = 0
	end

	arg_1_0._minRange = var_1_3
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

	local var_1_4

	if not arg_1_0._tempData.arg_list.damage_sfx then
		var_1_4 = ""
	end

	arg_1_0._damageSFX = var_1_4
	arg_1_0._damageBuffID = arg_1_0._tempData.arg_list.buff_id
	arg_1_0._damageBuffLV = arg_1_0._tempData.arg_list.buff_lv

	local var_1_5

	if not arg_1_0._tempData.arg_list.diveFilter then
		var_1_5 = {
			2
		}
	end

	arg_1_0._damageDiveFilter = var_1_5

	local var_1_6

	if not arg_1_0._tempData.arg_list.diveDamageRate then
		var_1_6 = {
			1,
			1
		}
	end

	arg_1_0._damageDiveDMGRate = var_1_6
	arg_1_0._delayCLSTimerList = {}

	return
end

function var_0_4.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doCLS(arg_2_1)

	return
end

function var_0_4.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doCLS(arg_3_1)

	return
end

function var_0_4.doCLS(arg_4_0, arg_4_1)
	if arg_4_0._angle then
		arg_4_0:cacheSectorData(arg_4_1)
	end

	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()

	local function var_4_1(arg_5_0)
		ipairs = var_2_10001

		for iter_5_0, iter_5_1 in var_2_10001(arg_5_0) do
			local var_5_0 = iter_5_1.UID
			local var_5_1 = var_4_0
			local var_5_2 = var_7.GetBulletList(var_5_1)[iter_5_1.UID]

			if var_7.GetExist(var_5_2) then
				local var_5_3 = arg_4_0

				if var_8.checkBulletType(var_5_3, var_7) and not var_7:ImmuneCLS() and not var_7:ImmuneBombCLS() then
					local var_5_4 = arg_4_0

					if not var_8.isEnterBlind(var_5_4, var_7) then
						local var_5_5 = arg_4_0

						if not var_8.isOutOfAngle(var_5_5, var_7) then
							if arg_4_0._delayCLS then
								local var_5_6

								local function var_5_7()
									local var_6_0 = var_0

									if var_0.GetExist(var_6_0) then
										local var_6_1 = var_4_0

										var_0.RemoveBulletUnit(var_6_1, var_5_0)
									end

									pg = var_0

									local var_6_2 = var_0.TimeMgr.GetInstance()

									var_0.RemoveBattleTimer(var_6_2, var_5_6)

									arg_4_0._delayCLSTimerList[var_5_6] = nil

									return
								end

								pg = var_10

								local var_5_8 = var_10.TimeMgr.GetInstance()

								var_5_6 = var_10.AddBattleTimer(var_5_8, "clsBullet", -1, arg_4_0._delayCLS, var_5_7, true)
								arg_4_0._delayCLSTimerList[var_5_6] = true
							else
								local var_5_9 = var_4_0

								var_8.RemoveBulletUnit(var_5_9, var_5_0)
							end
						end
					end
				end
			end
		end

		return
	end

	local function var_4_2()
		pairs = var_2_10000

		for iter_7_0, iter_7_1 in var_2_10000(arg_4_0._delayCLSTimerList) do
			iter_7_0.func()

			pg = var_5

			local var_7_0 = var_5.TimeMgr.GetInstance()

			var_5.RemoveBattleTimer(var_7_0, iter_7_0)

			arg_4_0._delayCLSTimerList[iter_7_0] = nil
		end

		arg_4_0._delayCLSTimerList = {}

		if arg_4_0._finaleFX then
			local var_7_1 = var_4_0
			local var_7_2 = var_0.SpawnEffect
			local var_7_3 = arg_4_0._finaleFX
			local var_7_4 = arg_4_0._cldArea

			var_7_2(var_7_1, var_7_3, var_3.GetPosition(var_7_4), 1)
		end

		return
	end

	arg_4_0._cldArea = arg_4_0:generateArea(arg_4_1, var_0_1.AOEField.BULLET, var_4_1, var_4_2, arg_4_0._fx)

	if arg_4_0._damageSrcUnitTag then
		local var_4_3 = var_0.Battle.BattleTargetChoise.TargetAllHelp(arg_4_1)

		if #var_0.Battle.BattleTargetChoise.TargetShipTag(arg_4_1, {
			ship_tag_list = arg_4_0._damageSrcUnitTag
		}, var_4_3) <= 0 then
			return
		end

		local var_4_4 = 0

		ipairs = var_8

		for iter_4_0, iter_4_1 in var_8(var_5) do
			var_4_4 = var_4_4 + iter_4_1:GetAttrByName("formulaLevel")
		end

		math = var_8

		local var_4_5 = var_8.floor(var_4_4 / var_6)
		local var_4_6 = arg_4_0._damageParamA + var_4_5 * arg_4_0._damageParamB

		local function var_4_7(arg_8_0)
			ipairs = var_2_10001

			for iter_8_0, iter_8_1 in var_2_10001(arg_8_0) do
				if iter_8_1.Active then
					local var_8_0 = iter_8_1.UID
					local var_8_1 = var_4_0
					local var_8_2 = var_7.GetUnitList(var_8_1)[var_8_0]
					local var_8_3 = var_7.GetCurrentOxyState(var_8_2)

					math = var_8_2

					local var_8_4 = var_8_2.floor(arg_4_0._damageDiveDMGRate[var_8_3] * var_4_6)
					local var_8_5 = var_4_0

					var_10.HandleDirectDamage(var_8_5, var_7, var_4_6)
					var_0.Battle.PlayBattleSFX(arg_4_0._damageSFX)

					if arg_4_0._damageBuffID and var_7:IsAlive() then
						local var_8_6 = var_0.Battle.BattleBuffUnit.New(arg_4_0._damageBuffID, nil, arg_4_1)
						local var_8_7 = var_10.SetOrb
						local var_8_8 = arg_4_1
						local var_8_9

						if not arg_4_0._damageBuffLV then
							var_8_9 = 1
						end

						var_8_7(var_8_6, var_8_8, var_8_9)
						var_7:AddBuff(var_10)
					end
				end
			end

			return
		end

		local function var_4_8()
			return
		end

		local function var_4_9()
			return
		end

		local var_4_10 = arg_4_0:generateArea(arg_4_1, var_0_1.AOEField.SURFACE, var_4_7, var_4_8)

		var_12.SetDiveFilter(var_4_10, arg_4_0._damageDiveFilter)
	end

	return
end

function var_0_4.generateArea(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local function var_11_0()
		return
	end

	local var_11_1 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_11_2 = arg_11_1:GetIFF()
	local var_11_3

	if arg_11_0._range then
		var_11_3 = var_11_1:SpawnLastingColumnArea(arg_11_2, var_11_2, arg_11_1:GetPosition(), arg_11_0._range, arg_11_0._lifeTime, arg_11_3, var_11_0, false, arg_11_5, arg_11_4)
	else
		var_11_3 = var_11_1:SpawnLastingCubeArea(arg_11_2, var_11_2, arg_11_1:GetPosition(), arg_11_0._width, arg_11_0._height, arg_11_0._lifeTime, arg_11_3, var_11_0, false, arg_11_5, arg_11_4)

		if var_11_2 == var_0_2.FRIENDLY_CODE then
			var_11_3:SetAnchorPointAlignment(var_11_3.ALIGNMENT_LEFT)
		elseif var_11_2 == var_0_2.FOE_CODE then
			var_11_3:SetAnchorPointAlignment(var_11_3.ALIGNMENT_RIGHT)
		end
	end

	local var_11_4 = var_0.Battle.BattleAOEMobilizedComponent.New(var_11_3)

	var_10.SetReferenceUnit(var_11_4, arg_11_1)

	local var_11_5 = arg_11_0._speed * var_11_2

	var_10:ConfigData(arg_11_0._moveType, {
		speedX = var_11_5
	})

	return var_11_3
end

function var_0_4.cacheSectorData(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetIFF()
	local var_13_1 = arg_13_0._angle / 2

	math = var_1_10004
	arg_13_0._upperEdge = var_1_10004.deg2Rad * var_13_1
	arg_13_0._lowerEdge = -1 * arg_13_0._upperEdge

	if var_13_0 == var_0_2.FRIENDLY_CODE then
		arg_13_0._normalizeOffset = 0
	elseif var_13_0 == var_0_2.FOE_CODE then
		math = var_4
		arg_13_0._normalizeOffset = var_4.pi
	end

	math = var_4
	arg_13_0._wholeCircle = var_4.pi - arg_13_0._normalizeOffset
	math = var_4
	arg_13_0._negativeCircle = -var_4.pi - arg_13_0._normalizeOffset

	local var_13_2 = arg_13_0._normalizeOffset

	math = var_5
	arg_13_0._wholeCircleNormalizeOffset = var_13_2 - var_5.pi * 2

	local var_13_3 = arg_13_0._normalizeOffset

	math = var_5
	arg_13_0._negativeCircleNormalizeOffset = var_13_3 + var_5.pi * 2

	return
end

function var_0_4.isOutOfAngle(arg_14_0, arg_14_1)
	if not arg_14_0._angle then
		return false
	end

	local var_14_0 = arg_14_1:GetPosition()
	local var_14_1 = arg_14_0._cldArea
	local var_14_2 = var_3.GetPosition(var_14_1)

	math = var_14_1

	local var_14_3

	if var_14_1.atan2(var_14_0.z - var_14_2.z, var_14_0.x - var_14_2.x) > arg_14_0._wholeCircle then
		var_14_3 = var_14_3 + arg_14_0._wholeCircleNormalizeOffset
	elseif var_14_3 < arg_14_0._negativeCircle then
		var_14_3 = var_14_3 + arg_14_0._negativeCircleNormalizeOffset
	else
		var_14_3 = var_14_3 + arg_14_0._normalizeOffset
	end

	if var_14_3 > arg_14_0._lowerEdge and var_14_3 < arg_14_0._upperEdge then
		return false
	else
		return true
	end

	return
end

function var_0_4.isEnterBlind(arg_15_0, arg_15_1)
	if arg_15_0._minRange == 0 then
		return false
	end

	local var_15_0 = arg_15_1:GetPosition()
	local var_15_1 = arg_15_0._cldArea
	local var_15_2 = var_3.GetPosition(var_15_1)

	Vector3 = var_15_1

	return var_15_1.BattleDistance(var_15_2, var_15_0) < arg_15_0._minRange
end

function var_0_4.checkBulletType(arg_16_0, arg_16_1)
	if not arg_16_0._bulletType then
		return true
	else
		local var_16_0 = arg_16_1
		local var_16_1 = arg_16_1.GetType(var_16_0)

		table = var_16_0

		if var_16_0.contains(arg_16_0._bulletType, var_16_1) then
			return true
		else
			return false
		end
	end

	return
end

return
