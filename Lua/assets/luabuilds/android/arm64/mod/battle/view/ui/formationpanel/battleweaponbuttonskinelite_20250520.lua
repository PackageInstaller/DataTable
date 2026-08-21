ys = ys or {}

local var_0_0 = class("BattleWeaponButtonSkinElite_20250520", ys.Battle.BattleWeaponButtonSkinNormal_20250227)

ys.Battle.BattleWeaponButtonSkinElite_20250520 = var_0_0
var_0_0.__name = "BattleWeaponButtonSkinElite_20250520"

function var_0_0.OnTotalChange(arg_1_0, arg_1_1)
	if arg_1_0._progressInfo:GetTotal() <= 0 then
		arg_1_0._block:SetActive(true)

		arg_1_0._progressBar.fillAmount = 0
		arg_1_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 1
		arg_1_0._text:GetComponent(typeof(Text)).text = "0/0"

		arg_1_0:SetControllerActive(false)
		SetActive(arg_1_0._glowEff, false)
		arg_1_0:OnUnfill()
		arg_1_0:OnUnSelect()
	else
		if arg_1_0._progressInfo:GetTotal() == arg_1_0._progressInfo:GetCount() then
			SetActive(arg_1_0._glowEff, true)
		end

		arg_1_0:OnCountChange()
		arg_1_0:SetControllerActive(true)

		if arg_1_1 then
			if arg_1_1.Data.index and arg_1_1.Data.index == 1 then
				arg_1_0:OnUnSelect()
			end
		end
	end

	return
end

function var_0_0.OnCountChange(arg_2_0)
	var_0_0.super.OnCountChange(arg_2_0)
	SetActive(arg_2_0._gizmos1, arg_2_0._progressInfo:GetCount() > 0)

	return
end

function var_0_0.OnOverLoadChange(arg_3_0, arg_3_1)
	if arg_3_0._progressInfo:IsOverLoad() then
		arg_3_0._block:SetActive(true)
		arg_3_0:OnUnfill()
	else
		arg_3_0._block:SetActive(false)
		arg_3_0:OnFilled()
	end

	if arg_3_0._progressInfo:GetCount() >= 1 and arg_3_1 and arg_3_1.Data then
		if arg_3_1.Data.preCast then
			if arg_3_1.Data.preCast == 0 then
				quickCheckAndPlayAnimator(arg_3_0._skin, "weapon_button_progress_filled")
			elseif arg_3_1.Data.preCast > 0 then
				quickCheckAndPlayAnimator(arg_3_0._skin, "weapon_button_progress_charge")
			end
		end
	end

	if arg_3_1 and arg_3_1.Data and arg_3_1.Data.postCast then
		quickCheckAndPlayAnimator(arg_3_0._skin, "weapon_button_progress_use")
	end

	if arg_3_0._progressInfo:GetTotal() > 0 then
		arg_3_0:updateProgressBar()
	end

	return
end

return
