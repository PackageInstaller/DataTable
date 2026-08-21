local var_0_0 = require("game.views.activity.Submodule.anniversary.AnniversaryCelebrationGiftViewBase")
local var_0_1 = class("Anniversary5thCelebrationGiftView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/Version/V5_0_WuChang/V5_0_WuChang_CelebrationGiftUI/V5_0_WuChang_CelebrationGiftUI"
end

function var_0_1.AddListeners(arg_2_0)
	var_0_1.super.AddListeners(arg_2_0)
	arg_2_0:BindHelpBtn("ACTIVITY_ASSIGNMENT_DESC")
end

return var_0_1
