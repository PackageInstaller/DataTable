ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_2 = ys.Battle.BattleConst
local BattleSkillFire = class("BattleSkillFire", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillFire = BattleSkillFire
BattleSkillFire.__name = "BattleSkillFire"

function BattleSkillFire:Ctor(arg_1_1, arg_1_2)
	BattleSkillFire.super.Ctor(self, arg_1_1, arg_1_2)

	self._weaponID = self._tempData.arg_list.weapon_id
	self._emitter = self._tempData.arg_list.emitter
	self._useSkin = self._tempData.arg_list.useSkin
	self._equipIndex = self._tempData.arg_list.equip_index or -1
	self._atkAttrConvert = self._tempData.arg_list.attack_attribute_convert

	return
end

function BattleSkillFire:SetWeaponSkin(arg_2_1)
	self._modelID = arg_2_1

	return
end

function BattleSkillFire:IsFinaleEffect()
	return true
end

function BattleSkillFire:DoDataEffect(arg_4_1, arg_4_2)
	if self._weapon == nil then
		self._weapon = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(self._weaponID, arg_4_1, nil, self._equipIndex)

		if BATTLE_DEBUG and (self._weapon:GetType() == var_0_2.EquipmentType.INTERCEPT_AIRCRAFT or self._weapon:GetType() == var_0_2.EquipmentType.STRIKE_AIRCRAFT) then
			self._weapon:GetATKAircraftList()
			self._weapon:GetDEFAircraftList()
		end

		if self._modelID then
			self._weapon:SetModelID(self._modelID)
		elseif self._useSkin then
			local var_4_0 = arg_4_1:GetPriorityWeaponSkin()

			if var_4_0 then
				self._weapon:SetModelID(var_0_1.GetEquipSkin(var_4_0))
			end
		end

		arg_4_1:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, {
			weapon = self._weapon
		})))
	end

	local function var_4_1()
		self._weapon:Clear()

		if self._finaleCallback then
			self._finaleCallback()
		end

		return
	end

	if self._atkAttrConvert then
		self._weapon:SetAtkAttrTrasnform(self._atkAttrConvert.attr_type, self._atkAttrConvert.A, self._atkAttrConvert.B)
	end

	self._weapon:updateMovementInfo()
	self._weapon:SingleFire(arg_4_2, self._emitter, var_4_1)

	return
end

function BattleSkillFire:DoDataEffectWithoutTarget(arg_6_1)
	self:DoDataEffect(arg_6_1)

	return
end

function BattleSkillFire:Clear()
	BattleSkillFire.super.Clear(self)

	if self._weapon then
		if not self._weapon:GetHost():IsAlive() then
			self._weapon:Clear()
		end
	end

	return
end

function BattleSkillFire:Interrupt()
	BattleSkillFire.super.Interrupt(self)

	if self._weapon then
		self._weapon:Cease()
		self._weapon:Clear()
	end

	return
end

function BattleSkillFire:GetDamageSum()
	local var_9_0 = 0

	if not self._weapon then
		var_9_0 = 0
	elseif self._weapon:GetType() == var_0_2.EquipmentType.INTERCEPT_AIRCRAFT or self._weapon:GetType() == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
		for iter_9_0, iter_9_1 in ipairs(self._weapon:GetATKAircraftList()) do
			for iter_9_2, iter_9_3 in ipairs((iter_9_1:GetWeapon())) do
				var_9_0 = var_9_0 + iter_9_3:GetDamageSUM()
			end
		end
	else
		var_9_0 = self._weapon:GetDamageSUM()
	end

	return var_9_0
end

return
