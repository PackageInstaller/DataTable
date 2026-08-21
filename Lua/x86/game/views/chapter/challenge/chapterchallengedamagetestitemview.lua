local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterChallengeDamageTestItemView", var_0_0)

function var_0_1.ClickItem(arg_1_0, arg_1_1)
	arg_1_0:Go("/damageTestMode")
end

function var_0_1.IsLock(arg_2_0)
	arg_2_0.isLock_ = false
end

return var_0_1
