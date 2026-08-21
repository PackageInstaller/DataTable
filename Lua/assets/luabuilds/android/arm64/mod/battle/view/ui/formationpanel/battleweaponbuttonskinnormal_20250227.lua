ys = ys or {}

local var_0_0 = class("BattleWeaponButtonSkinNormal_20250227", ys.Battle.BattleWeaponButton)

ys.Battle.BattleWeaponButtonSkinNormal_20250227 = var_0_0
var_0_0.__name = "BattleWeaponButtonSkinNormal_20250227"

function var_0_0.OnTotalChange(arg_1_0, arg_1_1)
	if arg_1_0._progressInfo:GetTotal() <= 0 then
		arg_1_0._block:SetActive(true)

		arg_1_0._progressBar.fillAmount = 0
		arg_1_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 1
		arg_1_0._text:GetComponent(typeof(Text)).text = "0/0"

		arg_1_0:SetControllerActive(false)
		arg_1_0:OnUnfill()
		arg_1_0:OnUnSelect()
	else
		if arg_1_0._progressInfo:GetTotal() == arg_1_0._progressInfo:GetCount() then
			SetActive(arg_1_0._filled:Find("gizmos"))
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

function var_0_0.ConfigSkin(arg_2_0, arg_2_1)
	var_0_0.super.ConfigSkin(arg_2_0, arg_2_1)

	arg_2_0._glowEff = arg_2_0._filled:Find("gizmos")

	return
end

function var_0_0.OnCountChange(arg_3_0)
	var_0_0.super.OnCountChange(arg_3_0)
	SetActive(arg_3_0._glowEff, arg_3_0._progressInfo:GetTotal() == arg_3_0._progressInfo:GetCount())

	return
end

function var_0_0.SetToCombatUIPreview(arg_4_0, arg_4_1)
	if arg_4_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
		SetActive(arg_4_0._filled, true)
		SetActive(arg_4_0._unfill, false)

		arg_4_0._progressBar.fillAmount = 1
		arg_4_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 0
		arg_4_0._countTxt.text = "1/1"

		if arg_4_0._gizmos1 then
			SetActive(arg_4_0._gizmos1, true)
			SetActive(arg_4_0._gizmosXue, true)
		end

		SetActive(arg_4_0._glowEff, true)
		quickCheckAndPlayAnimator(arg_4_0._skin, "weapon_button_progress_filled")
	else
		SetActive(arg_4_0._unfill, true)
		SetActive(arg_4_0._filled, false)

		arg_4_0._progressBar.fillAmount = 0
		arg_4_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 1
		arg_4_0._countTxt.text = "0/0"

		SetActive(arg_4_0._glowEff, false)

		if arg_4_0._gizmos1 then
			SetActive(arg_4_0._gizmos1, false)
			SetActive(arg_4_0._gizmosXue, false)
		end
	end

	return
end

function var_0_0.updateProgressBar(arg_5_0)
	local var_5_0 = arg_5_0._progressInfo:GetCurrent() / arg_5_0._progressInfo:GetMax()

	arg_5_0._progressBar.fillAmount = var_5_0
	arg_5_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = arg_5_0._progressInfo.GetCount and arg_5_0._progressInfo:GetCount() > 0 and 0 or 1 - var_5_0

	return
end

return
