ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleMinionCharacter = class("BattleMinionCharacter", ys.Battle.BattleCharacter)
ys.Battle.BattleMinionCharacter.__name = "BattleMinionCharacter"

local var_0_3 = ys.Battle.BattleMinionCharacter

function ys.Battle.BattleMinionCharacter.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false

	return
end

function ys.Battle.BattleMinionCharacter:RegisterWeaponListener(arg_2_1)
	var_0_3.super.RegisterWeaponListener(self, arg_2_1)
	arg_2_1:RegisterEventListener(self, var_0_2.WEAPON_PRE_CAST, self.onWeaponPreCast)
	arg_2_1:RegisterEventListener(self, var_0_2.WEAPON_PRE_CAST_FINISH, self.onWeaponPrecastFinish)

	return
end

function ys.Battle.BattleMinionCharacter.UnregisterWeaponListener(arg_3_0, arg_3_1)
	var_0_3.super.UnregisterWeaponListener(arg_3_0, arg_3_1)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_2.WEAPON_PRE_CAST)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_2.WEAPON_PRE_CAST_FINISH)

	return
end

function ys.Battle.BattleMinionCharacter:Update()
	var_0_3.super.Update(self)
	self:UpdatePosition()
	self:UpdateMatrix()

	return
end

function ys.Battle.BattleMinionCharacter:updateComponentVisible()
	if self._unitData:GetIFF() ~= var_0_1.FOE_CODE then
		return
	end

	local var_5_0 = self._unitData:GetExposed() and (not self._unitData:GetDiveInvisible() or not not self._unitData:GetDiveDetected())

	SetActive(self._HPBarTf, var_5_0)
	SetActive(self._FXAttachPoint, var_5_0)

	return
end

function ys.Battle.BattleMinionCharacter:updateComponentDiveInvisible()
	local var_6_2 = not not (self._unitData:GetDiveDetected() and self._unitData:GetIFF() == var_0_1.FOE_CODE or not self._unitData:GetDiveInvisible())

	SetActive(self._HPBarTf, (self._unitData:GetDiveDetected() and self._unitData:GetIFF() == var_0_1.FOE_CODE or not self._unitData:GetDiveInvisible()) and true or false)
	SetActive(self._FXAttachPoint, var_6_2)

	return
end

function ys.Battle.BattleMinionCharacter:Dispose()
	self:AddShaderColor()
	var_0_3.super.Dispose(self)

	return
end

function ys.Battle.BattleMinionCharacter:GetModleID()
	return self._unitData:GetTemplate().prefab
end

function ys.Battle.BattleMinionCharacter:onWeaponPreCast(arg_9_1)
	self:AddFX(arg_9_1.Data.fx, true)

	self._preCastBound = arg_9_1.Data.isBound

	return
end

function ys.Battle.BattleMinionCharacter:onWeaponPrecastFinish(arg_10_1)
	self:RemoveCacheFX(arg_10_1.Data.fx)

	self._preCastBound = false

	return
end

function ys.Battle.BattleMinionCharacter:OnUpdateHP(arg_11_1)
	var_0_3.super.OnUpdateHP(self, arg_11_1)

	if arg_11_1.Data.dHP <= 0 then
		self:AddBlink(1, 1, 1, 0.1, 0.1, true)
	end

	return
end

function ys.Battle.BattleMinionCharacter:AddModel(arg_12_1)
	var_0_3.super.AddModel(self, arg_12_1)

	self._hpBarOffset = Vector3(0, self._unitData:GetTemplate().hp_bar[2], 0)

	return
end

function ys.Battle.BattleMinionCharacter:GetSpecificFXScale()
	return self._unitData:GetTemplate().specific_fx_scale
end

function ys.Battle.BattleMinionCharacter:OnAnimatorTrigger()
	self._unitData:CharacterActionTriggerCallback()

	return
end

function ys.Battle.BattleMinionCharacter:OnAnimatorEnd()
	self._unitData:CharacterActionEndCallback()

	return
end

function ys.Battle.BattleMinionCharacter:OnAnimatorStart()
	self._unitData:CharacterActionStartCallback()

	return
end

function ys.Battle.BattleMinionCharacter:UpdateAimBiasBar()
	var_0_3.super.UpdateAimBiasBar(self)

	if self._fogFx then
		local var_17_0 = self:GetUnitData():GetAimBias():GetCurrentRate()

		self._fogFx.transform.localScale = Vector3(var_17_0, var_17_0, 1)
	end

	return
end

return
