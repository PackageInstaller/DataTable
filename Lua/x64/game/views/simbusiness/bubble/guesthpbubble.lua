local var_0_0 = require("game.views.simBusiness.bubble.EntityBubbleBase")
local var_0_1 = class("GuestHpBubble", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/item/HpBar"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0.typeController = arg_2_0.controllers_:GetController("category")
end

function var_0_1.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.focus = arg_3_1
	arg_3_0.reverseFill = arg_3_2

	arg_3_0:SetFollowEntity(arg_3_1, "gua_Hp")

	local var_3_0 = DormUtils.GetEntityData(arg_3_1)
	local var_3_1 = math.max(0, var_3_0.hp or 0)
	local var_3_2 = var_3_0.max or 0

	if arg_3_2 then
		var_3_1 = var_3_2 - var_3_1
	end

	local var_3_3 = var_3_0.preference
	local var_3_4 = 1

	if var_3_2 ~= 0 then
		var_3_4 = var_3_1 / var_3_2
	end

	arg_3_0.bar_.fillAmount = var_3_4
	arg_3_0.progressText_.text = var_3_1

	arg_3_0.typeController:SetSelectedState(tostring(var_3_3))
end

function var_0_1.OnSetHp(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == arg_4_0.focus then
		arg_4_0:SetData(arg_4_1, arg_4_0.reverseFill)

		local var_4_0 = arg_4_2.buyCount

		arg_4_0.popText_.text = string.format("%+d", -var_4_0)

		arg_4_0.popTextAni_:Play("UI_text_cx", 0, 0)
	end
end

function var_0_1.RegisterEvents(arg_5_0)
	arg_5_0:RegistEventListener("SIM_BUSINESS_GUEST_HP_CHANGE", handler(arg_5_0, arg_5_0.OnSetHp))
end

return var_0_1
