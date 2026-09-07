ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent

ys.Battle.BattleEnemyCharacter = class("BattleEnemyCharacter", ys.Battle.BattleCharacter)
ys.Battle.BattleEnemyCharacter.__name = "BattleEnemyCharacter"

local var_0_1 = ys.Battle.BattleEnemyCharacter

function ys.Battle.BattleEnemyCharacter.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false
	arg_1_0._prefabPos = Vector3(0, 0, 0)

	return
end

function ys.Battle.BattleEnemyCharacter:RegisterWeaponListener(arg_2_1)
	var_0_1.super.RegisterWeaponListener(self, arg_2_1)
	arg_2_1:RegisterEventListener(self, var_0_0.WEAPON_PRE_CAST, self.onWeaponPreCast)
	arg_2_1:RegisterEventListener(self, var_0_0.WEAPON_PRE_CAST_FINISH, self.onWeaponPrecastFinish)
	arg_2_1:RegisterEventListener(self, var_0_0.WEAPON_INTERRUPT, self.onWeaponInterrupted)

	return
end

function ys.Battle.BattleEnemyCharacter.UnregisterWeaponListener(arg_3_0, arg_3_1)
	var_0_1.super.UnregisterWeaponListener(arg_3_0, arg_3_1)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_0.WEAPON_PRE_CAST)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_0.WEAPON_PRE_CAST_FINISH)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_0.WEAPON_INTERRUPT)

	return
end

function ys.Battle.BattleEnemyCharacter:Update()
	var_0_1.super.Update(self)
	self:UpdatePosition()
	self:UpdateMatrix()
	self:UpdateArrowBarPosition()
	self:UpdateArrowBarRotation()

	if self._vigilantBar then
		self:UpdateVigilantBarPosition()
		self._vigilantBar:UpdateVigilantProgress()
	end

	return
end

function ys.Battle.BattleEnemyCharacter:Dispose()
	if self._vigilantBar then
		self._vigilantBar:Dispose()

		self._vigilantBar = nil
	end

	self:AddShaderColor()
	self._factory:GetArrowPool():DestroyObj(self._arrowBar)
	var_0_1.super.Dispose(self)

	return
end

function ys.Battle.BattleEnemyCharacter:GetModleID()
	return self._unitData:GetTemplate().prefab
end

function ys.Battle.BattleEnemyCharacter:onWeaponPreCast(arg_7_1)
	self:AddFX(arg_7_1.Data.fx, true)

	self._preCastBound = arg_7_1.Data.isBound

	return
end

function ys.Battle.BattleEnemyCharacter:onWeaponPrecastFinish(arg_8_1)
	self:RemoveCacheFX(arg_8_1.Data.fx)

	self._preCastBound = false

	return
end

function ys.Battle.BattleEnemyCharacter:OnUpdateHP(arg_9_1)
	var_0_1.super.OnUpdateHP(self, arg_9_1)

	if arg_9_1.Data.dHP <= 0 then
		self:AddBlink(1, 1, 1, 0.1, 0.1, true)
	end

	return
end

function ys.Battle.BattleEnemyCharacter:AddModel(arg_10_1)
	var_0_1.super.AddModel(self, arg_10_1)

	self._hpBarOffset = Vector3(0, self._unitData:GetTemplate().hp_bar[2], 0)

	return
end

function ys.Battle.BattleEnemyCharacter:GetSpecificFXScale()
	return self._unitData:GetTemplate().specific_fx_scale
end

function ys.Battle.BattleEnemyCharacter:OnAnimatorTrigger()
	self._unitData:CharacterActionTriggerCallback()

	return
end

function ys.Battle.BattleEnemyCharacter:OnAnimatorEnd()
	self._unitData:CharacterActionEndCallback()

	return
end

function ys.Battle.BattleEnemyCharacter:OnAnimatorStart()
	self._unitData:CharacterActionStartCallback()

	return
end

function ys.Battle.BattleEnemyCharacter:UpdateAimBiasBar()
	var_0_1.super.UpdateAimBiasBar(self)

	if self._fogFx then
		local var_15_0 = self:GetUnitData():GetAimBias():GetCurrentRate()

		self._fogFx.transform.localScale = Vector3(var_15_0, var_15_0, 1)
	end

	return
end

function ys.Battle.BattleEnemyCharacter:getCharacterPos()
	local var_16_0 = self:GetUnitData():GetTemplate().prefab_offset

	self._prefabPos:Set(self._characterPos.x + var_16_0[1], self._characterPos.y + var_16_0[2], self._characterPos.z + var_16_0[3])

	return self._prefabPos
end

return
