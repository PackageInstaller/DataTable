local NewBossExperimentResultStatisticsPage = class("NewBossExperimentResultStatisticsPage", import("..hpShareActBoss.NewHpShareActBossResultStatisticsPage"))

function NewBossExperimentResultStatisticsPage:GetTicketUseCount()
	return 0
end

function NewBossExperimentResultStatisticsPage:UpdateTicket(arg_2_1)
	NewBossExperimentResultStatisticsPage.super.UpdateTicket(self, arg_2_1)

	local var_2_0 = arg_2_1:Find("playAgain/ticket/checkbox")

	triggerToggle(var_2_0, false)
	setToggleEnabled(var_2_0, false)

	return
end

function NewBossExperimentResultStatisticsPage:OnPlayAgain(arg_3_1)
	self:emit(NewBattleResultMediator.REENTER_STAGE)

	return
end

return NewBossExperimentResultStatisticsPage
