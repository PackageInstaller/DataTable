ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleWeaponButtonSkinElite_20260520", var_0.Battle.BattleWeaponButtonSkinElite_20250520)

var_0.Battle.BattleWeaponButtonSkinElite_20260520 = var_0_1
var_0_1.__name = "BattleWeaponButtonSkinElite_20260520"

local var_0_2 = 1

function var_0_1.ConfigSkin(arg_1_0, arg_1_1)
	var_0_1.super.ConfigSkin(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._bgEff
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Animator = var_1_10005
	arg_1_0._bgEffAni = var_1_1(var_1_0, var_4(var_1_10005))

	local var_1_2 = arg_1_0._bgEffAni.runtimeAnimatorController.animationClips[0]

	math = var_1_0

	local var_1_3 = var_1_0.max
	local var_1_4 = 1

	math = var_1_10005
	arg_1_0._bgEffAniClipTotalFrames = var_1_3(var_1_4, var_1_10005.floor(var_1_2.length * var_1_2.frameRate + 0.5))

	local var_1_5 = arg_1_0._icon

	arg_1_0._unfill = var_3.Find(var_1_5, "unfill/unfill")

	local var_1_6 = arg_1_0._icon

	arg_1_0._unfillShade = var_3.Find(var_1_6, "unfill/unfill_1")

	return
end

function var_0_1.OnFilled(arg_2_0)
	var_0_1.super.OnFilled(arg_2_0)

	SetActive = var_1

	var_1(arg_2_0._unfillShade, false)

	return
end

function var_0_1.OnUnfill(arg_3_0)
	var_0_1.super.OnUnfill(arg_3_0)

	SetActive = var_1

	var_1(arg_3_0._unfillShade, true)

	return
end

function var_0_1.SwitchIcon(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = var_0_1.super.SwitchIcon(arg_4_0, arg_4_1, arg_4_2)

	setImageSprite = var_5

	local var_4_2 = arg_4_0._unfillShade

	LoadSprite = var_1_10007

	var_5(var_4_2, var_1_10007("ui/CombatUI" .. var_4_0 .. "_atlas", "weapon_unfill_" .. var_4_1))

	return
end

function var_0_1.OnTotalChange(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._progressInfo

	if var_2.GetTotal(var_5_0) <= 0 then
		local var_5_1 = arg_5_0._block

		var_2.SetActive(var_5_1, true)

		arg_5_0._progressBar.fillAmount = 0

		local var_5_2 = arg_5_0._bgEff
		local var_5_3 = var_2.GetComponent

		typeof = var_4
		CanvasGroup = var_1_10005
		var_5_3(var_5_2, var_4(var_1_10005)).alpha = 0

		local var_5_4 = arg_5_0._text
		local var_5_5 = var_2.GetComponent

		typeof = var_4
		Text = var_1_10005
		var_5_5(var_5_4, var_4(var_1_10005)).text = "0/0"

		arg_5_0:SetControllerActive(false)

		SetActive = var_2

		var_2(arg_5_0._glowEff, false)
		arg_5_0:OnUnfill()
		arg_5_0:OnUnSelect()

		SetActive = var_2

		var_2(arg_5_0._gizmos1, false)

		SetActive = var_2

		var_2(arg_5_0._gizmosXue, false)
	else
		arg_5_0:OnCountChange()
		arg_5_0:SetControllerActive(true)

		if arg_5_1 and arg_5_1.Data.index and var_2 == 1 then
			arg_5_0:OnUnSelect()
		end
	end

	return
end

function var_0_1.OnCountChange(arg_6_0)
	var_0_1.super.OnCountChange(arg_6_0)

	SetActive = var_1

	local var_6_0 = arg_6_0._gizmosXue
	local var_6_1 = arg_6_0._progressInfo

	var_1(var_6_0, var_3.GetCount(var_6_1) > 0)

	SetActive = var_1

	local var_6_2 = arg_6_0._glowEff
	local var_6_3 = arg_6_0._progressInfo

	var_1(var_6_2, var_3.GetCount(var_6_3) > 0)

	return
end

function var_0_1.StopCombatUIPreviewLoop(arg_7_0)
	if arg_7_0._skin then
		LeanTween = var_1

		local var_7_0 = var_1.cancel

		go = var_1_10002

		var_7_0(var_1_10002(arg_7_0._skin))
	end

	return
end

function var_0_1.ApplyCombatUIPreviewState(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = 2

	SetActive = var_1_10005

	var_1_10005(arg_8_0._filled, not arg_8_3 and arg_8_1 > 0)

	SetActive = var_1_10005

	var_1_10005(arg_8_0._unfill, arg_8_3 or arg_8_1 <= 0)

	SetActive = var_1_10005

	var_1_10005(arg_8_0._unfillShade, arg_8_3 or arg_8_1 <= 0)

	arg_8_0._progressBar.fillAmount = arg_8_2

	local var_8_1 = arg_8_0._bgEff
	local var_8_2 = var_5.GetComponent

	typeof = var_7
	CanvasGroup = var_1_10008
	var_8_2(var_8_1, var_7(var_1_10008)).alpha = (arg_8_3 or arg_8_1 > 0) and 1 or 0
	arg_8_0._countTxt.text = arg_8_1 .. "/" .. var_8_0

	if arg_8_0._gizmos1 then
		SetActive = var_5

		var_5(arg_8_0._gizmos1, arg_8_1 > 0)

		SetActive = var_5

		var_5(arg_8_0._gizmosXue, arg_8_1 > 0)
	end

	SetActive = var_5

	var_5(arg_8_0._glowEff, arg_8_1 > 0)

	arg_8_0._bgEffAni.enabled = true

	arg_8_0:updateProgressBG(arg_8_2, 5)

	return
end

function var_0_1.StartCombatUIPreviewLoop(arg_9_0)
	go = var_1_10001

	local var_9_0 = var_1_10001(arg_9_0._skin)

	;(function()
		local var_10_0 = arg_9_0

		var_0.ApplyCombatUIPreviewState(var_10_0, 0, 0, true)

		LeanTween = var_0

		local var_10_1 = var_0.value(var_9_0, 0, 1, 5)
		local var_10_2 = var_0.setOnUpdate

		System = var_2

		local var_10_3 = var_10_2(var_10_1, var_2.Action_float(function(arg_11_0)
			local var_11_0 = arg_9_0

			var_1.ApplyCombatUIPreviewState(var_11_0, 0, arg_11_0, true)

			return
		end))
		local var_10_4 = var_0.setOnComplete

		System = var_2

		var_10_4(var_10_3, var_2.Action(function()
			local var_12_0 = arg_9_0

			var_0.ApplyCombatUIPreviewState(var_12_0, 2, 1, false)

			quickCheckAndPlayAnimator = var_0

			var_0(arg_9_0._skin, "weapon_button_progress_filled")

			LeanTween = var_0

			local var_12_1 = var_0.delayedCall
			local var_12_2 = var_9_0
			local var_12_3 = 3

			System = var_3

			var_12_1(var_12_2, var_12_3, var_3.Action(function()
				local var_13_0 = arg_9_0

				var_0.ApplyCombatUIPreviewState(var_13_0, 1, 1, false)

				quickCheckAndPlayAnimator = var_0

				var_0(arg_9_0._skin, "weapon_button_progress_use")

				LeanTween = var_0

				local var_13_1 = var_0.delayedCall
				local var_13_2 = var_9_0
				local var_13_3 = 3

				System = var_3

				var_13_1(var_13_2, var_13_3, var_3.Action(function()
					local var_14_0 = arg_9_0

					var_0.ApplyCombatUIPreviewState(var_14_0, 0, 0, false)

					quickCheckAndPlayAnimator = var_0

					var_0(arg_9_0._skin, "weapon_button_progress_use")

					LeanTween = var_0

					local var_14_1 = var_0.delayedCall
					local var_14_2 = var_9_0
					local var_14_3 = 3

					System = var_3

					var_14_1(var_14_2, var_14_3, var_3.Action(function()
						var_0()

						return
					end))

					return
				end))

				return
			end))

			return
		end))

		return
	end)()

	return
end

function var_0_1.SetToCombatUIPreview(arg_16_0, arg_16_1)
	arg_16_0:StopCombatUIPreviewLoop()

	CombatUIPreviewer = var_2

	if arg_16_1 == var_2.WeaponButtonPreviewMode.LOOP then
		arg_16_0:StartCombatUIPreviewLoop()

		return
	end

	if arg_16_1 ~= var_2.UNFILLED then
		arg_16_0:ApplyCombatUIPreviewState(2, 1, false)

		quickCheckAndPlayAnimator = var_3

		var_3(arg_16_0._skin, "weapon_button_progress_filled")
	else
		arg_16_0:ApplyCombatUIPreviewState(0, 0, false)
	end

	return
end

function var_0_1.updateProgressBar(arg_17_0)
	local var_17_0 = arg_17_0._progressInfo
	local var_17_1 = var_1.GetCurrent(var_17_0)
	local var_17_2 = arg_17_0._progressInfo
	local var_17_3 = var_17_1 / var_2.GetMax(var_17_2)

	arg_17_0._progressBar.fillAmount = var_17_3

	if arg_17_0._progressInfo.GetCount then
		local var_17_4 = arg_17_0._progressInfo

		if var_2.GetCount(var_17_4) > 0 then
			local var_17_5 = arg_17_0
			local var_17_6 = arg_17_0.updateProgressBG
			local var_17_7 = 1
			local var_17_8 = arg_17_0._progressInfo

			var_17_6(var_17_5, var_17_7, var_5.GetMax(var_17_8))

			goto label_17_0
		end
	end

	arg_17_0._bgEffAni.enabled = true

	do
		local var_17_9 = arg_17_0
		local var_17_10 = arg_17_0.updateProgressBG
		local var_17_11 = var_17_3
		local var_17_12 = arg_17_0._progressInfo

		var_17_10(var_17_9, var_17_11, var_5.GetMax(var_17_12))
	end

	::label_17_0::

	return
end

function var_0_1.updateProgressBG(arg_18_0, arg_18_1, arg_18_2)
	Mathf = var_1_10003

	local var_18_0 = var_1_10003.Clamp01(arg_18_1) * (arg_18_0._bgEffAniClipTotalFrames - 1)
	local var_18_1

	if arg_18_2 and var_0_2 < arg_18_2 then
		math = var_1_10007
		var_1_10007 = var_1_10007.floor(var_18_0)
		math = var_8

		local var_18_2 = var_8.min(var_4, var_1_10007 + 1)
		local var_18_3 = var_18_0 - var_1_10007

		var_18_1 = (var_1_10007 + (var_18_2 - var_1_10007) * var_18_3) / var_4
	else
		math = var_1_10007
		var_18_1 = var_1_10007.floor(var_18_0 + 0.5) / var_4
	end

	arg_18_0._bgEffAni.speed = 1

	local var_18_4 = arg_18_0._bgEffAni

	var_7.Play(var_18_4, "skinui_button_bg", 0, var_18_1)

	local var_18_5 = arg_18_0._bgEffAni

	var_7.Update(var_18_5, 0)

	arg_18_0._bgEffAni.speed = 0

	return
end

function var_0_1.Dispose(arg_19_0)
	arg_19_0:StopCombatUIPreviewLoop()
	var_0_1.super.Dispose(arg_19_0)

	return
end

return
