ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local BattleRepeaterAntiAirUnit = class("BattleRepeaterAntiAirUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleRepeaterAntiAirUnit = BattleRepeaterAntiAirUnit
BattleRepeaterAntiAirUnit.__name = "BattleRepeaterAntiAirUnit"

function BattleRepeaterAntiAirUnit:Ctor()
	BattleRepeaterAntiAirUnit.super.Ctor(self)

	self._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function BattleRepeaterAntiAirUnit:FilterTarget()
	local var_2_0 = {}
	local var_2_1 = self._host:GetIFF()

	for iter_2_0, iter_2_1 in pairs((self._dataProxy:GetAircraftList())) do
		if iter_2_1:GetIFF() ~= var_2_1 and iter_2_1:IsVisitable() then
			var_2_0[1] = iter_2_1
		end
	end

	return var_2_0
end

function BattleRepeaterAntiAirUnit:Fire()
	self._dataProxy:SpawnColumnArea(var_0_3.AOEField.AIR, self._host:GetIFF(), self._host:GetPosition(), self._tmpData.range * 2, -1, function(arg_4_0)
		if not self._dataProxy then
			return
		end

		local var_4_0 = {}
		local var_4_1 = self._dataProxy:GetAircraftList()

		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1.Active then
				if var_4_1[iter_4_1.UID] and var_4_1[iter_4_1.UID]:IsVisitable() then
					var_4_0[#var_4_0 + 1] = var_4_1[iter_4_1.UID]
				end
			end
		end

		local var_4_2 = var_0_2.CalculateRepaterAnitiAirTotalDamage(self)

		while var_4_2 > 0 and #var_4_0 > 0 do
			local var_4_3 = math.random(#var_4_0)
			local var_4_4 = var_4_0[var_4_3]:GetMaxHP()

			var_4_2 = var_4_2 - (var_4_4 + math.random(var_0_4.AnitAirRepeaterConfig.lower_range, var_0_4.AnitAirRepeaterConfig.upper_range))

			if var_4_2 < 0 then
				var_4_4 = var_4_4 + var_4_2
			end

			if not var_0_2.RollRepeaterHitDice(self, var_4_0[var_4_3]) then
				table.remove(var_4_0, var_4_3)
				self._dataProxy:HandleDirectDamage(var_4_0[var_4_3], var_4_4, self:GetHost())
			end
		end

		return
	end)
	self:EnterCoolDown()
	self._host:PlayFX(self._tmpData.fire_fx, true)
	var_0_0.Battle.PlayBattleSFX(self._tmpData.fire_sfx)

	return
end

return
