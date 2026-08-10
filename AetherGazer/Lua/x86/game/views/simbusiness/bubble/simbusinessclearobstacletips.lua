local var_0_0 = require("game.views.simBusiness.bubble.EntityBubbleBase")
local var_0_1 = class("SimBusinessClearObstacleTips", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/item/spaceLockItem"
end

function var_0_1.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.tips_.text = GetTipsF("SIM_BUSINESS_LEVEL_LIMIT", arg_2_1)

	arg_2_0:SetFollowTransform(arg_2_2)
end

return var_0_1
