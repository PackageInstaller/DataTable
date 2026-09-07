ys = ys or {}

local BattleWeaponButtonSkinElite_20260226 = class("BattleWeaponButtonSkinElite_20260226", ys.Battle.BattleWeaponButtonSkinElite_20250520)

ys.Battle.BattleWeaponButtonSkinElite_20260226 = BattleWeaponButtonSkinElite_20260226
BattleWeaponButtonSkinElite_20260226.__name = "BattleWeaponButtonSkinElite_20260226"

function BattleWeaponButtonSkinElite_20260226:ConfigSkin(arg_1_1)
	BattleWeaponButtonSkinElite_20260226.super.ConfigSkin(self, arg_1_1)

	self._books = self._selected:Find("usdfx/fx/up/book/book/book1")
	self._bookList = {}

	for iter_1_0 = 1, 4 do
		table.insert(self._bookList, self._books:Find("text_" .. iter_1_0))
	end

	return
end

function BattleWeaponButtonSkinElite_20260226:OnCountChange()
	BattleWeaponButtonSkinElite_20260226.super.OnCountChange(self)
	SetActive(self._gizmos1, self._progressInfo:GetCount() > 0)
	SetActive(self._gizmosXue, self._progressInfo:GetCount() > 0)

	return
end

function BattleWeaponButtonSkinElite_20260226:SetToCombatUIPreview(arg_3_1)
	if arg_3_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
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

function BattleWeaponButtonSkinElite_20260226:OnOverLoadChange(arg_4_1)
	if arg_4_1 and arg_4_1.Data and arg_4_1.Data.postCast then
		local var_4_0 = math.random(4)

		for iter_4_0, iter_4_1 in ipairs(self._bookList) do
			SetActive(iter_4_1, iter_4_0 == var_4_0)
		end
	end

	BattleWeaponButtonSkinElite_20260226.super.OnOverLoadChange(self, arg_4_1)

	return
end

function BattleWeaponButtonSkinElite_20260226:updateProgressBar()
	local var_5_0 = self._progressInfo:GetCurrent() / self._progressInfo:GetMax()

	self._progressBar.fillAmount = var_5_0

	if self._bgEff then
		self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = self._progressInfo.GetCount and self._progressInfo:GetCount() > 0 and 0 or 1 - var_5_0
	end

	return
end

return
