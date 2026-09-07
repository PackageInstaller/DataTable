ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig

ys.Battle.BattleAidWave = class("BattleAidWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleAidWave.__name = "BattleAidWave"

local var_0_2 = ys.Battle.BattleAidWave

function ys.Battle.BattleAidWave.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleAidWave:SetWaveData(arg_2_1)
	var_0_2.super.SetWaveData(self, arg_2_1)

	self._vanguardUnitList = self._param.vanguard_unitList
	self._mainUnitList = self._param.main_unitList
	self._subUnitList = self._param.sub_unitList
	self._killList = self._param.kill_list

	return
end

function ys.Battle.BattleAidWave:DoWave()
	var_0_2.super.DoWave(self)

	local var_3_0 = var_0_0.Battle.BattleDataProxy.GetInstance()

	if self._killList ~= nil then
		local var_3_1 = var_3_0:GetFriendlyShipList()

		for iter_3_0, iter_3_1 in ipairs(self._killList) do
			for iter_3_2, iter_3_3 in pairs(var_3_1) do
				if iter_3_3:GetTemplateID() == iter_3_1 then
					iter_3_3:Retreat()
				end
			end
		end
	end

	if self._vanguardUnitList ~= nil then
		for iter_3_4, iter_3_5 in ipairs(self._vanguardUnitList) do
			local var_3_2 = {}

			for iter_3_6, iter_3_7 in ipairs(iter_3_5.equipment) do
				var_3_2[#var_3_2 + 1] = {
					skin = 0,
					id = iter_3_7
				}
			end

			local var_3_3 = Clone(iter_3_5)

			var_3_3.equipment = var_3_2
			var_3_3.baseProperties = iter_3_5.properties

			local var_3_4 = var_3_0:SpawnVanguard(var_3_3, var_0_1.FRIENDLY_CODE)

			var_3_0.InitUnitWeaponCD(var_3_4)
			var_3_0:InitAidUnitStatistics(var_3_4)
		end
	end

	if self._mainUnitList ~= nil then
		for iter_3_8, iter_3_9 in ipairs(self._mainUnitList) do
			local var_3_5 = {}

			for iter_3_10, iter_3_11 in ipairs(iter_3_9.equipment) do
				var_3_5[#var_3_5 + 1] = {
					skin = 0,
					id = iter_3_11
				}
			end

			local var_3_6 = Clone(iter_3_9)

			var_3_6.equipment = var_3_5
			var_3_6.baseProperties = iter_3_9.properties

			local var_3_7 = var_3_0:SpawnMain(var_3_6, var_0_1.FRIENDLY_CODE)

			var_3_0.InitUnitWeaponCD(var_3_7)
			var_3_0:InitAidUnitStatistics(var_3_7)
		end
	end

	if self._subUnitList ~= nil then
		for iter_3_12, iter_3_13 in ipairs(self._subUnitList) do
			local var_3_8 = {}

			for iter_3_14, iter_3_15 in ipairs(iter_3_13.equipment) do
				var_3_8[#var_3_8 + 1] = {
					skin = 0,
					id = iter_3_15
				}
			end

			local var_3_9 = Clone(iter_3_13)

			var_3_9.equipment = var_3_8
			var_3_9.baseProperties = iter_3_13.properties

			var_3_0:InitAidUnitStatistics((var_3_0:SpawnSub(var_3_9, var_0_1.FRIENDLY_CODE)))
		end
	end

	self:doPass()

	return
end

return
