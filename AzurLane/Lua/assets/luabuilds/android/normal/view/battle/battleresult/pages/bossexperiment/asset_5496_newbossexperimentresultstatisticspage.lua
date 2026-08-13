class = var_0_10000

local var_0_0 = "NewBossExperimentResultStatisticsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..hpShareActBoss.NewHpShareActBossResultStatisticsPage"))

function var_0_1.GetTicketUseCount(arg_1_0)
	return 0
end

function var_0_1.UpdateTicket(arg_2_0, arg_2_1)
	var_0_1.super.UpdateTicket(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.Find(var_2_0, "playAgain/ticket/checkbox")

	triggerToggle = var_2_0

	var_2_0(var_2_1, false)

	setToggleEnabled = var_2_0

	var_2_0(var_2_1, false)

	return
end

function var_0_1.OnPlayAgain(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NewBattleResultMediator = var_1_10004

	var_3_1(var_3_0, var_1_10004.REENTER_STAGE)

	return
end

return var_0_1
