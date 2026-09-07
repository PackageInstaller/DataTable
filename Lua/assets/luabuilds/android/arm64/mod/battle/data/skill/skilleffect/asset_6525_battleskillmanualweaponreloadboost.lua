ys = ys or {}

local BattleSkillManualWeaponReloadBoost = class("BattleSkillManualWeaponReloadBoost", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillManualWeaponReloadBoost = BattleSkillManualWeaponReloadBoost
BattleSkillManualWeaponReloadBoost.__name = "BattleSkillManualWeaponReloadBoost"

function BattleSkillManualWeaponReloadBoost:Ctor(arg_1_1)
	BattleSkillManualWeaponReloadBoost.super.Ctor(self, arg_1_1, lv)

	self._weaponType = self._tempData.arg_list.weaponType
	self._boostValue = self._tempData.arg_list.value
	self._boostRate = self._tempData.arg_list.rate

	return
end

function BattleSkillManualWeaponReloadBoost:DoDataEffect(arg_2_1, arg_2_2)
	local var_2_0 = self.getWeaponQueueByType(arg_2_1, self._weaponType)

	if var_2_0 then
		local var_2_1 = var_2_0:GetCoolDownList()

		if self._boostValue then
			for iter_2_0, iter_2_1 in ipairs(var_2_1) do
				iter_2_1:AppendReloadBoost(self._boostValue * -1)
			end
		elseif self._boostRate then
			for iter_2_2, iter_2_3 in ipairs(var_2_1) do
				boostValue = iter_2_3:GetReloadTimeByRate(self._boostRate) * -1

				iter_2_3:AppendReloadBoost(boostValue)
			end
		end
	end

	return
end

function BattleSkillManualWeaponReloadBoost:DoDataEffectWithoutTarget(arg_3_1)
	self:DoDataEffect(arg_3_1, nil)

	return
end

function BattleSkillManualWeaponReloadBoost:getWeaponQueueByType(arg_4_1)
	local var_4_0

	if arg_4_1 == "ChargeWeapon" then
		var_4_0 = self:GetChargeQueue()
	elseif arg_4_1 == "TorpedoWeapon" then
		var_4_0 = self:GetTorpedoQueue()
	elseif arg_4_1 == "AirAssist" then
		var_4_0 = self:GetAirAssistQueue()
	end

	return var_4_0
end

return
