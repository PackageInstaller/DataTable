local GuestHpBubble = class("GuestHpBubble", (require("game.views.simBusiness.bubble.EntityBubbleBase")))

function GuestHpBubble:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/item/HpBar"
end

function GuestHpBubble:InitUI()
	self.typeController = self.controllers_:GetController("category")
end

function GuestHpBubble:SetData(arg_3_1, arg_3_2)
	self.focus = arg_3_1
	self.reverseFill = arg_3_2

	self:SetFollowEntity(arg_3_1, "gua_Hp")

	local var_3_0 = DormUtils.GetEntityData(arg_3_1)
	local var_3_1 = math.max(0, var_3_0.hp or 0)
	local var_3_2 = var_3_0.max or 0

	if arg_3_2 then
		var_3_1 = var_3_2 - var_3_1
	end

	if var_3_2 ~= 0 then
		self.bar_.fillAmount = var_3_1 / var_3_2
	end

	self.progressText_.text = var_3_1

	self.typeController:SetSelectedState(tostring(var_3_0.preference))
end

function GuestHpBubble:OnSetHp(arg_4_1, arg_4_2)
	if arg_4_1 == self.focus then
		self:SetData(arg_4_1, self.reverseFill)

		self.popText_.text = string.format("%+d", -arg_4_2.buyCount)

		self.popTextAni_:Play("UI_text_cx", 0, 0)
	end
end

function GuestHpBubble:RegisterEvents()
	self:RegistEventListener("SIM_BUSINESS_GUEST_HP_CHANGE", handler(self, self.OnSetHp))
end

return GuestHpBubble
