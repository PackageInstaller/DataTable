ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleConst
local BattleSkillFireSupport = class("BattleSkillFireSupport", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillFireSupport = BattleSkillFireSupport
BattleSkillFireSupport.__name = "BattleSkillFireSupport"

function BattleSkillFireSupport:Ctor(arg_1_1)
	BattleSkillFireSupport.super.Ctor(self, arg_1_1, lv)

	self._weaponID = self._tempData.arg_list.weapon_id
	self._supportTargetFilter = self._tempData.arg_list.supportTarget.targetChoice
	self._supportTargetArgList = self._tempData.arg_list.supportTarget.arg_list

	return
end

function BattleSkillFireSupport:DoDataEffect(arg_2_1, arg_2_2)
	if self._weapon == nil then
		local var_2_0

		for iter_2_0, iter_2_1 in ipairs(self._supportTargetFilter) do
			var_2_0 = var_0_0.Battle.BattleTargetChoise[iter_2_1](arg_2_1, self._supportTargetArgList, var_2_0)
		end

		self._weapon = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(self._weaponID, arg_2_1)

		if BATTLE_DEBUG and (self._weapon:GetType() == var_0_2.EquipmentType.INTERCEPT_AIRCRAFT or self._weapon:GetType() == var_0_2.EquipmentType.STRIKE_AIRCRAFT) then
			self._weapon:GetATKAircraftList()
		end

		if var_2_0[1] then
			self._weapon:SetStandHost(var_2_0[1])
		end

		arg_2_1:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, {
			weapon = self._weapon
		})))
	end

	local function var_2_1()
		self._weapon:Clear()

		return
	end

	self._weapon:updateMovementInfo()
	self._weapon:SingleFire(arg_2_2, self._emitter, var_2_1)

	return
end

function BattleSkillFireSupport:DoDataEffectWithoutTarget(arg_4_1)
	self:DoDataEffect(arg_4_1)

	return
end

function BattleSkillFireSupport:Clear()
	BattleSkillFireSupport.super.Clear(self)

	if self._weapon then
		if not self._weapon:GetHost():IsAlive() then
			self._weapon:Clear()
		end
	end

	return
end

function BattleSkillFireSupport:Interrupt()
	BattleSkillFireSupport.super.Interrupt(self)

	if self._weapon then
		self._weapon:Cease()
		self._weapon:Clear()
	end

	return
end

function BattleSkillFireSupport:GetDamageSum()
	local var_7_0 = 0

	if not self._weapon then
		var_7_0 = 0
	elseif self._weapon:GetType() == var_0_2.EquipmentType.INTERCEPT_AIRCRAFT or self._weapon:GetType() == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
		for iter_7_0, iter_7_1 in ipairs(self._weapon:GetATKAircraftList()) do
			for iter_7_2, iter_7_3 in ipairs((iter_7_1:GetWeapon())) do
				var_7_0 = var_7_0 + iter_7_3:GetDamageSUM()
			end
		end
	else
		var_7_0 = self._weapon:GetDamageSUM()
	end

	return var_7_0
end

return
