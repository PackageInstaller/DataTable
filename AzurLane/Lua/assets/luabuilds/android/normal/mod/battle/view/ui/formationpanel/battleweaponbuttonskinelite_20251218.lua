ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleWeaponButtonSkinElite_20251218", var_0.Battle.BattleWeaponButtonSkinElite_20250520)

var_0.Battle.BattleWeaponButtonSkinElite_20251218 = var_0_1
var_0_1.__name = "BattleWeaponButtonSkinElite_20251218"

function var_0_1.OnTotalChange(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._progressInfo

	if var_2.GetTotal(var_1_0) <= 0 then
		local var_1_1 = arg_1_0._block

		var_2.SetActive(var_1_1, true)

		arg_1_0._progressBar.fillAmount = 0

		local var_1_2 = arg_1_0._bgEff
		local var_1_3 = var_2.GetComponent

		typeof = var_4
		CanvasGroup = var_1_10005
		var_1_3(var_1_2, var_4(var_1_10005)).alpha = 0

		local var_1_4 = arg_1_0._text
		local var_1_5 = var_2.GetComponent

		typeof = var_4
		Text = var_1_10005
		var_1_5(var_1_4, var_4(var_1_10005)).text = "0/0"

		arg_1_0:SetControllerActive(false)

		SetActive = var_2

		var_2(arg_1_0._glowEff, false)
		arg_1_0:OnUnfill()
		arg_1_0:OnUnSelect()

		SetActive = var_2

		var_2(arg_1_0._gizmos1, false)

		SetActive = var_2

		var_2(arg_1_0._gizmosXue, false)
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

	local var_2_0 = arg_2_0._gizmosXue
	local var_2_1 = arg_2_0._progressInfo

	var_1(var_2_0, var_3.GetCount(var_2_1) > 0)

	return
end

function var_0_1.SetToCombatUIPreview(arg_3_0, arg_3_1)
	CombatUIPreviewer = var_1_10002

	if arg_3_1 ~= var_1_10002.WeaponButtonPreviewMode.UNFILLED then
		SetActive = var_1_10004

		var_1_10004(arg_3_0._filled, true)

		SetActive = var_1_10004

		var_1_10004(arg_3_0._unfill, false)

		var_1_10004 = arg_3_0._progressBar
		var_1_10004.fillAmount = 1

		local var_3_0 = arg_3_0._bgEff

		var_1_10004 = var_1_10004.GetComponent
		typeof = var_6
		CanvasGroup = var_1_10007
		var_1_10004 = var_1_10004(var_3_0, var_6(var_1_10007))
		var_1_10004.alpha = 1
		var_1_10004 = arg_3_0._countTxt
		var_1_10004.text = "1/1"

		if arg_3_0._gizmos1 then
			SetActive = var_1_10004

			var_1_10004(arg_3_0._gizmos1, true)

			SetActive = var_1_10004

			var_1_10004(arg_3_0._gizmosXue, true)
		end

		SetActive = var_1_10004

		var_1_10004(arg_3_0._glowEff, true)

		quickCheckAndPlayAnimator = var_1_10004

		var_1_10004(arg_3_0._skin, "weapon_button_progress_filled")
	else
		SetActive = var_1_10004

		var_1_10004(arg_3_0._unfill, true)

		SetActive = var_1_10004

		var_1_10004(arg_3_0._filled, false)

		arg_3_0._progressBar.fillAmount = 0

		local var_3_1 = arg_3_0._bgEff
		local var_3_2 = var_4.GetComponent

		typeof = var_6
		CanvasGroup = var_1_10007
		var_3_2(var_3_1, var_6(var_1_10007)).alpha = 0

		local var_3_3 = arg_3_0._countTxt

		var_3_3.text = "0/0"
		SetActive = var_3_3

		var_3_3(arg_3_0._glowEff, false)

		if arg_3_0._gizmos1 then
			SetActive = var_4

			var_4(arg_3_0._gizmos1, false)

			SetActive = var_4

			var_4(arg_3_0._gizmosXue, false)
		end
	end

	return
end

function var_0_1.updateProgressBar(arg_4_0)
	local var_4_0 = arg_4_0._progressInfo
	local var_4_1 = var_1.GetCurrent(var_4_0)
	local var_4_2 = arg_4_0._progressInfo
	local var_4_3 = var_4_1 / var_2.GetMax(var_4_2)

	arg_4_0._progressBar.fillAmount = var_4_3

	if arg_4_0._progressInfo.GetCount then
		local var_4_4 = arg_4_0._progressInfo

		if var_2.GetCount(var_4_4) > 0 then
			local var_4_5 = arg_4_0._bgEff
			local var_4_6 = var_2.GetComponent

			typeof = var_1_10004
			CanvasGroup = var_1_10005
			var_4_6(var_4_5, var_1_10004(var_1_10005)).alpha = 1

			goto label_4_0
		end
	end

	do
		local var_4_7 = arg_4_0._bgEff
		local var_4_8 = var_2.GetComponent

		typeof = var_1_10004
		CanvasGroup = var_1_10005
		var_4_8(var_4_7, var_1_10004(var_1_10005)).alpha = var_4_3
	end

	::label_4_0::

	return
end

return
