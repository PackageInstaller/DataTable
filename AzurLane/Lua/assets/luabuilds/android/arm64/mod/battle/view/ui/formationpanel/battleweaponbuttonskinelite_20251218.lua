ys = ys or {}

local var_0_0 = class("BattleWeaponButtonSkinElite_20251218", ys.Battle.BattleWeaponButtonSkinElite_20250520)

ys.Battle.BattleWeaponButtonSkinElite_20251218 = var_0_0
var_0_0.__name = "BattleWeaponButtonSkinElite_20251218"

function var_0_0.OnTotalChange(arg_1_0, arg_1_1)
	if arg_1_0._progressInfo:GetTotal() <= 0 then
		arg_1_0._block:SetActive(true)

		arg_1_0._progressBar.fillAmount = 0
		arg_1_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 0
		arg_1_0._text:GetComponent(typeof(Text)).text = "0/0"

		arg_1_0:SetControllerActive(false)
		SetActive(arg_1_0._glowEff, false)
		arg_1_0:OnUnfill()
		arg_1_0:OnUnSelect()
		SetActive(arg_1_0._gizmos1, false)
		SetActive(arg_1_0._gizmosXue, false)
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
	SetActive(arg_2_0._gizmosXue, arg_2_0._progressInfo:GetCount() > 0)

	return
end

function var_0_0.SetToCombatUIPreview(arg_3_0, arg_3_1)
	if arg_3_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
		SetActive(arg_3_0._filled, true)
		SetActive(arg_3_0._unfill, false)

		arg_3_0._progressBar.fillAmount = 1
		arg_3_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 1
		arg_3_0._countTxt.text = "1/1"

		if arg_3_0._gizmos1 then
			SetActive(arg_3_0._gizmos1, true)
			SetActive(arg_3_0._gizmosXue, true)
		end

		SetActive(arg_3_0._glowEff, true)
		quickCheckAndPlayAnimator(arg_3_0._skin, "weapon_button_progress_filled")
	else
		SetActive(arg_3_0._unfill, true)
		SetActive(arg_3_0._filled, false)

		arg_3_0._progressBar.fillAmount = 0
		arg_3_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 0
		arg_3_0._countTxt.text = "0/0"

		SetActive(arg_3_0._glowEff, false)

		if arg_3_0._gizmos1 then
			SetActive(arg_3_0._gizmos1, false)
			SetActive(arg_3_0._gizmosXue, false)
		end
	end

	return
end

function var_0_0.updateProgressBar(arg_4_0)
	local var_4_0 = arg_4_0._progressInfo:GetCurrent() / arg_4_0._progressInfo:GetMax()

	arg_4_0._progressBar.fillAmount = var_4_0
	arg_4_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = arg_4_0._progressInfo.GetCount and arg_4_0._progressInfo:GetCount() > 0 and 1 or var_4_0

	return
end

return
