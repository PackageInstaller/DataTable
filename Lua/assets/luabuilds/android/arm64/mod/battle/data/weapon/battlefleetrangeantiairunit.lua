ys = ys or {}

local var_0_1 = ys.Battle.BattleFormulas
local var_0_2 = ys.Battle.BattleConfig
local var_0_3 = ys.Battle.BattleDataFunction
local var_0_6 = ys.Battle.BattleConst.WeaponSearchType
local var_0_7 = ys.Battle.BattleConst.WeaponSuppressType
local var_0_8 = class("BattleFleetRangeAntiAirUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleFleetRangeAntiAirUnit = var_0_8
var_0_8.__name = "BattleFleetRangeAntiAirUnit"

function var_0_8.Ctor(arg_1_0)
	var_0_8.super.Ctor(arg_1_0)

	arg_1_0._currentState = var_0_8.STATE_DISABLE

	arg_1_0:init()

	return
end

function var_0_8.init(arg_2_0)
	arg_2_0._crewUnitList = {}
	arg_2_0._hitFXResIDList = {}
	arg_2_0._range = 0
	arg_2_0._majorEmitterList = {}
	arg_2_0._GCD = 0.5
	arg_2_0._tmpData = {}
	arg_2_0._tmpData.bullet_ID = {
		var_0_2.AntiAirConfig.RangeBulletID
	}
	arg_2_0._tmpData.barrage_ID = {
		var_0_2.AntiAirConfig.RangeBarrageID
	}
	arg_2_0._tmpData.aim_type = var_0.WeaponAimType.AIM
	arg_2_0._tmpData.axis_angle = 0
	arg_2_0._tmpData.search_type = var_0_6.SECTOR
	arg_2_0._tmpData.suppress = var_0_7.NONE
	arg_2_0._tmpData.queue = 0
	arg_2_0._tmpData.action_index = ""
	arg_2_0._tmpData.fire_sfx = "battle/cannon-air"
	arg_2_0._tmpData.spawn_bound = var_0_2.AntiAirConfig.RangeAntiAirBone
	arg_2_0._tmpData.shakescreen = 0
	arg_2_0._tmpData.fire_fx_loop_type = 0
	arg_2_0._tmpData.attack_attribute = var_0.WeaponDamageAttr.AIR
	arg_2_0._tmpData.attack_attribute_ratio = 100
	arg_2_0._tmpData.expose = 0
	arg_2_0._fireFXFlag = arg_2_0._tmpData.fire_fx_loop_type
	arg_2_0._preCastInfo = {}
	arg_2_0._convertedBulletVelocity = var_0_1.ConvertBulletSpeed(var_0_3.GetBulletTmpDataFromID(arg_2_0._tmpData.bullet_ID[1]).velocity)
	arg_2_0._bulletList = arg_2_0._tmpData.bullet_ID

	arg_2_0:ShiftBarrage(arg_2_0._tmpData.barrage_ID)

	return
end

function var_0_8.AppendCrewUnit(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetFleetRangeAntiAirList()

	if #var_3_0 > 0 then
		arg_3_0._currentState = var_0_8.STATE_READY
		arg_3_0._crewUnitList[arg_3_1] = var_3_0

		arg_3_0:flush()
	end

	return
end

function var_0_8.RemoveCrewUnit(arg_4_0, arg_4_1)
	if arg_4_0._crewUnitList[arg_4_1] then
		if arg_4_1 == arg_4_0._host then
			arg_4_0._host:DetachFleetRangeAAWeapon()
		end

		arg_4_0._crewUnitList[arg_4_1] = nil

		arg_4_0:flush()
	end

	return
end

function var_0_8.FlushCrewUnit(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetFleetRangeAntiAirList()

	if #var_5_0 <= 0 then
		arg_5_0:RemoveCrewUnit(arg_5_1)
	elseif arg_5_0._crewUnitList[arg_5_1] == nil then
		arg_5_0:AppendCrewUnit(arg_5_1)
	else
		arg_5_0._crewUnitList[arg_5_1] = var_5_0

		arg_5_0:flush()
	end

	return
end

function var_0_8.Spawn(arg_6_0, arg_6_1, arg_6_2)
	local var_6_1 = arg_6_0._dataProxy:CreateBulletUnit(arg_6_1, arg_6_0._host, arg_6_0, (arg_6_0:getAimPoint(arg_6_2)))

	arg_6_0:setBulletSkin(var_6_1, arg_6_1)
	arg_6_0:TriggerBuffWhenSpawn(var_6_1)

	return var_6_1
end

function var_0_8.getAimPoint(arg_7_0, arg_7_1)
	local var_7_0

	if target then
		local var_7_1 = arg_7_1:GetPosition()

		var_7_0 = Vector3(var_7_1.x + arg_7_0._aimOffset, 0, var_7_1.z)
	else
		local var_7_2 = arg_7_0:GetHost():GetPosition()

		var_7_0 = Vector3(var_7_2.x + arg_7_0._maxRangeSqr * arg_7_0._hostIFF + arg_7_0._aimOffset, 0, var_7_2.z)
	end

	return var_7_0
end

function var_0_8.GetCrewUnitList(arg_8_0)
	return arg_8_0._crewUnitList
end

function var_0_8.GetRange(arg_9_0)
	return arg_9_0._range
end

function var_0_8.GetAttackAngle(arg_10_0)
	return arg_10_0._aimAngle
end

function var_0_8.GetReloadTime(arg_11_0)
	return arg_11_0._interval
end

function var_0_8.flush(arg_12_0)
	arg_12_0._range = 0
	arg_12_0._interval = 0
	arg_12_0._aimAngle = 0
	arg_12_0._aimOffset = 0
	arg_12_0._maxRangeSqr = 0
	arg_12_0._minRangeSqr = 0
	arg_12_0._hitFXResIDList = {}
	arg_12_0._SFXID = nil
	arg_12_0._exploRange = 0

	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0._crewUnitList) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			var_12_0 = var_12_0 + 1
			arg_12_0._interval = arg_12_0._interval + iter_12_3:GetReloadTime()

			local var_12_1 = iter_12_3:GetTemplateData()

			arg_12_0._range = arg_12_0._range + var_12_1.range
			arg_12_0._SFXID = var_12_1.fire_sfx
			arg_12_0._aimAngle = arg_12_0._aimAngle + iter_12_3:GetAttackAngle()
			arg_12_0._maxRangeSqr = arg_12_0._maxRangeSqr + iter_12_3:GetWeaponMaxRange()
			arg_12_0._minRangeSqr = arg_12_0._minRangeSqr + iter_12_3:GetWeaponMinRange()

			local var_12_2 = var_0_3.GetBulletTmpDataFromID(iter_12_3:GetTemplateData().bullet_ID[1])

			arg_12_0._hitFXResIDList[iter_12_3] = var_12_2.hit_fx
			arg_12_0._exploRange = arg_12_0._exploRange + var_12_2.hit_type.range

			local var_12_3 = var_12_2.extra_param.aim_offset or 0

			arg_12_0._aimOffset = arg_12_0._aimOffset + var_12_3
		end

		;({})[#{} + 1] = {
			weight = var_0_1.AntiAirPowerWeight((iter_12_0:GetAttrByName("antiAirPower"))),
			rst = iter_12_0
		}
	end

	if var_12_0 == 0 then
		arg_12_0._currentState = var_0_8.STATE_DISABLE
	else
		arg_12_0:SwitchHost()

		arg_12_0._maxRangeSqr = arg_12_0._maxRangeSqr / var_12_0
		arg_12_0._minRangeSqr = arg_12_0._minRangeSqr / var_12_0
		arg_12_0._exploRange = arg_12_0._exploRange / var_12_0
		arg_12_0._aimAngle = arg_12_0._aimAngle / var_12_0
		arg_12_0._aimOffset = arg_12_0._aimOffset / var_12_0 * arg_12_0._host:GetIFF()
		arg_12_0._interval = arg_12_0._interval / var_12_0 + 0.5
		arg_12_0._weightList, arg_12_0._totalWeight = var_0_1.GenerateWeightList({})
	end

	return
end

function var_0_8.DoAreaSplit(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._crewUnitList) do
		iter_13_0:TriggerBuff(var_0.BuffEffectType.ON_ANTIAIR_FIRE_FAR, {})
		iter_13_0:PlayFX(iter_13_1[1]:GetTemplateData().fire_fx, true)
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0._hitFXResIDList) do
		local var_13_0 = var_0.Battle.BattleFXPool.GetInstance()

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_13_0:GetFX(iter_13_3), arg_13_1:GetPosition() + Vector3((math.random() * 2 - 1) * arg_13_0._exploRange, 10, (math.random() * 2 - 1) * arg_13_0._exploRange), true)
	end

	arg_13_0._dataProxy:SpawnColumnArea(var_0.BulletField.AIR, arg_13_1:GetIFF(), arg_13_1:GetPosition(), arg_13_0._exploRange, -1, function(arg_14_0)
		local var_14_0 = arg_13_0._dataProxy:GetAircraftList()

		for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
			if iter_14_1.Active then
				if var_14_0[iter_14_1.UID] and var_14_0[iter_14_1.UID]:IsVisitable() then
					({})[#{} + 1] = var_14_0[iter_14_1.UID]
				end
			end
		end

		local var_14_1 = var_0_1.CalculateFleetAntiAirTotalDamage(arg_13_0)
		local var_14_2 = var_0_1.GetMeteoDamageRatio(#{})

		for iter_14_2, iter_14_3 in ipairs({}) do
			arg_13_0._dataProxy:HandleDirectDamage(iter_14_3, math.max(1, math.floor(var_14_1 * var_14_2[iter_14_2])), (var_0_1.WeightListRandom(arg_13_0._weightList, arg_13_0._totalWeight)))
		end

		return
	end)

	if RANGE_ANTI_AREA then
		local var_13_1 = var_0.Battle.BattleFXPool.GetInstance():GetFX("AlertArea")

		var_13_1.transform.localScale = Vector3(arg_13_0._exploRange, 1, arg_13_0._exploRange)

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_13_1, arg_13_1:GetPosition())
	end

	arg_13_0._dataProxy:RemoveBulletUnit(arg_13_1:GetUniqueID())

	return
end

function var_0_8.SwitchHost(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._crewUnitList) do
		table.insert({}, iter_15_0)
	end

	table.sort({}, function(arg_16_0, arg_16_1)
		return arg_16_0:GetMainUnitIndex() < arg_16_1:GetMainUnitIndex()
	end)

	if arg_15_0._host == ({})[1] then
		return
	end

	arg_15_0:SetHostData(({})[1])
	arg_15_0._host:AttachFleetRangeAAWeapon(arg_15_0)

	return
end

function var_0_8.GetFilteredList(arg_17_0)
	return (arg_17_0:FilterAngle((arg_17_0:FilterRange((arg_17_0:FilterTarget())))))
end

function var_0_8.FilterTarget(arg_18_0)
	local var_18_0 = arg_18_0._host:GetIFF()

	for iter_18_0, iter_18_1 in pairs((arg_18_0._dataProxy:GetAircraftList())) do
		local var_18_1

		if iter_18_1:GetIFF() ~= var_18_0 and iter_18_1:IsVisitable() then
			({})[1] = iter_18_1
			var_18_1 = 1 + 1
		end
	end

	return {}
end

function var_0_8.Update(arg_19_0)
	if arg_19_0._currentState ~= var_0_8.STATE_DISABLE then
		var_0_8.super.Update(arg_19_0)
	end

	return
end

function var_0_8.RemovePrecastTimer(arg_20_0)
	return
end

function var_0_8.Dispose(arg_21_0)
	var_0_8.super.Dispose(arg_21_0)

	arg_21_0._crewUnitList = nil
	arg_21_0._weightList = nil
	arg_21_0._hitFXResIDList = nil
	arg_21_0._SFXID = nil

	return
end

return
