class = var_0_10000

local var_0_0 = var_0_10000("MainMonthCardSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	MonthCardOutDateTipPanel = var_1_10002

	if var_1_10002.GetMonthCardEndDate() == 0 then
		arg_1_1()

		return
	end

	pg = var_1_10003

	local var_1_0 = var_1_10003.TimeMgr.GetInstance()
	local var_1_1 = var_3.GetServerTime(var_1_0)

	MonthCardOutDateTipPanel = var_1_0

	local var_1_2 = var_1_0.GetMonthCardTipDate()

	if var_1_1 >= var_2 - 0 and var_1_2 < var_2 - 0 then
		arg_1_0:ShowMsg(var_2, var_1_1, arg_1_1)
	else
		arg_1_1()
	end

	return
end

function var_0_0.ShowMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	MonthCardOutDateTipPanel = var_1_10004

	var_1_10004.SetMonthCardTipDate(arg_2_2)

	pg = var_4

	local var_2_0 = var_4.TimeMgr.GetInstance()
	local var_2_1 = var_4.STimeDescS

	math = var_1_10006

	local var_2_2 = var_2_1(var_2_0, var_1_10006.min(arg_2_2, arg_2_1), "*t")

	i18n = var_2_0

	local var_2_3 = var_2_0("trade_card_tips4", var_2_2.year, var_2_2.month, var_2_2.day)

	pg = var_6

	local var_2_4 = var_6.TimeMgr.GetInstance()
	local var_2_5 = var_6.STimeDescS(var_2_4, arg_2_1, "*t")

	i18n = var_2_4

	local var_2_6 = var_2_4("trade_card_tips4", var_2_5.year, var_2_5.month, var_2_5.day)
	local var_2_7 = arg_2_1 <= arg_2_2

	pg = var_9

	local var_2_8 = var_9.MsgboxMgr.GetInstance()
	local var_2_9 = var_9.ShowMsgBox
	local var_2_10 = {
		hideNo = true
	}

	MSGBOX_TYPE_MONTH_CARD_TIP = var_1_10012
	var_2_10.type = var_1_10012
	pg = var_1_10012
	var_2_10.title = var_1_10012.MsgboxMgr.TITLE_INFORMATION
	i18n = var_12
	var_2_10.content = var_12(var_2_7 and "trade_card_tips2" or "trade_card_tips3", var_2_6)
	var_2_10.dateText = var_2_3
	i18n = var_12
	var_2_10.yesText = var_12("trade_card_tips1")
	var_2_10.onClose = arg_2_3

	function var_2_10.onYes()
		pg = var_2_10000

		local var_3_0 = var_2_10000.m02
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_3_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_3_3 = var_2_10003.CHARGE
		local var_3_4 = {
			confirmMonthCard = true
		}

		ChargeScene = var_2_10005
		var_3_4.wrap = var_2_10005.TYPE_DIAMOND

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end

	var_2_9(var_2_8, var_2_10)

	return
end

return var_0_0
