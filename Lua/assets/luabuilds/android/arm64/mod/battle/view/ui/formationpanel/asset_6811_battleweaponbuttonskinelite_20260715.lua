ys = ys or {}

local BattleWeaponButtonSkinElite_20260715 = class("BattleWeaponButtonSkinElite_20260715", ys.Battle.BattleWeaponButtonSkinElite_20250327)

ys.Battle.BattleWeaponButtonSkinElite_20260715 = BattleWeaponButtonSkinElite_20260715
BattleWeaponButtonSkinElite_20260715.__name = "BattleWeaponButtonSkinElite_20260715"

function BattleWeaponButtonSkinElite_20260715:OnTotalChange(arg_1_1)
	BattleWeaponButtonSkinElite_20260715.super.OnTotalChange(self, arg_1_1)
	SetActive(self._glowEff, self._progressInfo:GetTotal() > 0)
	SetActive(self._gizmosXue, self._progressInfo:GetTotal() > 0)

	return
end

function BattleWeaponButtonSkinElite_20260715:ConfigSkin(arg_2_1)
	BattleWeaponButtonSkinElite_20260715.super.ConfigSkin(self, arg_2_1)

	self._glowEff = self._btn:Find("gizmos_1")

	return
end

function BattleWeaponButtonSkinElite_20260715:OnCountChange()
	BattleWeaponButtonSkinElite_20260715.super.OnCountChange(self)
	SetActive(self._glowEff, self._progressInfo:GetCount() > 0)
	SetActive(self._gizmosXue, self._progressInfo:GetCount() > 0)

	return
end

function BattleWeaponButtonSkinElite_20260715:SetToCombatUIPreview(arg_4_1)
	if arg_4_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
		SetActive(self._filled, true)
		SetActive(self._unfill, false)

		self._progressBar.fillAmount = 1
		self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 1
		self._countTxt.text = "1/1"

		SetActive(self._glowEff, true)
		SetActive(self._gizmosXue, true)
		quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_filled")
	else
		SetActive(self._unfill, true)
		SetActive(self._filled, false)

		self._progressBar.fillAmount = 0
		self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 0
		self._countTxt.text = "0/0"

		SetActive(self._gizmos1, false)
		SetActive(self._gizmosXue, false)
	end

	return
end

function BattleWeaponButtonSkinElite_20260715:updateProgressBar()
	local var_5_0 = self._progressInfo:GetCurrent() / self._progressInfo:GetMax()

	self._progressBar.fillAmount = var_5_0
	self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = self._progressInfo.GetCount and self._progressInfo:GetCount() > 0 and 1 or var_5_0

	return
end

return
