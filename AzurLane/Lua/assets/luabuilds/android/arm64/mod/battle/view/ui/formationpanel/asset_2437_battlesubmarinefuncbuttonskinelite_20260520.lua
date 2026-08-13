ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSubmarineFuncButtonSkinElite_20260520", var_0.Battle.BattleSubmarineFuncButton)

var_0.Battle.BattleSubmarineFuncButtonSkinElite_20260520 = var_0_1
var_0_1.__name = "BattleSubmarineFuncButtonSkinElite_20260520"

local var_0_2 = 1

function var_0_1.ConfigSkin(arg_1_0, arg_1_1)
	var_0_1.super.ConfigSkin(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._bgEff
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Animator = var_1_10007
	arg_1_0._bgEffAni = var_1_1(var_1_0, var_5(var_1_10007))

	local var_1_2 = arg_1_0._bgEffAni.runtimeAnimatorController.animationClips[0]

	math = var_1_10003

	local var_1_3 = var_1_10003.max
	local var_1_4 = 1

	math = var_1_10006
	arg_1_0._bgEffAniClipTotalFrames = var_1_3(var_1_4, var_1_10006.floor(var_1_2.length * var_1_2.frameRate + 0.5))

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

	LoadSprite = var_1_10008

	var_5(var_4_2, var_1_10008("ui/CombatUI" .. var_4_0 .. "_atlas", "weapon_unfill_" .. var_4_1))

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
			local var_5_5 = arg_5_0
			local var_5_6 = arg_5_0.updateProgressBG
			local var_5_7 = 1
			local var_5_8 = arg_5_0._progressInfo

			var_5_6(var_5_5, var_5_7, var_6.GetMax(var_5_8))

			goto label_5_0
		end
	end

	arg_5_0._bgEffAni.enabled = true

	do
		local var_5_9 = arg_5_0
		local var_5_10 = arg_5_0.updateProgressBG
		local var_5_11 = var_5_3
		local var_5_12 = arg_5_0._progressInfo

		var_5_10(var_5_9, var_5_11, var_6.GetMax(var_5_12))
	end

	::label_5_0::

	return
end

function var_0_1.updateProgressBG(arg_6_0, arg_6_1, arg_6_2)
	Mathf = var_1_10003

	local var_6_0 = var_1_10003.Clamp01(arg_6_1) * (arg_6_0._bgEffAniClipTotalFrames - 1)
	local var_6_1

	if arg_6_2 and var_0_2 < arg_6_2 then
		math = var_1_10007
		var_1_10007 = var_1_10007.floor(var_6_0)
		math = var_1_10008

		local var_6_2 = var_1_10008.min(var_4, var_1_10007 + 1)
		local var_6_3 = var_6_0 - var_1_10007

		var_6_1 = (var_1_10007 + (var_6_2 - var_1_10007) * var_6_3) / var_4
	else
		math = var_1_10007
		var_6_1 = var_1_10007.floor(var_6_0 + 0.5) / var_4
	end

	arg_6_0._bgEffAni.speed = 1

	local var_6_4 = arg_6_0._bgEffAni

	var_7.Play(var_6_4, "skinui_button_bg", 0, var_6_1)

	local var_6_5 = arg_6_0._bgEffAni

	var_7.Update(var_6_5, 0)

	arg_6_0._bgEffAni.speed = 0

	return
end

return
