local NewHpShareActBossResultStatisticsPage = class("NewHpShareActBossResultStatisticsPage", import("..activityBoss.NewActivityBossResultStatisticsPage"))

function NewHpShareActBossResultStatisticsPage:UpdateGrade()
	LoadImageSpriteAsync("battlescore/grade_label_clear", self.gradeTxt, false)
	setActive(self.gradeIcon, false)

	return
end

function NewHpShareActBossResultStatisticsPage:UpdateTicket(arg_2_1)
	NewHpShareActBossResultStatisticsPage.super.UpdateTicket(self, arg_2_1)

	local var_2_0 = arg_2_1:Find("playAgain/ticket/checkbox")

	triggerToggle(var_2_0, true)
	setToggleEnabled(var_2_0, false)

	return
end

function NewHpShareActBossResultStatisticsPage:EnoughTicketCount()
	return getProxy(PlayerProxy):getRawData():getResource((self:GetTicketItemID(self.contextData.actId))) > 0
end

function NewHpShareActBossResultStatisticsPage:OnPlayAgain(arg_4_1)
	if self:IsLastBonus() then
		self:PassMsgbox("lastBonus", {
			content = i18n("expedition_drop_use_out")
		}, arg_4_1)

		return
	end

	if not self:EnoughTicketCount() then
		arg_4_1()
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noTicket"))

		return
	end

	local var_4_0, var_4_1 = self:NotEnoughOilCost()

	if var_4_0 then
		self:PassMsgbox("oil", var_4_1, arg_4_1)

		return
	end

	if self:NotEnoughShipBag() then
		self:PassMsgbox("shipCapacity", nil, arg_4_1)

		return
	end

	local var_4_2, var_4_3 = self:NotEnoughEnergy()

	if var_4_2 then
		self:PassMsgbox("energy", var_4_3, arg_4_1)

		return
	end

	self:emit(NewBattleResultMediator.REENTER_STAGE)

	return
end

return NewHpShareActBossResultStatisticsPage
