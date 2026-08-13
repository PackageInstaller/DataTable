ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleWeaponButtonSkinElite_20250520", var_0.Battle.BattleWeaponButtonSkinNormal_20250227)

var_0.Battle.BattleWeaponButtonSkinElite_20250520 = var_0_1
var_0_1.__name = "BattleWeaponButtonSkinElite_20250520"

function var_0_1.OnTotalChange(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._progressInfo

	if var_2.GetTotal(var_1_0) <= 0 then
		local var_1_1 = arg_1_0._block

		var_2.SetActive(var_1_1, true)

		arg_1_0._progressBar.fillAmount = 0

		local var_1_2 = arg_1_0._bgEff
		local var_1_3 = var_2.GetComponent

		typeof = var_5
		CanvasGroup = var_1_10007
		var_1_3(var_1_2, var_5(var_1_10007)).alpha = 1

		local var_1_4 = arg_1_0._text
		local var_1_5 = var_2.GetComponent

		typeof = var_5
		Text = var_1_10007
		var_1_5(var_1_4, var_5(var_1_10007)).text = "0/0"

		arg_1_0:SetControllerActive(false)

		SetActive = var_2

		var_2(arg_1_0._glowEff, false)
		arg_1_0:OnUnfill()
		arg_1_0:OnUnSelect()
	else
		local var_1_6 = arg_1_0._progressInfo
		local var_1_7 = var_2.GetTotal(var_1_6)
		local var_1_8 = arg_1_0._progressInfo

		if var_1_7 == var_3.GetCount(var_1_8) then
			SetActive = var_1_7

			var_1_7(arg_1_0._glowEff, true)
		end

		arg_1_0:OnCountChange()
		arg_1_0:SetControllerActive(true)

		if arg_1_1 and arg_1_1.Data.index and var_2 == 1 then
			arg_1_0:OnUnSelect()
		end
	end

	return
end

function var_0_1.OnCountChange(arg_2_0)
	var_0_1.super.OnCountChange(arg_2_0)

	SetActive = var_1

	local var_2_0 = arg_2_0._gizmos1
	local var_2_1 = arg_2_0._progressInfo

	var_1(var_2_0, var_4.GetCount(var_2_1) > 0)

	return
end

function var_0_1.OnOverLoadChange(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._progressInfo

	if var_2.IsOverLoad(var_3_0) then
		local var_3_1 = arg_3_0._block

		var_2.SetActive(var_3_1, true)
		arg_3_0:OnUnfill()
	else
		local var_3_2 = arg_3_0._block

		var_2.SetActive(var_3_2, false)
		arg_3_0:OnFilled()
	end

	local var_3_3 = arg_3_0._progressInfo
	local var_3_4 = var_2.GetCount(var_3_3)

	if 1 <= var_3_4 and arg_3_1 and arg_3_1.Data and arg_3_1.Data.preCast then
		if var_2 == 0 then
			quickCheckAndPlayAnimator = var_3

			var_3(arg_3_0._skin, "weapon_button_progress_filled")
		elseif 0 < var_2 then
			quickCheckAndPlayAnimator = var_3

			var_3(arg_3_0._skin, "weapon_button_progress_charge")
		end
	end

	if arg_3_1 and arg_3_1.Data and arg_3_1.Data.postCast then
		quickCheckAndPlayAnimator = var_2

		var_2(arg_3_0._skin, "weapon_button_progress_use")
	end

	local var_3_5 = arg_3_0._progressInfo

	if var_2.GetTotal(var_3_5) > 0 then
		arg_3_0:updateProgressBar()
	end

	return
end

return
