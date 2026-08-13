class = var_0_10000

local var_0_0 = "NieRAutomataMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)

	local var_1_0 = arg_1_0.activity
	local var_1_1 = var_1.getConfig(var_1_0, "config_client").intro_story

	pg = var_1_0

	local var_1_2 = var_1_0.NewStoryMgr.GetInstance()

	if not var_2.IsPlayed(var_1_2, var_1_1) then
		pg = var_1_2

		local var_1_3 = var_1_2.NewStoryMgr.GetInstance()

		var_3.Play(var_1_3, var_1_1[1])
	end

	return
end

return var_0_1
