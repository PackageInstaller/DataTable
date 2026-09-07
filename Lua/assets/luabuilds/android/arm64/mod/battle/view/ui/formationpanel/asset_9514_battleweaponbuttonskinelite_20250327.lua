ys = ys or {}

local BattleWeaponButtonSkinElite_20250327 = class("BattleWeaponButtonSkinElite_20250327", ys.Battle.BattleWeaponButton)

ys.Battle.BattleWeaponButtonSkinElite_20250327 = BattleWeaponButtonSkinElite_20250327
BattleWeaponButtonSkinElite_20250327.__name = "BattleWeaponButtonSkinElite_20250327"

function BattleWeaponButtonSkinElite_20250327:OnTotalChange(arg_1_1)
	if self._progressInfo:GetTotal() <= 0 then
		self._block:SetActive(true)

		self._progressBar.fillAmount = 0
		self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 1
		self._text:GetComponent(typeof(Text)).text = "0/0"

		self:SetControllerActive(false)
		SetActive(self._glowEff, false)
		self:OnUnfill()
		self:OnUnSelect()
	else
		if self._progressInfo:GetTotal() == self._progressInfo:GetCount() then
			SetActive(self._glowEff, true)
		end

		self:OnCountChange()
		self:SetControllerActive(true)

		if arg_1_1 then
			if arg_1_1.Data.index and arg_1_1.Data.index == 1 then
				self:OnUnSelect()
			end
		end
	end

	return
end

function BattleWeaponButtonSkinElite_20250327:ConfigSkin(arg_2_1)
	BattleWeaponButtonSkinElite_20250327.super.ConfigSkin(self, arg_2_1)

	self._glowEff = self._btn:Find("gizmos_1")

	return
end

function BattleWeaponButtonSkinElite_20250327:OnCountChange()
	BattleWeaponButtonSkinElite_20250327.super.OnCountChange(self)
	SetActive(self._glowEff, self._progressInfo:GetCount() > 0)

	return
end

function BattleWeaponButtonSkinElite_20250327:SetToCombatUIPreview(arg_4_1)
	if arg_4_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
		SetActive(self._filled, true)
		SetActive(self._unfill, false)

		self._progressBar.fillAmount = 1
		self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 0
		self._countTxt.text = "1/1"

		if self._gizmos1 then
			SetActive(self._gizmos1, true)
			SetActive(self._gizmosXue, true)
		end

		SetActive(self._glowEff, true)
		quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_filled")
	else
		SetActive(self._unfill, true)
		SetActive(self._filled, false)

		self._progressBar.fillAmount = 0
		self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 1
		self._countTxt.text = "0/0"

		SetActive(self._glowEff, false)

		if self._gizmos1 then
			SetActive(self._gizmos1, false)
			SetActive(self._gizmosXue, false)
		end
	end

	return
end

function BattleWeaponButtonSkinElite_20250327:updateProgressBar()
	local var_5_0 = self._progressInfo:GetCurrent() / self._progressInfo:GetMax()

	self._progressBar.fillAmount = var_5_0
	self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = self._progressInfo.GetCount and self._progressInfo:GetCount() > 0 and 0 or 1 - var_5_0

	return
end

function BattleWeaponButtonSkinElite_20250327:OnOverLoadChange(arg_6_1)
	if self._progressInfo:IsOverLoad() then
		self._block:SetActive(true)
		self:OnUnfill()
	else
		self._block:SetActive(false)
		self:OnFilled()
	end

	if self._progressInfo:GetCount() >= 1 and arg_6_1 and arg_6_1.Data then
		if arg_6_1.Data.preCast then
			if arg_6_1.Data.preCast == 0 then
				quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_filled")
			elseif arg_6_1.Data.preCast > 0 then
				quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_charge")
			end
		end
	end

	if arg_6_1 and arg_6_1.Data and arg_6_1.Data.postCast then
		quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_use")
	end

	if self._progressInfo:GetTotal() > 0 then
		self:updateProgressBar()
	end

	return
end

return
