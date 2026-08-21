local var_0_0 = class("NewHpShareActBossResultStatisticsPage", import("..activityBoss.NewActivityBossResultStatisticsPage"))

function var_0_0.UpdateGrade(arg_1_0)
	LoadImageSpriteAsync("battlescore/grade_label_clear", arg_1_0.gradeTxt, false)
	setActive(arg_1_0.gradeIcon, false)

	return
end

function var_0_0.UpdateTicket(arg_2_0, arg_2_1)
	var_0_0.super.UpdateTicket(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_1:Find("playAgain/ticket/checkbox")

	triggerToggle(var_2_0, true)
	setToggleEnabled(var_2_0, false)

	return
end

function var_0_0.EnoughTicketCount(arg_3_0)
	local var_3_0 = getProxy(PlayerProxy):getRawData()

	return var_3_0:getResource((arg_3_0:GetTicketItemID(arg_3_0.contextData.actId))) > 0
end

function var_0_0.OnPlayAgain(arg_4_0, arg_4_1)
	if arg_4_0:IsLastBonus() then
		arg_4_0:PassMsgbox("lastBonus", {
			content = i18n("expedition_drop_use_out")
		}, arg_4_1)

		return
	end

	if not arg_4_0:EnoughTicketCount() then
		arg_4_1()
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noTicket"))

		return
	end

	local var_4_0, var_4_1 = arg_4_0:NotEnoughOilCost()

	if var_4_0 then
		arg_4_0:PassMsgbox("oil", var_4_1, arg_4_1)

		return
	end

	if arg_4_0:NotEnoughShipBag() then
		arg_4_0:PassMsgbox("shipCapacity", nil, arg_4_1)

		return
	end

	local var_4_2, var_4_3 = arg_4_0:NotEnoughEnergy()

	if var_4_2 then
		arg_4_0:PassMsgbox("energy", var_4_3, arg_4_1)

		return
	end

	arg_4_0:emit(NewBattleResultMediator.REENTER_STAGE)

	return
end

return var_0_0
