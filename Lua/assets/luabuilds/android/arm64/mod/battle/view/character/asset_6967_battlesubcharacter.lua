ys = ys or {}

local BattleSubCharacter = class("BattleSubCharacter", ys.Battle.BattlePlayerCharacter)

ys.Battle.BattleSubCharacter = BattleSubCharacter
BattleSubCharacter.__name = "BattleSubCharacter"

function BattleSubCharacter:Ctor()
	BattleSubCharacter.super.Ctor(self)

	return
end

function BattleSubCharacter:AddArrowBar(arg_2_1)
	BattleSubCharacter.super.AddArrowBar(self, arg_2_1)

	self._vectorOxygenSlider = self._arrowBarTf:Find("submarine/oxygenBar/oxygen"):GetComponent(typeof(Slider))
	self._vectorOxygenSlider.value = 1
	self._vectorAmmoCount = self._arrowBarTf:Find("submarine/Count/CountText"):GetComponent(typeof(Text))

	local var_2_0 = #self._unitData:GetTorpedoList()

	self._vectorAmmoCount.text = var_2_0 .. "/" .. var_2_0

	return
end

function BattleSubCharacter:Update()
	BattleSubCharacter.super.Update(self)

	if not self._inViewArea then
		self:updateOxygenVector()
	end

	return
end

function BattleSubCharacter:updateOxygenVector()
	self._vectorOxygenSlider.value = self._unitData:GetOxygenProgress()

	return
end

function BattleSubCharacter:onTorpedoWeaponFire(arg_5_1)
	BattleSubCharacter.super.onTorpedoWeaponFire(self, arg_5_1)

	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(self._unitData:GetTorpedoList()) do
		if iter_5_1:GetCurrentState() == iter_5_1.STATE_READY then
			var_5_0 = var_5_0 + 1
		end
	end

	self._vectorAmmoCount.text = var_5_0 .. "/" .. #self._unitData:GetTorpedoList()

	return
end

return
