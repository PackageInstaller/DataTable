ys = ys or {}

local var_0_0 = class("BattleSubmarineButton", ys.Battle.BattleWeaponButton)

ys.Battle.BattleSubmarineButton = var_0_0
var_0_0.__name = "BattleSubmarineButton"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function var_0_0.OnCountChange(arg_2_0)
	local var_2_0 = arg_2_0._progressInfo:GetTotal()

	arg_2_0._countTxt.text = string.format("%d", (arg_2_0._progressInfo:GetCount()))

	return
end

function var_0_0.ConfigSkin(arg_3_0, arg_3_1)
	var_0_0.super.ConfigSkin(arg_3_0, arg_3_1)
	arg_3_0._progress.gameObject:SetActive(false)
	arg_3_0._filledEffect.gameObject:SetActive(false)

	return
end

function var_0_0.ConfigCallback(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	var_0_0.super.ConfigCallback(arg_4_0, arg_4_1, function()
		arg_4_2()

		return
	end, arg_4_3, arg_4_4)

	return
end

function var_0_0.OnOverLoadChange(arg_6_0, arg_6_1)
	var_0_0.super.OnOverLoadChange(arg_6_0, arg_6_1)

	if arg_6_0._progressInfo:GetTotal() == arg_6_0._progressInfo:GetCount() then
		quickCheckAndPlayAnimator(arg_6_0._skin, "weapon_button_into")
	elseif arg_6_0._progressInfo:GetCount() == 0 then
		quickCheckAndPlayAnimator(arg_6_0._skin, "weapon_button_use")
	end

	return
end

function var_0_0.Update(arg_7_0)
	return
end

function var_0_0.updateProgressBar(arg_8_0)
	return
end

function var_0_0.OnfilledEffect(arg_9_0)
	return
end

return
