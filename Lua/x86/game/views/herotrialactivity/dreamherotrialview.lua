local var_0_0 = import("game.views.heroTrialActivity.HeroTrialActivityView")
local var_0_1 = class("DreamHeroTrialView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/EmptyDream/HeroTrial/EDreamHeroTrialUI"
end

function var_0_1.RefreshTextName(arg_2_0, arg_2_1)
	local var_2_0 = string.split(arg_2_1, "·")

	arg_2_0.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", GetI18NText(var_2_0[1]), GetI18NText(var_2_0[2]))
end

return var_0_1
