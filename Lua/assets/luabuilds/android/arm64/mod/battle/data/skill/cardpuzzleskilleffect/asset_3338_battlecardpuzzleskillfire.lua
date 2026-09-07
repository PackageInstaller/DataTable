ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_2 = ys.Battle.BattleCardPuzzleFormulas
local BattleCardPuzzleSkillFire = class("BattleCardPuzzleSkillFire", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillFire = BattleCardPuzzleSkillFire
BattleCardPuzzleSkillFire.__name = "BattleCardPuzzleSkillFire"

function BattleCardPuzzleSkillFire:Ctor(arg_1_1)
	BattleCardPuzzleSkillFire.super.Ctor(self, arg_1_1)

	self._weaponID = self._tempData.arg_list.weapon_id
	self._emitter = self._tempData.arg_list.emitter
	self._useSkin = self._tempData.arg_list.useSkin
	self._enhance = self._tempData.arg_list.enhance_formula

	return
end

function BattleCardPuzzleSkillFire:SetWeaponSkin(arg_2_1)
	self._modelID = arg_2_1

	return
end

function BattleCardPuzzleSkillFire:SkillEffectHandler()
	if self._weapon == nil then
		self._weapon = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(self._weaponID, self._caster)

		if self._modelID then
			self._weapon:SetModelID(self._modelID)
		elseif self._useSkin then
			local var_3_0 = self._caster:GetPriorityWeaponSkin()

			if var_3_0 then
				self._weapon:SetModelID(var_0_1.GetEquipSkin(var_3_0))
			end
		end

		self._caster:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, {
			weapon = self._weapon
		})))
	end

	local function var_3_1()
		self._weapon:Clear()
		self:Finale()

		return
	end

	if self._enhance then
		self._weapon:SetCardPuzzleDamageEnhance((var_0_2.parseFormula(self._enhance, self:GetCardPuzzleComponent():GetAttrManager())))
	end

	self._weapon:updateMovementInfo()

	local var_3_2 = self:GetTarget()

	if #var_3_2 > 0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_2) do
			self._weapon:SingleFire(iter_3_1, self._emitter, var_3_1)
		end
	else
		self._weapon:SingleFire(nil, self._emitter, var_3_1)
	end

	return
end

function BattleCardPuzzleSkillFire:Clear()
	BattleCardPuzzleSkillFire.super.Clear(self)

	if self._weapon then
		if not self._weapon:GetHost():IsAlive() then
			self._weapon:Clear()
		end
	end

	return
end

function BattleCardPuzzleSkillFire:Interrupt()
	BattleCardPuzzleSkillFire.super.Interrupt(self)

	if self._weapon then
		self._weapon:Cease()
		self._weapon:Clear()
	end

	return
end

return
