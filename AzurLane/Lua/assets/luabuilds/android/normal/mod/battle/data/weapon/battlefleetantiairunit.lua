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

class = var_0_10008

local var_0_8 = var_0_10008("BattleFleetAntiAirUnit")

var_0.Battle.BattleFleetAntiAirUnit = var_0_8
var_0_8.__name = "BattleFleetAntiAirUnit"
var_0_8.STATE_DISABLE = "DISABLE"
var_0_8.STATE_READY = "READY"
var_0_8.STATE_PRECAST = "PRECAST"
var_0_8.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
var_0_8.STATE_ATTACK = "ATTACK"
var_0_8.STATE_OVER_HEAT = "OVER_HEAT"

function var_0_8.Ctor(arg_1_0)
	arg_1_0:init()

	return
end

function var_0_8.init(arg_2_0)
	arg_2_0._crewUnitList = {}
	arg_2_0._hitFXResIDList = {}
	arg_2_0._currentState = var_0_8.STATE_DISABLE
	arg_2_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_2_0._range = 0

	return
end

function var_0_8.AppendCrewUnit(arg_3_0, arg_3_1)
	if #arg_3_1:GetFleetAntiAirList() > 0 then
		arg_3_0._currentState = var_0_8.STATE_READY
		arg_3_0._crewUnitList[arg_3_1] = var_2

		arg_3_0:flush()
	end

	return
end

function var_0_8.RemoveCrewUnit(arg_4_0, arg_4_1)
	if arg_4_0._crewUnitList[arg_4_1] then
		arg_4_0._crewUnitList[arg_4_1] = nil

		arg_4_0:flush()
	end

	return
end

function var_0_8.FlushCrewUnit(arg_5_0, arg_5_1)
	if #arg_5_1:GetFleetAntiAirList() <= 0 then
		arg_5_0:RemoveCrewUnit(arg_5_1)
	elseif arg_5_0._crewUnitList[arg_5_1] == nil then
		arg_5_0:AppendCrewUnit(arg_5_1)
	else
		arg_5_0._crewUnitList[arg_5_1] = var_2

		arg_5_0:flush()
	end

	return
end

function var_0_8.SwitchHost(arg_6_0, arg_6_1)
	arg_6_0._host = arg_6_1

	return
end

function var_0_8.GetCrewUnitList(arg_7_0)
	return arg_7_0._crewUnitList
end

function var_0_8.GetRange(arg_8_0)
	return arg_8_0._range
end

function var_0_8.flush(arg_9_0)
	arg_9_0._range = 0
	arg_9_0._interval = 0
	arg_9_0._hitFXResIDList = {}
	arg_9_0._SFXID = nil

	local var_9_0 = {}
	local var_9_1 = 0
	local var_9_2 = 0

	pairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(arg_9_0._crewUnitList) do
		var_9_2 = var_9_2 + iter_9_0:GetAttrByName("extraAntiAirRange")
		ipairs = var_9

		for iter_9_2, iter_9_3 in var_9(iter_9_1) do
			var_9_1 = var_9_1 + 1
			arg_9_0._interval = arg_9_0._interval + iter_9_3:GetReloadTime()

			local var_9_3 = iter_9_3:GetTemplateData()

			arg_9_0._range = arg_9_0._range + var_9_3.range
			arg_9_0._hitFXResIDList[iter_9_3] = var_0.Battle.BattleDataFunction.GetBulletTmpDataFromID(var_9_3.bullet_ID[1]).hit_fx
			arg_9_0._SFXID = var_9_3.fire_sfx
		end

		local var_9_4 = iter_9_0:GetAttrByName("antiAirPower")
		local var_9_5 = var_0_2.AntiAirPowerWeight(var_9_4)
		local var_9_6 = {
			weight = var_9_5,
			rst = iter_9_0
		}

		var_9_0[#var_9_0 + 1] = var_9_6
	end

	if var_9_1 == 0 then
		arg_9_0._currentState = var_0_8.STATE_DISABLE

		if arg_9_0._precastTimer then
			arg_9_0:RemovePrecastTimer()
		end
	else
		arg_9_0._range = arg_9_0._range / var_9_1 + var_9_2
		arg_9_0._interval = arg_9_0._interval / var_9_1 + 0.5
		arg_9_0._weightList, arg_9_0._totalWeight = var_0_2.GenerateWeightList(var_9_0)
	end

	return
end

function var_0_8.Update(arg_10_0)
	if arg_10_0._currentState == var_0_8.STATE_READY then
		local var_10_0 = arg_10_0:FilterTarget()

		if #arg_10_0:FilterRange(var_10_0) > 0 then
			arg_10_0:AddPreCastTimer()
		end
	end

	return
end

function var_0_8.AddPreCastTimer(arg_11_0)
	local function var_11_0()
		local var_12_0 = arg_11_0

		var_0.RemovePrecastTimer(var_12_0)

		local var_12_1 = arg_11_0

		var_0.Fire(var_12_1)

		return
	end

	arg_11_0._currentState = var_0_8.STATE_PRECAST
	pg = var_2

	local var_11_1 = var_2.TimeMgr.GetInstance()

	arg_11_0._precastTimer = var_2.AddBattleTimer(var_11_1, "", 0, var_0_4.AntiAirConfig.Precast_duration, var_11_0, true)

	return
end

function var_0_8.RemovePrecastTimer(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_13_0, arg_13_0._precastTimer)

	arg_13_0._precastTimer = nil

	return
end

function var_0_8.FilterTarget(arg_14_0)
	local var_14_0 = arg_14_0._dataProxy
	local var_14_1 = var_1.GetAircraftList(var_14_0)
	local var_14_2 = {}
	local var_14_3 = arg_14_0._host
	local var_14_4 = var_3.GetIFF(var_14_3)
	local var_14_5 = 1

	pairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(var_14_1) do
		if iter_14_1:GetIFF() ~= var_14_4 and iter_14_1:IsVisitable() then
			var_14_2[var_14_5] = iter_14_1
			var_14_5 = var_14_5 + 1
		end
	end

	return var_14_2
end

function var_0_8.FilterRange(arg_15_0, arg_15_1)
	for iter_15_0 = #arg_15_1, 1, -1 do
		if arg_15_0:IsOutOfRange(arg_15_1[iter_15_0]) then
			table = var_6

			var_6.remove(arg_15_1, iter_15_0)
		end
	end

	return arg_15_1
end

function var_0_8.IsOutOfRange(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getTrackingHost()

	return var_2.GetDistance(var_16_0, arg_16_1) > arg_16_0._range
end

function var_0_8.getTrackingHost(arg_17_0)
	return arg_17_0._host
end

function var_0_8.Fire(arg_18_0)
	if arg_18_0._currentState == arg_18_0.DISABLE then
		return
	end

	local function var_18_0(arg_19_0)
		local var_19_0 = {}
		local var_19_1 = arg_18_0._dataProxy
		local var_19_2 = var_2.GetAircraftList(var_19_1)

		ipairs = var_19_1

		for iter_19_0, iter_19_1 in var_19_1(arg_19_0) do
			if iter_19_1.Active and var_19_2[iter_19_1.UID] then
				var_2_10010 = var_8

				if var_8.IsVisitable(var_2_10010) then
					var_19_0[#var_19_0 + 1] = var_8
				end
			end
		end

		local var_19_3 = var_0_2.CalculateFleetAntiAirTotalDamage(arg_18_0)
		local var_19_4 = var_0_2.GetMeteoDamageRatio(#var_19_0)

		ipairs = var_5

		for iter_19_2, iter_19_3 in var_5(var_19_0) do
			math = var_2_10010
			var_2_10010 = var_2_10010.max

			local var_19_5 = 1

			math = var_2_10012
			var_2_10010 = var_2_10010(var_19_5, var_2_10012.floor(var_19_3 * var_19_4[iter_19_2]))

			local var_19_6 = var_0_2.WeightListRandom(arg_18_0._weightList, arg_18_0._totalWeight)
			local var_19_7 = arg_18_0._dataProxy

			var_2_10012.HandleDirectDamage(var_19_7, iter_19_3, var_2_10010, var_19_6)
		end

		return
	end

	local var_18_1 = arg_18_0._dataProxy
	local var_18_2 = var_2.SpawnColumnArea
	local var_18_3 = var_0_3.AOEField.AIR
	local var_18_4 = arg_18_0._host
	local var_18_5 = var_5.GetIFF(var_18_4)
	local var_18_6 = arg_18_0._host

	var_18_2(var_18_1, var_18_3, var_18_5, var_6.GetPosition(var_18_6), arg_18_0._range * 2, -1, var_18_0)
	arg_18_0:EnterCoolDown()

	pairs = var_2

	for iter_18_0, iter_18_1 in var_2(arg_18_0._crewUnitList) do
		iter_18_0:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_FIRE_NEAR, {})

		local var_18_7 = iter_18_0
		local var_18_8 = iter_18_0.PlayFX
		local var_18_9 = iter_18_1[1]

		var_18_8(var_18_7, var_9.GetTemplateData(var_18_9).fire_fx, true)
	end

	pairs = var_2

	for iter_18_2, iter_18_3 in var_2(arg_18_0._hitFXResIDList) do
		math = var_18_8
		var_18_8 = (var_18_8.random() * 2 - 1) * arg_18_0._range
		math = var_8

		local var_18_10 = (var_8.random() * 2 - 1) * arg_18_0._range
		local var_18_11 = arg_18_0._host
		local var_18_12 = var_9.GetPosition(var_18_11)

		Vector3 = var_18_11

		local var_18_13 = var_18_12 + var_18_11(var_18_8, 10, var_18_10)
		local var_18_14 = var_0.Battle.BattleFXPool.GetInstance()
		local var_18_15 = var_10.GetFX(var_18_14, iter_18_3)

		pg = var_18_14

		local var_18_16 = var_18_14.EffectMgr.GetInstance()

		var_11.PlayBattleEffect(var_18_16, var_18_15, var_18_13, true)
	end

	var_0.Battle.PlayBattleSFX(arg_18_0._SFXID)

	return
end

function var_0_8.EnterCoolDown(arg_20_0)
	arg_20_0._currentState = arg_20_0.STATE_OVER_HEAT

	arg_20_0:AddCDTimer(arg_20_0._interval)

	return
end

function var_0_8.GetCurrentState(arg_21_0)
	return arg_21_0._currentState
end

function var_0_8.AddCDTimer(arg_22_0, arg_22_1)
	local function var_22_0()
		arg_22_0._currentState = arg_22_0.STATE_READY

		local var_23_0 = arg_22_0

		var_0.RemoveCDTimer(var_23_0)

		return
	end

	arg_22_0:RemoveCDTimer()

	pg = var_3

	local var_22_1 = var_3.TimeMgr.GetInstance()

	arg_22_0._cdTimer = var_3.AddBattleTimer(var_22_1, "weaponTimer", -1, arg_22_1, var_22_0, true)

	return
end

function var_0_8.RemoveCDTimer(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_24_0, arg_24_0._cdTimer)

	arg_24_0._cdTimer = nil

	return
end

function var_0_8.Dispose(arg_25_0)
	arg_25_0:RemoveCDTimer()
	arg_25_0:RemovePrecastTimer()

	arg_25_0._crewUnitList = nil
	arg_25_0._weightList = nil
	arg_25_0._hitFXResIDList = nil
	arg_25_0._dataProxy = nil
	arg_25_0._SFXID = nil

	return
end

return
