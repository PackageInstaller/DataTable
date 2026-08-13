class = var_0_10000

local var_0_0 = "NewHpShareActBossResultStatisticsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..activityBoss.NewActivityBossResultStatisticsPage"))

function var_0_1.UpdateGrade(arg_1_0)
	local var_1_0 = "battlescore/grade_label_clear"

	LoadImageSpriteAsync = var_1_10002

	var_1_10002(var_1_0, arg_1_0.gradeTxt, false)

	setActive = var_1_10002

	var_1_10002(arg_1_0.gradeIcon, false)

	return
end

function var_0_1.UpdateTicket(arg_2_0, arg_2_1)
	var_0_1.super.UpdateTicket(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.Find(var_2_0, "playAgain/ticket/checkbox")

	triggerToggle = var_2_0

	var_2_0(var_2_1, true)

	setToggleEnabled = var_2_0

	var_2_0(var_2_1, false)

	return
end

function var_0_1.EnoughTicketCount(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GetTicketItemID(var_3_0, arg_3_0.contextData.actId)

	getProxy = var_3_0
	PlayerProxy = var_3

	local var_3_2 = var_3_0(var_3)
	local var_3_3 = var_2.getRawData(var_3_2)

	return var_2.getResource(var_3_3, var_3_1) > 0
end

function var_0_1.OnPlayAgain(arg_4_0, arg_4_1)
	if arg_4_0:IsLastBonus() then
		local var_4_0 = arg_4_0
		local var_4_1 = arg_4_0.PassMsgbox

		var_1_10004 = "lastBonus"

		local var_4_2 = {}

		i18n = var_1_10006
		var_4_2.content = var_1_10006("expedition_drop_use_out")

		var_4_1(var_4_0, var_1_10004, var_4_2, arg_4_1)

		return
	end

	if not arg_4_0:EnoughTicketCount() then
		arg_4_1()

		pg = var_2

		local var_4_3 = var_2.TipsMgr.GetInstance()
		local var_4_4 = var_2.ShowTips

		i18n = var_1_10004

		var_4_4(var_4_3, var_1_10004("stage_beginStage_error_noTicket"))

		return
	end

	local var_4_5, var_4_6 = arg_4_0:NotEnoughOilCost()

	if var_4_5 then
		arg_4_0:PassMsgbox("oil", var_4_6, arg_4_1)

		return
	end

	if arg_4_0:NotEnoughShipBag() then
		arg_4_0:PassMsgbox("shipCapacity", nil, arg_4_1)

		return
	end

	local var_4_7, var_4_8 = arg_4_0:NotEnoughEnergy()

	if var_4_7 then
		arg_4_0:PassMsgbox("energy", var_4_8, arg_4_1)

		return
	end

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.emit

	NewBattleResultMediator = var_1_10008

	var_4_10(var_4_9, var_1_10008.REENTER_STAGE)

	return
end

return var_0_1
