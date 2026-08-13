ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleConfig
local var_0_5 = var_0.Battle.BattleDataFunction
local var_0_6 = var_0.Battle.BattleAttr
local var_0_7 = var_0.Battle.BattleVariable
local var_0_8 = var_0_3.WeaponSearchType
local var_0_9 = var_0_3.WeaponSuppressType

class = var_0_10010

local var_0_10 = var_0_10010("BattleFleetRangeAntiAirUnit", var_0.Battle.BattleWeaponUnit)

var_0.Battle.BattleFleetRangeAntiAirUnit = var_0_10
var_0_10.__name = "BattleFleetRangeAntiAirUnit"

function var_0_10.Ctor(arg_1_0)
	var_0_10.super.Ctor(arg_1_0)

	arg_1_0._currentState = var_0_10.STATE_DISABLE

	arg_1_0:init()

	return
end

function var_0_10.init(arg_2_0)
	arg_2_0._crewUnitList = {}
	arg_2_0._hitFXResIDList = {}
	arg_2_0._range = 0
	arg_2_0._majorEmitterList = {}
	arg_2_0._GCD = 0.5
	arg_2_0._tmpData = {}
	arg_2_0._tmpData.bullet_ID = {
		var_0_4.AntiAirConfig.RangeBulletID
	}
	arg_2_0._tmpData.barrage_ID = {
		var_0_4.AntiAirConfig.RangeBarrageID
	}
	arg_2_0._tmpData.aim_type = var_0_3.WeaponAimType.AIM
	arg_2_0._tmpData.axis_angle = 0
	arg_2_0._tmpData.search_type = var_0_8.SECTOR
	arg_2_0._tmpData.suppress = var_0_9.NONE
	arg_2_0._tmpData.queue = 0
	arg_2_0._tmpData.action_index = ""
	arg_2_0._tmpData.fire_sfx = "battle/cannon-air"
	arg_2_0._tmpData.spawn_bound = var_0_4.AntiAirConfig.RangeAntiAirBone
	arg_2_0._tmpData.shakescreen = 0
	arg_2_0._tmpData.fire_fx_loop_type = 0
	arg_2_0._tmpData.attack_attribute = var_0_3.WeaponDamageAttr.AIR
	arg_2_0._tmpData.attack_attribute_ratio = 100
	arg_2_0._tmpData.expose = 0
	arg_2_0._fireFXFlag = arg_2_0._tmpData.fire_fx_loop_type
	arg_2_0._preCastInfo = {}
	arg_2_0._convertedBulletVelocity = var_0_2.ConvertBulletSpeed(var_0_5.GetBulletTmpDataFromID(arg_2_0._tmpData.bullet_ID[1]).velocity)
	arg_2_0._bulletList = arg_2_0._tmpData.bullet_ID

	arg_2_0:ShiftBarrage(arg_2_0._tmpData.barrage_ID)

	return
end

function var_0_10.AppendCrewUnit(arg_3_0, arg_3_1)
	if #arg_3_1:GetFleetRangeAntiAirList() > 0 then
		arg_3_0._currentState = var_0_10.STATE_READY
		arg_3_0._crewUnitList[arg_3_1] = var_2

		arg_3_0:flush()
	end

	return
end

function var_0_10.RemoveCrewUnit(arg_4_0, arg_4_1)
	if arg_4_0._crewUnitList[arg_4_1] then
		if arg_4_1 == arg_4_0._host then
			local var_4_0 = arg_4_0._host

			var_3.DetachFleetRangeAAWeapon(var_4_0)
		end

		arg_4_0._crewUnitList[arg_4_1] = nil

		arg_4_0:flush()
	end

	return
end

function var_0_10.FlushCrewUnit(arg_5_0, arg_5_1)
	if #arg_5_1:GetFleetRangeAntiAirList() <= 0 then
		arg_5_0:RemoveCrewUnit(arg_5_1)
	elseif arg_5_0._crewUnitList[arg_5_1] == nil then
		arg_5_0:AppendCrewUnit(arg_5_1)
	else
		arg_5_0._crewUnitList[arg_5_1] = var_2

		arg_5_0:flush()
	end

	return
end

function var_0_10.Spawn(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1 = arg_6_0:getAimPoint(arg_6_2)
	local var_6_2 = arg_6_0._dataProxy
	local var_6_3 = var_5.CreateBulletUnit(var_6_2, arg_6_1, arg_6_0._host, arg_6_0, var_6_1)

	arg_6_0:setBulletSkin(var_6_3, arg_6_1)
	arg_6_0:TriggerBuffWhenSpawn(var_6_3)

	return var_6_3
end

function var_0_10.getAimPoint(arg_7_0, arg_7_1)
	local var_7_0

	target = var_1_10003

	if var_1_10003 then
		local var_7_1 = arg_7_1:GetPosition()

		Vector3 = var_1_10004
		var_7_0 = var_1_10004(var_7_1.x + arg_7_0._aimOffset, 0, var_7_1.z)
	else
		local var_7_2 = arg_7_0:GetHost()
		local var_7_3 = var_3.GetPosition(var_7_2).z
		local var_7_4 = var_3.x + arg_7_0._maxRangeSqr * arg_7_0._hostIFF + arg_7_0._aimOffset

		Vector3 = var_6
		var_7_0 = var_6(var_7_4, 0, var_7_3)
	end

	return var_7_0
end

function var_0_10.GetCrewUnitList(arg_8_0)
	return arg_8_0._crewUnitList
end

function var_0_10.GetRange(arg_9_0)
	return arg_9_0._range
end

function var_0_10.GetAttackAngle(arg_10_0)
	return arg_10_0._aimAngle
end

function var_0_10.GetReloadTime(arg_11_0)
	return arg_11_0._interval
end

function var_0_10.flush(arg_12_0)
	arg_12_0._range = 0
	arg_12_0._interval = 0
	arg_12_0._aimAngle = 0
	arg_12_0._aimOffset = 0
	arg_12_0._maxRangeSqr = 0
	arg_12_0._minRangeSqr = 0
	arg_12_0._hitFXResIDList = {}
	arg_12_0._SFXID = nil
	arg_12_0._exploRange = 0

	local var_12_0 = {}
	local var_12_1 = 0

	pairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(arg_12_0._crewUnitList) do
		ipairs = var_1_10008

		for iter_12_2, iter_12_3 in var_1_10008(iter_12_1) do
			var_12_1 = var_12_1 + 1
			arg_12_0._interval = arg_12_0._interval + iter_12_3:GetReloadTime()

			local var_12_2 = iter_12_3:GetTemplateData()

			arg_12_0._range = arg_12_0._range + var_12_2.range
			arg_12_0._SFXID = var_12_2.fire_sfx
			arg_12_0._aimAngle = arg_12_0._aimAngle + iter_12_3:GetAttackAngle()
			arg_12_0._maxRangeSqr = arg_12_0._maxRangeSqr + iter_12_3:GetWeaponMaxRange()
			arg_12_0._minRangeSqr = arg_12_0._minRangeSqr + iter_12_3:GetWeaponMinRange()

			local var_12_3 = var_0_5.GetBulletTmpDataFromID(iter_12_3:GetTemplateData().bullet_ID[1])

			arg_12_0._hitFXResIDList[iter_12_3] = var_12_3.hit_fx
			arg_12_0._exploRange = arg_12_0._exploRange + var_12_3.hit_type.range

			local var_12_4 = arg_12_0._aimOffset
			local var_12_5

			if not var_12_3.extra_param.aim_offset then
				var_12_5 = 0
			end

			arg_12_0._aimOffset = var_12_4 + var_12_5
		end

		var_1_10008 = iter_12_0:GetAttrByName("antiAirPower")

		local var_12_6 = var_0_2.AntiAirPowerWeight(var_1_10008)
		local var_12_7 = {
			weight = var_12_6,
			rst = iter_12_0
		}

		var_12_0[#var_12_0 + 1] = var_12_7
	end

	if var_12_1 == 0 then
		arg_12_0._currentState = var_0_10.STATE_DISABLE
	else
		arg_12_0:SwitchHost()

		arg_12_0._maxRangeSqr = arg_12_0._maxRangeSqr / var_12_1
		arg_12_0._minRangeSqr = arg_12_0._minRangeSqr / var_12_1
		arg_12_0._exploRange = arg_12_0._exploRange / var_12_1
		arg_12_0._aimAngle = arg_12_0._aimAngle / var_12_1

		local var_12_8 = arg_12_0._aimOffset / var_12_1
		local var_12_9 = arg_12_0._host

		arg_12_0._aimOffset = var_12_8 * var_4.GetIFF(var_12_9)
		arg_12_0._interval = arg_12_0._interval / var_12_1 + 0.5
		arg_12_0._weightList, arg_12_0._totalWeight = var_0_2.GenerateWeightList(var_12_0)
	end

	return
end

function var_0_10.DoAreaSplit(arg_13_0, arg_13_1)
	local function var_13_0(arg_14_0)
		local var_14_0 = {}
		local var_14_1 = arg_13_0._dataProxy
		local var_14_2 = var_2.GetAircraftList(var_14_1)

		ipairs = var_2_10003

		for iter_14_0, iter_14_1 in var_2_10003(arg_14_0) do
			if iter_14_1.Active and var_14_2[iter_14_1.UID] and var_8:IsVisitable() then
				var_14_0[#var_14_0 + 1] = var_8
			end
		end

		local var_14_3 = var_0_2.CalculateFleetAntiAirTotalDamage(arg_13_0)
		local var_14_4 = var_0_2.GetMeteoDamageRatio(#var_14_0)

		ipairs = var_5

		for iter_14_2, iter_14_3 in var_5(var_14_0) do
			math = var_2_10010
			var_2_10010 = var_2_10010.max

			local var_14_5 = 1

			math = var_2_10013
			var_2_10010 = var_2_10010(var_14_5, var_2_10013.floor(var_14_3 * var_14_4[iter_14_2]))

			local var_14_6 = var_0_2.WeightListRandom(arg_13_0._weightList, arg_13_0._totalWeight)
			local var_14_7 = arg_13_0._dataProxy

			var_12.HandleDirectDamage(var_14_7, iter_14_3, var_2_10010, var_14_6)
		end

		return
	end

	pairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(arg_13_0._crewUnitList) do
		iter_13_0:TriggerBuff(var_0_3.BuffEffectType.ON_ANTIAIR_FIRE_FAR, {})

		local var_13_1 = iter_13_0

		var_1_10008 = iter_13_0.PlayFX

		local var_13_2 = iter_13_1[1]

		var_1_10008(var_13_1, var_1_10011.GetTemplateData(var_13_2).fire_fx, true)
	end

	pairs = var_3

	for iter_13_2, iter_13_3 in var_3(arg_13_0._hitFXResIDList) do
		math = var_1_10008
		var_1_10008 = (var_1_10008.random() * 2 - 1) * arg_13_0._exploRange
		math = var_9

		local var_13_3 = (var_9.random() * 2 - 1) * arg_13_0._exploRange
		local var_13_4 = arg_13_1
		local var_13_5 = arg_13_1.GetPosition(var_13_4)

		Vector3 = var_1_10011

		local var_13_6 = var_13_5 + var_1_10011(var_1_10008, 10, var_13_3)
		local var_13_7 = var_0.Battle.BattleFXPool.GetInstance()

		var_1_10011 = var_1_10011.GetFX(var_13_7, iter_13_3)
		pg = var_13_4

		local var_13_8 = var_13_4.EffectMgr.GetInstance()

		var_12.PlayBattleEffect(var_13_8, var_1_10011, var_13_6, true)
	end

	local var_13_9 = arg_13_0._dataProxy

	var_3.SpawnColumnArea(var_13_9, var_0_3.BulletField.AIR, arg_13_1:GetIFF(), arg_13_1:GetPosition(), arg_13_0._exploRange, -1, var_13_0)

	RANGE_ANTI_AREA = var_3

	if var_3 then
		local var_13_10 = var_0.Battle.BattleFXPool.GetInstance()
		local var_13_11 = var_3.GetFX(var_13_10, "AlertArea").transform

		Vector3 = var_13_10
		var_13_11.localScale = var_13_10(arg_13_0._exploRange, 1, arg_13_0._exploRange)
		pg = var_5

		local var_13_12 = var_5.EffectMgr.GetInstance()

		var_5.PlayBattleEffect(var_13_12, var_3, arg_13_1:GetPosition())
	end

	local var_13_13 = arg_13_0._dataProxy

	var_3.RemoveBulletUnit(var_13_13, arg_13_1:GetUniqueID())

	return
end

function var_0_10.SwitchHost(arg_15_0)
	local var_15_0 = {}

	pairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0._crewUnitList) do
		table = var_1_10007

		var_1_10007.insert(var_15_0, iter_15_0)
	end

	table = var_2

	var_2.sort(var_15_0, function(arg_16_0, arg_16_1)
		return arg_16_0:GetMainUnitIndex() < arg_16_1:GetMainUnitIndex()
	end)

	local var_15_1 = var_15_0[1]

	if arg_15_0._host == var_15_1 then
		return
	end

	arg_15_0:SetHostData(var_15_1)

	local var_15_2 = arg_15_0._host

	var_3.AttachFleetRangeAAWeapon(var_15_2, arg_15_0)

	return
end

function var_0_10.GetFilteredList(arg_17_0)
	local var_17_0 = arg_17_0:FilterTarget()
	local var_17_1 = arg_17_0:FilterRange(var_17_0)

	return (arg_17_0:FilterAngle(var_17_1))
end

function var_0_10.FilterTarget(arg_18_0)
	local var_18_0 = arg_18_0._dataProxy
	local var_18_1 = var_1.GetAircraftList(var_18_0)
	local var_18_2 = {}
	local var_18_3 = arg_18_0._host
	local var_18_4 = var_3.GetIFF(var_18_3)
	local var_18_5 = 1

	pairs = var_18_3

	for iter_18_0, iter_18_1 in var_18_3(var_18_1) do
		if iter_18_1:GetIFF() ~= var_18_4 and iter_18_1:IsVisitable() then
			var_18_2[var_18_5] = iter_18_1
			var_18_5 = var_18_5 + 1
		end
	end

	return var_18_2
end

function var_0_10.Update(arg_19_0)
	if arg_19_0._currentState ~= var_0_10.STATE_DISABLE then
		var_0_10.super.Update(arg_19_0)
	end

	return
end

function var_0_10.RemovePrecastTimer(arg_20_0)
	return
end

function var_0_10.Dispose(arg_21_0)
	var_0_10.super.Dispose(arg_21_0)

	arg_21_0._crewUnitList = nil
	arg_21_0._weightList = nil
	arg_21_0._hitFXResIDList = nil
	arg_21_0._SFXID = nil

	return
end

return
