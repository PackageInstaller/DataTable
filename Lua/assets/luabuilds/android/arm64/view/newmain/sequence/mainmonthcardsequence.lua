local var_0_0 = class("MainMonthCardSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = MonthCardOutDateTipPanel.GetMonthCardEndDate()

	if var_1_0 == 0 then
		arg_1_1()

		return
	end

	local var_1_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_1_1 >= var_1_0 - 0 and MonthCardOutDateTipPanel.GetMonthCardTipDate() < var_1_0 - 0 then
		arg_1_0:ShowMsg(var_1_0, var_1_1, arg_1_1)
	else
		arg_1_1()
	end

	return
end

function var_0_0.ShowMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_9000

	MonthCardOutDateTipPanel.SetMonthCardTipDate(arg_2_2)

	local var_2_0 = pg.TimeMgr.GetInstance().STimeDescS(var_2_9000, math.min(arg_2_2, arg_2_1), "*t")
	local var_2_1 = pg.TimeMgr.GetInstance():STimeDescS(arg_2_1, "*t")

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideNo = true,
		type = MSGBOX_TYPE_MONTH_CARD_TIP,
		title = pg.MsgboxMgr.TITLE_INFORMATION,
		content = i18n(arg_2_1 <= arg_2_2 and "trade_card_tips2" or "trade_card_tips3", (i18n("trade_card_tips4", var_2_1.year, var_2_1.month, var_2_1.day))),
		dateText = i18n("trade_card_tips4", var_2_0.year, var_2_0.month, var_2_0.day),
		yesText = i18n("trade_card_tips1"),
		onClose = arg_2_3,
		onYes = function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				confirmMonthCard = true,
				wrap = ChargeScene.TYPE_DIAMOND
			})

			return
		end
	})

	return
end

return var_0_0
