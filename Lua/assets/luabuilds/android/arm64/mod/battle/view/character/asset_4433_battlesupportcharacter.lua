ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleSupportCharacter = class("BattleSupportCharacter", ys.Battle.BattleCharacter)
ys.Battle.BattleSupportCharacter.__name = "BattleSupportCharacter"

local var_0_3 = ys.Battle.BattleSupportCharacter

function ys.Battle.BattleSupportCharacter.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false

	return
end

function ys.Battle.BattleSupportCharacter:RegisterWeaponListener(arg_2_1)
	var_0_3.super.RegisterWeaponListener(self, arg_2_1)
	arg_2_1:RegisterEventListener(self, var_0_2.WEAPON_PRE_CAST, self.onWeaponPreCast)
	arg_2_1:RegisterEventListener(self, var_0_2.WEAPON_PRE_CAST_FINISH, self.onWeaponPrecastFinish)

	return
end

function ys.Battle.BattleSupportCharacter.UnregisterWeaponListener(arg_3_0, arg_3_1)
	var_0_3.super.UnregisterWeaponListener(arg_3_0, arg_3_1)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_2.WEAPON_PRE_CAST)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_2.WEAPON_PRE_CAST_FINISH)

	return
end

function ys.Battle.BattleSupportCharacter.Update(arg_4_0)
	return
end

function ys.Battle.BattleSupportCharacter.UpdateHPBarPosition(arg_5_0)
	return
end

function ys.Battle.BattleSupportCharacter:SpawnBullet(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._bulletFactoryList[arg_6_1:GetTemplate().type]:CreateBullet(self._tf, arg_6_1, self._unitData:GetPosition(), arg_6_3, self._unitData:GetDirection())

	return
end

function ys.Battle.BattleSupportCharacter.AddFX(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4 then
		arg_7_4()
	end

	return
end

function ys.Battle.BattleSupportCharacter:updateComponentVisible()
	if self._unitData:GetIFF() ~= var_0_1.FOE_CODE then
		return
	end

	local var_8_0 = self._unitData:GetExposed() and (not self._unitData:GetDiveInvisible() or not not self._unitData:GetDiveDetected())

	SetActive(self._HPBarTf, var_8_0)
	SetActive(self._FXAttachPoint, var_8_0)

	return
end

function ys.Battle.BattleSupportCharacter:updateComponentDiveInvisible()
	local var_9_2 = not not (self._unitData:GetDiveDetected() and self._unitData:GetIFF() == var_0_1.FOE_CODE or not self._unitData:GetDiveInvisible())

	SetActive(self._HPBarTf, (self._unitData:GetDiveDetected() and self._unitData:GetIFF() == var_0_1.FOE_CODE or not self._unitData:GetDiveInvisible()) and true or false)
	SetActive(self._FXAttachPoint, var_9_2)

	return
end

function ys.Battle.BattleSupportCharacter:Dispose()
	self:AddShaderColor()
	var_0_3.super.Dispose(self)

	return
end

function ys.Battle.BattleSupportCharacter:GetModleID()
	return self._unitData:GetTemplate().prefab
end

function ys.Battle.BattleSupportCharacter:OnAnimatorTrigger()
	self._unitData:CharacterActionTriggerCallback()

	return
end

function ys.Battle.BattleSupportCharacter:OnAnimatorEnd()
	self._unitData:CharacterActionEndCallback()

	return
end

function ys.Battle.BattleSupportCharacter:OnAnimatorStart()
	self._unitData:CharacterActionStartCallback()

	return
end

function ys.Battle.BattleSupportCharacter:UpdateAimBiasBar()
	var_0_3.super.UpdateAimBiasBar(self)

	if self._fogFx then
		local var_15_0 = self:GetUnitData():GetAimBias():GetCurrentRate()

		self._fogFx.transform.localScale = Vector3(var_15_0, var_15_0, 1)
	end

	return
end

return
