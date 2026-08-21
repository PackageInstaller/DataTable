ys = ys or {}

local var_0_1 = ys.Battle.BattleFormulas
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_7 = class("BattleFleetAntiAirUnit")

ys.Battle.BattleFleetAntiAirUnit = var_0_7
var_0_7.__name = "BattleFleetAntiAirUnit"
var_0_7.STATE_DISABLE = "DISABLE"
var_0_7.STATE_READY = "READY"
var_0_7.STATE_PRECAST = "PRECAST"
var_0_7.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
var_0_7.STATE_ATTACK = "ATTACK"
var_0_7.STATE_OVER_HEAT = "OVER_HEAT"

function var_0_7.Ctor(arg_1_0)
	arg_1_0:init()

	return
end

function var_0_7.init(arg_2_0)
	arg_2_0._crewUnitList = {}
	arg_2_0._hitFXResIDList = {}
	arg_2_0._currentState = var_0_7.STATE_DISABLE
	arg_2_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_2_0._range = 0

	return
end

function var_0_7.AppendCrewUnit(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetFleetAntiAirList()

	if #var_3_0 > 0 then
		arg_3_0._currentState = var_0_7.STATE_READY
		arg_3_0._crewUnitList[arg_3_1] = var_3_0

		arg_3_0:flush()
	end

	return
end

function var_0_7.RemoveCrewUnit(arg_4_0, arg_4_1)
	if arg_4_0._crewUnitList[arg_4_1] then
		arg_4_0._crewUnitList[arg_4_1] = nil

		arg_4_0:flush()
	end

	return
end

function var_0_7.FlushCrewUnit(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetFleetAntiAirList()

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

function var_0_7.SwitchHost(arg_6_0, arg_6_1)
	arg_6_0._host = arg_6_1

	return
end

function var_0_7.GetCrewUnitList(arg_7_0)
	return arg_7_0._crewUnitList
end

function var_0_7.GetRange(arg_8_0)
	return arg_8_0._range
end

function var_0_7.flush(arg_9_0)
	arg_9_0._range = 0
	arg_9_0._interval = 0
	arg_9_0._hitFXResIDList = {}
	arg_9_0._SFXID = nil

	local var_9_0 = 0
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_0._crewUnitList) do
		var_9_1 = var_9_1 + iter_9_0:GetAttrByName("extraAntiAirRange")

		for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
			var_9_0 = var_9_0 + 1
			arg_9_0._interval = arg_9_0._interval + iter_9_3:GetReloadTime()

			local var_9_2 = iter_9_3:GetTemplateData()

			arg_9_0._range = arg_9_0._range + var_9_2.range
			arg_9_0._hitFXResIDList[iter_9_3] = var_0.Battle.BattleDataFunction.GetBulletTmpDataFromID(var_9_2.bullet_ID[1]).hit_fx
			arg_9_0._SFXID = var_9_2.fire_sfx
		end

		;({})[#{} + 1] = {
			weight = var_0_1.AntiAirPowerWeight((iter_9_0:GetAttrByName("antiAirPower"))),
			rst = iter_9_0
		}
	end

	if var_9_0 == 0 then
		arg_9_0._currentState = var_0_7.STATE_DISABLE

		if arg_9_0._precastTimer then
			arg_9_0:RemovePrecastTimer()
		end
	else
		arg_9_0._range = arg_9_0._range / var_9_0 + var_9_1
		arg_9_0._interval = arg_9_0._interval / var_9_0 + 0.5
		arg_9_0._weightList, arg_9_0._totalWeight = var_0_1.GenerateWeightList({})
	end

	return
end

function var_0_7.Update(arg_10_0)
	if arg_10_0._currentState == var_0_7.STATE_READY and #arg_10_0:FilterRange((arg_10_0:FilterTarget())) > 0 then
		arg_10_0:AddPreCastTimer()
	end

	return
end

function var_0_7.AddPreCastTimer(arg_11_0)
	arg_11_0._currentState = var_0_7.STATE_PRECAST
	arg_11_0._precastTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 0, var_0_3.AntiAirConfig.Precast_duration, function()
		arg_11_0:RemovePrecastTimer()
		arg_11_0:Fire()

		return
	end, true)

	return
end

function var_0_7.RemovePrecastTimer(arg_13_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_13_0._precastTimer)

	arg_13_0._precastTimer = nil

	return
end

function var_0_7.FilterTarget(arg_14_0)
	local var_14_0 = arg_14_0._host:GetIFF()

	for iter_14_0, iter_14_1 in pairs((arg_14_0._dataProxy:GetAircraftList())) do
		local var_14_1

		if iter_14_1:GetIFF() ~= var_14_0 and iter_14_1:IsVisitable() then
			({})[1] = iter_14_1
			var_14_1 = 1 + 1
		end
	end

	return {}
end

function var_0_7.FilterRange(arg_15_0, arg_15_1)
	for iter_15_0 = #arg_15_1, 1, -1 do
		if arg_15_0:IsOutOfRange(arg_15_1[iter_15_0]) then
			table.remove(arg_15_1, iter_15_0)
		end
	end

	return arg_15_1
end

function var_0_7.IsOutOfRange(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getTrackingHost()

	return var_16_0:GetDistance(arg_16_1) > arg_16_0._range
end

function var_0_7.getTrackingHost(arg_17_0)
	return arg_17_0._host
end

function var_0_7.Fire(arg_18_0)
	if arg_18_0._currentState == arg_18_0.DISABLE then
		return
	end

	arg_18_0._dataProxy:SpawnColumnArea(var_0_2.AOEField.AIR, arg_18_0._host:GetIFF(), arg_18_0._host:GetPosition(), arg_18_0._range * 2, -1, function(arg_19_0)
		local var_19_0 = arg_18_0._dataProxy:GetAircraftList()

		for iter_19_0, iter_19_1 in ipairs(arg_19_0) do
			if iter_19_1.Active then
				if var_19_0[iter_19_1.UID] and var_19_0[iter_19_1.UID]:IsVisitable() then
					({})[#{} + 1] = var_19_0[iter_19_1.UID]
				end
			end
		end

		local var_19_1 = var_0_1.CalculateFleetAntiAirTotalDamage(arg_18_0)
		local var_19_2 = var_0_1.GetMeteoDamageRatio(#{})

		for iter_19_2, iter_19_3 in ipairs({}) do
			arg_18_0._dataProxy:HandleDirectDamage(iter_19_3, math.max(1, math.floor(var_19_1 * var_19_2[iter_19_2])), (var_0_1.WeightListRandom(arg_18_0._weightList, arg_18_0._totalWeight)))
		end

		return
	end)
	arg_18_0:EnterCoolDown()

	for iter_18_0, iter_18_1 in pairs(arg_18_0._crewUnitList) do
		iter_18_0:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_FIRE_NEAR, {})
		iter_18_0:PlayFX(iter_18_1[1]:GetTemplateData().fire_fx, true)
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0._hitFXResIDList) do
		local var_18_0 = var_0.Battle.BattleFXPool.GetInstance()

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_18_0:GetFX(iter_18_3), arg_18_0._host:GetPosition() + Vector3((math.random() * 2 - 1) * arg_18_0._range, 10, (math.random() * 2 - 1) * arg_18_0._range), true)
	end

	var_0.Battle.PlayBattleSFX(arg_18_0._SFXID)

	return
end

function var_0_7.EnterCoolDown(arg_20_0)
	arg_20_0._currentState = arg_20_0.STATE_OVER_HEAT

	arg_20_0:AddCDTimer(arg_20_0._interval)

	return
end

function var_0_7.GetCurrentState(arg_21_0)
	return arg_21_0._currentState
end

function var_0_7.AddCDTimer(arg_22_0, arg_22_1)
	arg_22_0:RemoveCDTimer()

	arg_22_0._cdTimer = pg.TimeMgr.GetInstance():AddBattleTimer("weaponTimer", -1, arg_22_1, function()
		arg_22_0._currentState = arg_22_0.STATE_READY

		arg_22_0:RemoveCDTimer()

		return
	end, true)

	return
end

function var_0_7.RemoveCDTimer(arg_24_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_24_0._cdTimer)

	arg_24_0._cdTimer = nil

	return
end

function var_0_7.Dispose(arg_25_0)
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
