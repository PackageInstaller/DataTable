local var_0_0 = class("BossRushAlvitFleetSelectView", import("view.activity.BossRush.BossRushFleetSelectView"))

function var_0_0.GetTextColor(arg_1_0)
	local var_1_0 = Color.NewHex("1C231F")
	local var_1_1 = Color.NewHex("979A98")
end

function var_0_0.getUIName(arg_2_0)
	return "BossRushAlvitFleetSelectUI"
end

function var_0_0.tempCache(arg_3_0)
	return true
end

function var_0_0.didEnter(arg_4_0)
	var_0_0.super.didEnter(arg_4_0)
	removeOnButton(arg_4_0._tf:Find("BG"))
	onButton(arg_4_0, arg_4_0._tf:Find("BG/close"), function()
		arg_4_0:onCancelHard()

		return
	end, SFX_CANCEL)

	arg_4_0.anim = arg_4_0._tf:GetComponent(typeof(Animation))
	arg_4_0.animEvent = arg_4_0.anim:GetComponent(typeof(DftAniEvent))

	arg_4_0.animEvent:SetEndEvent(function()
		var_0_0.super.onCancelHard(arg_4_0)

		return
	end)

	return
end

function var_0_0.onCancelHard(arg_7_0)
	arg_7_0.anim:Play("anim_kinder_fleetselect_out")

	return
end

return var_0_0
