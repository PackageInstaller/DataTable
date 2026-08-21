ys = ys or {}

local var_0_1 = ys.Battle.BattleFormulas
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_7 = class("BattleRepeaterAntiAirUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleRepeaterAntiAirUnit = var_0_7
var_0_7.__name = "BattleRepeaterAntiAirUnit"

function var_0_7.Ctor(arg_1_0)
	var_0_7.super.Ctor(arg_1_0)

	arg_1_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()

	return
end

function var_0_7.FilterTarget(arg_2_0)
	local var_2_0 = arg_2_0._host:GetIFF()

	for iter_2_0, iter_2_1 in pairs((arg_2_0._dataProxy:GetAircraftList())) do
		local var_2_1

		if iter_2_1:GetIFF() ~= var_2_0 and iter_2_1:IsVisitable() then
			({})[1] = iter_2_1
			var_2_1 = 1 + 1
		end
	end

	return {}
end

function var_0_7.Fire(arg_3_0)
	arg_3_0._dataProxy:SpawnColumnArea(var_0_2.AOEField.AIR, arg_3_0._host:GetIFF(), arg_3_0._host:GetPosition(), arg_3_0._tmpData.range * 2, -1, function(arg_4_0)
		if not arg_3_0._dataProxy then
			return
		end

		local var_4_0 = {}
		local var_4_1 = arg_3_0._dataProxy:GetAircraftList()

		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1.Active then
				if var_4_1[iter_4_1.UID] and var_4_1[iter_4_1.UID]:IsVisitable() then
					var_4_0[#var_4_0 + 1] = var_4_1[iter_4_1.UID]
				end
			end
		end

		local var_4_2 = var_0_1.CalculateRepaterAnitiAirTotalDamage(arg_3_0)

		while var_4_2 > 0 and #var_4_0 > 0 do
			local var_4_3 = math.random(#var_4_0)
			local var_4_4 = var_4_0[var_4_3]:GetMaxHP()

			var_4_2 = var_4_2 - (var_4_4 + math.random(var_0_3.AnitAirRepeaterConfig.lower_range, var_0_3.AnitAirRepeaterConfig.upper_range))

			if var_4_2 < 0 then
				var_4_4 = var_4_4 + var_4_2
			end

			if not var_0_1.RollRepeaterHitDice(arg_3_0, var_4_0[var_4_3]) then
				table.remove(var_4_0, var_4_3)
				arg_3_0._dataProxy:HandleDirectDamage(var_4_0[var_4_3], var_4_4, arg_3_0:GetHost())
			end
		end

		return
	end)
	arg_3_0:EnterCoolDown()
	arg_3_0._host:PlayFX(arg_3_0._tmpData.fire_fx, true)
	var_0.Battle.PlayBattleSFX(arg_3_0._tmpData.fire_sfx)

	return
end

return
