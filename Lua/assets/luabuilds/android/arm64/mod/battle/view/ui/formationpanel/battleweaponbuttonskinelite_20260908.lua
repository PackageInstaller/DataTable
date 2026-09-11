ys = ys or {}

local BattleWeaponButtonSkinElite_20260908 = class("BattleWeaponButtonSkinElite_20260908", ys.Battle.BattleWeaponButtonSkinElite_20251218)

ys.Battle.BattleWeaponButtonSkinElite_20260908 = BattleWeaponButtonSkinElite_20260908
BattleWeaponButtonSkinElite_20260908.__name = "BattleWeaponButtonSkinElite_20260908"

function BattleWeaponButtonSkinElite_20260908:updateProgressBar()
	local var_1_0 = self._progressInfo:GetCurrent() / self._progressInfo:GetMax()

	self._progressBar.fillAmount = var_1_0
	self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = self._progressInfo.GetCount and self._progressInfo:GetCount() > 0 and 1 or var_1_0

	return
end

return BattleWeaponButtonSkinElite_20260908
