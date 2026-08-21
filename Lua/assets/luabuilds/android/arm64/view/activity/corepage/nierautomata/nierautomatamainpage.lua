local var_0_0 = class("NieRAutomataMainPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)

	local var_1_0 = arg_1_0.activity:getConfig("config_client").intro_story

	if not pg.NewStoryMgr.GetInstance():IsPlayed(var_1_0) then
		pg.NewStoryMgr.GetInstance():Play(var_1_0[1])
	end

	return
end

return var_0_0
