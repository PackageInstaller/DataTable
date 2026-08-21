ys = ys or {}

local var_0_0 = class("BattleSubmarineFuncButtonSkinElite_20260520", ys.Battle.BattleSubmarineFuncButton)

ys.Battle.BattleSubmarineFuncButtonSkinElite_20260520 = var_0_0
var_0_0.__name = "BattleSubmarineFuncButtonSkinElite_20260520"

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

function var_0_0.updateProgressBar(arg_5_0)
	local var_5_0 = arg_5_0._progressInfo:GetCurrent() / arg_5_0._progressInfo:GetMax()

	arg_5_0._progressBar.fillAmount = var_5_0

	if arg_5_0._progressInfo.GetCount and arg_5_0._progressInfo:GetCount() > 0 then
		arg_5_0:updateProgressBG(1, arg_5_0._progressInfo:GetMax())
	else
		arg_5_0._bgEffAni.enabled = true

		arg_5_0:updateProgressBG(var_5_0, arg_5_0._progressInfo:GetMax())
	end

	return
end

function var_0_0.updateProgressBG(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = Mathf.Clamp01(arg_6_1)

	local var_6_0

	if arg_6_2 and arg_6_2 > var_0_1 then
		local var_6_1 = math.floor(arg_6_1 * (arg_6_0._bgEffAniClipTotalFrames - 1))

		var_6_0 = (var_6_1 + (math.min(arg_6_0._bgEffAniClipTotalFrames - 1, var_6_1 + 1) - var_6_1) * (arg_6_1 * (arg_6_0._bgEffAniClipTotalFrames - 1) - var_6_1)) / (arg_6_0._bgEffAniClipTotalFrames - 1)
	else
		var_6_0 = math.floor(arg_6_1 * (arg_6_0._bgEffAniClipTotalFrames - 1) + 0.5) / (arg_6_0._bgEffAniClipTotalFrames - 1)
	end

	arg_6_0._bgEffAni.speed = 1

	arg_6_0._bgEffAni:Play("skinui_button_bg", 0, var_6_0)
	arg_6_0._bgEffAni:Update(0)

	arg_6_0._bgEffAni.speed = 0

	return
end

return
