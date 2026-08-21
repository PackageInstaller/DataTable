ys = ys or {}

local var_0_0 = class("BattleWeaponButtonSkinElite_20260715", ys.Battle.BattleWeaponButtonSkinElite_20250327)

ys.Battle.BattleWeaponButtonSkinElite_20260715 = var_0_0
var_0_0.__name = "BattleWeaponButtonSkinElite_20260715"

function var_0_0.OnTotalChange(arg_1_0, arg_1_1)
	var_0_0.super.OnTotalChange(arg_1_0, arg_1_1)
	SetActive(arg_1_0._glowEff, arg_1_0._progressInfo:GetTotal() > 0)
	SetActive(arg_1_0._gizmosXue, arg_1_0._progressInfo:GetTotal() > 0)

	return
end

function var_0_0.ConfigSkin(arg_2_0, arg_2_1)
	var_0_0.super.ConfigSkin(arg_2_0, arg_2_1)

	arg_2_0._glowEff = arg_2_0._btn:Find("gizmos_1")

	return
end

function var_0_0.OnCountChange(arg_3_0)
	var_0_0.super.OnCountChange(arg_3_0)
	SetActive(arg_3_0._glowEff, arg_3_0._progressInfo:GetCount() > 0)
	SetActive(arg_3_0._gizmosXue, arg_3_0._progressInfo:GetCount() > 0)

	return
end

function var_0_0.SetToCombatUIPreview(arg_4_0, arg_4_1)
	if arg_4_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
		SetActive(arg_4_0._filled, true)
		SetActive(arg_4_0._unfill, false)

		arg_4_0._progressBar.fillAmount = 1
		arg_4_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 1
		arg_4_0._countTxt.text = "1/1"

		SetActive(arg_4_0._glowEff, true)
		SetActive(arg_4_0._gizmosXue, true)
		quickCheckAndPlayAnimator(arg_4_0._skin, "weapon_button_progress_filled")
	else
		SetActive(arg_4_0._unfill, true)
		SetActive(arg_4_0._filled, false)

		arg_4_0._progressBar.fillAmount = 0
		arg_4_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 0
		arg_4_0._countTxt.text = "0/0"

		SetActive(arg_4_0._gizmos1, false)
		SetActive(arg_4_0._gizmosXue, false)
	end

	return
end

function var_0_0.updateProgressBar(arg_5_0)
	local var_5_0 = arg_5_0._progressInfo:GetCurrent() / arg_5_0._progressInfo:GetMax()

	arg_5_0._progressBar.fillAmount = var_5_0
	arg_5_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = arg_5_0._progressInfo.GetCount and arg_5_0._progressInfo:GetCount() > 0 and 1 or var_5_0

	return
end

return
