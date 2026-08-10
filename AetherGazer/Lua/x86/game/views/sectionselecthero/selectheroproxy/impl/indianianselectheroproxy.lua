local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("IndiaNianSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.destID = arg_1_1.destID
end

function var_0_1.UpdateBar(arg_2_0)
	manager.windowBar:SwitchBar(arg_2_0.barList)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/indiaNianMain")
	end)
end

function var_0_1.OnSectionSelectEnter(arg_4_0)
	if IndiaNianCfg[arg_4_0.destID].stage_type == 0 then
		arg_4_0:AddHpTimer()
	end
end

function var_0_1.OnSectionSelectExit(arg_5_0)
	if arg_5_0.timer then
		arg_5_0.timer:Stop()

		arg_5_0.timer = nil
	end
end

function var_0_1.AddHpTimer(arg_6_0)
	arg_6_0.timer = Timer.New(function()
		if IndiaNianData:GetCurrentHpByID(arg_6_0.destID) == 0 then
			arg_6_0:Back()
		end
	end, 1, -1, true)

	arg_6_0.timer:Start()
end

return var_0_1
