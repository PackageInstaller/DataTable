ys = ys or {}

local var_0_0 = class("BattleWeaponButtonSkinElite_20260520", ys.Battle.BattleWeaponButtonSkinElite_20250520)

ys.Battle.BattleWeaponButtonSkinElite_20260520 = var_0_0
var_0_0.__name = "BattleWeaponButtonSkinElite_20260520"

local var_0_1 = 1

function var_0_0.ConfigSkin(arg_1_0, arg_1_1)
	var_0_0.super.ConfigSkin(arg_1_0, arg_1_1)

	arg_1_0._bgEffAni = arg_1_0._bgEff:GetComponent(typeof(Animator))
	arg_1_0._bgEffAniClipTotalFrames = math.max(1, math.floor(arg_1_0._bgEffAni.runtimeAnimatorController.animationClips[0].length * arg_1_0._bgEffAni.runtimeAnimatorController.animationClips[0].frameRate + 0.5))
	arg_1_0._unfill = arg_1_0._icon:Find("unfill/unfill")
	arg_1_0._unfillShade = arg_1_0._icon:Find("unfill/unfill_1")

	return
end

function var_0_0.OnFilled(arg_2_0)
	var_0_0.super.OnFilled(arg_2_0)
	SetActive(arg_2_0._unfillShade, false)

	return
end

function var_0_0.OnUnfill(arg_3_0)
	var_0_0.super.OnUnfill(arg_3_0)
	SetActive(arg_3_0._unfillShade, true)

	return
end

function var_0_0.SwitchIcon(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = var_0_0.super.SwitchIcon(arg_4_0, arg_4_1, arg_4_2)

	setImageSprite(arg_4_0._unfillShade, LoadSprite("ui/CombatUI" .. var_4_0 .. "_atlas", "weapon_unfill_" .. var_4_1))

	return
end

function var_0_0.OnTotalChange(arg_5_0, arg_5_1)
	if arg_5_0._progressInfo:GetTotal() <= 0 then
		arg_5_0._block:SetActive(true)

		arg_5_0._progressBar.fillAmount = 0
		arg_5_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 0
		arg_5_0._text:GetComponent(typeof(Text)).text = "0/0"

		arg_5_0:SetControllerActive(false)
		SetActive(arg_5_0._glowEff, false)
		arg_5_0:OnUnfill()
		arg_5_0:OnUnSelect()
		SetActive(arg_5_0._gizmos1, false)
		SetActive(arg_5_0._gizmosXue, false)
	else
		arg_5_0:OnCountChange()
		arg_5_0:SetControllerActive(true)

		if arg_5_1 then
			if arg_5_1.Data.index and arg_5_1.Data.index == 1 then
				arg_5_0:OnUnSelect()
			end
		end
	end

	return
end

function var_0_0.OnCountChange(arg_6_0)
	var_0_0.super.OnCountChange(arg_6_0)
	SetActive(arg_6_0._gizmosXue, arg_6_0._progressInfo:GetCount() > 0)
	SetActive(arg_6_0._glowEff, arg_6_0._progressInfo:GetCount() > 0)

	return
end

function var_0_0.StopCombatUIPreviewLoop(arg_7_0)
	if arg_7_0._skin then
		LeanTween.cancel(go(arg_7_0._skin))
	end

	return
end

function var_0_0.ApplyCombatUIPreviewState(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	SetActive(arg_8_0._filled, not arg_8_3 and arg_8_1 > 0)
	SetActive(arg_8_0._unfill, arg_8_3 or arg_8_1 <= 0)
	SetActive(arg_8_0._unfillShade, arg_8_3 or arg_8_1 <= 0)

	arg_8_0._progressBar.fillAmount = arg_8_2
	arg_8_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = (arg_8_3 or arg_8_1 > 0) and 1 or 0
	arg_8_0._countTxt.text = arg_8_1 .. "/" .. 2

	if arg_8_0._gizmos1 then
		SetActive(arg_8_0._gizmos1, arg_8_1 > 0)
		SetActive(arg_8_0._gizmosXue, arg_8_1 > 0)
	end

	SetActive(arg_8_0._glowEff, arg_8_1 > 0)

	arg_8_0._bgEffAni.enabled = true

	arg_8_0:updateProgressBG(arg_8_2, 5)

	return
end

function var_0_0.StartCombatUIPreviewLoop(arg_9_0)
	local var_9_0 = go(arg_9_0._skin)

	;(function()
		arg_9_0:ApplyCombatUIPreviewState(0, 0, true)
		LeanTween.value(var_9_0, 0, 1, 5):setOnUpdate(System.Action_float(function(arg_11_0)
			arg_9_0:ApplyCombatUIPreviewState(0, arg_11_0, true)

			return
		end)):setOnComplete(System.Action(function()
			arg_9_0:ApplyCombatUIPreviewState(2, 1, false)
			quickCheckAndPlayAnimator(arg_9_0._skin, "weapon_button_progress_filled")
			LeanTween.delayedCall(var_9_0, 3, System.Action(function()
				arg_9_0:ApplyCombatUIPreviewState(1, 1, false)
				quickCheckAndPlayAnimator(arg_9_0._skin, "weapon_button_progress_use")
				LeanTween.delayedCall(var_9_0, 3, System.Action(function()
					arg_9_0:ApplyCombatUIPreviewState(0, 0, false)
					quickCheckAndPlayAnimator(arg_9_0._skin, "weapon_button_progress_use")
					LeanTween.delayedCall(var_9_0, 3, System.Action(function()
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

function var_0_0.SetToCombatUIPreview(arg_16_0, arg_16_1)
	arg_16_0:StopCombatUIPreviewLoop()

	if arg_16_1 == CombatUIPreviewer.WeaponButtonPreviewMode.LOOP then
		arg_16_0:StartCombatUIPreviewLoop()

		return
	end

	if arg_16_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
		arg_16_0:ApplyCombatUIPreviewState(2, 1, false)
		quickCheckAndPlayAnimator(arg_16_0._skin, "weapon_button_progress_filled")
	else
		arg_16_0:ApplyCombatUIPreviewState(0, 0, false)
	end

	return
end

function var_0_0.updateProgressBar(arg_17_0)
	local var_17_0 = arg_17_0._progressInfo:GetCurrent() / arg_17_0._progressInfo:GetMax()

	arg_17_0._progressBar.fillAmount = var_17_0

	if arg_17_0._progressInfo.GetCount and arg_17_0._progressInfo:GetCount() > 0 then
		arg_17_0:updateProgressBG(1, arg_17_0._progressInfo:GetMax())
	else
		arg_17_0._bgEffAni.enabled = true

		arg_17_0:updateProgressBG(var_17_0, arg_17_0._progressInfo:GetMax())
	end

	return
end

function var_0_0.updateProgressBG(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1 = Mathf.Clamp01(arg_18_1)

	local var_18_0

	if arg_18_2 and arg_18_2 > var_0_1 then
		local var_18_1 = math.floor(arg_18_1 * (arg_18_0._bgEffAniClipTotalFrames - 1))

		var_18_0 = (var_18_1 + (math.min(arg_18_0._bgEffAniClipTotalFrames - 1, var_18_1 + 1) - var_18_1) * (arg_18_1 * (arg_18_0._bgEffAniClipTotalFrames - 1) - var_18_1)) / (arg_18_0._bgEffAniClipTotalFrames - 1)
	else
		var_18_0 = math.floor(arg_18_1 * (arg_18_0._bgEffAniClipTotalFrames - 1) + 0.5) / (arg_18_0._bgEffAniClipTotalFrames - 1)
	end

	arg_18_0._bgEffAni.speed = 1

	arg_18_0._bgEffAni:Play("skinui_button_bg", 0, var_18_0)
	arg_18_0._bgEffAni:Update(0)

	arg_18_0._bgEffAni.speed = 0

	return
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:StopCombatUIPreviewLoop()
	var_0_0.super.Dispose(arg_19_0)

	return
end

return
