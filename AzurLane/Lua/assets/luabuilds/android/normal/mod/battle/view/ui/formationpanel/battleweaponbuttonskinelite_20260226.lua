ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleWeaponButtonSkinElite_20260226", var_0.Battle.BattleWeaponButtonSkinElite_20250520)

var_0.Battle.BattleWeaponButtonSkinElite_20260226 = var_0_1
var_0_1.__name = "BattleWeaponButtonSkinElite_20260226"

function var_0_1.ConfigSkin(arg_1_0, arg_1_1)
	var_0_1.super.ConfigSkin(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._selected

	arg_1_0._books = var_2.Find(var_1_0, "usdfx/fx/up/book/book/book1")
	arg_1_0._bookList = {}

	for iter_1_0 = 1, 4 do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_1_1 = arg_1_0._bookList
		local var_1_2 = arg_1_0._books

		var_1_10006(var_1_1, var_8.Find(var_1_2, "text_" .. iter_1_0))
	end

	return
end

function var_0_1.OnCountChange(arg_2_0)
	var_0_1.super.OnCountChange(arg_2_0)

	SetActive = var_1

	local var_2_0 = arg_2_0._gizmos1
	local var_2_1 = arg_2_0._progressInfo

	var_1(var_2_0, var_3.GetCount(var_2_1) > 0)

	SetActive = var_1

	local var_2_2 = arg_2_0._gizmosXue
	local var_2_3 = arg_2_0._progressInfo

	var_1(var_2_2, var_3.GetCount(var_2_3) > 0)

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
		var_1_10004.alpha = 0
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
		var_3_2(var_3_1, var_6(var_1_10007)).alpha = 1

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

function var_0_1.OnOverLoadChange(arg_4_0, arg_4_1)
	if arg_4_1 and arg_4_1.Data and arg_4_1.Data.postCast then
		math = var_2

		local var_4_0 = var_2.random(4)

		ipairs = var_3

		for iter_4_0, iter_4_1 in var_3(arg_4_0._bookList) do
			SetActive = var_1_10008

			var_1_10008(iter_4_1, iter_4_0 == var_4_0)
		end
	end

	var_0_1.super.OnOverLoadChange(arg_4_0, arg_4_1)

	return
end

function var_0_1.updateProgressBar(arg_5_0)
	local var_5_0 = arg_5_0._progressInfo
	local var_5_1 = var_1.GetCurrent(var_5_0)
	local var_5_2 = arg_5_0._progressInfo
	local var_5_3 = var_5_1 / var_2.GetMax(var_5_2)

	arg_5_0._progressBar.fillAmount = var_5_3

	if arg_5_0._bgEff then
		if arg_5_0._progressInfo.GetCount then
			local var_5_4 = arg_5_0._progressInfo

			if var_2.GetCount(var_5_4) > 0 then
				local var_5_5 = arg_5_0._bgEff
				local var_5_6 = var_2.GetComponent

				typeof = var_1_10004
				CanvasGroup = var_1_10005
				var_5_6(var_5_5, var_1_10004(var_1_10005)).alpha = 0

				goto label_5_0
			end
		end

		local var_5_7 = arg_5_0._bgEff
		local var_5_8 = var_2.GetComponent

		typeof = var_1_10004
		CanvasGroup = var_1_10005
		var_5_8(var_5_7, var_1_10004(var_1_10005)).alpha = 1 - var_5_3
	end

	::label_5_0::

	return
end

return
