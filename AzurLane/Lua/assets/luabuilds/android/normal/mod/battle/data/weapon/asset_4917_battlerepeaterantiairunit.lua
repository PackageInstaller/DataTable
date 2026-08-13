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

local var_0_8 = var_0_10008("BattleRepeaterAntiAirUnit", var_0.Battle.BattleWeaponUnit)

var_0.Battle.BattleRepeaterAntiAirUnit = var_0_8
var_0_8.__name = "BattleRepeaterAntiAirUnit"

function var_0_8.Ctor(arg_1_0)
	var_0_8.super.Ctor(arg_1_0)

	arg_1_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()

	return
end

function var_0_8.FilterTarget(arg_2_0)
	local var_2_0 = arg_2_0._dataProxy
	local var_2_1 = var_1.GetAircraftList(var_2_0)
	local var_2_2 = {}
	local var_2_3 = arg_2_0._host
	local var_2_4 = var_3.GetIFF(var_2_3)
	local var_2_5 = 1

	pairs = var_1_10005

	for iter_2_0, iter_2_1 in var_1_10005(var_2_1) do
		if iter_2_1:GetIFF() ~= var_2_4 and iter_2_1:IsVisitable() then
			var_2_2[var_2_5] = iter_2_1
			var_2_5 = var_2_5 + 1
		end
	end

	return var_2_2
end

function var_0_8.Fire(arg_3_0)
	local function var_3_0(arg_4_0)
		if not arg_3_0._dataProxy then
			return
		end

		local var_4_0 = {}
		local var_4_1 = arg_3_0._dataProxy
		local var_4_2 = var_2.GetAircraftList(var_4_1)

		ipairs = var_4_1

		for iter_4_0, iter_4_1 in var_4_1(arg_4_0) do
			if iter_4_1.Active and var_4_2[iter_4_1.UID] and var_8:IsVisitable() then
				var_4_0[#var_4_0 + 1] = var_8
			end
		end

		local var_4_3 = var_0_2.CalculateRepaterAnitiAirTotalDamage(arg_3_0)

		while var_4_3 > 0 and #var_4_0 > 0 do
			math = var_4

			local var_4_4 = var_4_0[var_4.random(#var_4_0)]
			local var_4_5 = var_5.GetMaxHP(var_4_4)

			math = var_4_4

			if var_4_3 - (var_4_5 + var_4_4.random(var_0_4.AnitAirRepeaterConfig.lower_range, var_0_4.AnitAirRepeaterConfig.upper_range)) < 0 then
				var_4_5 = var_4_5 + var_4_3
			end

			if not var_0_2.RollRepeaterHitDice(arg_3_0, var_5) then
				table = var_10

				var_10.remove(var_4_0, var_4)

				local var_4_6 = arg_3_0._dataProxy
				local var_4_7 = var_10.HandleDirectDamage
				local var_4_8 = var_5
				local var_4_9 = var_4_5
				local var_4_10 = arg_3_0

				var_4_7(var_4_6, var_4_8, var_4_9, var_14.GetHost(var_4_10))
			end
		end

		return
	end

	local var_3_1 = arg_3_0._dataProxy
	local var_3_2 = var_2.SpawnColumnArea
	local var_3_3 = var_0_3.AOEField.AIR
	local var_3_4 = arg_3_0._host
	local var_3_5 = var_5.GetIFF(var_3_4)
	local var_3_6 = arg_3_0._host

	var_3_2(var_3_1, var_3_3, var_3_5, var_6.GetPosition(var_3_6), arg_3_0._tmpData.range * 2, -1, var_3_0)
	arg_3_0:EnterCoolDown()

	local var_3_7 = arg_3_0._host

	var_2.PlayFX(var_3_7, arg_3_0._tmpData.fire_fx, true)
	var_0.Battle.PlayBattleSFX(arg_3_0._tmpData.fire_sfx)

	return
end

return
