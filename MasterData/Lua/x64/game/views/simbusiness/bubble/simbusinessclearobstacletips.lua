local SimBusinessClearObstacleTips = class("SimBusinessClearObstacleTips", (require("game.views.simBusiness.bubble.EntityBubbleBase")))

function SimBusinessClearObstacleTips:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/item/spaceLockItem"
end

function SimBusinessClearObstacleTips:SetData(arg_2_1, arg_2_2)
	self.tips_.text = GetTipsF("SIM_BUSINESS_LEVEL_LIMIT", arg_2_1)

	self:SetFollowTransform(arg_2_2)
end

return SimBusinessClearObstacleTips
