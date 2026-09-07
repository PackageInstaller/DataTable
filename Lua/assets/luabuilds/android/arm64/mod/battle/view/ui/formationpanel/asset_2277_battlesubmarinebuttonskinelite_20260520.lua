ys = ys or {}

local BattleSubmarineButtonSkinElite_20260520 = class("BattleSubmarineButtonSkinElite_20260520", ys.Battle.BattleSubmarineButton)

ys.Battle.BattleSubmarineButtonSkinElite_20260520 = BattleSubmarineButtonSkinElite_20260520
BattleSubmarineButtonSkinElite_20260520.__name = "BattleSubmarineButtonSkinElite_20260520"

function BattleSubmarineButtonSkinElite_20260520:ConfigSkin(arg_1_1)
	BattleSubmarineButtonSkinElite_20260520.super.ConfigSkin(self, arg_1_1)

	self._unfill = self._icon:Find("unfill/unfill")
	self._unfillShade = self._icon:Find("unfill/unfill_1")

	return
end

function BattleSubmarineButtonSkinElite_20260520:OnFilled()
	BattleSubmarineButtonSkinElite_20260520.super.OnFilled(self)
	SetActive(self._unfillShade, false)

	return
end

function BattleSubmarineButtonSkinElite_20260520:OnUnfill()
	BattleSubmarineButtonSkinElite_20260520.super.OnUnfill(self)
	SetActive(self._unfillShade, true)

	return
end

function BattleSubmarineButtonSkinElite_20260520:SwitchIcon(arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = BattleSubmarineButtonSkinElite_20260520.super.SwitchIcon(self, arg_4_1, arg_4_2)

	setImageSprite(self._unfillShade, LoadSprite("ui/CombatUI" .. var_4_0 .. "_atlas", "weapon_unfill_" .. var_4_1))

	return
end

return
