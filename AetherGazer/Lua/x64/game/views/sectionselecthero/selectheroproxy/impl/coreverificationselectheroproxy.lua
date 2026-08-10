local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("CoreVerificationSelectHeroProxy", var_0_0)

function var_0_1.GetHeroTeamInfoRoute(arg_1_0)
	return "/heroTeamInfoCoreVerification"
end

function var_0_1.InitCustomParams(arg_2_0, arg_2_1)
	arg_2_0.updateHandler = handler(arg_2_0, arg_2_0.UpdateCoreVerification)
end

function var_0_1.OnSectionSelectEnter(arg_3_0)
	manager.notify:RegistListener(CORE_VERIFICATION_CYCLE_UPDATE, arg_3_0.updateHandler)
end

function var_0_1.OnSectionSelectExit(arg_4_0)
	manager.notify:RemoveListener(CORE_VERIFICATION_CYCLE_UPDATE, arg_4_0.updateHandler)
end

function var_0_1.UpdateCoreVerification(arg_5_0)
	CoreVerificationData:InvokeUpdateCycleCallBack()
end

function var_0_1.CustomCheckBeforeBattle(arg_6_0)
	if manager.time:GetServerTime() >= CoreVerificationData:GetRefreshTime() - 600 then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("NEARLY_OVER"),
			OkCallback = function()
				return false
			end,
			MaskCallback = function()
				return false
			end
		})

		return false
	end

	return true
end

return var_0_1
