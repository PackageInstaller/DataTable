ys = ys or {}

local BattleSubmarineButton = class("BattleSubmarineButton", ys.Battle.BattleWeaponButton)

ys.Battle.BattleSubmarineButton = BattleSubmarineButton
BattleSubmarineButton.__name = "BattleSubmarineButton"

function BattleSubmarineButton:Ctor()
	BattleSubmarineButton.super.Ctor(self)

	return
end

function BattleSubmarineButton:OnCountChange()
	local var_2_0 = self._progressInfo:GetTotal()

	self._countTxt.text = string.format("%d", (self._progressInfo:GetCount()))

	return
end

function BattleSubmarineButton:ConfigSkin(arg_3_1)
	BattleSubmarineButton.super.ConfigSkin(self, arg_3_1)
	self._progress.gameObject:SetActive(false)
	self._filledEffect.gameObject:SetActive(false)

	return
end

function BattleSubmarineButton:ConfigCallback(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	BattleSubmarineButton.super.ConfigCallback(self, arg_4_1, function()
		arg_4_2()

		return
	end, arg_4_3, arg_4_4)

	return
end

function BattleSubmarineButton:OnOverLoadChange(arg_6_1)
	BattleSubmarineButton.super.OnOverLoadChange(self, arg_6_1)

	if self._progressInfo:GetTotal() == self._progressInfo:GetCount() then
		quickCheckAndPlayAnimator(self._skin, "weapon_button_into")
	elseif self._progressInfo:GetCount() == 0 then
		quickCheckAndPlayAnimator(self._skin, "weapon_button_use")
	end

	return
end

function BattleSubmarineButton:Update()
	return
end

function BattleSubmarineButton:updateProgressBar()
	return
end

function BattleSubmarineButton:OnfilledEffect()
	return
end

return
