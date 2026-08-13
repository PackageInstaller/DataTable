ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleWeaponButtonSkinNormal_20250227", var_0.Battle.BattleWeaponButton)

var_0.Battle.BattleWeaponButtonSkinNormal_20250227 = var_0_1
var_0_1.__name = "BattleWeaponButtonSkinNormal_20250227"

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
		arg_1_0:OnUnfill()
		arg_1_0:OnUnSelect()
	else
		local var_1_6 = arg_1_0._progressInfo
		local var_1_7 = var_2.GetTotal(var_1_6)
		local var_1_8 = arg_1_0._progressInfo

		if var_1_7 == var_3.GetCount(var_1_8) then
			SetActive = var_1_7

			local var_1_9 = arg_1_0._filled

			var_1_7(var_4.Find(var_1_9, "gizmos"))
		end

		arg_1_0:OnCountChange()
		arg_1_0:SetControllerActive(true)

		if arg_1_1 and arg_1_1.Data.index and var_2 == 1 then
			arg_1_0:OnUnSelect()
		end
	end

	return
end

function var_0_1.ConfigSkin(arg_2_0, arg_2_1)
	var_0_1.super.ConfigSkin(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0._filled

	arg_2_0._glowEff = var_2.Find(var_2_0, "gizmos")

	return
end

function var_0_1.OnCountChange(arg_3_0)
	var_0_1.super.OnCountChange(arg_3_0)

	SetActive = var_1

	local var_3_0 = arg_3_0._glowEff
	local var_3_1 = arg_3_0._progressInfo
	local var_3_2 = var_4.GetTotal(var_3_1)
	local var_3_3 = arg_3_0._progressInfo

	var_1(var_3_0, var_3_2 == var_5.GetCount(var_3_3))

	return
end

function var_0_1.SetToCombatUIPreview(arg_4_0, arg_4_1)
	CombatUIPreviewer = var_1_10002

	if arg_4_1 ~= var_1_10002.WeaponButtonPreviewMode.UNFILLED then
		SetActive = var_1_10004

		var_1_10004(arg_4_0._filled, true)

		SetActive = var_1_10004

		var_1_10004(arg_4_0._unfill, false)

		var_1_10004 = arg_4_0._progressBar
		var_1_10004.fillAmount = 1

		local var_4_0 = arg_4_0._bgEff

		var_1_10004 = var_1_10004.GetComponent
		typeof = var_7
		CanvasGroup = var_1_10009
		var_1_10004 = var_1_10004(var_4_0, var_7(var_1_10009))
		var_1_10004.alpha = 0
		var_1_10004 = arg_4_0._countTxt
		var_1_10004.text = "1/1"

		if arg_4_0._gizmos1 then
			SetActive = var_1_10004

			var_1_10004(arg_4_0._gizmos1, true)

			SetActive = var_1_10004

			var_1_10004(arg_4_0._gizmosXue, true)
		end

		SetActive = var_1_10004

		var_1_10004(arg_4_0._glowEff, true)

		quickCheckAndPlayAnimator = var_1_10004

		var_1_10004(arg_4_0._skin, "weapon_button_progress_filled")
	else
		SetActive = var_1_10004

		var_1_10004(arg_4_0._unfill, true)

		SetActive = var_1_10004

		var_1_10004(arg_4_0._filled, false)

		arg_4_0._progressBar.fillAmount = 0

		local var_4_1 = arg_4_0._bgEff
		local var_4_2 = var_4.GetComponent

		typeof = var_7
		CanvasGroup = var_1_10009
		var_4_2(var_4_1, var_7(var_1_10009)).alpha = 1

		local var_4_3 = arg_4_0._countTxt

		var_4_3.text = "0/0"
		SetActive = var_4_3

		var_4_3(arg_4_0._glowEff, false)

		if arg_4_0._gizmos1 then
			SetActive = var_4

			var_4(arg_4_0._gizmos1, false)

			SetActive = var_4

			var_4(arg_4_0._gizmosXue, false)
		end
	end

	return
end

function var_0_1.updateProgressBar(arg_5_0)
	local var_5_0 = arg_5_0._progressInfo
	local var_5_1 = var_1.GetCurrent(var_5_0)
	local var_5_2 = arg_5_0._progressInfo
	local var_5_3 = var_5_1 / var_2.GetMax(var_5_2)

	arg_5_0._progressBar.fillAmount = var_5_3

	if arg_5_0._progressInfo.GetCount then
		local var_5_4 = arg_5_0._progressInfo

		if var_2.GetCount(var_5_4) > 0 then
			local var_5_5 = arg_5_0._bgEff
			local var_5_6 = var_2.GetComponent

			typeof = var_1_10005
			CanvasGroup = var_1_10007
			var_5_6(var_5_5, var_1_10005(var_1_10007)).alpha = 0

			goto label_5_0
		end
	end

	do
		local var_5_7 = arg_5_0._bgEff
		local var_5_8 = var_2.GetComponent

		typeof = var_1_10005
		CanvasGroup = var_1_10007
		var_5_8(var_5_7, var_1_10005(var_1_10007)).alpha = 1 - var_5_3
	end

	::label_5_0::

	return
end

return
