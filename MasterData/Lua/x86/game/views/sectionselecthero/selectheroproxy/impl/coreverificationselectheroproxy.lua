local CoreVerificationSelectHeroProxy = class("CoreVerificationSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function CoreVerificationSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/heroTeamInfoCoreVerification"
end

function CoreVerificationSelectHeroProxy:InitCustomParams(arg_2_1)
	self.updateHandler = handler(self, self.UpdateCoreVerification)
end

function CoreVerificationSelectHeroProxy:OnSectionSelectEnter()
	manager.notify:RegistListener(CORE_VERIFICATION_CYCLE_UPDATE, self.updateHandler)
end

function CoreVerificationSelectHeroProxy:OnSectionSelectExit()
	manager.notify:RemoveListener(CORE_VERIFICATION_CYCLE_UPDATE, self.updateHandler)
end

function CoreVerificationSelectHeroProxy:UpdateCoreVerification()
	CoreVerificationData:InvokeUpdateCycleCallBack()
end

function CoreVerificationSelectHeroProxy:CustomCheckBeforeBattle()
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

return CoreVerificationSelectHeroProxy
